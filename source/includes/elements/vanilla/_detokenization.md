# Detokenization

> Retrieve `string` token data and set value into TextElement

```javascript
const textElement = BasisTheory.createElement('text', { targetId: 'text-element' });

BasisTheory.tokens.retrieve('ca9f3fd7-3906-4087-83aa-9a6129221297', {
  apiKey: 'key_N88mVGsp3sCXkykyN2EFED' // api key is required and should belong to an 'expiring' application
}).then((token) => {
  textElement.setValue(token.data);
});
```

> Retrieve card token and set value into CardElement

```javascript
const cardElement = BasisTheory.createElement('card');

BasisTheory.tokens.retrieve('ca9f3fd7-3906-4087-83aa-9a6129221297', {
  apiKey: 'key_N88mVGsp3sCXkykyN2EFED' // api key is required and should belong to an 'expiring' application
}).then((token) => {
  cardElement.setValue(token.data);
});

// or

BasisTheory.tokens.retrieve('ca9f3fd7-3906-4087-83aa-9a6129221297', {
  apiKey: 'key_N88mVGsp3sCXkykyN2EFED' // api key is required and should belong to an 'expiring' application
}).then((token) => {
  cardElement.setValue({
    number: token.data.number, // expects string
    expiration_month: token.data.expiration_month, // expects number
    expiration_year: token.data.expiration_year, // expects number
  });
});
```

> Retrieve card token and set value into split card elements

```javascript
const cardNumberElement = BasisTheory.createElement('cardNumber', { targetId: 'card-number' });
const cardExpirationDateElement = BasisTheory.createElement('cardExpirationDate', { targetId: 'card-expiration-date' });

BasisTheory.tokens.retrieve('ca9f3fd7-3906-4087-83aa-9a6129221297', {
  apiKey: 'key_N88mVGsp3sCXkykyN2EFED' // api key is required and should belong to an 'expiring' application
}).then((token) => {
  cardNumberElement.setValue(token.data.number);
  cardExpirationDateElement.setValue({
    month: token.data.expiration_month,
    year: token.data.expiration_year
  });
});
```

Elements' values can be securely revealed using the [`tokens.retrieve`](/#tokens-get-a-token) service and the Elements' [`setValue`](#element-methods)
method. When `retrieve` is called from a Basis Theory instance whereas `elements: true`, the API request is made from inside a Basis Theory hosted `iframe` and the returned data remains within it.

<aside class="warning">
  <span>Note that the <code>data</code> attribute in the token returned by the <code>retrieve</code> method is not the actual data, but a a synthetic representation of the sensitive detokenized data.</span>
</aside>

<aside class="notice">
  <span>Other token attributes such as <code>metadata</code> are directly accessible from the <code>retrieve</code> response as they are considered non-sensitive.</span>
</aside>

## Errors

Elements services could throw an error if the server rejects the request.

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
} from '@basis-theory/basis-theory-js/common';

BasisTheory.tokens.retrieve('ca9f3fd7-3906-4087-83aa-9a6129221297', {
  apiKey: 'key_N88mVGsp3sCXkykyN2EFED' // api key is required and should belong to an 'expiring' application
}).catch((error) => {
  if (error instanceof BasisTheoryValidationError) {
    // check error details
  }
});
```
