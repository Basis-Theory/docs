# Masks

Masks allow you to reformat token data into a non-sensitive representation that can be safely exposed. For example, if the original credit card number was `4242-4242-4242-4242`, a common mask pattern is to only show the last 4 digits, such as `XXXX-XXXX-XXXX-4242`.

When [creating a token](/#tokens-create-token), the mask can be specified within the request.
You are able to reference the `data` property within an [object](#language-objects) expression -
`data` will be bound to the provided token data.

When retrieving a token with inadequate read permissions, returned token data is either masked or redacted based on the token's [data restriction policy](/#tokens-token-restriction-policies). For tokens with the `mask` restriction policy, the token's mask will be evaluated and returned within the `data` property. For tokens with the `redact`  restriction policy, `data` will not be returned and a `mask` cannot be defined. The `mask` property is required for tokens with type `token` having a data restriction policy of `mask`. All other token types have a default mask assigned in case a custom one is not provided. 

<aside class="notice">
  <span>Only generic tokens (those with type <code>token</code>) allow providing custom masks.</span>
</aside>

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