# Masks

Masks allow you to reformat token data into a non-sensitive representation that can be safely exposed. 
For example, if the original credit card number was `4242-4242-4242-4242`, a common mask pattern is to only show 
the last 4 digits, such as `XXXX-XXXX-XXXX-4242`.

When [creating a token](/#tokens-create-token), the mask can be specified within the request.
You are able to reference the `data` property within an [object](#language-objects) expression -
`data` will be bound to the provided token data.

When retrieving a token with an Application API Key, token data is returned according to the format specified by the
[transform](https://developers.basistheory.com/concepts/access-controls/#transform) applied within the Application's
[Access Controls](https://developers.basistheory.com/concepts/access-controls).
For tokens that receive a `mask` transform, the token's mask will be evaluated and returned within the `data` property.
If a mask expression is not defined on the token, the token's data will be redacted.

## Examples

- [Masking Primitive Tokens](#masks-examples-masking-primitive-tokens)
- [Masking Complex Tokens](#masks-examples-masking-complex-tokens)

### Masking Primitive Tokens

Request:

<div class="center-column"></div>
```json
{
  "type": "token",
  "data": "4242-4242-4242-4242",
  "mask": "{{ data | reveal_last: 4 }}",
  ...
}
```

Response:

<div class="center-column"></div>
```json
{
  "type": "token",
  "data": "XXXX-XXXX-XXXX-4242",
  "mask": "{{ data | reveal_last: 4 }}",
  ...
}
```

### Masking Complex Tokens

Request:

<div class="center-column"></div>
```json
{
  "type": "token",
  "data": {
    "name": { 
      "first": "John", 
      "middle": "Wilson", 
      "last": "Doe" 
    },
    "ssn": "123-45-6789",
    "card_number": "4242-4242-4242-4242",
    "cvc": "123"
  },
  "mask": {
    "name": {
      "first": "{{ data.name.first }}",
      "last": "{{ data.name.last | slice: 0, 1 }}."
    },
    "ssn": "{{ data.ssn | reveal_last: 4, '#' }}",
    "card_number": "{{ data.card_number | reveal_last: 4, '#' }}"
  },
  ...
}
```

Response:

<div class="center-column"></div>
```json
{
  "type": "token",
  "data": {
    "name": { 
      "first": "John",  
      "last": "D." 
    },
    "ssn": "###-##-6789",
    "card_number": "####-####-####-4242"
  },
  "mask": {
    "name": {
      "first": "{{ data.name.first }}",
      "last": "{{ data.name.last | slice: 0, 1 }}."
    },
    "ssn": "{{ data.ssn | reveal_last: 4, '#' }}",
    "card_number": "{{ data.card_number | reveal_last: 4, '#' }}"
  },
  ...
}
```

<aside class="notice">
  <span>As shown in this example, you can redact specific data properties by just omitting them in the mask object.</span>
</aside>
