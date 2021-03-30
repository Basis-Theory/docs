# Javascript Module

# Overview

The `javascript` module will allow consumers to tokenize any data they want within the browser of their customers. 
This will give you the power to continue to own the UX of your application, while still being able to off-load most of the risk and compliance of holding that data.

<aside class="warning">
<b>Warning</b> - If you're looking to use this module for storing payments cards, keep in mind that you will need to complete a <i>SAQ-A-PM</i> survey for Basis Theory to keep on file.
This survey will identify and enforce certain data protections for the PCI compliance of your frontend systems (ones touching the card data). 
</aside>

- [Examples](#js-examples)
- [Initialize](#js-initialize)
- [Tokenize](#js-tokenize)
- [Store Credit Card](#js-store-credit-card)

# JS - Examples

We have 2 fully functional examples for how to use our javascript modules to store any data you want into your token infrastructure.

## Store PII example
We have a vanilla javascript example that will enable you to create PII in a browser, tokenize it and get a token back to be stored within your system.

[Check it out here](https://github.com/Basis-Theory/basis-theory-js/blob/main/examples/pii.html)

## Store credit card example
If you have the correct PCI compliant systems and certifications, you'll be able to create atomic cards from within your code using our vanilla javascript example. Follow it here:

[Check it out here](https://github.com/Basis-Theory/basis-theory-js/blob/main/examples/credit_card.html)

# JS - Initialize

> To initialize, use this code:

```javascript
const BasisTheory = require('basis-theory');

BasisTheory.init("test_1234567890")
```

```shell
// checkout the javascript tab
```

> Make sure to replace `test_1234567890` with your API key.

You will need a [public api key](#public-key) to initialize the Basis Theory javascript module, this will give you access to 
both the `vault` and `payments` features within the module. 

Parameter | Description
--------- | -----------
api_key | your application's public api key

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
// checkout the javascript tab
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
  .storeCreditCard(
    {
      card: {
        number: "4242424242424242",
        expiration_month: 10,
        expiration_year: 25,
        cvc: "000",
      },
      billing_details: {
        name: "Fiona Theory",
      }
    })
  .then(function (card) {
    console.log(card.id); // token to store in your system
  });
```

```shell
// checkout the javascript tab
```

> Make sure you've initialized BasisTheory

Tokenize a credit card to be able to use later. 

Parameter | Description
--------- | -----------
card.number | credit card number
card.expiration_month | month the card will expire
card.expiration_year | year the card will expire
card.cvc | the verification code for the card (used to validate the card)
billing_details.name | name associated with the card

