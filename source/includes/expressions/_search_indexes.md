# Search Indexes

Several token attributes can be [searched](https://developers.basistheory.com/concepts/what-is-search/) through the [token search](/#tokens-search-tokens) API.
A token's data can also be searched, provided that the token has been indexed for search at the time of its creation.

When [creating a token](/#tokens-create-token), an array of search index expressions can be specified within the request.
You are able to reference the `data` variable within [object](#language-objects) expressions - 
`data` will be bound to the provided token data, which may either be a complex or primitive value, based on your usage.

## Examples

- [Indexing Primitive Tokens](#search-indexes-examples-indexing-primitive-tokens)
- [Indexing Properties of a Complex Token](#search-indexes-examples-indexing-properties-of-a-complex-token)
- [Transforming Data Before Indexing](#search-indexes-examples-transforming-data-before-indexing)

### Indexing Primitive Tokens

Request:

<div class="center-column"></div>
```json
{
  "type": "token",
  "data": "111-22-3333",
  "search_indexes": [
    "{{ data }}",
    "{{ data | last4 }}",
    "{{ data | remove: '-' }}"
  ]
}
```

Created Indexes:

- `"111-22-3333"`
- `"3333"`
- `"111223333"`

### Indexing Properties of a Complex Token

Request:

<div class="center-column"></div>
```json
{
  "type": "token",
  "data": {
    "card": {
      "card_number": "4000056655665556",
      "exp_month": 4,
      "exp_year": 2026,
      "owner": {
        "first_name": "John",
        "middle_name": "Andrew",
        "last_name": "Smith"
      }
    },
    "billing_address": {
      "street_address": "175 5th Ave",
      "city": "New York",
      "state": "NY",
      "zip": "10010"
    }
  },
  "search_indexes": [
    "{{ data.card.card_number }}",
    "{{ data.card.owner.last_name }}",
    "{{ data.billing_address.zip }}"
  ]
}
```

Created Indexes:

- `"4000056655665556"`
- `"Smith"`
- `"10010"`

### Transforming Data Before Indexing

Request:

<div class="center-column"></div>
```json
{
  "type": "token",
  "data": {
    "card": {
      "card_number": "4000056655665556",
      "exp_month": 4,
      "exp_year": 2026,
      "owner": {
        "first_name": "John",
        "middle_name": "Andrew",
        "last_name": "Smith"
      }
    },
    "billing_address": {
      "street_address": "175 5th Ave",
      "city": "New York",
      "state": "NY",
      "zip": "10010"
    }
  },
  "search_indexes": [
    "{{ data.card.card_number | last4 }}",
    "{{ data.card.owner.last_name | upcase }}",
    "{{ data.card.owner.first_name | upcase }} {{ data.card.owner.last_name | upcase }}",
    "{{ data.billing_address.zip | slice: 0, 5 }}"
  ]
}
```

Created Indexes:

- `"5556"`
- `"SMITH"`
- `"JOHN SMITH"`
- `"10010"`
