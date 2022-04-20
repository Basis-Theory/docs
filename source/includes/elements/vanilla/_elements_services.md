# Elements Services

The following **BasisTheory.js** services are capable of recognizing Elements instances in the payload and securely tokenizing their data directly to Basis Theory vault. 

## Tokens

> Create generic token

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
  console.log(token.id); // token to store
  console.log(JSON.stringify(token)); // encrypted token data
});
```

> Tokenize card element

```javascript
BasisTheory.tokens.create({
  type: 'card',
  data: cardElement,
}).then((token) => {
  console.log(token.id); // token to store
  console.log(JSON.stringify(token.data)); // redacted card data
});
```

> Tokenize bank details

```javascript
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

Allows secure submission and tokenization of primitive data and elements. Returns a `Promise` that resolves to the created token. The
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

> Tokenize data

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
  console.log(token.id); // token to store
  console.log(JSON.stringify(token)); // encrypted token data
});
```

> Tokenize multiple card elements

```javascript
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
  console.log(token.id); // token to store
  console.log(JSON.stringify(token)); // encrypted token data
});
```

> Tokenize multiple bank details

```javascript
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
  console.log(token.id); // token to store
  console.log(JSON.stringify(token)); // encrypted token data
});
```

Allows secure submission and tokenization of primitive data and elements. Returns a `Promise` that resolves to the created tokens. The
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

Any elements service could throw an error based on [client-side validations](#elements-services-errors-client) or if the [server rejects the request](#elements-services-errors-server).

### Client

> Error details structure

```jsx
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

Attribute    | Type        | Description
------------ | ---------- | ------ | -----------
`details`     | *object*    | Maps payload properties to their respective elements errors. Each failing element value will translate to a [PropertyError](#elements-services-errors-propertyerror) object.
~~`validation`~~ | *array*    | [Deprecated in favor of details](#deprecations-deprecated-features). Array of [FieldError](#element-events-on-change-fielderror), in case of client-side error. 

#### PropertyError

> Property error

```jsx
{
  "type": "invalid"
}
```

Attribute  | Type       | Description
---------- | ---------- | -----------
`type`     | *"invalid"* or *"incomplete"*   | Type of the error.


### Server

Attribute    | Type        | Description
------------ | ---------- | ------ | -----------
`data`       | *object*   | Response body sent from the server.
`status`     | *number*   | Response HTTP status.

> Handling an error

```javascript
import {
    BasisTheoryApiError,
    BasisTheoryValidationError
} from '@basis-theory/basis-theory-js/common';

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
})).catch(error => {
    // handle error

    if (error instanceof BasisTheoryValidationError) {
        // check error details
    }

    if (error instanceof BasisTheoryApiError) {
        // check error data or status
    }
});
```