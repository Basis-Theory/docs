# Atomic Cards

## Atomic Card Object

| Attribute         | Type                                                                         | Description                                                                                                                                |
|-------------------|------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| `id`              | *uuid*                                                                       | Unique identifier of the token which can be used to [get an Atomic Card](#atomic-cards-get-an-atomic-card)                                 |
| `tenant_id`       | *uuid*                                                                       | The [Tenant](#tenants) ID which owns the card                                                                                              |
| `type`            | *string*                                                                     | `Card` [token type](#tokens-token-types)                                                                                                   |
| `card`            | *[card](#atomic-cards-atomic-card-object-card-object)*                       | Card data                                                                                                                                  |
| `fingerprint`     | *string*                                                                     | Uniquely identifies this particular card number. You can use this attribute to check whether two card tokens contain the same card number. |
| `metadata`        | *map*                                                                        | A key-value map of non-sensitive data.                                                                                                     |
| `created_by`      | *uuid*                                                                       | (Optional) The [Application](#applications) ID which created the Atomic Card                                                               |
| `created_at`      | *date*                                                                       | (Optional) Created date of the Atomic Card in ISO 8601 format                                                                              |
| `modified_by`     | *uuid*                                                                       | (Optional) The [Application](#applications) ID which last modified the Atomic Card                                                         |
| `modified_at`     | *date*                                                                       | (Optional) Last modified date of the Atomic Card in ISO 8601 format                                                                        |

### Card Object

| Attribute          | Required | Type      | Default | Description                                               |
|--------------------|----------|-----------|---------|-----------------------------------------------------------|
| `number`           | true     | *string*  | `null`  | The card number without any separators                    |
| `expiration_month` | false    | *integer* | `null`  | Two-digit number representing the card's expiration month |
| `expiration_year`  | false    | *integer* | `null`  | Four-digit number representing the card's expiration year |
| `cvc`              | false    | *string*  | `null`  | Three or four-digit card verification code                |


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
  Metadata = new Dictionary<string, string> {
    { "nonSensitiveField", "Non-Sensitive Value" }
  }
});
```

```python
# Coming Soon!
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
  "fingerprint": "EVYsSLRyb86Z5awJksvnjVMEC4iP7KX639GtHVUFpzER",
  "metadata": {
    "nonSensitiveField": "Non-Sensitive Value"
  },
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_by": "34053374-d721-43d8-921c-5ee1d337ef21",
  "modified_at": "2021-10-27T17:34:23+00:00"
}
```

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/atomic/cards`
</span>

Create a new Atomic Card for the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">card:create (deprecated)</span>
  <span class="scope">token:pci:create</span>
</p>

### Request Parameters

| Attribute         | Required | Type                                                                         | Default | Description                            |
|-------------------|----------|------------------------------------------------------------------------------|---------|----------------------------------------|
| `card`            | true     | *[card](#atomic-cards-atomic-card-object-card-object)*                       | `null`  | Card data                              |
| `metadata`        | false    | *map*                                                                        | `null`  | A key-value map of non-sensitive data. |

### Response

Returns an [Atomic Card](#atomic-cards-atomic-card-object) with masked [card data](#atomic-cards-atomic-card-object-card-object) if the Atomic Card was created. Returns [an error](#errors) if there were validation errors, or the Atomic Card failed to create.


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

```python
# Coming Soon!
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
      "fingerprint": "EVYsSLRyb86Z5awJksvnjVMEC4iP7KX639GtHVUFpzER",
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
  <span class="scope">card:read (deprecated)</span>
  <span class="scope">token:pci:read:&lt;impact_level&gt;</span>
</p>

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of [Atomic Cards](#atomic-cards-atomic-card-object). Providing any query parameters will filter the results. Returns [an error](#errors) if Atomic Cards could not be retrieved.


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

```python
# Coming Soon!
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
  "fingerprint": "EVYsSLRyb86Z5awJksvnjVMEC4iP7KX639GtHVUFpzER",
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
  <span class="scope">card:read (deprecated)</span>
  <span class="scope">token:pci:read:&lt;impact_level&gt;</span>
</p>

### URI Parameters

| Parameter | Required | Type   | Default | Description               |
|-----------|----------|--------|---------|---------------------------|
| `id`      | true     | *uuid* | `null`  | The ID of the Atomic Card |

### Response

Returns an [Atomic Card](#atomic-cards-atomic-card-object) with the `id` provided. Returns [an error](#errors) if the Atomic Card could not be retrieved.


## Update Atomic Card

> Request

```shell
curl "https://api.basistheory.com/atomic/cards/c1e565009-1984-4638-8fca-dce8a82cc2af" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "PATCH" \
  -d '{
    "card": {
      "number": "4242424242424242",
      "expiration_month": 12,
      "expiration_year": 2025,
      "cvc": "123"
    }
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const atomicCard = await bt.atomicCards.update("c1e565009-1984-4638-8fca-dce8a82cc2af", {
  card: {
    number: '4242424242424242',
    expirationMonth: 12,
    expirationYear: 2025,
    cvc: '123',
  }
});
```

```csharp
using BasisTheory.net.Atomic.Cards;

var client = new AtomicCardClient("key_N88mVGsp3sCXkykyN2EFED");

var atomicCard = await client.UpdateAsync("c1e565009-1984-4638-8fca-dce8a82cc2af", new UpdateAtomicCardRequest {
  Card = new Card {
    CardNumber = "4242424242424242",
    ExpirationMonth = 12,
    ExpirationYear = 2025,
    CardVerificationCode = "123"
  }
});
```

```python
# Coming Soon!
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
  "fingerprint": "EVYsSLRyb86Z5awJksvnjVMEC4iP7KX639GtHVUFpzER",
  "metadata": {
    "nonSensitiveField": "Non-Sensitive Value"
  },
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_by": "34053374-d721-43d8-921c-5ee1d337ef21",
  "modified_at": "2021-10-27T17:34:23+00:00"
}
```

<span class="http-method patch">
  <span class="box-method">PATCH</span>
  `https://api.basistheory.com/atomic/cards/{id}`
</span>

Update an Atomic Card for the Tenant. At least one property on the request body is required.

### Permissions

<p class="scopes">
  <span class="scope">card:update (deprecated)</span>
  <span class="scope">token:pci:update</span>
</p>

### Request Parameters

| Attribute         | Required | Type                                                                         | Default | Description     |
|-------------------|----------|------------------------------------------------------------------------------|---------|-----------------|
| `card`            | false    | *[card](#atomic-cards-atomic-card-object-card-object)*                       | `null`  | Card data       |

### Response

Returns an [Atomic Card](#atomic-cards-atomic-card-object) with masked [card data](#atomic-cards-atomic-card-object-card-object) if the Atomic Card was updated. Returns [an error](#errors) if there were validation errors, or the Atomic Card failed to update.


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

```python
# Coming Soon!
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
  <span class="scope">card:delete (deprecated)</span>
  <span class="scope">token:pci:delete</span>
</p>

### URI Parameters

| Parameter | Required | Type   | Default | Description               |
|-----------|----------|--------|---------|---------------------------|
| `id`      | true     | *uuid* | `null`  | The ID of the Atomic Card |

### Response

Returns [an error](#errors) if the Atomic Card failed to delete.


## React with an Atomic Card

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

const reactResponse = await bt.atomicCards.react('c1e565009-1984-4638-8fca-dce8a82cc2af', {
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

var reactResponse = await client.ReactAsync("c1e565009-1984-4638-8fca-dce8a82cc2af", 
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

```python
# Coming Soon!
```

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/atomic/cards/{id}/react`
</span>

React with an Atomic Card by ID.

### Permissions

<p class="scopes">
  <span class="scope">card:read (deprecated)</span>
  <span class="scope">token:pci:use:reactor</span>
</p>

### URI Parameters

| Parameter | Required | Type   | Default | Description               |
|-----------|----------|--------|---------|---------------------------|
| `id`      | true     | *uuid* | `null`  | The ID of the Atomic Card |

### Request Parameters
| Parameter            | Required | Type   | Default | Description                                                                                                                                                        |
|----------------------|----------|--------|---------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `reactor_id`         | true     | *uuid* | `null`  | The ID of the reactor                                                                                                                                              |
| `request_parameters` | false    | *map*  | `null`  | A key-value map of [request parameters](#reactor-forumula-request-parameter-object) names and values for the reactor                                               |
| `metadata`           | false    | *map*  | `null`  | A key-value map of non-sensitive data. We overwrite the following keys: `correlation_id`, `reactor_id`, `reactor_name`, `source_token_id`, and `source_token_type` |

### Response

Returns a [React Response](#atomic-cards-react-with-an-atomic-card-react-response-object) if the Atomic Card was reacted successfully. Returns [an error](#errors) if the Atomic Card failed to react.
Errors generated from Reactors will be translated to the common Basis Theory Error format. See [Reactor Errors](#errors-reactor-errors) for more details.

### React Response Object
| Attribute | Type  | Description                                                                                           |
|-----------|-------|-------------------------------------------------------------------------------------------------------|
| `tokens`  | *map* | (Optional) [Token(s)](#tokens-token-object) created from the `tokenize` block of the Reactor response |
| `raw`     | *map* | (Optional) Raw output returned from the Reactor                                                       |


## Test Cards

To enable testing of Atomic Cards, we've implemented a list of acceptable test card numbers to ensure you are able to test with non-sensitive data.  

<aside class="warning">
<span>WARNING - while testing our system, these card numbers will be the only accepted cards available to test with.</span>
</aside>

### Test card numbers

| Card             | Description |
|------------------|-------------|
| 4242424242424242 | Test card   |
| 4000056655665556 | Test card   |
| 5555555555554444 | Test card   |
| 2223003122003222 | Test card   |
| 5200828282828210 | Test card   |
| 5105105105105100 | Test card   |
| 378282246310005  | Test card   |
| 371449635398431  | Test card   |
| 6011111111111117 | Test card   |
| 6011000990139424 | Test card   |
| 3056930009020004 | Test card   |
| 36227206271667   | Test card   |
| 3566002020360505 | Test card   |
| 620000000000000  | Test card   |
