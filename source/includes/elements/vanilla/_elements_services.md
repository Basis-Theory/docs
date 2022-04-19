# Elements Services

The following **BasisTheory.js** services are capable of recognizing Elements instances in the payload and securely tokenizing their data directly to Basis Theory vault. 

## Atomic Cards <span class="deprecated menu">DEPRECATED</span>

<aside class="danger">
  <span>This service has been deprecated in favor of <a class="black-link" href="#elements-services-tokens">Tokens</a></span>
</aside>

```javascript
BasisTheory.atomicCards.create({
  card: cardElement,
}).then((token) => {
  console.log(token.id); // token to store
  console.log(JSON.stringify(token.card)); // redacted card data
});
```

Allows secure submission and tokenization of a card element. Returns a `Promise` that resolves to the tokenized card data.
See [CardModel](#element-types-card-element) for the resolved value type. The `Promise` will reject with an [error](#elements-services-errors)
if the response status is not in the 2xx range.


You can fetch this same data later with [Get a token API](/api-reference/#tokens-get-a-token).

<aside class="notice">
  <span>Notice that the actual card data never leaves the element (iframe) other than to hit our secure API endpoints.</span>
</aside>

## Atomic Banks <span class="deprecated menu">DEPRECATED</span>

<aside class="danger">
  <span>This service has been deprecated in favor of <a class="black-link" href="#elements-services-tokens">Tokens</a></span>
</aside>

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


You can fetch this same data later with [Get a token API](/api-reference#tokens-get-a-token).

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

```javascript
// tokenizing card element
BasisTheory.tokens.create({
  type: 'card',
  data: cardElement,
}).then((token) => {
  console.log(token.id); // token to store
  console.log(JSON.stringify(token.data)); // redacted card data
});
```

```javascript
// tokenizing bank details with text element
BasisTheory.tokens.create({
  type: 'bank'
  data: {
    routingNumber: routingNumberElement | 'plainText',  // values can be either a TextElement or plain text (see warning).
    accountNumber: accountNumberElement | 'plainText',
  },
}).then((token) => {
  console.log(token.id); // token to store
  console.log(JSON.stringify(token.data)); // redacted bank data
});
```

Allows secure submission and tokenization of primitive data and card or text elements. Returns a `Promise` that resolves to the created token. The
`Promise` will reject with an [error](#elements-services-errors) if the response status is not in the 2xx range.

You can fetch this same data later with [Get a Token API](/api-reference#tokens-get-a-token)

<aside class="notice">
  <span>Notice that the actual input data never leaves the element (iframe) other than to hit our secure API endpoints.</span>
</aside>

<aside class="warning">
  <span>Note that when submitting <code>plainText</code> values, data will be HTML encoded before storage for security reasons.
</aside>

<aside class="warning">
  <span>The <code>children</code> attribute supported by the API is <strong>NOT</strong> supported when creating a token with elements.</span>
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

```javascript
// tokenizing multiple card elements
BasisTheory.tokenize({
  card1: {
  type: 'card',
  data: cardElement1,
},
card2: {
  type: 'card',
  data: cardElement2,
}
}).then((token) => {
  console.log(JSON.stringify(token)); // encrypted token data
});
```

```javascript
// tokenizing multiple bank details with text elements
BasisTheory.tokenize({
  bank1: {
  type: 'bank'
  data: {
    routingNumber: routingNumberElement1 | 'plainText',  // values can be either a TextElement or plain text (see warning).
    accountNumber: accountNumberElement1 | 'plainText',
  },
  bank2: {
  type: 'bank'
  data: {
    routingNumber: routingNumberElement2 | 'plainText',  // values can be either a TextElement or plain text (see warning).
    accountNumber: accountNumberElement2 | 'plainText',
  },
}
}).then((token) => {
  console.log(JSON.stringify(token)); // encrypted token data
});
```

Allows secure submission and tokenization of primitive data and card or text elements. Returns a `Promise` that resolves to the created tokens. The
`Promise` will reject with an [error](#elements-services-errors) if the response status is not in the 2xx range.

You can fetch this same data later with [Get a Token API](/api-reference#tokens-get-a-token)

<aside class="notice">
  <span>Notice that the actual input data never leaves the element (iframe) other than to hit our secure API endpoints.</span>
</aside>

<aside class="warning">
  <span>Note that when submitting <code>plainText</code> values, data will be HTML encoded before storage for security reasons.
</aside>

<aside class="warning">
  <span>The <code>children</code> attribute supported by the API is <strong>NOT</strong> supported when creating a token with elements.</span>
</aside>


## Errors

```jsx
// example of error details structure
{
  "details": {
    card1: {
      number: { type: 'invalid' },
      cvc: { type: 'incomplete' }
    },
    card2: {}
  }
}
```

```javascript
// handling the error
BasisTheory.tokens.create(bt.tokenize({
    card1: {
      type: 'card', 
      data: cardElement1
    },
    card2: {
      type: 'card', 
      data: cardElement2
    },
	  ssn: textElement
  } as MyPayload)).catch(error => {
  // handle error
  if(error.details.card1?.number?.type === 'incomplete') addMessage('Card 1 number is incomplete');
  if(error.details.card2?.number?.type === 'invalid') addMessage('Card 2 number is invalid');
});
```

In case any Elements service throws an error, that could be related to client-side validation or an unaccepted request from the server.

Attribute    | Type       | Scope  | Description
------------ | ---------- | ------ | -----------
`details`     | *`Record<string, any>`*   | client | Error details. Each value will have a [PropertyError](#elements-services-errors-propertyerror)
`data`       | *object*   | server | Response body sent from the server.
`status`     | *number*   | both   | Response HTTP status or `-1` if the request never left the client (i.e. connection issues)
~~`validation`~~ | *array*    | client | [Deprecated in favor of details](#deprecations-deprecated-features). Array of [FieldError](#element-events-on-change-fielderror), in case of client-side error. 

### PropertyError

```jsx
{
  "type": "invalid"
}
```

Attribute  | Type       | Description
---------- | ---------- | -----------
`type`     | *"invalid"* or *"incomplete"*   | Type of the error.
