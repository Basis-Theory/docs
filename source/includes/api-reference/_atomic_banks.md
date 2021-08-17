# Atomic Banks

## Atomic Bank Object

Attribute | Type | Description
--------- | ---- | -----------
`id` | *uuid* | Unique identifier of the token which can be used to [get an atomic bank](#get-an-atomic-bank)
`tenant_id` | *uuid* | The [tenant](#tenants) ID which owns the bank
`type` | *string* | `Bank` [token type](#token-types)
`bank` | *[bank](#bank-object)* | Bank data
`metadata` | *map* | A key-value map of non-sensitive data.
`created_by` | *uuid* | The [application](#applications) ID which created the atomic bank
`created_at` | *date* | Created date of the application in ISO 8601 format

### Bank Object

Attribute | Type | Description
--------- | ---- | -----------
`routing_number` | *string* | Nine-digit ABA routing number
`account_number` | *string* | Account number up to seventeen-digits


## Create Atomic Bank

> Request

```shell
curl "https://api.basistheory.com/atomic/banks" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -H "Content-Type: application/json"
  -X "POST"
  -D '{
      "bank": {
        "routing_number": "021000021",
        "account_number": "1234567890"
      },
      "metadata": {
        "nonSensitiveField": "Non-Sensitive Value"
      }
    }
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const atomicBank = await bt.atomicBanks.create({
  bank: {
    routingNumber: '021000021',
    accountNumber: '1234567890',
  },
  metadata: {
    nonSensitiveField: 'Non-Sensitive Value'
  },
});
```

```csharp
var client = new AtomicBankClient("key_N88mVGsp3sCXkykyN2EFED");

var atomicBank = await client.CreateAsync(new AtomicBank {
  Bank = new Bank {
    RoutingNumber = "021000021",
    AccountNumber = "1234567890"
  },
  Metadata = new Dictionary<string, string> {
    { "nonSensitiveField", "Non-Sensitive Value" }
  }
});
```

> Response

```json
{
  "id": "1485efb9-6b1f-4248-a5d1-cf9b3907164c",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "type": "bank",
  "bank": {
    "routing_number": "021000021",
    "account_number": "XXXXXX7890"
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
  `https://api.basistheory.com/atomic/banks`
</span>

Create a new atomic bank for the tenant.

### Permissions

<p class="scopes">
  <span class="scope">bank:create</span>
</p>

### Request Parameters

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`bank` | true | *[bank](#bank-object)* | `null` | Bank data
`metadata` | false | *map* | `null` | A key-value map of non-sensitive data.

### Response

Returns an [atomic bank](#atomic-bank-object) with masked [bank data](#bank-object) if the atomic bank was created. Returns [an error](#errors) if there were validation errors or the atomic bank failed to create.


## List Atomic Banks

> Request

```shell
curl "https://api.basistheory.com/atomic/banks" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const atomicBanks = await bt.atomicBanks.list();
```

```csharp
var client = new AtomicBankClient("key_N88mVGsp3sCXkykyN2EFED");

var atomicBanks = await client.GetAsync();
```

> Response

```json
{
  "pagination": {...}
  "data": [
    {
      "id": "1485efb9-6b1f-4248-a5d1-cf9b3907164c",
      "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
      "type": "bank",
      "bank": {
        "routing_number": "021000021",
        "account_number": "XXXXXX7890"
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
  `https://api.basistheory.com/atomic/banks`
</span>

Get a list of atomic banks for the tenant.

### Permissions

<p class="scopes">
  <span class="scope">bank:read</span>
</p>

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of [atomic banks](#atomic-bank-object). Providing any query parameters will filter the results. Returns [an error](#errors) if atomic banks could not be retrieved.


## Get an Atomic Bank

> Request

```shell
curl "https://api.basistheory.com/atomic/banks/1485efb9-6b1f-4248-a5d1-cf9b3907164c" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```csharp
var client = new AtomicBankClient("key_N88mVGsp3sCXkykyN2EFED");

var atomicBank = await client.GetByIdAsync("1485efb9-6b1f-4248-a5d1-cf9b3907164c");
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const atomicBank = await bt.atomicBanks.retrieve('1485efb9-6b1f-4248-a5d1-cf9b3907164c');
```

> Response

```json
{
  "id": "1485efb9-6b1f-4248-a5d1-cf9b3907164c",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "type": "bank",
  "bank": {
    "routing_number": "021000021",
    "account_number": "XXXXXX7890"
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
  `https://api.basistheory.com/atomic/banks/{id}`
</span>

Get an atomic bank by ID in the tenant.

### Permissions

<p class="scopes">
  <span class="scope">bank:read</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the atomic bank

### Response

Returns an [atomic bank](#atomic-bank-object) with the `id` provided. Returns [an error](#errors) if the atomic bank could not be retrieved.


## Delete Atomic Bank

> Request

```shell
curl "https://api.basistheory.com/atomic/banks/1485efb9-6b1f-4248-a5d1-cf9b3907164c" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -X "DELETE"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

await bt.atomicBanks.delete('1485efb9-6b1f-4248-a5d1-cf9b3907164c');
```

```csharp
var client = new AtomicBankClient("key_N88mVGsp3sCXkykyN2EFED");

await client.DeleteAsync("1485efb9-6b1f-4248-a5d1-cf9b3907164c");
```

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/atomic/banks/{id}`
</span>

Delete an atomic bank by ID in the tenant.

<aside class="warning">
<span>WARNING - The data associated with a deleted atomic bank will be removed forever. The reference will still exists for audit purposes</span>
</aside>

### Permissions

<p class="scopes">
  <span class="scope">bank:delete</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the atomic bank

### Response

Returns [an error](#errors) if the atomic bank failed to delete.


## Decrypt Atomic Bank

> Request

```shell
curl "https://api.basistheory.com/atomic/banks/1485efb9-6b1f-4248-a5d1-cf9b3907164c/decrypt" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const atomicBank = await bt.atomicBanks.retrieveDecrypted('1485efb9-6b1f-4248-a5d1-cf9b3907164c');
```

```csharp
var client = new AtomicBankClient("key_N88mVGsp3sCXkykyN2EFED");

var atomicBank = await client.GetByIdAsync("1485efb9-6b1f-4248-a5d1-cf9b3907164c", 
  new BankGetByIdRequest {
    Decrypt = true
  });
```

> Response

```json
{
  "id": "1485efb9-6b1f-4248-a5d1-cf9b3907164c",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "type": "bank",
  "bank": {
    "routing_number": "021000021",
    "account_number": "1234567890"
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
  `https://api.basistheory.com/atomic/banks/{id}/decrypt`
</span>

Decrypt an atomic bank by ID in the tenant.

### Permissions

<p class="scopes">
  <span class="scope">bank:decrypt</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the atomic bank

### Response

Returns an [atomic bank](#atomic-bank-object) with plaintext [bank](#bank-object) data with the `id` provided. Returns [an error](#errors) if the atomic bank could not be retrieved.


## Create an Atomic Bank Reaction

> Request

```shell
curl "api.basistheory.com/atomic/banks/1485efb9-6b1f-4248-a5d1-cf9b3907164c/react" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -X "POST"
  -D '{
    "reactor_id": "5b493235-6917-4307-906a-2cd6f1a90b13",
    "request_paramters": {
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

const reactionToken = await bt.atomicBanks.react('1485efb9-6b1f-4248-a5d1-cf9b3907164c', {
  reactorId: '5b493235-6917-4307-906a-2cd6f1a90b13',
  requestParameters: {
    REQUEST_PARAMETER_1: 'Some request value',
  },
  metadata: {
    nonSensitiveField: 'Non-Sensitive value',
  },
});
```

```csharp
var client = new AtomicBankClient("key_N88mVGsp3sCXkykyN2EFED");

var reactionToken = await client.ReactAsync("1485efb9-6b1f-4248-a5d1-cf9b3907164c", 
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
  `https://api.basistheory.com/atomic/banks/{id}/react`
</span>

Create an Atomic Bank Reaction by ID in the tenant.

### Permissions

<p class="scopes">
  <span class="scope">reactor:read</span>
  <span class="scope">bank:create</span>
  <span class="scope">bank:read</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the atomic bank

### Request Parameters
Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`ractor_id` | true | *uuid* | `null` | The ID of the reactor
`request_parameters` | false | *map* | `null` | A key-value map of [request parameters](#reactor-forumula-request-parameter-object) names and values for the reactor
`metadata` | false | *map* | `null` | A key-value map of non-sensitive data. We overwrite the following keys: `correlation_id`, `reactor_id`, `reactor_name`, `source_token_id`, and `source_token_type`

### Response

Returns a [token](#token-object) with type of `bank:reaction` if the atomic bank was reacted. Returns [an error](#errors) if the atomic bank failed to react.


## Get an Atomic Bank Reaction Token

> Request

```shell
curl "api.basistheory.com/atomic/banks/1485efb9-6b1f-4248-a5d1-cf9b3907164c/reaction/6c12a05d-99e3-4454-bdb0-2e6ff88ec5b0" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -X "GET"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const reactionToken = await bt.atomicBanks.retrieveReaction(
  '1485efb9-6b1f-4248-a5d1-cf9b3907164c', '6c12a05d-99e3-4454-bdb0-2e6ff88ec5b0');
```

```csharp
var client = new AtomicBankClient("key_N88mVGsp3sCXkykyN2EFED");

var reactionToken = await client.GetReactionByIdAsync(
  "1485efb9-6b1f-4248-a5d1-cf9b3907164c", "6c12a05d-99e3-4454-bdb0-2e6ff88ec5b0");
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/atomic/banks/{atomicBankId}/reaction/{reactionTokenId}`
</span>

Get an atomic bank reaction token by ID in the tenant.

### Permissions

<p class="scopes">
  <span class="scope">bank:read</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`atomicBankId` | true | *uuid* | `null` | The ID of the atomic bank
`reactionTokenId` | true | *uuid* | `null` | The ID of the reaction token

### Response

Returns a [token](#token-object) with type of `bank:reaction`. Returns [an error](#errors) if the atomic bank failed to react.
