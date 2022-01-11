# Atomic Banks

## Atomic Bank Object

| Attribute     | Type                                                   | Description                                                                                                                   |
|---------------|--------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------|
| `id`          | *uuid*                                                 | Unique identifier of the token which can be used to [get an Atomic Bank](#atomic-banks-get-an-atomic-bank)                    |
| `tenant_id`   | *uuid*                                                 | The [Tenant](#tenants) ID which owns the bank                                                                                 |
| `type`        | *string*                                               | `Bank` [token type](#tokens-token-types)                                                                                      |
| `bank`        | *[bank](#atomic-banks-atomic-bank-object-bank-object)* | Bank data                                                                                                                     |
| `fingerprint` | *string*                                               | Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same. |
| `metadata`    | *map*                                                  | A key-value map of non-sensitive data.                                                                                        |
| `created_by`  | *uuid*                                                 | (Optional) The [Application](#applications) ID which created the Atomic Bank                                                  |
| `created_at`  | *date*                                                 | (Optional) Created date of the Atomic Bank in ISO 8601 format                                                                 |
| `modified_by` | *uuid*                                                 | (Optional) The [Application](#applications) ID which last modified the Atomic Bank                                            |
| `modified_at` | *date*                                                 | (Optional) Last modified date of the Atomic Bank in ISO 8601 format                                                           |

### Bank Object

| Attribute        | Required | Type     | Default | Description                           |
|------------------|----------|----------|---------|---------------------------------------|
| `routing_number` | true     | *string* | `null`  | Nine-digit ABA routing number         |
| `account_number` | true     | *string* | `null`  | Account number up to seventeen-digits |


## Create Atomic Bank

> Request

```shell
curl "https://api.basistheory.com/atomic/banks" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "POST" \
  -d '{
      "bank": {
        "routing_number": "021000021",
        "account_number": "1234567890"
      },
      "metadata": {
        "nonSensitiveField": "Non-Sensitive Value"
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
using BasisTheory.net.Atomic.Banks;

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

```python
# Coming Soon!
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
  "fingerprint": "8j6WJgk4Dz1qoJgrHrioUFJhYKQTnk75DfJAue5bNab2",
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

Create a new Atomic Bank for the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">token:bank:create</span>
</p>

### Request Parameters

| Attribute  | Required | Type                                                   | Default | Description                            |
|------------|----------|--------------------------------------------------------|---------|----------------------------------------|
| `bank`     | true     | *[bank](#atomic-banks-atomic-bank-object-bank-object)* | `null`  | Bank data                              |
| `metadata` | false    | *map*                                                  | `null`  | A key-value map of non-sensitive data. |

### Response

Returns an [Atomic Bank](#atomic-banks-atomic-bank-object) with masked [bank data](#atomic-banks-atomic-bank-object-bank-object) if the Atomic Bank was created. Returns [an error](#errors) if there were validation errors, or the Atomic Bank failed to create.


## List Atomic Banks

> Request

```shell
curl "https://api.basistheory.com/atomic/banks" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const atomicBanks = await bt.atomicBanks.list();
```

```csharp
using BasisTheory.net.Atomic.Banks;

var client = new AtomicBankClient("key_N88mVGsp3sCXkykyN2EFED");

var atomicBanks = await client.GetAsync();
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
      "id": "1485efb9-6b1f-4248-a5d1-cf9b3907164c",
      "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
      "type": "bank",
      "bank": {
        "routing_number": "021000021",
        "account_number": "XXXXXX7890"
      },
      "fingerprint": "8j6WJgk4Dz1qoJgrHrioUFJhYKQTnk75DfJAue5bNab2",
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

Get a list of Atomic Banks for the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">token:bank:read:&lt;impact_level&gt;</span>
</p>

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of [Atomic Banks](#atomic-banks-atomic-bank-object). Providing any query parameters will filter the results.
Plaintext Bank data will be returned when the requester has `token:bank:read:high` permission.
Bank data will be masked when the requester has read permissions on `bank` classification at a lower impact level (i.e. `token:bank:read:low`, `token:bank:read:moderate`).
Returns [an error](#errors) if Atomic Banks could not be retrieved.


## Get an Atomic Bank

> Request

```shell
curl "https://api.basistheory.com/atomic/banks/1485efb9-6b1f-4248-a5d1-cf9b3907164c" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```csharp
using BasisTheory.net.Atomic.Banks;

var client = new AtomicBankClient("key_N88mVGsp3sCXkykyN2EFED");

var atomicBank = await client.GetByIdAsync("1485efb9-6b1f-4248-a5d1-cf9b3907164c");
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const atomicBank = await bt.atomicBanks.retrieve('1485efb9-6b1f-4248-a5d1-cf9b3907164c');
```

```python
# Coming Soon!
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
  "fingerprint": "8j6WJgk4Dz1qoJgrHrioUFJhYKQTnk75DfJAue5bNab2",
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

Get an Atomic Bank by ID in the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">token:bank:read:&lt;impact_level&gt;</span>
</p>

### URI Parameters

| Parameter | Required | Type   | Default | Description               |
|-----------|----------|--------|---------|---------------------------|
| `id`      | true     | *uuid* | `null`  | The ID of the Atomic Bank |

### Response

Returns an [Atomic Bank](#atomic-banks-atomic-bank-object) with the `id` provided.
Plaintext Bank data will be returned when the requester has `token:bank:read:high` permission.
Bank data will be masked when the requester has read permissions on `bank` classification at a lower impact level (i.e. `token:bank:read:low`, `token:bank:read:moderate`).
Returns [an error](#errors) if the Atomic Bank could not be retrieved.


## Update Atomic Bank

> Request

```shell
curl "https://api.basistheory.com/atomic/banks/1485efb9-6b1f-4248-a5d1-cf9b3907164c" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "PATCH" \
  -d '{
      "bank": {
        "routing_number": "021000021",
        "account_number": "1234567890"
      },
    }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const atomicBank = await bt.atomicBanks.update("1485efb9-6b1f-4248-a5d1-cf9b3907164c", {
  bank: {
    routingNumber: '021000021',
    accountNumber: '1234567890',
  },
});
```

```csharp
using BasisTheory.net.Atomic.Banks;

var client = new AtomicBankClient("key_N88mVGsp3sCXkykyN2EFED");

var atomicBank = await client.UpdateAsync("1485efb9-6b1f-4248-a5d1-cf9b3907164c", new UpdateAtomicBankRequest {
  Bank = new Bank {
    RoutingNumber = "021000021",
    AccountNumber = "1234567890"
  },
});
```

```python
# Coming Soon!
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
  "fingerprint": "8j6WJgk4Dz1qoJgrHrioUFJhYKQTnk75DfJAue5bNab2",
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
  `https://api.basistheory.com/atomic/banks/{id}`
</span>

Update an Atomic Bank for the Tenant. At least one property on the request body is required.

### Permissions

<p class="scopes">
  <span class="scope">token:bank:update</span>
</p>

### Request Parameters

| Attribute | Required | Type                                                   | Default | Description |
|-----------|----------|--------------------------------------------------------|---------|-------------|
| `bank`    | true     | *[bank](#atomic-banks-atomic-bank-object-bank-object)* | `null`  | Bank data   |

### Response

Returns an [Atomic Bank](#atomic-banks-atomic-bank-object) with masked [bank data](#atomic-banks-atomic-bank-object-bank-object) if the Atomic Bank was updated. Returns [an error](#errors) if there were validation errors, or the Atomic Bank failed to update.


## Delete Atomic Bank

> Request

```shell
curl "https://api.basistheory.com/atomic/banks/1485efb9-6b1f-4248-a5d1-cf9b3907164c" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -X "DELETE"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

await bt.atomicBanks.delete('1485efb9-6b1f-4248-a5d1-cf9b3907164c');
```

```csharp
using BasisTheory.net.Atomic.Banks;

var client = new AtomicBankClient("key_N88mVGsp3sCXkykyN2EFED");

await client.DeleteAsync("1485efb9-6b1f-4248-a5d1-cf9b3907164c");
```

```python
# Coming Soon!
```

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/atomic/banks/{id}`
</span>

Delete an Atomic Bank by ID in the Tenant.

<aside class="warning">
<span>WARNING - The data associated with a deleted Atomic Bank will be removed forever. The reference will still exist for audit purposes</span>
</aside>

### Permissions

<p class="scopes">
  <span class="scope">token:bank:delete</span>
</p>

### URI Parameters

| Parameter | Required | Type   | Default | Description               |
|-----------|----------|--------|---------|---------------------------|
| `id`      | true     | *uuid* | `null`  | The ID of the Atomic Bank |

### Response

Returns [an error](#errors) if the Atomic Bank failed to delete.


## Decrypt Atomic Bank <span class="deprecated menu">DEPRECATED</span>

<aside class="danger">
  <span>This endpoint has been deprecated in favor of <a class="black-link" href="#atomic-banks-get-an-atomic-bank">Get an Atomic Bank</a>.</span>
</aside>

> Request

```shell
curl "https://api.basistheory.com/atomic/banks/1485efb9-6b1f-4248-a5d1-cf9b3907164c/decrypt" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const atomicBank = await bt.atomicBanks.retrieveDecrypted('1485efb9-6b1f-4248-a5d1-cf9b3907164c');
```

```csharp
using BasisTheory.net.Atomic.Banks;

var client = new AtomicBankClient("key_N88mVGsp3sCXkykyN2EFED");

var atomicBank = await client.GetByIdAsync("1485efb9-6b1f-4248-a5d1-cf9b3907164c", 
  new BankGetByIdRequest {
    Decrypt = true
  });
```

```python
# Coming Soon!
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
  "fingerprint": "8j6WJgk4Dz1qoJgrHrioUFJhYKQTnk75DfJAue5bNab2",
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

Decrypt an Atomic Bank by ID in the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">token:bank:read:high</span>
</p>

### URI Parameters

| Parameter | Required | Type   | Default | Description               |
|-----------|----------|--------|---------|---------------------------|
| `id`      | true     | *uuid* | `null`  | The ID of the Atomic Bank |

### Response

Returns an [Atomic Bank](#atomic-banks-atomic-bank-object) with plaintext [bank](#atomic-banks-atomic-bank-object-bank-object) data with the `id` provided. Returns [an error](#errors) if the Atomic Bank could not be retrieved.


## React with an Atomic Bank

> Request

```shell
curl "https://api.basistheory.com/atomic/banks/1485efb9-6b1f-4248-a5d1-cf9b3907164c/react" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
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

const reactResponse = await bt.atomicBanks.react('1485efb9-6b1f-4248-a5d1-cf9b3907164c', {
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
using BasisTheory.net.Atomic.Banks;

var client = new AtomicBankClient("key_N88mVGsp3sCXkykyN2EFED");

var reactResponse = await client.ReactAsync("1485efb9-6b1f-4248-a5d1-cf9b3907164c", 
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
  `https://api.basistheory.com/atomic/banks/{id}/react`
</span>

React with an Atomic Bank by ID.

### Permissions

<p class="scopes">
  <span class="scope">token:bank:use:reactor</span>
</p>

### URI Parameters

| Parameter | Required | Type   | Default | Description               |
|-----------|----------|--------|---------|---------------------------|
| `id`      | true     | *uuid* | `null`  | The ID of the Atomic Bank |

### Request Parameters
| Parameter            | Required | Type   | Default | Description                                                                                                                                                        |
|----------------------|----------|--------|---------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `reactor_id`         | true     | *uuid* | `null`  | The ID of the reactor                                                                                                                                              |
| `request_parameters` | false    | *map*  | `null`  | A key-value map of [request parameters](#reactor-forumula-request-parameter-object) names and values for the reactor                                               |
| `metadata`           | false    | *map*  | `null`  | A key-value map of non-sensitive data. We overwrite the following keys: `correlation_id`, `reactor_id`, `reactor_name`, `source_token_id`, and `source_token_type` |

### Response

Returns a [React Response](#atomic-banks-react-with-an-atomic-bank-react-response-object) if the Atomic Bank was reacted successfully. Returns [an error](#errors) if the Atomic Bank failed to react.
Errors generated from Reactors will be translated to the common Basis Theory Error format. See [Reactor Errors](#errors-reactor-errors) for more details.

### React Response Object
| Attribute | Type  | Description                                                                                           |
|-----------|-------|-------------------------------------------------------------------------------------------------------|
| `tokens`  | *map* | (Optional) [Token(s)](#tokens-token-object) created from the `tokenize` block of the Reactor response |
| `raw`     | *map* | (Optional) Raw output returned from the Reactor                                                       |


## Test Banks

To enable testing of Atomic Banks, we've implemented a list of acceptable test bank accounts to ensure you are able to test with non-sensitive data.

### Test bank accounts

| Routing Number | Account Number | Description             |
|----------------|----------------|-------------------------|
| 110000000      | 000123456789   | Successfully added bank |
