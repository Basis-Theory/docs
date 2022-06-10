# Fingerprints

A [fingerprint](https://developers.basistheory.com/concepts/what-are-fingerprints/) can be generated at the time a token is created, 
which can be used to uniquely identify the contents of a token for its type. You will get different fingerprints for the same content
across different token types, but the same fingerprints for the same content across the same token types.
Fingerprints are cryptographically secure and cannot be reversed to recover the original token's data, 
so they are safe to store in your application and used to compare tokens without retrieving plaintext token data (e.g. for token de-duplication).

When [creating a token](/#tokens-create-token), fingerprint expression can be specified within the request.
You are able to reference the `data` and `metadata` variable within an [object](#language-objects) expression -
`data` and `metadata` will be bound to the provided token data and metadata, respectively.

## Examples

- [Fingerprinting Primitive Tokens](#search-indexes-examples-indexing-primitive-tokens)
- [Fingerprinting a Property of a Complex Token](#search-indexes-examples-indexing-properties-of-a-complex-token)
- [Fingerprinting Multiple Properties of a Complex Token](#search-indexes-examples-indexing-properties-of-a-complex-token)
- [Transforming Data Before Fingerprinting](#search-indexes-examples-indexing-properties-of-a-complex-token)

### Fingerprinting Primitive Tokens

Request:

<div class="center-column"></div>
```json
{
  "type": "token",
  "data": "111-22-3333",
  "fingerprint_expression": "{{ data }}"
}
```

Fingerprinted Value: `"111-22-3333"`

### Fingerprinting a Property of a Complex Token

Request:

<div class="center-column"></div>
```json
{
  "type": "token",
  "data": {
    "bank": {
      "routing_number": "021000021",
      "account_number": "1234567890",
      "account_owner": {
        "first_name": "John",
        "middle_name": "Andrew",
        "last_name": "Smith"
      }
    }
  },
  "fingerprint_expression": "{{ data.account_number }}"
}
```

Fingerprinted Value: `"1234567890"`

### Fingerprinting Multiple Properties of a Complex Token

Request:

<div class="center-column"></div>
```json
{
  "type": "token",
  "data": {
    "bank": {
      "routing_number": "021000021",
      "account_number": "1234567890",
      "account_owner": {
        "first_name": "John",
        "middle_name": "Andrew",
        "last_name": "Smith"
      }
    }
  },
  "fingerprint_expression": "{{ data.bank.routing_number }}|{{ data.bank.account_number }}"
}
```

Fingerprinted Value: `"021000021|1234567890"`

### Transforming Data Before Fingerprinting

Request:

<div class="center-column"></div>
```json
{
  "type": "token",
  "data": {
    "name": {
      "first_name": "John",
      "middle_name": "Andrew",
      "last_name": "Smith"
    }
  },
  "fingerprint_expression": "{{ data.name.first_name | upcase }} {{ data.last_name | upcase }}"
}
```

Fingerprinted Value: `"JOHN SMITH"`
