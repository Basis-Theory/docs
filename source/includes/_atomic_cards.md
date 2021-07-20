# Atomic Cards

## Atomic Card Object

Attribute | Type | Description
--------- | ---- | -----------
`id` | *uuid* | Unique identifier of the token which can be used to [get an atomic card](#get-an-atomic-card)
`tenant_id` | *uuid* | The [tenant](#tenants) ID which owns the card
`type` | *string* | `Card` [token type](#token-types)
`card` | *[card](#card-object)* | Card data
`billing_details` | *[billing details](#billing-details-object)* | Billing details
`metadata` | *any* | Non-sensitive token metadata. Can be an object, array, or any primitive type such as an integer, boolean, or string
`created_by` | *uuid* | The [application](#applications) ID which created the atomic card
`created_at` | *date* | Created date of the application in ISO 8601 format

### Card Object

Attribute | Type | Description
--------- | ---- | -----------
`number` | *string* | The card number without any separators
`expiration_month` | *integer* | Two-digit number representing the card's expiration month
`expiration_year` | *integer* | our-digit number representing the card's expiration year

### Billing Details Object

Attribute | Type | Description
--------- | ---- | -----------
`name` | *string* | The cardholder or customer's full name
`email` | *string* | The cardholder or customer's email address
`phone` | *string* | The cardholder or customer's phone number
`address` | *address* | The cardholder or customer's [address](#address-object)

### Address Object

Attribute | Type | Description
--------- | ---- | -----------
`line1` | *string* | Address line 1 (Street address / PO Box / Company name)
`line2` | *string* | Address line 2 (Apartment / Suite / Unit / Building)
`city` | *string* | City / District / Suburb / Town / Village
`state` | *string* | State / County / Province / Region
`postal_code` | *string* | Zip or postal code
`country` | *string* | Two-character ISO country code (e.g. `US`)


## Create Atomic Card

> Request

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
    },
    "metadata": {
      "nonSensitiveField": "Non-Sensitive Value"
    }
  }'
```

```csharp
var client = new AtomicCardClient("key_N88mVGsp3sCXkykyN2EFED");

var atomicCard = await client.CreateAsync(new AtomicCard {
  Card = new Card {
    CardNumber = "4242424242424242",
    ExpirationMonth = 12,
    ExpirationYear = 2025,
    CardVerificationCode = "123"
  },
  BillingDetails = new BillingDetails {
    Name = "John Doe",
    Email = "johndoe@test.com",
    PhoneNumber = "555-123-4567",
    Address = new Address {
      LineOne = "111 Test St.",
      LineTwo = "Apt 304",
      City = "San Francisco",
      State = "CA",
      PostalCode = "94141",
      Country = "US"
    }
  },
  Metadata = new {
    nonSensitiveField = "Non-Sensitive Value"
  }
});
```

> Response

```json
{
  "id": "c1e565009-1984-4638-8fca-dce8a82cc2af",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "type": "card",
  "card": {
    "number": "XXXXXXXXXXXX4242",
    "expiration_month": 12,
    "expiration_year": 2025
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
  },
  "metadata": {
    "nonSensitiveField": "Non-Sensitive Value"
  },
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00"
}
```

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/atomic/cards`
</span>

Create a new atomic card for the tenant.

### Permissions

<p class="scopes">
  <span class="scope">card:create</span>
  <span class="scope">token:create</span>
</p>

### Request Parameters

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`card` | true | *[card](#card-object)* | `null` | Card data
`billing_details` | false | *[billing details](#billing-details-object)* | `null` | Billing details
`metadata` | false | *any* | `null` | Non-sensitive token metadata. Can be an object, array, or any primitive type such as an integer, boolean, or string

### Response

Returns an [atomic card](#atomic-card-object) with masked [card data](#card-object) if the atomic card was created. Returns [an error](#errors) if there were validation errors or the atomic card failed to create.


## List Atomic Cards

> Request

```shell
curl "api.basistheory.com/atomic/cards" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```csharp
var client = new AtomicCardClient("key_N88mVGsp3sCXkykyN2EFED");

var atomicCards = await client.GetAsync();
```

> Response

```json
{
  "pagination": {...}
  "data": [
    {
      "id": "c1e565009-1984-4638-8fca-dce8a82cc2af",
      "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
      "type": "card",
      "card": {
        "number": "XXXXXXXXXXXX4242",
        "expiration_month": 12,
        "expiration_year": 2025
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
      },
      "metadata": {
        "nonSensitiveField": "Non-Sensitive Value"
      },
      "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
      "created_at": "2020-09-15T15:53:00+00:00"
    },
    {...},
    {...}
  ]
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/atomic/cards`
</span>

Get a list of atomic cards for the tenant.

### Permissions

<p class="scopes">
  <span class="scope">card:read</span>
  <span class="scope">token:read</span>
</p>

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of [atomic cards](#atomic-card-object). Providing any query parameters will filter the results. Returns [an error](#errors) if atomic cards could not be retrieved.


## Get an Atomic Card

> Request

```shell
curl "api.basistheory.com/atomic/cards/c1e565009-1984-4638-8fca-dce8a82cc2af" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```csharp
var client = new AtomicCardClient("key_N88mVGsp3sCXkykyN2EFED");

var atomicCard = await client.GetByIdAsync("c1e565009-1984-4638-8fca-dce8a82cc2af");
```

> Response

```json
{
  "id": "c1e565009-1984-4638-8fca-dce8a82cc2af",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "type": "card",
  "card": {
    "number": "XXXXXXXXXXXX4242",
    "expiration_month": 12,
    "expiration_year": 2025
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
  },
  "metadata": {
    "nonSensitiveField": "Non-Sensitive Value"
  },
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00"
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/atomic/cards/{id}`
</span>

Get an atomic card by ID in the tenant.

### Permissions

<p class="scopes">
  <span class="scope">card:read</span>
  <span class="scope">token:read</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the atomic card

### Response

Returns an [atomic card](#atomic-card-object) with the `id` provided. Returns [an error](#errors) if the atomic card could not be retrieved.


## Delete Atomic Card

> Request

```shell
curl "api.basistheory.com/atomic/cards/c1e565009-1984-4638-8fca-dce8a82cc2af" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -X "DELETE"
```

```csharp
var client = new AtomicCardClient("key_N88mVGsp3sCXkykyN2EFED");

await client.DeleteAsync("c1e565009-1984-4638-8fca-dce8a82cc2af");
```

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/atomic/cards/{id}`
</span>

Delete an atomic card by ID in the tenant.

<aside class="warning">
<span>WARNING - The data associated with a deleted atomic card will be removed forever. The reference will still exists for audit purposes</span>
</aside>

### Permissions

<p class="scopes">
  <span class="scope">card:delete</span>
  <span class="scope">token:delete</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the atomic card

### Response

Returns [an error](#errors) if the atomic card failed to delete.

## Exchange an Atomic Card

> Request

```shell
curl "api.basistheory.com/atomic/cards/c1e565009-1984-4638-8fca-dce8a82cc2af/exchange" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -X "POST"
  -D '{
    "exchange_id": "5b493235-6917-4307-906a-2cd6f1a90b13",
    "metadata": {
      "nonSensitiveField": "Non-Sensitive Value"
    }
  }'
```

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/atomic/cards/{id}/exchange`
</span>

Delete an atomic card by ID in the tenant.

### Permissions

<p class="scopes">
  <span class="scope">exchange:read</span>
  <span class="scope">card:create</span>
  <span class="scope">card:read</span>
  <span class="scope">token:create</span>
  <span class="scope">token:read</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the atomic card
`exchange_id` | true | *uuid* | `null` | The ID of the exchange
`metadata` | false | *any* | `null` | Non-sensitive token metadata. Can be an object, array, or any primitive type such as an integer, boolean, or string

### Response

Returns a [token](#token-object) with type of `card:exchanged` if the atomic card was exchanged. Returns [an error](#errors) if the atomic card failed to exchange.

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
