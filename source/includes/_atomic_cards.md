# Atomic Cards

## Create Atomic Card

> Create Atomic Card Request Example:

```shell
curl "api.basistheory.com/atomic/cards" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -H "Content-Type: application/json"
  -X "POST"
  -D '{
    "card": {
      "number": "4242424242424242",
      "expiration_month": 12,
      "expiration_year": 2025,
      "cvc": "123"
    },
    "billing_details": {
      "name": "John Doe",
      "email": "johndoe@test.com",
      "phone": "555-123-4567",
      "address": {
        "line1": "111 Test St.",
        "line2": "Apt 304",
        "city": "San Francisco",
        "state": "CA",
        "postal_code": "94141",
        "country": "US"
      }
    }
  }'
```

> Create Atomic Card Response Example:

```json
{
  "id": "c1e565009-1984-4638-8fca-dce8a82cc2af",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "type": "card",
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00",
  "card": {
    "number": "XXXXXXXXXXXX4242",
    "expiration_month": 12,
    "expiration_year": 2025
  }
}
```

<span class="http-method post">POST</span> `https://api.basistheory.com/atomic/cards`

Create a new atomic card for the tenant.

### Permissions

<p class="scopes">
  <span class="scope">card:create</span>
  <span class="scope">token:write</span>
</p>

### Request Schema

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`card` | true | *card* | `null` | [Card object](#card-object-schema)
`billing_details` | false | *billing details* | `null` | [Billing details object](#billing-details-object-schema)

### Card Object Schema

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`number` | true | *string* | `null` | The card number without any separators
`expiration_month` | true | *integer* | `null` | Two-digit number representing the card's expiration month
`expiration_year` | true | *integer* | `null` | Four-digit number representing the card's expiration year

### Billing Details Object Schema

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | false | *string* | `null` | The cardholder or customer's full name
`email` | false | *string* | `null` | The cardholder or customer's email address
`phone` | false | *string* | `null` | The cardholder or customer's phone number
`address` | false | *address* | `null` | The cardholder or customer's [address](#address-object-schema)

### Address Object Schema

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`line1` | false | *string* | `null` | Address line 1 (Street address / PO Box / Company name)
`line2` | false | *string* | `null` | Address line 2 (Apartment / Suite / Unit / Building)
`city` | false | *string* | `null` | City / District / Suburb / Town / Village
`state` | false | *string* | `null` | State / County / Province / Region
`postal_code` | false | *string* | `null` | Zip or postal code
`country` | false | *string* | `null` | Two-character ISO country code (e.g. `US`)

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the token which can be used to [get an atomic card](#get-an-atomic-card)
`tenant_id` | *string* | The tenant ID which owns the card
`type` | *string* | `Card` [token type](#token-types)
`created_by` | *string* | The [application](#applications) ID which created the atomic card
`created_at` | *string* | Created date of the application in ISO 8601 format
`card` | *card* | Masked [card object](#card-object-schema)

### Response Messages

Code | Description
---- | -----------
`201` | Atomic card successfully created
`400` | Invalid request body. See [Errors](#errors) response for details
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions


## List Atomic Cards

> List Atomic Cards Request Example:

```shell
curl "api.basistheory.com/atomic/cards" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> Atomic Cards Response Example:

```json
{
  "pagination": {...}
  "data": [
    {
      "id": "c1e565009-1984-4638-8fca-dce8a82cc2af",
      "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
      "type": "card",
      "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
      "created_at": "2020-09-15T15:53:00+00:00",
      "card": {
        "number": "XXXXXXXXXXXX4242",
        "expiration_month": 12,
        "expiration_year": 2025
      }
    },
    {...},
    {...}
  ]
}
```

<span class="http-method get">GET</span> `https://api.basistheory.com/atomic/cards`

Get a list of atomic cards for the tenant.

### Permissions

<p class="scopes">
  <span class="scope">card:read</span>
  <span class="scope">token:read</span>
</p>

### Response Schema

Returns the [Pagination](#pagination) schema. The `data` attribute in the response contains an array of tokens with the following schema:

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the token which can be used to [get an atomic card](#get-an-atomic-card)
`tenant_id` | *string* | The tenant ID which owns the card
`type` | *string* | `Card` [token type](#token-types)
`created_by` | *string* | The [application](#applications) ID which created the atomic card
`created_at` | *string* | Created date of the application in ISO 8601 format
`card` | *card* | Masked [card object](#card-object-schema)

### Response Messages

Code | Description
---- | -----------
`200` | Atomic cards successfully retrieved
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions


## Get an Atomic Card

> Get Atomic Card Request Example:

```shell
curl "api.basistheory.com/atomic/cards/c1e565009-1984-4638-8fca-dce8a82cc2af" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> Atomic Card Response Example:

```json
{
  "id": "c1e565009-1984-4638-8fca-dce8a82cc2af",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "type": "card",
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00",
  "card": {
    "number": "XXXXXXXXXXXX4242",
    "expiration_month": 12,
    "expiration_year": 2025
  }
}
```

<span class="http-method get">GET</span> `https://api.basistheory.com/atomic/cards/{id}`

Get an atomic card by ID in the tenant.

### Permissions

<p class="scopes">
  <span class="scope">card:read</span>
  <span class="scope">token:read</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *string* | `null` | The ID of the atomic card

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the token which can be used to [get an atomic card](#get-an-atomic-card)
`tenant_id` | *string* | The tenant ID which owns the card
`type` | *string* | `Card` [token type](#token-types)
`created_by` | *string* | The [application](#applications) ID which created the atomic card
`created_at` | *string* | Created date of the application in ISO 8601 format
`card` | *card* | Masked [card object](#card-object-schema)

### Response Messages

Code | Description
---- | -----------
`200` | Atomic card successfully retrieved
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | The atomic card was not found


## Delete Atomic Card

> Delete Token Request Example:

```shell
curl "api.basistheory.com/atomic/cards/c1e565009-1984-4638-8fca-dce8a82cc2af" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -X "DELETE"
```

<span class="http-method delete">DELETE</span> `https://api.basistheory.com/atomic/cards/{id}`

Delete an atomic card by ID in the tenant.

<aside class="warning">
<span>WARNING - The data associated with a deleted atomic card will be removed forever. The reference will still exists for audit purposes</span>
</aside>

### Permissions

<p class="scopes">
  <span class="scope">card:delete</span>
  <span class="scope">token:write</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *string* | `null` | The ID of the atomic card

### Response Messages

Code | Description
---- | -----------
`204` | Atomic card successfully deleted
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | The atomic card was not found


## Test Cards

To enable testing of atomic cards, we've implemented a list of acceptable test card numbers to ensure you are able to test with non-sensitive data.  

<aside class="warning">
<span>WARNING - while testing our system, these card numbers will be the only accepted cards available to test with.</span>
</aside>

### Test card numbers

Card | Description
---- | -----------
4242424242424242 | Test card
4000056655665556 | Test card
5555555555554444 | Test card
2223003122003222 | Test card
5200828282828210 | Test card
5105105105105100 | Test card
378282246310005 | Test card
371449635398431 | Test card
6011111111111117 | Test card
6011000990139424 | Test card
3056930009020004 | Test card
36227206271667 | Test card
3566002020360505 | Test card
620000000000000 | Test card
