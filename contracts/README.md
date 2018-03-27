# CryptoKitties Blockchain Contracts / Services

Note: Almost all of the CryptoKitties contract scripts are open source and documented with lots of inline comments. Thanks!
The [KittyCore](dl/KittyCore.sol) contract script is about 2 000 lines total. 

The only sooper-sekretoo contract is the [GeneScienceInterface](GeneScienceInterface.sol) with the "magic" mixGenes function 
that given genes of kitten 1 & 2, return a genetic combination.

Note: The mixGenes got "reverse-engineered" from the opcode - thanks to Sean Soria (see [CryptoKitties mixGenes Function](https://medium.com/@sean.soria/cryptokitties-mixgenes-function-69207883fc80)) -  
and is now a "public" sooper-sektretoo.
See [`mixGenes.rb`](https://github.com/openblockchains/awesome-cryptokitties/blob/master/genes/mixGenes.rb) for a ruby version 
or [`mixGenes.py`](https://github.com/openblockchains/awesome-cryptokitties/blob/master/genes/mixGenes.py) for a python version.



## Overview

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








### Code on the Blockchain - Electronic Contract Scripts


#### Contract Structure

> The day-one functionality of the contract scripts includes:
>                
> - Keep track of the genes of upcoming gen0 CryptoKitties
> - Introducing the genes of gen0 CryptoKitties to the Core Contract
> - Launching the auctions for gen0 CryptoKitties (including price determination)
> - Combining the genotypes of two parent CryptoKitties to determine the genotype of the new CryptoKitten
> - Managing the auctions of CryptoKitties (both gen-0 cats being auctioned to users and user-to-user auctions) and siring tokens
> - Managing siring auctions (including initiating the breeding when successful).
>
>  All functionality for breeding, buying, selling, and transferring cats
> will be possible for any user by interacting directly with the contracts on the blockchain.
> Any auctions or sales conducted through our auction contract
> will include a 3.75% commission (no minimum) taken from the seller's portion.

(Source: [CryptoKitties Technical Details / Contract Structure](https://www.cryptokitties.co/Technical-details))


#### Contract Script (Public) Source Code

[CryptoKittiesCore.sol](CryptoKittiesCore.sol) in Ethereum Solidity -- copied from [Etherscan](https://etherscan.io/address/0x06012c8cf97bead5deae237070f9587f8e7a266d#code)

More contract scripts

- [Sale auction](https://etherscan.io/address/0xb1690c08e213a35ed9bab7b318de14420fb57d8c#code)
- [Siring auction](https://etherscan.io/address/0xc7af99fe5513eb6710e6d5f44f9989da40f27f26#code)

<!-- add why? why not?
- [CEO](https://etherscan.io/address/0xaf1e54b359b0897133f437fc961dd16f20c045e1)
- [CFO](https://etherscan.io/address/0x2041bb7d8b49f0bde3aa1fa7fb506ac6c539394c)
- [COO](https://etherscan.io/address/0xa21037849678af57f9865c6b9887f4e339f6377a)
  -->


#### Non-fungible Token (NFT) Standard - Ethereum Request for Comments #721 (ERC-721)

_CryptoKitties provides a practical use case for digital scarcity
and digital collectibles by pioneering ERC-721, a non-fungible token protocol_


A standard interface allows any Non-fungible Token (NFTs) on Ethereum
to be handled by general-purpose applications.
In particular, it will allow for Non-fungible Token (NFTs)
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


(Source: [Ethereum, Non-fungible Token (NFT) Standard #721](https://github.com/ethereum/EIPs/issues/721))


#### More About Contract Scripts

For more contract scripts see:

**The CryptoKitty Bounty Program** (github: [axiomzen/cryptokitties-bounty](https://github.com/axiomzen/cryptokitties-bounty))

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




## Articles

See [How to Code Your Own CryptoKitties-Style Game on Ethereum](https://medium.com/loom-network/how-to-code-your-own-cryptokitties-style-game-on-ethereum-7c8ac86a4eb3)
by James Martin Duffy, Dec 2017 --
for an in-depth analysis / write-up about the machinery,
