# Atomic Cards

## Create a new atomic card

```shell
curl --request POST \
  "https://api-dev.basistheory.com/atomic/cards/cards" \
  --header 'Content-Type: application/json' \
  --header "X-API-KEY: test_123456790"
  --data '{
    "card": {
      "number": "4242424242424242",
      "expiration_month": 10,
      "expiration_year": 25,
      "cvc": "000"
    },
     "billing_details": {
        "name": "Fiona Theory",
      }
  }'
```

```javascript
const BasisTheory = require('basis-theory');

BasisTheory.init("test_1234567890")

// soon
```

> The above command returns JSON structured like this:

```json
{
  "id": "string",
  "data": "(encrypted card information)",
  "metadata": {
    "masked": {
      "number": "XXXXXXXXXXXX4242",
      "expiration_year": 25,
      "expiration_month": 10
    }
  }
}
```

This endpoint will tokenize any credit card to enable you to securely store and integrate with your `atomic cards` in anyway you need, without the burden of full PCI compliance. 

### HTTP Request

`POST https://api-dev.basistheory.com/atomic/cards/cards`

<aside class="success">
Remember — you'll need to be authenticated to use this endpoint!
</aside>

### Required Scopes

- `card:write`
- `vault:write`

### Query Parameters

Parameter | Description
--------- | -----------
card.number | credit card number
card.expiration_month | month the card will expire
card.expiration_year | year the card will expire
card.cvc | the verification code for the card (used to validate the card)
billing_details.name | name associated with the card

### Response Properties

Parameter | Description
--------- | -----------
id | id of the created token 
data | *we shouldn't return this* 
encryption | *we shouldn't return this*
masked.number | the non-sensitive masked card number (use this to display)
masked.expiration_month | month the card will expire
masked.expiration_year | year the card will expire

## Get an existing atomic card

```shell
curl "https://api-dev.basistheory.com/atomic/cards/cards/tok_1234" \
  -H "X-API-KEY: test_123456790"
```

```javascript
const BasisTheory = require('basis-theory');

BasisTheory.init("test_1234567890")

// soon
```

> The above command returns JSON structured like this:

```json
{
  "id": "string",
  "data": "(encrypted card information)",
  "metadata": {
    "masked": {
      "number": "XXXXXXXXXXXX4242",
      "expiration_year": 25,
      "expiration_month": 10
    }
  }
}
```

### HTTP Request

`GET https://api-dev.basistheory.com/atomic/cards/cards/:atomic_card_id`

<aside class="success">
Remember — you'll need to be authenticated to use this endpoint!
</aside>

### Required Scopes

- `vault:read`

### Query Parameters

Parameter | Description
--------- | -----------
atomic_card_id | atomic card id that you want to retrieve

### Response Properties

Parameter | Description
--------- | -----------
id | id of the created token
data | *we shouldn't return this*
encryption | *we shouldn't return this*
masked.number | the non-sensitive masked card number (use this to display)
masked.expiration_month | month the card will expire
masked.expiration_year | year the card will expire


## List your atomic cards

```shell
curl "https://api-dev.basistheory.com/atomic/cards/cards" \
  -H "X-API-KEY: test_123456790"
```

> The above command returns JSON structured like this:

```json
[
  {
    "id": "string",
    "data": "(encrypted card information)",
    "metadata": {
      "masked": {
        "number": "XXXXXXXXXXXX4242",
        "expiration_year": 25,
        "expiration_month": 10
      }
    }
  },
  //... additional tokens
]
```

### HTTP Request

`GET https://api-dev.basistheory.com/atomic/cards/cards`

<aside class="success">
Remember — you'll need to be authenticated to use this endpoint!
</aside>

### Required Scopes

- `card:read`

### Response Properties

Parameter | Description
--------- | -----------
[0].id | id of the created token
[0].data | *we shouldn't return this*
[0].encryption | *we shouldn't return this*
[0].masked.number | the non-sensitive masked card number (use this to display)
[0].masked.expiration_month | month the card will expire
[0].masked.expiration_year | year the card will expire

## Delete an atomic card

```shell
curl "https://api-dev.basistheory.com/atomic/cards/cards/tok_1234" \
  -X DELETE \
  -H "Authorization: api_key_1234"
```

```javascript
const BasisTheory = require('basis-theory');

BasisTheory.init("api_key_1234")

// coming soon
```

This endpoint will remove any underlying data associated with the token, you will not be able to access the card or token after this. The data will be permanently deleted and is irreversible. Depending on your configuration, your token's logs will be retained for the specified length.  

<aside class="warning">
WARNING - The data associated with a deleted token will be removed forever. It's will still exists for audit purposes.
</aside>

### HTTP Request

`DELETE https://api-dev.basistheory.com/atomic/cards/cards/:atomic_card_id`

### Required Scopes

- `card:delete`

### URL Parameters

Parameter | Description
--------- | -----------
atomic_card_id | token id that you want to delete



## Test Data

To enable testing of atomic cards, we've implemented a list of acceptable test card numbers to ensure you are able to test with non-sensitive data.  

<aside class="warning">
WARNING - while testing our system, these card numbers will be the only accepted cards available to test with.
</aside>

### Test card numbers

Card | Description
--------- | -----------
4242424242424242 | test card number
4000056655665556 | test card number
5555555555554444 | test card number
2223003122003222 | test card number
5200828282828210 | test card number
5105105105105100 | test card number
378282246310005 | test card number
371449635398431 | test card number
6011111111111117 | test card number
6011000990139424 | test card number
3056930009020004 | test card number
36227206271667 | test card number
3566002020360505 | test card number
620000000000000 | test card number