_Code on the Blockchain - Electronic Contract Scripts_

# Wrapped CryptoKitties (WCK) Blockchain Contract / Service

> $WCK wrapped cryptokitties; its actually backed by a digital cat;
> where as other coins are backed by hot-air.

![](../i/kittyhelper-wrapped-2021-02-05.png)


Turn unique non-fungible tokens into a fungible token.

How? Tokens (ERC20 on Ethereum) each backed 1:1 by an CryptoKitty (ERC721 on Ethereum)


Note: The Wrapped CryptoKitties (WCK) contract script is open source and documented with inline running commentary. Thanks!
The [WrappedCK](dl/WrappedCK.sol) contract script is about 500 lines total.



## Source Code

Etherscan

- WrappedCK (WCK), see contract address [`0x09fe5f0236f0ea5d930197dce254d77b04128075`](https://etherscan.io/address/0x09fe5f0236f0ea5d930197dce254d77b04128075#code)
- WrappedG0 (WG0), see contract address [`0xa10740ff9ff6852eac84cdcff9184e1d6d27c057`](https://etherscan.io/address/0xa10740ff9ff6852eac84cdcff9184e1d6d27c057#code) - Gen 0 Variant
- WrappedVG0 (WVG0), see contract address [`0x25c7b64a93eb1261e130ec21a3e9918caa38b611`](https://etherscan.io/address/0x25c7b64a93eb1261e130ec21a3e9918caa38b611#code) - Virgin Gen 0 Variant




## Overview

Contract commentary:

> Main contract for WrappedCK. This contract converts Cryptokitties between
> the ERC721 standard and the
>  ERC20 standard by locking cryptokitties into the contract and minting 1:1 backed
> ERC20 tokens, that
> then be redeemed for cryptokitties when desired.
>
> NOTE: When wrapping a cryptokitty, you get a generic WCK token.
> Since the WCK token is generic, it has no
> no information about what cryptokitty you submitted, so you will most likely
> not receive the same kitty
> back when redeeming the token unless you specify that kitty's ID.
> The token only entitles you to receive
> *a* cryptokitty in return, not necessarily the *same* cryptokitty in return.
> A different user can submit
> their own WCK tokens to the contract and withdraw the kitty that you originally
> deposited. WCK tokens have
> no information about which kitty was originally deposited to mint WCK -
> this is due to the very nature of
> the ERC20 standard being fungible, and the ERC721 standard being nonfungible.


The contract outline & inheritance for the wrapped kitty contract looks like this:


``` solidity
interface IERC20                // ERC20 interface
contract ERC20 is IERC20        // Standard ERC20 token
contract ReentrancyGuard        // Helps contracts guard against reentrancy attacks
contract WrappedCK is ERC20, ReentrancyGuard    //  Main contract
  using SafeMath                // Unsigned math operations with safety checks

// Extern
contract KittyCore              // Interface for interacting with CryptoKitties
```


### WrappedCK

#### Constants

> The metadata details about the "Wrapped CryptoKitties" WCK ERC20 token.

``` solidity
uint8 constant public decimals = 18;
string constant public name = "Wrapped CryptoKitties";
string constant public symbol = "WCK";
```

> The address of official CryptoKitties contract that stores the metadata about each cat.
>
> NOTE: The owner is not capable of changing the address of the CryptoKitties Core contract
> once the contract has been deployed.

``` solidity
address public kittyCoreAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
```


#### Events

**DepositKittyAndMintToken**

> This event is fired when a user deposits cryptokitties into the contract in exchange
> for an equal number of WCK ERC20 tokens.
>
>  @param kittyId  The cryptokitty id of the kitty that was deposited into the contract.

``` solidity
event DepositKittyAndMintToken(
        uint256 kittyId
);
```

**BurnTokenAndWithdrawKitty**

> This event is fired when a user deposits WCK ERC20 tokens into the contract in exchange
> for an equal number of locked cryptokitties.
>
>  @param kittyId  The cryptokitty id of the kitty that was withdrawn from the contract.

``` solidity
event BurnTokenAndWithdrawKitty(
        uint256 kittyId
);
```

#### Storage

**depositedKitties**

> An Array containing all of the cryptokitties that are locked in the contract, backing
> WCK ERC20 tokens 1:1
>
> NOTE: Some of the kitties in this array were indeed deposited to the contract,
> but they are no longer held by the contract. This is because withdrawSpecificKitty()
> allows a user to withdraw a kitty "out of order".
> Since it would be prohibitively expensive to
> shift the entire array once we've withdrawn a single element,
> we instead maintain this
> mapping to determine whether an element is still contained in the contract or not.

``` solidity
uint256[] private depositedKittiesArray;
```

**kittyIsDepositedInContract**

> A mapping keeping track of which kittyIDs are currently contained within the contract.
>
> NOTE: We cannot rely on depositedKittiesArray as the source of truth
> as to which cats are
> deposited in the contract. This is because burnTokensAndWithdrawKitties()
> allows a user to
> withdraw a kitty "out of order" of the order that they are stored in the array.
> Since it
> would be prohibitively expensive to shift the entire array once we've
> withdrawn a single
> element, we instead maintain this mapping to determine whether
> an element is still contained
> in the contract or not.

``` solidity
mapping (uint256 => bool) private kittyIsDepositedInContract;
```


#### Functions

**depositKittiesAndMintTokens**

> Allows a user to lock cryptokitties in the contract in exchange
>  for an equal number of WCK ERC20 tokens.
>
>  @param _kittyIds  The ids of the cryptokitties that will be locked into the contract.
>
> NOTE: The user must first call approve() in the Cryptokitties Core contract
> on each kitty that thye wish to deposit before calling depositKittiesAndMintTokens().
> There is no danger  of this contract overreaching its approval,
> since the CryptoKitties Core contract's approve()
>  function only approves this contract for a single Cryptokitty.
> Calling approve() allows this
> contract to transfer the specified kitty in the depositKittiesAndMintTokens() function.

``` solidity
function depositKittiesAndMintTokens(
  uint256[] calldata _kittyIds
)
```


**burnTokensAndWithdrawKitties**

> Allows a user to burn WCK ERC20 tokens in exchange for an equal number of locked
> cryptokitties.
>
> - @param _kittyIds  The IDs of the kitties that the user wishes to withdraw. If the user submits 0
>   as the ID for any kitty, the contract uses the last kitty in the array for that kitty.
> - @param _destinationAddresses  The addresses that the withdrawn kitties will be sent to
>   (this allows
>    anyone to "airdrop" kitties to addresses that they do
>    not own in a single transaction).

``` solidity
function burnTokensAndWithdrawKitties(
  uint256[] calldata _kittyIds, address[] calldata _destinationAddresses
)
```

**batchRemoveWithdrawnKittiesFromStorage**

> Removes any kitties that exist in the array but are no longer held in the
>  contract, which happens if the first few kitties have previously been withdrawn
> out of order using the withdrawSpecificKitty() function.
>
> NOTE: This function exists to prevent a griefing attack
> where a malicious attacker
> could call withdrawSpecificKitty() on a large number of kitties
> at the front of the
> array, causing the while-loop in _popKitty to always run out of gas.
>
> @param _numSlotsToCheck  The number of slots to check in the array.

``` solidity
function batchRemoveWithdrawnKittiesFromStorage(
  uint256 _numSlotsToCheck
)
```

(Source: [WrappedCK.sol](WrappedCK.sol))





## Bonus - Wrapped CryptoKitties Gen-0 (WG0), Wrapped Virgin CryptoKitties Gen-0 (WVG0)

> Main contract for Wrapped G0. This contract converts Gen 0 Cryptokitties between the ERC721 standard
> and the ERC20 standard by locking cryptokitties into the contract and minting 1:1 backed
> ERC20 tokens, that
> can then be redeemed for cryptokitties when desired.
> This concept originated with WCK (Wrapped Cryptokitties).
> This code is only a very slight modification of the original contract;
> It simply adds the Gen 0 requirement
>	 as well the getKitty interfacing.


``` solidity
uint256 kittyCooldown;
uint256 kittyGen;

(,,kittyCooldown,,,,,,kittyGen,) = kittyCore.getKitty(kittyToDeposit);

require( kittyGen == 0, 'this cat must be generation 0' );
```


Wrapped Virgin CryptoKitties Gen-0 (WVG0) adds:

``` solidity
require( kittyCooldown == 0, 'cooldown must be fast' );
```





## Appendix

### Wrapped Kitties (WCK) Facts

> Every Wrapped CryptoKitty token is backed 1:1 by a CryptoKitty.
> As Kitties are "wrapped" WCK is minted. Inversely, Kitties are transferred out of the contract when $WCK is burned
>
> To create a single $WCK, you'll need one CryptoKitty and two additional transactions.
> At 100 gwei the approval tx costs ~0.005 ETH & wrapping tx ~0.013 for a total of 0.018 ETH each excluding the variable cost of the Kitty
>
> You can save on gas by batch wrapping cats. At 100 gwei, the tx fees to mint 30 $WCK totals ~0.34 ETH or roughly 0.011 ETH each
>
> $WCK supply is not fixed but the minting process is very laborious.
> The theoretical max circulating supply is the total number of CryptoKitties which is currently 1.96m
>
> (Source: [$WCK Facts, Poppie Cat](https://twitter.com/Poopie_cat/status/1308847180745236483))



### Wrapped CryptoKitties Lite Pa-purr

> NFTs suffer from lack of liquidity and have a tendency to have high spreads. These issues along with additional
> complexity of understanding their respective markets makes speculating on NFTs difficult.
> Many investors are left to do their own research and figure out what others have had years to learn.
> Investing in NFTs remains challenging due to their non-fungibility and transaction costs on ethereum.
>
> Wrapped CryptoKitties ($WCK) was the first experiment to convert NFTs into ERC20s to enable easy trading on exchanges like Uniswap.
> With WCK, any CryptoKitty, regardless of market value, could be “wrapped” into a ERC-20 token.
> This breakthrough allowed CryptoKitties players to convert over 50 thousand Kitties to gain access to liquid markets.
>
> Enter Wrapped Gen-0 ($WG0) CryptoKitties. The motivation behind WGO is to provide easy access to liquidity
> for a more valuable asset class with fixed supply. Only 50,000 Generation 0 cats can ever exist and much less are in circulation.
> WG0 is a modification of the original experiment, with the additional requirement that the wrapped CryptoKitty must be a scarce Generation 0 cat.
>
> Deflationary supply Generation 0s is another variant that remains interesting for collectors and speculators.
> This asset class is called Virgin Generation 0 and Wrapped Virgin Generation 0 ($WVG0).
> These Kitties are of mint quality and must remain unbred to keep their virginity.
>
> There are only two ways to get a WG0 token: wrap an existing Gen 0 kitty that you own, or buy one from Uniswap.
> A WG0 token is always backed exactly 1:1 with a Gen 0 kitty, and at any time a holder of 1 WG0 token can "burn"
> the token and withdraw any Gen 0 from the WG0 contract. This creates unique opportunities to arbitrage between CryptoKitties'
> first-party marketplace and the WG0 pool as well as the ability
> to upgrade any Generation 0 you may own with any Generation 0 in the pool.
>
> (Source: [Wrapped CryptoKitties Lite Pa-purr](https://www.wrappered.com/litepapurr.html))


