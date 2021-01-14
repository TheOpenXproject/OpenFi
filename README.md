# OpenFi
 OpenFi plans to give Users the ability to manage their tokens on Harmony Blockchain the same way a bank web-portal allows you to manage your different bank acounts.



## OverView :



It plans to bring a Fiat gateway, secure pegged decentralized
cryptocurrencies (ex:  USD, CHF, EUR etc), 
Nfc solution that allows user to write their own cards and accept 
payment on aready exitant POS terminals //the whole idea is provide an OPEN banking solution with Low fees (taking advantage of 2s finality)
have Easy access of Decentralized exchanges directly on the OpenFi Dashboard 
have a simplified interface or candle chart for users who want to trade) //will start with a fork of uniswap. iv been thinking about porting DyDx too,



### Simplified Timeline :

1 build first version of dashboard with bugeting , contacts, trading, Liquidity mining, staking , statistics, Coin/Token management (Current Status)

2 build pegged Tokens To realword currencies,

3 bring fiat gateway so users can deposit Fiat money on an account and it mints the respective currency ideally 1:1 ratio but fees exist so maybe 1 : 0.99999 (user will be able to recieve sepa transfers in exchage for the pegged token to their bank account )

4 Develop web usb -> rfid for users to write their cards, encryptiton via password etc...

5 integrate OpenFi nfc to existing point of sale terminals


### This is NOT :

A short term project,
A platform that will have high fees
A private key management service

### This IS :

A new kind of project built to give ease of access to billions of users to a cheap bank alternative with the intent of users being in charge of their finances and private keys.

A decentralized Finance aggregator

Not Finished yet > true story




### The Project :

The project is planned to be built in a 2-3 year Time Frame. I find that this is a reasonable amout of time considering audits for the final product, rigorous testing, getting required governement authorizations
From FINMA (Swiss Financial Market Supervisory Authority FINMA) (Note that Swiss Laws Are very Open to Cryptocurrency though they require declaration of activity and crypto based income is not taxable)
It is currently In very early developement and planning stage. 


### Source Code :

The source code provided is not fully adapted to be built and tested but more of a proof of work. If you want to test it please follow this link : http://openfi.dev
it contains the basic web app and the smart contracts curently in developement and used on the link mentioned above.


### Documentation :

Documentation will be provided as the project development moves forward.


### Questions :

I will gladly answer any questions, im available on telegram as @noob_dev20. when the project will be mature enough to have social media  i will ask to be contacted from there.


# Project setup

make sure you setup your DOTENV file and truffle Config to work with harmony.

```
npm install
```
```
truffle compile
```

```
truffle migrate --network [choose network] --reset
```


#Project Source Info

the files provided in this repository use truffle for the contract migration and Vue + Vuetify for the web front end... if you need more info read the npm package JSON (though it needs a thourough cleanup haha)

## rough draft of web app FEATURES

WEB
features:
	-ledget/web wallet connect/ + others
	-manage transactions / arrange
	-account statistics
		detailed account spendings/earnings
		extract of accounts
		cost of service
	-account funds
		value of savings acc
		value of debit account
		how much invested
		+lots of other cool little details
	-investments
		portfolio
		staking
		liquidity provider
		investment returns
	-write nfc cards
	-create wallets for the nfc cards
	-manage multiple keys at once
	-never store user private key... EVER
	-Fiat GateWay
	-Multiple Exchanges
	-Multiple Liquidity Pools
	-Valitador manager (simplified terms and usage while providing more stats )
	-Delegator manager (same as above)



