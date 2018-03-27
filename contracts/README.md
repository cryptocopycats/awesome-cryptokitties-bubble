_Code on the Blockchain - Electronic Contract Scripts_

# CryptoKitties Blockchain Contracts / Services


Note: Almost all of the CryptoKitties contract scripts are open source and documented with inline running commentary. Thanks!
The [KittyCore](dl/KittyCore.sol) contract script is about 2 000 lines total. 

The only sooper-sekretoo contract is the [GeneScienceInterface](GeneScienceInterface.sol) with the "magic" mixGenes function 
that given genes of kitten 1 & 2, return a genetic combination.

Note: The mixGenes got "reverse-engineered" from the opcode - thanks to Sean Soria (see [CryptoKitties mixGenes Function](https://medium.com/@sean.soria/cryptokitties-mixgenes-function-69207883fc80), Dec 2017) -
and is now a "public" sooper-sektretoo.
See [`mixGenes.rb`](https://github.com/openblockchains/awesome-cryptokitties/blob/master/genes/mixGenes.rb) for a ruby version 
or [`mixGenes.py`](https://github.com/openblockchains/awesome-cryptokitties/blob/master/genes/mixGenes.py) for a python version.




## Source Code

Etherscan

- KittyCore (Open Source), see contract address [`0x06012c8cf97bead5deae237070f9587f8e7a266d`](https://etherscan.io/address/0x06012c8cf97bead5deae237070f9587f8e7a266d#code)
- GeneScienceInterface (Opcode), see contract address [`0xf97e0a5b616dffc913e72455fde9ea8bbe946a2b`](https://etherscan.io/address/0xf97e0a5b616dffc913e72455fde9ea8bbe946a2b#code)

> The genetic combination algorithm is kept seperate so we can open-source all of
> the rest of our code without making it _too_ easy for folks to figure out how the genetics work.
> Don't worry, I'm sure someone will reverse engineer it soon enough!
>
> -- Commentary from the CryptoKitties source code

- SaleClockAuction (Open Source), see contract address [`0xb1690c08e213a35ed9bab7b318de14420fb57d8c`](https://etherscan.io/address/0xb1690c08e213a35ed9bab7b318de14420fb57d8c#code)
- SiringClockAuction (Open Source), see contract address [`0xc7af99fe5513eb6710e6d5f44f9989da40f27f26`](https://etherscan.io/address/0xc7af99fe5513eb6710e6d5f44f9989da40f27f26#code)

> The auctions are
> seperate since their logic is somewhat complex and there's always a risk of subtle bugs. By keeping
> them in their own contracts, we can upgrade them without disrupting the main contract that tracks
> kitty ownership. 
>
> -- Commentary from the CryptoKitties source code


<!-- add why? why not?

- CEO, see contract address [`0xaf1e54b359b0897133f437fc961dd16f20c045e1`](https://etherscan.io/address/0xaf1e54b359b0897133f437fc961dd16f20c045e1#code)
- CFO, see contract address [`0x2041bb7d8b49f0bde3aa1fa7fb506ac6c539394c`](https://etherscan.io/address/0x2041bb7d8b49f0bde3aa1fa7fb506ac6c539394c#code)
- COO, see contract address [`0xa21037849678af57f9865c6b9887f4e339f6377a`](https://etherscan.io/address/0xa21037849678af57f9865c6b9887f4e339f6377a#code)
-->



## Overview

Contract structure:

> The day-one functionality of the contract scripts includes:
>                
> - Keep track of the genes of upcoming gen0 CryptoKitties
> - Introducing the genes of gen0 CryptoKitties to the Core Contract
> - Launching the auctions for gen0 CryptoKitties (including price determination)
> - Combining the genotypes of two parent CryptoKitties to determine the genotype of the new CryptoKitten
> - Managing the auctions of CryptoKitties (both gen-0 cats being auctioned to users and user-to-user auctions) and siring tokens
> - Managing siring auctions (including initiating the breeding when successful).
>
> All functionality for breeding, buying, selling, and transferring cats
> will be possible for any user by interacting directly with the contracts on the blockchain.
> Any auctions or sales conducted through our auction contract
> will include a 3.75% commission (no minimum) taken from the seller's portion.

(Source: [CryptoKitties Technical Details / Contract Structure](https://www.cryptokitties.co/Technical-details))


The contract inheritance for the main kitty contract looks like this:


``` solidity
contract KittyAccessControl
contract KittyBase is KittyAccessControl
contract KittyOwnership is KittyBase, ERC721
contract KittyBreeding is KittyOwnership
contract KittyAuction is KittyBreeding
contract KittyMinting is KittyAuction
contract KittyCore is KittyMinting
```


### KittyAccessControl - Who controls the contract? - CEO, CFO, COO

> This contract manages the various addresses and constraints for operations
> that can be executed only by specific roles. Namely CEO, CFO and COO.
>
> -- Commentary from the CryptoKitties source code



### KittyBase - What's a kitty, really? - Kitty data type structure

> This is where we define the most fundamental code shared throughout the core
> functionality. This includes our main data storage, constants and data types, plus
> internal functions for managing these items.
>
> -- Commentary from the CryptoKitties source code


``` solidity
/// @dev The main Kitty struct. Every cat in CryptoKitties is represented by a copy
///  of this structure, so great care was taken to ensure that it fits neatly into
///  exactly two 256-bit words. Note that the order of the members in this structure
///  is important because of the byte-packing rules used by Ethereum.
///  Ref: http://solidity.readthedocs.io/en/develop/miscellaneous.html

struct Kitty {
    // The Kitty's genetic code is packed into these 256-bits, the format is
    // sooper-sekret! A cat's genes never change.
    uint256 genes;

    // The timestamp from the block when this cat came into existence.
    uint64 birthTime;

    // The minimum timestamp after which this cat can engage in breeding
    // activities again. This same timestamp is used for the pregnancy
    // timer (for matrons) as well as the siring cooldown.
    uint64 cooldownEndBlock;

    // The ID of the parents of this kitty, set to 0 for gen0 cats.
    // Note that using 32-bit unsigned integers limits us to a "mere"
    // 4 billion cats. This number might seem small until you realize
    // that Ethereum currently has a limit of about 500 million
    // transactions per year! So, this definitely won't be a problem
    // for several years (even as Ethereum learns to scale).
    uint32 matronId;
    uint32 sireId;

    // Set to the ID of the sire cat for matrons that are pregnant,
    // zero otherwise. A non-zero value here is how we know a cat
    // is pregnant. Used to retrieve the genetic material for the new
    // kitten when the birth transpires.
    uint32 siringWithId;

    // Set to the index in the cooldown array (see below) that represents
    // the current cooldown duration for this Kitty. This starts at zero
    // for gen0 cats, and is initialized to floor(generation/2) for others.
    // Incremented by one for each successful breeding action, regardless
    // of whether this cat is acting as matron or sire.
    uint16 cooldownIndex;

     // The "generation number" of this cat. Cats minted by the CK contract
     // for sale are called "gen0" and have a generation number of 0. The
     // generation number of all other cats is the larger of the two generation
     // numbers of their parents, plus one.
     // (i.e. max(matron.generation, sire.generation) + 1)
     uint16 generation;
}
```

(Source: [KittyBase.sol](KittyBase.sol))


### KittyOwnership - Kitties as tokens

> This provides the methods required for basic non fungible token
> transactions, following the draft [ERC-721 spec](https://github.com/ethereum/EIPs/issues/721).
>
> -- Commentary from the CryptoKitties source code


### KittyBreeding - Cats get down and dirty

> This file contains the methods necessary to breed cats together, including
> keeping track of siring offers, and relies on an external genetic combination contract.
>
> -- Commentary from the CryptoKitties source code


### KittyAuction - Buying, selling and pimpin' of cats

> Here we have the public methods for auctioning or bidding on cats or siring
> services. The actual auction functionality is handled in two sibling contracts (one
> for sales and one for siring), while auction creation and bidding is mostly mediated
> through this facet of the core contract.
>
> -- Commentary from the CryptoKitties source code


### KittyMiniting - The gen0 cat factory

> This final facet contains the functionality we use for creating new gen0 cats.
> We can make up to 5000 "promo" cats that can be given away (especially important when
> the community is new), and all others can only be created and then immediately put up
> for auction via an algorithmically determined starting price. Regardless of how they
> are created, there is a hard limit of 50k gen0 cats. After that, it's all up to the
> community to breed, breed, breed!
>
> -- Commentary from the CryptoKitties source code

``` solidity
// Limits the number of cats the contract owner can ever create.

uint256 public constant PROMO_CREATION_LIMIT = 5000;
uint256 public constant GEN0_CREATION_LIMIT = 45000;
```

(Source: [KittyMinting.sol](KittyCore.sol))



### KittyCore - The master contract - all together now


``` solidity
/// @notice Returns all the relevant information about a specific kitty.
/// @param _id The ID of the kitty of interest.

function getKitty(uint256 _id)
    external
    view
    returns (
      bool isGestating,
      bool isReady,
      uint256 cooldownIndex,
      uint256 nextActionAt,
      uint256 siringWithId,
      uint256 birthTime,
      uint256 matronId,
      uint256 sireId,
      uint256 generation,
      uint256 genes
    ) {
      Kitty storage kit = kitties[_id];

      // if this variable is 0 then it's not gestating
      isGestating = (kit.siringWithId != 0);
      isReady = (kit.cooldownEndBlock <= block.number);
      cooldownIndex = uint256(kit.cooldownIndex);
      nextActionAt = uint256(kit.cooldownEndBlock);
      siringWithId = uint256(kit.siringWithId);
      birthTime = uint256(kit.birthTime);
      matronId = uint256(kit.matronId);
      sireId = uint256(kit.sireId);
      generation = uint256(kit.generation);
      genes = kit.genes;
   }
```

(Source: [KittyCore.sol](KittyCore.sol))



## Articles

See [How to Code Your Own CryptoKitties-Style Game on Ethereum](https://medium.com/loom-network/how-to-code-your-own-cryptokitties-style-game-on-ethereum-7c8ac86a4eb3)
by James Martin Duffy, Dec 2017 --
for an in-depth analysis / write-up about the machinery,




## CryptoKitty Bounty Program

Documentation from the Official CryptoKitty Bounty Program (github: [axiomzen/cryptokitties-bounty](https://github.com/axiomzen/cryptokitties-bounty)), Nov 2017


> CryptoKitties is composed of 4 public facing contracts. Below we'll provide an overview on these contracts:
>
> ##### KittyCore.sol - `0x16baf0de678e52367adc69fd067e5edd1d33e3bf`
>
> Also referred as the main contract, is where Kitties and their ownership are stored.
> This also mediates all the main operations, such as breeding, exchange, and part of auctions.
>
> For this release, the actual bytecode released for the contract is `KittyCoreRinkeby.sol`, explained below.
>
> ##### SaleClockAuction.sol - `0x8a316edee51b65e1627c801dbc09aa413c8f97c2`
>
> Where users are expected to acquire their gen0 kitten. It is also a marketplace where anyone can post their kitten for auction.
> [See Dutch/Clock auction](https://en.wikipedia.org/wiki/Dutch_auction) - note we also accept an increasing price.
> ps: CryptoKitties auctions take an initial time and duration, and after duration is over they are not closed.
> Instead they hold the final price indefinitely
>
> ##### SiringClockAuction.sol - `0x07ca8a3a1446109468c3cf249abb53578a2bbe40`
>
> A marketplace where any user can offer their Kitty as a potential sire for any takers.
>
> ##### GeneScience.sol
>
> It's a mystery! Not public for this release.
>
>
> [...]
>
> ### Common functions
>
> Here's what we expect to be the most usual flow, and what function are to be called.
>
> 1. COO will periodically put a kitten to gen0 auction (Main `createGen0Auction()`)
> 1. user go an buy gen0 kittens (Sale Auction `bid()`)
> 1. user can get kitty data (Main `getKitty()`)
> 1. user can breed their own kittens (Main `breedWith()` or `breedWithAuto()`)
> 1. after cooldown is passed, any user can have a pregnant kitty giving birth (Main `giveBirth()`)
> 1. user can offer one of their kitties as sire via auction (Main `createSiringAuction()`)
> 1. user can offer their kitty as sire to another user (Main `approveSiring()`)
> 1. user can bid on an active siring auction (Main `createSiringAuction()`)
> 1. user can put their kitty for sale on auction (Main `createSaleAuction()`)
> 1. user can buy a kitty that is on auction from another user (Sale Auction `bid()`)
> 1. user can check info of a kitty that is to auction (Sale/Siring Auction `getAuction()`)
> 1. user can cancel an auction they started (Sale/Siring Auction `cancelAuction()`)
> 1. user can transfer a kitty they own to another user (Main `transfer()`)
> 1. user can allow another user to take ownership of a kitty they own (Main `approve()`)
> 1. once an user has a kitty ownership approved, they can claim a kitty (Main `transferFrom()`)
> 1. CEO is the only one that may replace COO or CTO (Main `setCEO()` `setCFO()` `setCOO()`)
> 1. COO can mint and distribute promotional kittens (Main `createPromoKitty()`)
> 1. COO can transfer the balance from auctions (Main `withdrawAuctionBalances()`)
> 1. CFO can drain funds from main contract (Main `withdrawBalance()`)
>
> -- [Basics of CryptoKitties](https://github.com/axiomzen/cryptokitties-bounty/blob/master/CryptoKitty%20Basics.md)




## Non Fungible Token (NFT) Standard - Ethereum Request for Comments #721 (ERC-721)

_CryptoKitties provides a practical use case for digital scarcity
and digital collectibles by pioneering ERC-721, a non-fungible token protocol_

A standard interface allows any Non Fungible Token (NFTs) on Ethereum
to be handled by general-purpose applications.
In particular, it will allow for Non Fungible Token (NFTs)
to be tracked in standardized wallets and traded on exchanges.


Compatibility Functions for Ethereum Request for Comments #20 (ERC-20)

- function **name**() constant returns (string name)
- function **symbol**() constant returns (string symbol)
- function **totalSupply**() constant returns (uint256 totalSupply)
- function **balanceOf**(address _owner) constant returns (uint256 balance)

Basic Ownership Functions

- function **ownerOf**(uint256 _tokenId) constant returns (address owner)
- function **approve**(address _to, uint256 _tokenId)
- function **takeOwnership**(uint256 _tokenId)
- function **transfer**(address _to, uint256 _tokenId)
- function **tokenOfOwnerByIndex**(address _owner, uint256 _index) constant returns (uint tokenId)

Metadata Functions

- function **tokenMetadata**(uint256 _tokenId) constant returns (string infoUrl)

Events

- event **Transfer**(address indexed _from, address indexed _to, uint256 _tokenId)
- event **Approval**(address indexed _owner, address indexed _approved, uint256 _tokenId)


(Source: [Ethereum, Non Fungible Token (NFT) Standard #721](https://github.com/ethereum/EIPs/issues/721))

