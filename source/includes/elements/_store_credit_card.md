# Store Credit Card

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

Allows secure submission and tokenization of a card element. Returns a `Promise` that resoles to the tokenized card data. See [CardModel](#element-types-card-element) for the resolved value type.

Internally, `BasisTheory.elements.storeCreditCard` calls [Create Atomic Card API](api-reference/#atomic-cards-create-atomic-card).

You can fetch this same data later with [Get an Atomic Card API](api-reference/#atomic-cards-get-an-atomic-card-reaction-token).

<aside class="notice">
  <span>Notice that the actual card data never leaves the element (iframe) other than to hit our secure API endpoints.</span>
</aside>

## storeCreditCard Errors

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
