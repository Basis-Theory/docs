# Masks

Masks allow to format original data to create a partial view of it without leaking sensitive data. For example, if the original credit card number was `4242-4242-4242-4242`, a common mask pattern is to only show the last 4 digits, such as `XXXX-XXXX-XXXX-4242`.

The token's mask will be applied to the `data` property upon token retrieval, for those tokens with a `mask` data restriction policy. If the token's data restriction policy is `redact` then a mask cannot be provided since the data will be redacted. The `mask` is required for tokens with type `token` and data restriction policy `mask`. All other token types have a default mask assigned in case a custom one is not provided. 

When [creating a token](/#tokens-create-token), the mask can be specified within the request.
You are able to reference the `data` property within an [object](#language-objects) expression -
`data` will be bound to the provided token data.

<aside class="notice">
  <span>Only generic tokens, those with type <code>token</code> allow providing custom masks.</span>
</aside>

## Examples

- [Masking Primitive Tokens](#search-indexes-examples-indexing-primitive-tokens)
- [Masking Complex Tokens](#search-indexes-examples-indexing-properties-of-a-complex-token)

### Masking Primitive Tokens

Request:

<div class="center-column"></div>
```json
{
  "type": "token",
  "data": "4242-4242-4242-4242",
  "mask": "{{ data | reveal_last: 4, '#' }}",
  ...
}
```

Response:

<div class="center-column"></div>
```json
{
  "type": "token",
  "data": "XXXX-XXXX-XXXX-4242",
  "mask": "{{ data | reveal_last: 4, '#' }}",
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
      "first" = "John", 
      "middle" = "Wilson", 
      "last" = "Doe" 
    },
    "ssn" = "123-45-6789",
    "card_number" = "4242-4242-4242-4242",
    "cvc" = "123"
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
      "first" = "John",  
      "last" = "D." 
    },
    "ssn" = "###-##-6789",
    "card_number" = "####-####-####-4242"
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