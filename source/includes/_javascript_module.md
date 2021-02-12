# Javascript Module

# Overview

The `javascript` module will allow consumers to tokenize any data they want within the browser of their customers. 
This will give you the power to continue to own the UX of your application, while still being able to off-load most of the risk and compliance of holding that data.

<aside class="warning">
<b>Warning</b> - If you're looking to use this module for storing payments cards, keep in mind that you will need to complete a <i>SAQ-A-PM</i> survey for Basis Theory to keep on file.
This survey will identify and enforce certain data protections for the PCI compliance of your frontend systems (ones touching the card data). 
</aside>

- [Initialize](#js-initialize)
- [Encrypt](#js-encrypt)
- [Tokenize](#js-tokenize)
- [Store Credit Card](#js-store-credit-card)

# JS - Initialize

> To initialize, use this code:

```javascript
const BasisTheory = require('basis-theory');

BasisTheory.init("test_1234567890")
```

```shell
const BasisTheory = require('basis-theory');

BasisTheory.init("test_1234567890")
```

> Make sure to replace `test_1234567890` with your API key.

You will need a [public api key](#public-key) to initialize the Basis Theory javascript module, this will give you access to 
both the `vault` and `payments` features within the module. 

Parameter | Description
--------- | -----------
api_key | your application's public api key


# JS - Encrypt
> To encrypt, use this code:

```javascript
const keyPair = BasisTheory.encryption.generateKeyPair(); // replace with your own public key
const pii = { name: "Fiona", dob: "02/12/70" };

BasisTheory.encryption
          .encrypt(keyPair.publicKey, JSON.stringify(pii))
          .then(function (encrypted) {
              console.log(encrypted); // encrypted cipher text 
          });
```

```shell
const pii = { name: "Fiona", dob: "02/12/70" };

BasisTheory.encryption
          .encrypt(keyPair.publicKey, JSON.stringify(pii))
          .then(function (encrypted) {
              console.log(encrypted); // encrypted cipher text 
          });
```

> Make sure you've initialized BasisTheory

You are able to encrypt any data with our encryption helpers. Just pass the data through the helpers before creating a token!  

Parameter | Description
--------- | -----------
encryption_key | a public key you wish to encrypt with
data | string data you wish to encrypt

# JS - Tokenize
> To tokenize data, use this code:

```javascript
const encrypted_data = "1vauq19af..."; //cipher text from encrypted data

BasisTheory.vault.createToken(encrypted_data)
  .then(function (res) {
        console.log(res.id); //token to store in your system
    });
```

```shell
const encrypted_data = "1vauq19af..."; //cipher text from encrypted data

BasisTheory.vault.createToken(encrypted_data)
  .then(function (res) {
        console.log(res.id); //token to store in your system
    });
```

> Make sure you've initialized BasisTheory

You are able to encrypt any data with our encryption helpers. Just pass the data through the helpers before creating a token!

Parameter | Description
--------- | -----------
data | string or object data to tokenize

# JS - Store Credit Card

> To initialize, use this code:

```javascript
BasisTheory.payments
  .storeCreditCard({
    cardNumber: "4242424242424242",
    holderName: "James Armstead",
    expiration: "10/24",
    cvv: "999",
  })
  .then(function (card) {
    console.log(card.id); // token to store in your system
  });
```

```shell
BasisTheory.payments
  .storeCreditCard({
    cardNumber: "4242424242424242",
    holderName: "Fiona Theory",
    expiration: "10/24",
    cvv: "999",
  })
  .then(function (card) {
    console.log(card.id); // token to store in your system
  });
```

> Make sure you've initialized BasisTheory

Tokenize a credit card to be able to use later. 

Parameter | Description
--------- | -----------
cardNumber | Credit card number to store
holderName | Name on the credit card
expiration | Expiration date on the card
cvv        | Verification code on the card 

