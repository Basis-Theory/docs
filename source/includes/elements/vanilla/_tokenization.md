# Tokenization

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
  console.log(JSON.stringify(token)); // full response
});
```

> Create card token

```javascript
BasisTheory.tokens.create({
  type: 'card',
  data: cardElement,
}).then((token) => {
  console.log(token.id); // token to store
  console.log(JSON.stringify(token.data)); // redacted card data
});
```

> Create bank token

```javascript
BasisTheory.tokens.create({
  type: 'bank',
  data: {
    routingNumber: routingNumberElement,
    accountNumber: accountNumberElement,
  }
}).then((token) => {
  console.log(token.id); // token to store
  console.log(JSON.stringify(token.data)); // redacted bank data
});
```

> Tokenize data

```javascript
BasisTheory.tokenize({
  card1: {
    type: 'card',
    data: cardElement,
  },
  card2: {
    type: 'card',
    data: {
      number: cardNumberElement,
      expiration_month: cardExpirationDateElement.month(),
      expiration_year: cardExpirationDateElement.year(),
      cvc: cardVerificationCodeElement
    },
  },
  sensitiveData: sensitiveDataElement,
  nonSensitiveData: 'plainText', // see warning on plain text data
  otherData: {
    someInteger: 20,
    someBoolean: false,
  },
  someOtherData: ['plainText1', 'plainText2'],
}).then((tokens) => {
  console.log(tokens.card1.id, tokens.card2.id, tokens.sensitiveData); // token to store
  console.log(JSON.stringify(tokens)); // full response
});
```


Elements' values can be securely tokenized using [`tokens.create`](/#tokens-create-token) and [`tokenize`](/#tokenize)
services. To do that, simply pass the Element instance (or one of its [data parsing methods](#element-methods)) in the payload.

You can fetch this same data later with [Get a Token API](/api-reference#tokens-get-a-token)

<aside class="notice">
  <span>Notice that the actual input data never leaves the element (iframe) other than to hit our secure API endpoints.</span>
</aside>

<aside class="warning">
  <span>Note that when submitting <code>plainText</code> values, data will be HTML encoded before storage for security reasons.
</aside>

## Errors

Elements services could throw an error based on client-side validations or if the server rejects the request.

### BasisTheoryValidationError

> BasisTheoryValidationError

```tsx
{
  details: {
    card1: {
      number: {
        type: 'invalid'
      },
      cvc: {
        type: 'incomplete'
      }
    },
    card2: {
    }
  },
  validation: [] // deprecated
}
```

| Attribute        | Type     | Description                                                                                                                                                     | 
|------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `name`           | string   | Error name, always `'BasisTheoryValidationError'`.                                                                                                              |
| `details`        | *object* | Maps payload properties to their respective element's validation problems.                                                                                       |
| ~~`validation`~~ | *array*  | [Deprecated in favor of details](#deprecations-deprecated-features). Array of [FieldError](#element-events-on-change-fielderror), in case of client-side error. |

### BasisTheoryApiError

> BasisTheoryApiError

```tsx
{
  data: {
    // API response body
  },
  status: 400
}
```

| Attribute | Type     | Description                                     |
|-----------|----------|-------------------------------------------------|
| `name`    | string   | Error name, always `'BasisTheoryApiError'`.     |
| `data`    | *object* | Response body [sent from the server](/#errors). |
| `status`  | *number* | Response HTTP status.                           |

<aside class="notice">
  <span>Error <code>name</code> property may be used instead of checking its instance type.</span>
</aside>

> Handling services errors

```javascript
import {
  BasisTheoryApiError,
  BasisTheoryValidationError
} from '@basis-theory/basis-theory-js/common';

BasisTheory.tokenize({
  card1: {
    type: 'card',
    data: cardElement1
  },
  card2: {
    type: 'card',
    data: cardElement2
  },
  ssn: textElement
}).catch((error) => {
  if (error instanceof BasisTheoryValidationError) {
    // check error details
  } else if (error instanceof BasisTheoryApiError) {
    // check error data or status
  }
});
```
