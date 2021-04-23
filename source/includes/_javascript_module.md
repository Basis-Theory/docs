# Basis Theory JS

**BasisTheory.js** module allows consumers to tokenize any data they want within the browser of their customers, or at their backend systems. 
This will give you the power to continue to own the UX of your application, while still being able to off-load most of the risk and compliance of holding that data.


<aside class="warning">
<b>Warning</b> - If you're looking to use this module for storing payments cards, keep in mind that you will need to complete a <i>SAQ-A-PM</i> survey for Basis Theory to keep on file.
This survey will identify and enforce certain data protections for the PCI compliance of your frontend systems (ones touching the card data). 
</aside>

- [Install](#install)
- [Initialize](#initialize)
- [Tokenize](#tokenize)
- [Store Credit Card](#store-credit-card)
- [Examples](#examples)

# Install

```shell
npm install --save @Basis-Theory/basis-theory-js

# OR

yarn add @Basis-Theory/basis-theory-js
```

```html
<script src="https://js.basistheory.com"></script>
```

```javascript--node
// checkout shell and html language tabs
```

```typescript
// checkout shell and html language tabs
```

**BasisTheory.js** is available for including in your site directly from `https://js.basistheory.com` **or** installing it as a module, and bundling/hosting it yourself within your site, or using it in your backend systems.

# Initialize

```shell
// checkout other language tabs
```

```html
<!-- This adds a window/global BasisTheory variable -->
<script src="https://js.basistheory.com"></script>

<!-- Somewhere in your site code -->
<script>
    // Here is an example on where to init BasisTheory, making sure the page has fully loaded.
    window.addEventListener('load', async () => {
      await BasisTheory.init("test_1234567890");
      // use BasisTheory
    });  
</script>
```

```javascript--node
const BasisTheory = require('@Basis-Theory/basis-theory-js');

BasisTheory.init("test_1234567890").then(() => {
  // use BasisTheory
})
```

```typescript
import BasisTheory from '@Basis-Theory/basis-theory-js';

await BasisTheory.init("test_1234567890");
// use BasisTheory
```

`BasisTheory` instance should be initialized only once, and it can be done whenever it suits best your workflow.

<aside class="notice">
  Beware that single page applications may share BasisTheory instance across multiple routes, and calling init multiple times in the same instance will result in an error.
</aside>

You will need a [`public`](#application-types) Application [API key](#authentication) to initialize the `BasisTheory` instance, this will give you access to both `tokens` and `atomic` features within the module.

Parameter | Required | Type     | Description
--------- | -------- | -------- | -----------
`apiKey`  | true     | *string* | your public application's api key

The `init` method returns a short-lived `Promise` that resolves to the same `BasisTheory` instance. You may choose to ignore the yielded result, but it is strongly recommended to `await` for the `Promise` to resolve before performing any subsequent actions with `BasisTheory` instance.


> Make sure to replace `test_1234567890` with your API key.


# Tokenize

```
BasisTheory.tokens
```

General tokenization methods can be found under `tokens` service inside `BasisTheory` instance.

## createToken

```shell
# checkout other language tabs
```

```html
<script src="https://js.basistheory.com"></script>

<script>
  function tokenize() {
    const data = document.getElementById('data-input').value;
    BasisTheory.tokens.createToken(data).then((res) => {
      console.log(res.id)
    })
  }
</script>

<input id="data-input" type="text">
<button onclick="tokenize()">Tokenize</button>
```

```javascript--node
const BasisTheory = require('@Basis-Theory/basis-theory-js');

// sample data
const data = {
  encryptedField: '1vauq19af...',
  myFlag: true,
  values: [1, 2, 3, 4],
}

BasisTheory.tokens.createToken(data)
  .then(function (res) {
    console.log(res.id); //token to store in your system
  });
```

```typescript
import BasisTheory from '@Basis-Theory/basis-theory-js';

// sample data
const data = {
  encryptedField: '1vauq19af...',
  myFlag: true,
  values: [1, 2, 3, 4],
}

const { id } = await BasisTheory.tokens.createToken(data)
console.log(id); //token to store in your system

```

> Make sure you've [initialized](#initialize) BasisTheory

With `createToken` method, you can choose to tokenize plain or encrypted data, in any serializable format:

Parameter | Required | Type                                               | Description
--------- | -------- | -------------------------------------------------- | -----------
`data`    | true     | *string*, *number*, *boolean*, *object* or *array* | The data to tokenize

It returns a `Promise` that resolves to a `TokenCreateResponse` object:

Attribute   | Type     | Description
----------- | -------- | -----------
`id`        | *string* | Unique identifier of the token
`tenantId`  | *string* | The tenant ID which owns the token
`type`      | *string* | [Token type](#token-types)
`createdAt` | *string* | Created date of the token in ISO 8601 format

<!-- include metadata -->

Internally, `BasisTheory.tokens` calls [Create Token API](#create-token) and maps the response to [conventionally named](https://www.w3schools.com/js/js_conventions.asp) attributes.


## getToken

```shell
# checkout javascript--node and typescript language tabs
```

```html
<!-- We don't recommend fetching tokens at client-side -->
<!-- Checkout javascript--node and typescript language tabs. -->
```

```javascript--node
const BasisTheory = require('@Basis-Theory/basis-theory-js');

const id = '25e2cd6b-2373-4cce-b9a0-98a9c65f53fb'; // previously stored token id

BasisTheory.tokens.getToken(id)
  .then(function (token) {
    console.log(token.data);
  });
```

```typescript
import BasisTheory from '@Basis-Theory/basis-theory-js';

const id = '25e2cd6b-2373-4cce-b9a0-98a9c65f53fb'; // previously stored token id

const { data } = await BasisTheory.tokens.getToken(id);
console.log(data);
```

> Make sure you've [initialized](#initialize) BasisTheory

With `getToken` method, you can fetch tokenized data by a token id:

Parameter | Required | Type     | Description
--------- | -------- | -------- | -----------
`id`      | true     | *string* | The id of the token

It returns a `Promise` that resolves to a `GetTokenResponse` object:

Attribute    | Type     | Description
------------ | -------- | -----------
`id`         | *string* | Unique identifier of the token
`ownerId`    | *string* | The tenant ID which owns the token
`type`       | *string* | [Token type](#token-types)
`data`       | *any*    | The data provided when [creating the token](#createtoken)
`createdAt`  | *string* | Created date of the token in ISO 8601 format

<!-- `encryption` | *any*    | The [encryption](#encryption-request-object) data provided when [creating the token](#create-token) -->
<!-- `metadata` | *any* | The metadata provided when [creating the token](#create-token) -->

Internally, `BasisTheory.tokens` calls [Get Token API](#get-a-token) and maps the response to [conventionally named](https://www.w3schools.com/js/js_conventions.asp) attributes.


## deleteToken

```shell
# checkout javascript--node and typescript language tabs
```

```html
<!-- We don't recommend deleting tokens at client-side -->
<!-- Checkout javascript--node and typescript language tabs. -->
```

```javascript--node
const BasisTheory = require('@Basis-Theory/basis-theory-js');

const id = '25e2cd6b-2373-4cce-b9a0-98a9c65f53fb'; // previously stored token id

BasisTheory.tokens.delete(id)
  .then(function () {
    // token has been deleted
   });
```

```typescript
import BasisTheory from '@Basis-Theory/basis-theory-js';

const id = '25e2cd6b-2373-4cce-b9a0-98a9c65f53fb'; // previously stored token id

await BasisTheory.tokens.deleteToken(id);
// token has been deleted
```

> Make sure you've [initialized](#initialize) BasisTheory

With `deleteToken` method, you can delete tokenized data using a token id:

Parameter | Required | Type     | Description
--------- | -------- | -------- | -----------
`id`      | true     | *string* | The id of the token

It returns a `Promise` of `void`.

<!-- `encryption` | *any*    | The [encryption](#encryption-request-object) data provided when [creating the token](#create-token) -->
<!-- `metadata` | *any* | The metadata provided when [creating the token](#create-token) -->

Internally, `BasisTheory.tokens` calls [Delete Token API](#delete-token).

# Atomic

```
BasisTheory.atomic
```

## storeCreditCard

```shell
# checkout other language tabs
```

```html
<script src="https://js.basistheory.com"></script>

<script>
  function storeCreditCard() {
    const data = {
      card: {
        number: '4242424242424242',
        expirationMonth: 10,
        expirationYear: 25,
        cvc: '000',
      },
      billingDetails: {
        name: 'Fiona Theory',
      },
    };
    BasisTheory.atomic.storeCreditCard(data).then((res) => {
      console.log(res.id)
    })
  }
</script>
```

```javascript--node
const BasisTheory = require('@Basis-Theory/basis-theory-js');

const data = {
  card: {
    number: '4242424242424242',
    expirationMonth: 10,
    expirationYear: 25,
    cvc: '000',
  },
  billingDetails: {
    name: 'Fiona Theory',
  },
};

BasisTheory.atomic.storeCreditCard(data).then((res) => {
  console.log(res.id)
})
```

```typescript
import BasisTheory from '@Basis-Theory/basis-theory-js';

const data = {
  card: {
    number: '4242424242424242',
    expirationMonth: 10,
    expirationYear: 25,
    cvc: '000',
  },
  billingDetails: {
    name: 'Fiona Theory',
  },
};

const { id } = await BasisTheory.atomic.storeCreditCard(data);
console.log(res.id);
```

> Make sure you've [initialized](#initialize) BasisTheory

With `storeCreditCard` method, you can tokenize any credit card to securely store and integrate with you `atomic cards`, in any way you need.

In most scenarios, this reliefs the burden of full PCI compliance.

Attribute        | Required | Type     | Description
---------------- | -------- | -------- | -----------
`card`           | true     | *object* | [CardModel object](#cardmodel)
`billingDetails` | false    | *object* | [BillingDetailsModel object](#billingdetailsmodel)

### CardModel

Attribute         | Required | Type              | Description
----------------- | -------- | ----------------- | -----------
`number`          | true     | *string*          | The card number without any separators
`expirationMonth` | true     | *integer*         | Two-digit number representing the card's expiration month
`expirationYear`  | true     | *integer*         | Four-digit number representing the card's expiration year

### BillingDetailsModel

Attribute | Required | Type      | Description
--------- | -------- | --------- | -----------
`name`    | false    | *string*  | The cardholder or customer's full name
`email`   | false    | *string*  | The cardholder or customer's email address
`phone`   | false    | *string*  | The cardholder or customer's phone number
`address` | false    | *object* | The cardholder or customer's [address](#addressmodel)

### AddressModel

Attribute     | Required | Type     | Description
------------- | -------- | -------- | -----------
`line1`       | false    | *string* | Address line 1 (Street address / PO Box / Company name)
`line2`       | false    | *string* | Address line 2 (Apartment / Suite / Unit / Building)
`city`        | false    | *string* | City / District / Suburb / Town / Village
`state`       | false    | *string* | State / County / Province / Region
`postal_code` | false    | *string* | Zip or postal code
`country`     | false    | *string* | Two-character ISO country code (e.g. `US`)


# Examples

We have 2 fully functional examples for how to use our javascript modules to store any data you want into your token infrastructure.

## Store PII example
We have a vanilla javascript example that will enable you to create PII in a browser, tokenize it and get a token back to be stored within your system.

[Check it out here](https://github.com/Basis-Theory/basis-theory-js/blob/main/examples/pii.html)

## Store credit card example
If you have the correct PCI compliant systems and certifications, you'll be able to create atomic cards from within your code using our vanilla javascript example. Follow it here:

[Check it out here](https://github.com/Basis-Theory/basis-theory-js/blob/main/examples/credit_card.html)
