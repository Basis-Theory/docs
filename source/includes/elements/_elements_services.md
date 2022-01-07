# Elements Services

The following **BasisTheory.js** services are capable of recognizing Elements instances in the payload and securely tokenizing their data directly to Basis Theory vault. 

## Atomic Cards

```javascript
BasisTheory.atomicCards.create({
  card: cardElement
}).then((token) => {
  console.log(token.id); // token to store
  console.log(JSON.stringify(token.card)); // redacted card data
});
```

Allows secure submission and tokenization of a card element. Returns a `Promise` that resolves to the tokenized card data.
See [CardModel](#element-types-card-element) for the resolved value type. The `Promise` will reject with an [error](#elements-services-errors)
if the response status is not in the 2xx range.


You can fetch this same data later with [Get an Atomic Card API](/api-reference/#atomic-cards-get-an-atomic-card).

<aside class="notice">
  <span>Notice that the actual card data never leaves the element (iframe) other than to hit our secure API endpoints.</span>
</aside>

## Atomic Banks

```javascript
BasisTheory.atomicBanks.create({
  bank: {
    routingNumber: routingNumberElement | 'plainText',  // values can be either a TextElement or plain text (see warning).
    accountNumber: accountNumberElement | 'plainText',
  },
}).then((token) => {
  console.log(token.id); // token to store
  console.log(JSON.stringify(token.bank)); // redacted bank data
});
```

Allows secure submission and tokenization of a bank element. Returns a `Promise` that resolves to the tokenized bank
data. The `Promise` will reject with an [error](#elements-services-errors) if the response status is not in the 2xx
range.


You can fetch this same data later with [Get an Atomic Bank API](/api-reference#atomic-banks-get-an-atomic-bank).

<aside class="notice">
  <span>Notice that the actual bank data never leaves the element (iframe) other than to hit our secure API endpoints.</span>
</aside>

<aside class="warning">
  <span>Note that when submitting <code>plainText</code> values, data will be HTML encoded before storage for security reasons.
</aside>

## Tokens

```javascript
BasisTheory.tokens.create({
  type: 'token',
  data: {
    sensitiveData: sensitiveDataElement,
    nonSensitiveData: 'plainText', // see warning on plain text data
    otherData: {
      someInteger: 20,
      someBoolean: false,
    },
    someOtherData: ['plainText1', 'plainText2'],
  },
  metadata: {
    nonSensitiveField: 'nonSensitiveValue'
  }
}).then((token) => {
  console.log(JSON.stringify(token)); // encrypted token data
});
```

Allows secure submission and tokenization of string data. Returns a `Promise` that resolves to the created token. The
`Promise` will reject with an [error](#elements-services-errors) if the response status is not in the 2xx range.

You can fetch this same data later with [Get a Token API](/api-reference#tokens-get-a-token) or [Get a Decrypted Token API](/api-reference#tokens-get-a-decrypted-token)

<aside class="notice">
  <span>Notice that the actual input data never leaves the element (iframe) other than to hit our secure API endpoints.</span>
</aside>

<aside class="warning">
  <span>Note that when submitting <code>plainText</code> values, data will be HTML encoded before storage for security reasons.
</aside>

<aside class="warning">
  <span>Currently only the <code>token</code> type is supported. Support for more types will be added in the future.</span>
</aside>

<aside class="warning">
  <span>The <code>encryption</code> and <code>children</code> attributes supported by the API are <strong>NOT</strong> supported when creating a token with elements.</span>
</aside>

## Tokenize

```javascript
BasisTheory.tokenize({
  sensitiveData: sensitiveDataElement,
  nonSensitiveData: 'plainText', // see warning on plain text data
  otherData: {
    someInteger: 20,
    someBoolean: false,
  },
  someOtherData: ['plainText1', 'plainText2'],
}).then((token) => {
  console.log(JSON.stringify(token)); // encrypted token data
});
```

Allows secure submission and tokenization of string data. Returns a `Promise` that resolves to the created tokens. The
`Promise` will reject with an [error](#elements-services-errors) if the response status is not in the 2xx range.

You can fetch this same data later with [Get a Token API](/api-reference#tokens-get-a-token) or [Get a Decrypted Token API](/api-reference#tokens-get-a-decrypted-token).

<aside class="notice">
  <span>Notice that the actual input data never leaves the element (iframe) other than to hit our secure API endpoints.</span>
</aside>

<aside class="warning">
  <span>Note that when submitting <code>plainText</code> values, data will be HTML encoded before storage for security reasons.
</aside>

<aside class="warning">
  <span>The <code>encryption</code> and <code>children</code> attributes supported by the API are <strong>NOT</strong> supported when creating a token with elements.</span>
</aside>


## Errors

```javascript
BasisTheory.tokens.create(...).catch(error => {
  // handle error
});
```

In case any Elements service throws an error, that could be related to client-side validation or an unaccepted request from the server.

Attribute    | Type       | Scope  | Description
------------ | ---------- | ------ | -----------
`validation` | *array*    | client | Array of [FieldError](#element-events-on-change-fielderror), in case of client-side error.
`data`       | *object*   | server | Response body sent from the server.
`status`     | *number*   | both   | Response HTTP status or `-1` if the request never left the client (i.e. connection issues)


## Store Credit Card <span class="deprecated menu">DEPRECATED</span>

<aside class="danger">
  <span>This endpoint has been deprecated in favor of <a class="black-link" href="#elements-services-atomic-cards">Atomic Cards</a></span>
</aside>

```javascript
BasisTheory.elements.storeCreditCard({
  card: cardElement,
}).then((token) => {
  console.log(token.id); // token to store
  console.log(JSON.stringify(token.card)); // redacted card data
});
```

Allows secure submission and tokenization of a card element. Returns a `Promise` that resolves to the tokenized card
data. See [CardModel](#element-types-card-element) for the resolved value type. The `Promise` will reject with an
[error](#elements-services-errors) if the response status is not in the 2xx range.

Internally, `BasisTheory.elements.storeCreditCard` calls [Create Atomic Card API](/api-reference/#atomic-cards-create-atomic-card).

You can fetch this same data later with [Get an Atomic Card API](/api-reference/#atomic-cards-get-an-atomic-card).

<aside class="notice">
  <span>Notice that the actual card data never leaves the element (iframe) other than to hit our secure API endpoints.</span>
</aside>
