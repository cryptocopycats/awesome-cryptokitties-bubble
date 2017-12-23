
The Future of Digital Collectibles - CryptoKitties, CryptoPuppies, CryptoPets, CryptoMonsters, CryptoTulips - Latest (and Greatest) Investment Opportunities 


> - I'm giving away a Gen 1 FAST Gold for free...
> - Rarity: 0.00264% Gen 5 JAGUAR FABULOUS GOLD DALI!! VIRGIN! 
> - Rarity: 0.0015% Princess Bubblegum is now for sale! Gen 12 | Brisk | Virgin | Chartreux | Bubblegum | Otaku | Emeraldgreen | Saycheese | Mauveover | Spock - Starts ETH 20/Ends ETH 10 
> - Gold ducat, Gen 5, Virgin, Swift. Very cheap 
> - Selling a lot of GEN1-3 for less than .2 | Fire Sale 
> - Selling all kitties for .45 ETH - 9 kitties, quick cooldowns, early generations, rare traits
> - Selling account with 9 kitties (GEN1 - 2 cats, GEN2 - 5 cats, GEN3 - 2 cats), price = ETH 1.2
> - Cheap Gen 1 cute kittie with rare genes! Only 0.125 ETH 
> - UNIQUE Virgin Peach Googly Gold Mauveover gen:2 cooldown:1 0.87992% RARE
>
> -- [CrypoKittiesMarket](https://www.reddit.com/r/CryptoKittiesMarket)


> Blockchain has unlocked the magic of digital scarcity, and combining that with the power of
> making the digital goods persistent gives them a potential value that is only limited by how much
> prestige a wealthy person might place on ownership of the item.
>
> -- [Justin Poirier](https://twitter.com/tokenizedcap/status/938460753589424128)



# Awesome CryptoKitties

A collection about Awesome CryptoKitties (Yes, Cute Little Cartoon Cats) on the Blockchain! - digital assets secured on a distributed public databases w/ crypto hashes.  Are CryptoPuppies the new CryptoKitties?  Contributions welcome.



## CryptoKitties (Yes, Cute Little Cartoon Cats) on the Blockchain!

Collectible. Breedable. Adorable.

Collect and breed digital cats. Start meow. Buy! Sell! Hold!

> Q: What's CryptoKitties? What's the big deal? 
>
> CryptoKitties is centered around breedable, collectible, and oh-so-adorable creatures 
> we call CryptoKitties! Each cat is one-of-a-kind and 100% owned by you; 
> it cannot be replicated, taken away, or destroyed.
>
> CryptoKitties is built on blockchain technology. 
> You can buy, sell, or trade your CryptoKitty like it was a traditional collectible, 
> secure in the knowledge that blockchain will track ownership securely.
> But, unlike traditional collectibles, you can breed two CryptoKitties
> to create a brand-new, genetically unique offspring.
> It results in something special—just like you!

Learn more @ [cryptokitties.co](https://cryptokitties.co), 
twitter: [CryptoKitties](https://twitter.com/CryptoKitties),
reddit: [CryptoKitties](https://www.reddit.com/r/CryptoKitties)

![](i/cryptokitties.png)


> All I want for Christmas is a CryptoKitty.
>
> -- [Kayla Williams](https://twitter.com/kaylaw/status/938590748655550464)

> I got a fever. And the only prescription is more CryptoKitties.
>
> -- [Eduardo Salazar](https://twitter.com/ceduardosalazar/status/938558630663634944)

> [My Gen 7 CryptoKitty #104375](https://www.cryptokitties.co/kitty/104375). The Future is Meow.
>
> -- [Anshul Dhawan](https://twitter.com/TheAnshulDhawan/status/938551642202324993)

> Celebrating 100 000 Kitties!
>
> -- [CryptoKitties](https://twitter.com/CryptoKitties/status/938223161232916481) - Dec/5

> WikiLeaks now accepts #CryptoKitties as a contribution method. 
> In many jurisdictions you can write them down for tax purposes as an investment.
> [Official WikiLeaks CryptoKitties](https://wikileaks.shop/pages/cryptokitties) -
> Purebred WikiLeaks CryptoKitties arrive in time for Christmas.
>  
> -- [WikiLeaks](https://twitter.com/wikileaks/status/944209405377101824)



### Code on the Blockchain - Electronic Contract Scripts

[CryptoKittiesCore.sol](CryptoKittiesCore.sol) in Ethereum Solidity -- copied from [Etherscan](https://etherscan.io/address/0x06012c8cf97bead5deae237070f9587f8e7a266d#code)

More contract scripts

- [Sale auction](https://etherscan.io/address/0xb1690c08e213a35ed9bab7b318de14420fb57d8c#code)
- [Siring auction](https://etherscan.io/address/0xc7af99fe5513eb6710e6d5f44f9989da40f27f26#code)

<!-- add why? why not?
- [CEO](https://etherscan.io/address/0xaf1e54b359b0897133f437fc961dd16f20c045e1)
- [CFO](https://etherscan.io/address/0x2041bb7d8b49f0bde3aa1fa7fb506ac6c539394c)
- [COO](https://etherscan.io/address/0xa21037849678af57f9865c6b9887f4e339f6377a)
  -->


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




### Special Collector's CryptoKitties

- [Genesis Kittie](https://www.cryptokitties.co/kitty/1) #1 (Cattributes: Exclusive Genesis) - sold for $115 000
- [First Xmas Kittie](https://www.cryptokitties.co/kitty/174756) #174756 (Cattributes: Fancy Mistletoe) 
- [Ho Ho Ho - First Santa Claus Kittie](https://www.cryptokitties.co/kitty/275808)  #275808 (Cattributes: Fancy SantaClaws)
- [Kitty No. 100 000](https://www.cryptokitties.co/kitty/100000) #100000 - celebrating 100 000 CryptoKitties (on Dec/5)


**[Official WikiLeaks CryptoKitties](https://wikileaks.shop/pages/cryptokitties)**.
Purebred WikiLeaks CryptoKitties arrive in time for Christmas.

> How it works. [Mr. WikiLeaks](https://cryptokitties.co/kitty/301923) and [Mrs. WikiLeaks](https://cryptokitties.co/kitty/363461) 
> are two Generation 0 CryptoKitties. WikiLeaks will keep scarcity by breeding only one kitten per week 
> after the initial Christmas litter of 10 (of which only 8 will be for sale). 
> Kitties can be renamed and resold or gifted by their new owners. Their authenticity can be verified on the blockchain.
> WikiLeaks CryptoKitties will be auctioned at a variety of prices, starting at the highest bidding price which will decrease over the 
> course of the four day auction or until a buyer acquires the kitty.



### Sales Statistics

|Date    | Total Sales | Total Unique Kittens | Total Sold (ETH) | Total Sold ($) | Average Sale Price | Median Sale Price  |
|--------|-------------|----------------------|------------------|----------------|--------------------|--------------------|
| Dec/23 |     220 946 |              174 122 |    35 631.34 ETH | $17 471 050.47 |      $79.07        |  $14.06            |
| Dec/9  |      97 830 |               79 233 |    25 699.86 ETH | $12 030 567.96 |     $122.97        |  $23.15            |

Source: [CryptoKitties Sales](https://kittysales.co)



### Articles

_CryptoKitties marks the beginning of a (massive) digital revolution. To understand why, learn about the blockchain, blockchain, blockchain._

[**Why we’re not doing an Initial Coin Offering (ICO)**](https://www.axiomzen.co/news/article/why-were-not-doing-an-initial-coin-offering-ico) by Benny Giang (Axiom Zen, Vancouver, Canada), November 2017 

> CryptoKitties is not holding an Initial Coin Offering (ICO). 
> Instead, we're offering utility from day one and pursuing a sustainable revenue model based on our games' mechanics.

[**Cryptokitties @ Wikipedia**](https://en.wikipedia.org/wiki/Cryptokitties)

> CryptoKitties offers something similar to a cryptocurrency: each CryptoKitty is one-of-a-kind, 100% owned by the user, validated
> through the blockchain, and the value can appreciate or depreciate based on the market.
> Cryptokitties cannot be replicated, taken away, or destroyed. 


[**CryptoKitties & Fun-tier Technologies**](https://medium.com/@vijayssundaram/cryptokitties-fun-tier-technologies-8e73903b98fc)
by Vijay Sundaram, December 2017

> These tokens ought to primarily flow to users and partners who participate in a well-designed economy, 
> rather than just speculate on it. Almost by definition this approach will pay off even if the crypto tide goes out.


[**People are spending $millions on digital cats and here's why it makes sense**](https://medium.com/swlh/people-are-spending-millions-on-digital-cats-and-heres-why-it-make-sense-aea431740bcf) 
by Tony Aubé, December 2017 -- Crypto Kitties is about so much more than cats.

> The blockchain changes everything we thought we knew about computers. 
> By removing one of the computer's biggest feature - the ability to duplicate information - it opens up computing 
> to a multitude of new, real-world use-cases that would have never been possible before.




### Questions & Answers

_Tech_

**Q: Couldn't CryptoKitties be hosted on many types of databases besides a blockchain?**

> A: Crypto-collectibles have key properties that proprietary digital collectibles didn't: 
> longevity, code-enforced scarcity and rules, resistance to actions of sponsoring company. 
> Much closer to non-digital collectibles like baseball cards than pre-crypto digital goods.
>
> -- [Chris Dixon](https://twitter.com/cdixon/status/937671322724982784)


_Legal_

**Q: Do you really own your CryptoKitties?**

> A: Spoiler: No.
>
> CryptoKitties are made up of two pieces: the DNA written to the blockchain, and the graphics 
> assembled to represent each CryptoKitty. Axiom Zen owns the graphics, 
> and makes it clear you have no rights to those in their Terms of Use.
>
> -- [Greg McMullen](https://medium.com/@gmcmullen/do-you-really-own-your-cryptokitties-d2731d3491a9)


_Market & Gaming / Investing_


**Q: What's the cost of playing?**

A:

* Price of kitties that you purchase.
* Fees for breeding two kitties together (about $0.50 to $0.60 as of 3rd December 2017).
* Fees for listing the sale auction to sell your kitties (about $0.20 as of 3rd December 2017).
* Additional funds in your wallet to allow the transactions to occur.

> We have dropped the birthing fee from 0.015 ETH to 0.008 ETH. Happy breeding everyone!
> 
> -- [CryptoKitties](https://twitter.com/CryptoKitties/status/940302318792163328) - Dec/11



**Q: What's the population? How many gen0 kitties will there be?**

A: 50_000 – Every 15 minutes a new gen0 kitty gets added (that is, 672 kitties per week) 
until reaching a limit of 50_000 in one year (end of November 2018).



**Q: What make's a kitty good?**

A: The generation, cooldown speed, traits, and all affect the overall price and desirability of the kitties.
Generally, anything gen(eration) 0/1/2/3/4, with fast/swift/snappy/brisk is a good kitty. Rare traits make it even better.

**Generation.** The best generation of kitty is Gen 0. 
The lower the generation number, the better starting cooldown the kitty is born with. 

When breeding two kitties together, the resulting generation will be one higher than the highest generation parent. 
For example:

* If a Gen 0 and Gen 0 breed, the kitten will be Gen 1. 
* If a Gen 5 and Gen 5 breed, the kitten will be Gen 6.
* If a Gen 0 and a Gen 5 breed, the kitten will be Gen 6.

**Cooldowns.**  Each time a kitty breeds another kitty it needs a
period of cooldown time to recover. The cooldown wait time increases (moves down one level) each time the kitty breeds
until it reaches "catatonic" cooldown, where it will remain.


| Cooldowns  | Time to recover |
|------------|-----------------|
| Fast       |              1m |
| Swift      |         2m - 5m |
| Snappy     |       10m - 30m |
| Brisk      |         1h - 2h |
| Plodding   |         4h - 8h |
| Slow       |       16h - 24h |
| Sluggish   |         2d - 4d |
| Catatonic  |          1 week |

For example a generation 2 kitty will start off with a swift cooldown when born, and a generation 14 will be born with a plodding cooldown.


**Traits.** Certain traits are rarer than others, making the Kitty more desirable. 
As more kitties are bred with these traits and new traits are discovered, the value of each one can change.

Traits include:

- Body and Tail: Chartreux Cymric Himalayan Laperm Mainecoon Munchkin Ragamuffin Sphynx
- Pimary Color: Mauveover Cloudwhite Cottoncandy Salmon Shadowgrey Orangesoda Topaz Greymatter Cottoncandy Oldlace
- Secondary Color: Peach Bloodred Emeraldgreen Granitegrey Kittencream
- Pattern: Spock Tigerpunk Calicool Luckystripe Jaguar Totesbasic
- Pattern Color: Barkbrown Cerulian Chocolate Coffee Lemonade Royalpurple Scarlet Skyblue Swampgreen Violet Wolfgrey
- Eye Type: Wingtips Fabulous Otaku Raisedbrow Simple Crazy Thicccbrowz Googly
- Eye Color / Background Color: Bubblegum Chestnut Gold Limegreen Mintgreen Sizzurp Strawberry Topaz
- Mouth:  Whixtensions Dali Saycheese Beard Tongue Happygokitty Pouty Soserious Gerbil

**Q: What are rare traits?**

A: Use these website services:

- [CryptoKittydex Cattributes](https://cryptokittydex.com/cattributes) 
- [Kitty Explorer Cattributes](http://www.kittyexplorer.com/kitties/?cattributes=whixtensions)

Currently oldlace (81 kitties), wolfgrey (146 kitties), and gerbil (185 kitties) are the three rarest.



See the [Crypto Kitty World F.A.Q.](http://cryptokittyworld.com/faq/) 
or the [Crypto Kitties Wiki](http://cryptokitties.wikia.com/wiki/CryptoKitties_Wiki) for many more questions and answers.


#### More Questions & Answers

Ask the [CryptoKitty team anything! @ CryptoKitties Reddit](https://www.reddit.com/r/CryptoKitties/comments/7kowyy/ask_the_cryptokitty_team_anything/) - Dec/14

CryptoKitty Team @ Axiom Zen (Vancouver, Canada) Attending:
- Arthur Camara / Developer / twitter: [arthur_camara](https://twitter.com/arthur_camara), reddit: [arthurcamara1](https://www.reddit.com/u/arthurcamara1)
- Fabiano Pereira / Smart Contract Developer / twitter: [FlockonUS](https://twitter.com/FlockonUS), reddit: [flockonus](https://www.reddit.com/u/flockonus)
- Dieter Shirley / Technical Architect / twitter: [dete73](https://twitter.com/dete73), reddit: [dete73](https://www.reddit.com/u/dete73)
- Mack Flavelle / Product / twitter: [mackflavelle](https://twitter.com/mackflavelle), reddit: [mackflavelle](https://www.reddit.com/u/mackflavelle)
- Benny Giang / Product  / twitter: [BennyGiang](https://twitter.com/BennyGiang), reddit: [nezmoixa](https://www.reddit.com/u/nezmoixa)
- Layne LaFrance / Product / twitter: [laynelafrance](https://twitter.com/laynelafrance), reddit: [laynee77](https://www.reddit.com/u/laynee77)

**Q: Where do you see CryptoKitties 6 months from now?**

_Arthur Camara_:
6 months from now: there'll be tons of new genes, fancy cats, new features that enhance the gameplay. Managing larger collections will be easy and fun. Cats of all prices will be meaningful and we'll find new ways for people to play with their kitties. We want to enhance the meaning of ownership and make it even more fun.

  * * *

**Q: Can you please return the cat names to the breeding screen?**

_Benny Giang_:
Cat names was an awesome way to have personality in the marketplace but unfortunately, 
there were too many people taking advantage 
and tricking new users.

> Q: How does having names in the breeding screen trick new users? They're your own cats...
>
>> I list my gen 15 cat for sale and name it "RARE gen 0 SANTA mom" 
>> and new people not yet understanding how things work buy it. That was happening ALOT.

  * * *
   
**Q: We have 365k kitties now and under 196k total sales (kitties traded or sired). 
That combined with the drop in values suggests that the demand isn't keeping pace with the supply
[...] causing the market to tank. What do you think caused the crash? 
Are you working on strategies to increase kitty values or do you want the value to stabilize at $1 per cat or so as rumored?**

**Q: Any plans to make the market more sustainable for small investors? 
Currently, someone who invests only $10 can barely buy two kitties, let alone cover the cost to breed them. 
To make that worse, the likelihood that they'll be able to sell the offspring is minimal. What's your take?**

**Q: Any modification in plan regarding the mass supply of Gen 0s overcoming the demand?**

_Mack Flavelle_: To be honest, the market has been unpredictable for users and for us. We don't have any more visibility 
on what will happen next than any other user.

The market excelled much more quickly than we expected - the Gen 0 pricing is 50% more than the average of the last 5 kitties so it is completely determined by the market not us.

We really do believe that long term the kitties will capture a ton of value for users and fans, 
but it's important to remember that CryptoKitties is a decentralized game. 
We have very little control on the economy for good or for bad. 

Q1 of 2018 we have plans to stabilize the economy and reduce the volatility - in the long run we believe the kitties will be valuable.

Over time the economy will expand to be truly fun and valuable for high net worth players and new, exploratory players - a bigger, healthier economy creates value for everyone inside it. 


_Arthur Camara_: 
I believe we're building long term value to CryptoKitties with amazing features that are coming, new ways to play with the kitties, 
new interactions. And remember: there will only ever be 50,000 gen0 kitties, we are constantly adding features, fancy kitties are constantly being discovered.


_Benny Giang_: There are some interesting ideas around limiting the supply of kitties that we will explore in 2018.


**Q: Please let us have a option to recycle / trash worthless kitties in exchange for something**

_Benny Giang_: Yup, a "kitty sink" could be useful for the market 
but there are also various of other viable solutions.


**Q: Where do you see CryptoKitties 6 years from now?**

_Arthur Camara_: CryptoKitties will be a global brand (way before that, actually). 
People will give CryptoKitties to their children 
on their first birthday. There'll be a complex ecosystem around the game, with lots of features and tools.



### More / Misc

**Kitty Raririty Calculator** Browser (Fan Add-on) Extension (github: [HaJaeKyung/KittyExtension](https://github.com/HaJaeKyung/KittyExtension)) by Ha Jae Kyung -- gives color coded rarity info by hovering; Pink: ultra rare,
Orange: very rare,
Purple: rare,
Blue: uncommon,
White: common

**Kitty Offspring Guesser / Cattribute Predictor** (web: [kitty.services](http://www.kitty.services)) -- Genetics Fur Cats: Premier genetic testing services for your CryptoKitties based on machine learning and the blockchain - put in the IDs of your parents-to-be and we'll let you know what their offspring will look like.



## CryptoPuppies (Yes, Cute Little Cartoon Dogs) on the Blockchain! (Upcoming)

Collectable. Breedable. Adorable. 

Learn more @ [cryptopuppies.org](http://cryptopuppies.org), twitter: [CryptoPuppies_](https://twitter.com/CryptoPuppies_)

---

Learn more @ twitter: [Crypto_Puppies](https://twitter.com/Crypto_Puppies)



## CryptoPets on the Blockchain!  (Upcoming)

The first five animals to be sold off...
Please welcome the Dog, Galapagos Turtle, Giant Panda, T-Rex  and Unicorn  
as the founding species on CryptoPets!

> CryptoPets are the newest breed of animals on the block... blockchain that is. 
> Unlike cryptocurrencies, which require all tokens to be identical, 
> your CryptoPet will be the only one of its kind in the entire world. 
> These cute collectibles are cryptographically unique, non-fungible digital assets. 
> CryptoPets uses the immutability of blockchain technology to verify and prove that each CryptoPet 
> has its own special attributes and is entirely owned by you.  
> Each species will have variations in specific attributes, 
> including fur color, eye shape, paw, and feet type, to name a few.

Learn more @ [cryptopets.co](https://cryptopets.co), 
twitter: [CryptoPets](https://twitter.com/CryptoPets),
reddit: [CryptoPets](https://www.reddit.com/r/CryptoPets)




## CryptoTulips on the Blockchain!  (Upcoming)

Learn by Example from the Real World (Anno 1637) - Buy! Sell! Hold! 
Enjoy the Beauty of Admiral of Admirals, Semper Augustus and More.

Learn more @ [openblockchains/tulips](https://github.com/openblockchains/tulips)


## More Crypto Copycats on the Blockchain!

### CryptoMons(ters) on the Blockchain! (Upcoming)

Collect. Combat. Trade. Digital collectible (monster) cards on the blockchain.

> Every CryptoMons(ter) has his own DNA that defines his aspect and stats: 
> there are no two identical CryptoMons(ter).

Learn more @ [cryptomons.com](http://cryptomons.com), 
twitter: [cryptomons](https://twitter.com/cryptomons)


### CryptoDrome (CryptoHorses) on the Blockchain! (Upcoming)

Collect. Breed. Compete. Raise your own champions.

> We're CryptoHorses, and we were born to compete. Collect and become a champion of the CryptoDrome.

Learn more @ [cryptodrome.co](http://cryptodrome.co), 
twitter: [cryptodrome](https://twitter.com/cryptodrome)


### CryptoBirdies on the Blockchain! (Upcoming)

Buy. Sell. Breed birds. Hatch eggs.

> CryptoBirdies offers a new blockchain experience.
> CryptoBirdies is not just for Making Money. We want users to treat their birds as a real pet. 
> They could Breed, Feed them, and put them in a Open Area where Birds and their owners can interact with each other.

Learn more @
twitter: [CryptoBirdies](https://twitter.com/CryptoBirdies)


### CryptoBunnies on the Blockchain! (Upcoming)

Learn more @
twitter: [CryptoBunniesHQ](https://twitter.com/CryptoBunniesHQ),
reddit: [cryptobunnies](https://www.reddit.com/r/cryptobunnies)



## Meta

**License**

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The awesome list is dedicated to the public domain. Use it as you please with no restrictions whatsoever.
