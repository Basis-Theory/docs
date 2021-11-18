# Elements Services

## Store Credit Card

```javascript
BasisTheory.elements.storeCreditCard({
  card: cardElement,
  billingDetails: {
    name: 'Fiona Theory'  
  }
}).then((token) => {
  console.log(token.id); // token to store
  console.log(JSON.stringify(token.card)); // redacted card data
});
```

Allows secure submission and tokenization of a card element. Returns a `Promise` that resolves to the tokenized card data. See [CardModel](#element-types-card-element) for the resolved value type.

Internally, `BasisTheory.elements.storeCreditCard` calls [Create Atomic Card API](/api-reference/#atomic-cards-create-atomic-card).

You can fetch this same data later with [Get an Atomic Card API](/api-reference/#atomic-cards-get-an-atomic-card).

<aside class="notice">
  <span>Notice that the actual card data never leaves the element (iframe) other than to hit our secure API endpoints.</span>
</aside>

### storeCreditCard Errors

```javascript
BasisTheory.elements.storeCreditCard(...).catch(error => {
  // handle error
});
```

In case `storeCreditCard` throws an error, that could be related to client-side validation or an unaccepted request from the server.

Attribute    | Type       | Scope  | Description
------------ | ---------- | ------ | -----------
`validation` | *array*    | client | Array of [FieldError](#element-events-on-change-fielderror), in case of client-side error.
`data`       | *object*   | server | Response body sent from the server.
`status`     | *number*   | both   | Response HTTP status or `-1` if the request never left the client (i.e. connection issues)

## Atomic Banks

```javascript
BasisTheory.elements.atomicBank.create({
  bank: {
    routingNumber: routingNumberElement | 'plainText',  // values can be either a TextElement or plain text (see warning).
    accountNumber: accountNumberElement | 'plainText',
  },
}).then((token) => {
  console.log(token.id); // token to store
  console.log(JSON.stringify(token.bank)); // redacted bank data
});
```

Allows secure submission and tokenization of a bank element. Returns a `Promise` that resolves to the tokenized bank data.

Internally, `BasisTheory.elements.atomicBanks.create` calls [Create Atomic Bank API](/api-reference#atomic-banks-create-atomic-bank).

You can fetch this same data later with [Get an Atomic Bank API](/api-reference#atomic-banks-get-an-atomic-bank).

<aside class="notice">
  <span>Notice that the actual bank data never leaves the element (iframe) other than to hit our secure API endpoints.</span>
</aside>

<aside class="warning">
  <span>Note that when submitting <code>plainText</code> values, data will be HTML encoded before storage for security reasons.
</aside>

### atomicBank Errors

```javascript
BasisTheory.elements.atomicBank.create(...).catch(error => {
  // handle error
});
```

In case `atomicBank.create` throws an error, that could be related to client-side validation or an unaccepted request from the server.

Attribute    | Type       | Scope  | Description
------------ | ---------- | ------ | -----------
`validation` | *array*    | client | Array of [FieldError](#element-events-on-change-fielderror), in case of client-side error.
`data`       | *object*   | server | Response body sent from the server.
`status`     | *number*   | both   | Response HTTP status or `-1` if the request never left the client (i.e. connection issues)
