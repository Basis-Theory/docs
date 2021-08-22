# Atomic Cards

## Atomic Card Object

Attribute | Type | Description
--------- | ---- | -----------
`id` | *uuid* | Unique identifier of the token which can be used to [get an Atomic Card](#get-an-atomic-card)
`tenant_id` | *uuid* | The [Tenant](#tenants) ID which owns the card
`type` | *string* | `Card` [token type](#token-types)
`card` | *[card](#card-object)* | Card data
`billing_details` | *[billing details](#billing-details-object)* | Billing details
`metadata` | *map* | A key-value map of non-sensitive data.
`created_by` | *uuid* | The [application](#applications) ID which created the Atomic Card
`created_at` | *date* | Created date of the Atomic Card in ISO 8601 format

### Card Object

Attribute | Type | Description
--------- | ---- | -----------
`number` | *string* | The card number without any separators
`expiration_month` | *integer* | Two-digit number representing the card's expiration month
`expiration_year` | *integer* | Four-digit number representing the card's expiration year

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
curl "https://api.basistheory.com/atomic/cards" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "POST" \
  -d '{
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

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const atomicCard = await bt.atomicCards.create({
  card: {
    number: '4242424242424242',
    expirationMonth: 12,
    expirationYear: 2025,
    cvc: '123',
  },
  billingDetails: {
    name: 'John Doe',
    email: 'johndoe@test.com',
    phone: '555-123-4567',
    address: {
      line1: '111 Test St.',
      line2: 'Apt 304',
      city: 'San Francisco',
      state: 'CA',
      postalCode: '94141',
      country: 'US'
    },
  },
  metadata: {
    nonSensitiveField: 'Non-Sensitive Value'
  },
});
```

```csharp
using BasisTheory.net.Atomic.Cards;

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
  Metadata = new Dictionary<string, string> {
    { "nonSensitiveField", "Non-Sensitive Value" }
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

Create a new Atomic Card for the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">card:create</span>
</p>

### Request Parameters

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`card` | true | *[card](#card-object)* | `null` | Card data
`billing_details` | false | *[billing details](#billing-details-object)* | `null` | Billing details
`metadata` | false | *map* | `null` | A key-value map of non-sensitive data.

### Response

Returns an [Atomic Card](#atomic-card-object) with masked [card data](#card-object) if the Atomic Card was created. Returns [an error](#errors) if there were validation errors, or the Atomic Card failed to create.


## List Atomic Cards

> Request

```shell
curl "https://api.basistheory.com/atomic/cards" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const atomicCards = await bt.atomicCards.list();
```

```csharp
using BasisTheory.net.Atomic.Cards;

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

Get a list of Atomic Cards for the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">card:read</span>
</p>

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of [Atomic Cards](#atomic-card-object). Providing any query parameters will filter the results. Returns [an error](#errors) if Atomic Cards could not be retrieved.


## Get an Atomic Card

> Request

```shell
curl "https://api.basistheory.com/atomic/cards/c1e565009-1984-4638-8fca-dce8a82cc2af" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const atomicCard = await bt.atomicCards.retrieve('c1e565009-1984-4638-8fca-dce8a82cc2af');
```

```csharp
using BasisTheory.net.Atomic.Cards;

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

Get an Atomic Card by ID in the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">card:read</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the Atomic Card

### Response

Returns an [Atomic Card](#atomic-card-object) with the `id` provided. Returns [an error](#errors) if the Atomic Card could not be retrieved.


## Delete Atomic Card

> Request

```shell
curl "https://api.basistheory.com/atomic/cards/c1e565009-1984-4638-8fca-dce8a82cc2af" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -X "DELETE"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

await bt.atomicCards.delete('c1e565009-1984-4638-8fca-dce8a82cc2af');
```

```csharp
using BasisTheory.net.Atomic.Cards;

var client = new AtomicCardClient("key_N88mVGsp3sCXkykyN2EFED");

await client.DeleteAsync("c1e565009-1984-4638-8fca-dce8a82cc2af");
```

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/atomic/cards/{id}`
</span>

Delete an Atomic Card by ID in the Tenant.

<aside class="warning">
<span>WARNING - The data associated with a deleted Atomic Card will be removed forever. The reference will still exists for audit purposes</span>
</aside>

### Permissions

<p class="scopes">
  <span class="scope">card:delete</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the Atomic Card

### Response

Returns [an error](#errors) if the Atomic Card failed to delete.


## Create an Atomic Card Reaction

> Request

```shell
curl "https://api.basistheory.com/atomic/cards/c1e565009-1984-4638-8fca-dce8a82cc2af/react" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -X "POST" \
  -d '{
    "reactor_id": "5b493235-6917-4307-906a-2cd6f1a90b13",
    "request_parameters": {
      "REQUEST_PARAMETER_1": "Some request value"
    },
    "metadata": {
      "nonSensitiveField": "Non-Sensitive Value"
    }
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const reactionToken = await bt.atomicCards.react('c1e565009-1984-4638-8fca-dce8a82cc2af', {
  reactorId: '5b493235-6917-4307-906a-2cd6f1a90b13',
  requestParameters: {
    REQUEST_PARAMETER_1: 'Some request value',
  },
  metadata: {
    nonSensitiveField: 'Non-Sensitive Value',
  },
});
```

```csharp
using BasisTheory.net.Atomic.Cards;

var client = new AtomicCardClient("key_N88mVGsp3sCXkykyN2EFED");

var reactionToken = await client.ReactAsync("c1e565009-1984-4638-8fca-dce8a82cc2af", 
  new ReactRequest {
    ReactorId = "5b493235-6917-4307-906a-2cd6f1a90b13",
    RequestParameters = new Dictionary<string, object> {
      { "REQUEST_PARAMETER_1",  "Some request value" }
    },
    Metadata = new Dictionary<string, string> {
      { "nonSensitiveField",  "Non-Sensitive Value" }
    }
  });
```

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/atomic/cards/{id}/react`
</span>

Create an Atomic Card Reaction by ID in the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">reactor:read</span>
  <span class="scope">card:create</span>
  <span class="scope">card:read</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the Atomic Card

### Request Parameters
Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`reactor_id` | true | *uuid* | `null` | The ID of the reactor
`request_parameters` | false | *map* | `null` | A key-value map of [request parameters](#reactor-forumula-request-parameter-object) names and values for the reactor
`metadata` | false | *map* | `null` | A key-value map of non-sensitive data. We overwrite the following keys: `correlation_id`, `reactor_id`, `reactor_name`, `source_token_id`, and `source_token_type`

### Response

Returns a [token](#token-object) with type of `card:reaction` if the Atomic Card was reacted. Returns [an error](#errors) if the Atomic Card failed to react.


## Get an Atomic Card Reaction Token

> Request

```shell
curl "https://api.basistheory.com/atomic/cards/c1e565009-1984-4638-8fca-dce8a82cc2af/reactions/6c12a05d-99e3-4454-bdb0-2e6ff88ec5b0" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -X "GET"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const reactionToken = await bt.atomicCards.retrieveReaction(
  'c1e565009-1984-4638-8fca-dce8a82cc2af', '6c12a05d-99e3-4454-bdb0-2e6ff88ec5b0');
```

```csharp
using BasisTheory.net.Atomic.Cards;

var client = new AtomicCardClient("key_N88mVGsp3sCXkykyN2EFED");

var reactionToken = await client.GetReactionByIdAsync(
  "c1e565009-1984-4638-8fca-dce8a82cc2af", "6c12a05d-99e3-4454-bdb0-2e6ff88ec5b0");
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/atomic/cards/{atomicCardId}/reactions/{reactionTokenId}`
</span>

Get an Atomic Card reaction token by ID in the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">card:read</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`atomicCardId` | true | *uuid* | `null` | The ID of the Atomic Card
`reactionTokenId` | true | *uuid* | `null` | The ID of the reaction token

### Response

Returns a [token](#token-object) with type of `card:reaction`. Returns [an error](#errors) if the Atomic Card failed to react.


## Test Cards

To enable testing of Atomic Cards, we've implemented a list of acceptable test card numbers to ensure you are able to test with non-sensitive data.  

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
