# Tenants

Tenants provide a way to logically group your Applications and tokens. Common use cases for Tenants may be to create one per environment such as development, QA, and production or to isolate business domains from each other. Tenant data is isolated from other tenants unless explicitly shared.


## Tenant Object

| Attribute     | Type                                               | Description                                                                                 |
|---------------|----------------------------------------------------|---------------------------------------------------------------------------------------------|
| `id`          | *uuid*                                             | Unique identifier of the Tenant                                                             |
| `owner_id`    | *uuid*                                             | The user ID which owns the Tenant                                                           |
| `name`        | *string*                                           | The name of the Tenant                                                                      |
| `settings`    | [Tenant Settings](#tenants-tenant-settings-object) | The setting for the Tenant                                                                  |
| `created_by`  | *uuid*                                             | (Optional) The ID of the user that created the Tenant                                       |
| `created_at`  | *date*                                             | (Optional) Created date of the Tenant in ISO 8601 format                                    |
| `modified_by` | *uuid*                                             | (Optional) The ID of the user or [Application](#applications) that last modified the Tenant |
| `modified_at` | *date*                                             | (Optional) Last modified date of the Tenant in ISO 8601 format                              |

## Tenant Usage Report Object

| Attribute      | Type                                         | Description                   |
|----------------|----------------------------------------------|-------------------------------|
| `token_report` | [Token Report](#tenants-token-report-object) | Token Usage Report for Tenant |

## Token Report Object

| Attribute                        | Type                                                                    | Description                                                                 |
|----------------------------------|-------------------------------------------------------------------------|-----------------------------------------------------------------------------|
| `metrics_by_type`                | *map\<string, [TokenTypeMetrics](#tenants-token-type-metrics-object)\>* | Token Metrics by [TokenType](#token-types)                                  |
| `included_monthly_active_tokens` | *long*                                                                  | Number of included monthly active tokens for the billing plan               |
| `monthly_active_tokens`          | *long*                                                                  | Number of tokens that have been created, read, or used in the current month |

<aside class="notice">
  <span><em>To learn more about Monthly Active Tokens (MATs), check out <a href="https://developers.basistheory.com/concepts/what-are-mats/" target="_blank">our guide</a>.</em></span>
</aside>

## Token Type Metrics Object

| Attribute         | Type   | Description                                     |
|-------------------|--------|-------------------------------------------------|
| `count`           | *long* | Number of tokens                                |
| `last_created_at` | *date* | (Optional) Last created date in ISO 8601 format |

## Tenant Settings Object

| Attribute            | Type       | Description                                                    |
|----------------------|------------|----------------------------------------------------------------|
| `deduplicate_tokens` | *string*   | (Bool) Whether tokens are deduplicated on creation and updates |

## Get a Tenant

> Request

```shell
curl "https://api.basistheory.com/tenants/self" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const tenant = await bt.tenants.retrieve();
```

```csharp
using BasisTheory.net.Tenants;

var client = new TenantClient("key_N88mVGsp3sCXkykyN2EFED");

var tenant = await client.GetSelfAsync();
```

```python
import basistheory
from basistheory.api import tenants_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    tenants_client = tenants_api.TenantsApi(api_client)

    tenant = tenants_client.get()
```

> Response

```json
{
  "id": "f88da999-b124-4a14-acde-cbc121444f14",
  "owner_id": "97cec6e8-a143-4fb4-9ab0-cf7e49242d21",
  "name": "My Tenant",
  "settings": {
    "deduplicate_tokens": "false"
  },
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "modified_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/tenants/self`
</span>

Retrieves the Tenant associated with the provided `BT-API-KEY`.

### Permissions

<p class="scopes">
  <span class="scope">tenant:read</span>
</p>

### Response

Returns a [Tenants](#tenants-tenant-object) for the provided `BT-API-KEY`. Returns [an error](#errors) if the Tenant could not be retrieved.


## Update Tenant

> Request

```shell
curl "https://api.basistheory.com/tenants/self" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "PUT" \
  -d '{
    "name": "My Example Tenant",
    "settings": {
      "deduplicate_tokens": "true"
    }
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const tenant = await bt.tenants.update({
  name: 'My Example Tenant',
  settings: {
    "deduplicate_tokens": "true"
  }
});
```

```csharp
using BasisTheory.net.Tenants;

var client = new TenantClient("key_N88mVGsp3sCXkykyN2EFED");

var tenant = await client.UpdateAsync(new Tenant {
  Name = "My Example Tenant"
  Settings = new Dictionary<string, string> {
    { "deduplicate_tokens",  "true" }
  },
});
```

```python
import basistheory
from basistheory.api import tenants_api
from basistheory.model.update_tenant_request import UpdateTenantRequest

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    tenants_client = tenants_api.TenantsApi(api_client)

    tenant = tenants_client.update(update_tenant_request=UpdateTenantRequest(
        name="My Example Tenant"
    ))
```

> Response

```json
{
  "id": "f88da999-b124-4a14-acde-cbc121444f14",
  "owner_id": "97cec6e8-a143-4fb4-9ab0-cf7e49242d21",
  "name": "My Example Tenant",
  "settings": {
    "deduplicate_tokens": "true"
  },
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "modified_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method put">
  <span class="box-method">PUT</span>
  `https://api.basistheory.com/tenants/self`
</span>

Update the Tenant associated with the provided `BT-API-KEY`.

### Permissions

<p class="scopes">
  <span class="scope">tenant:update</span>
</p>

### Request Parameters

| Attribute  | Required | Type     | Default                                            | Description                                           |
|------------|----------|----------|----------------------------------------------------|-------------------------------------------------------|
| `name`     | true     | *string* | `null`                                             | The name of the Tenant. Has a maximum length of `200` |
| `settings` | false    | *string* | [Tenant Settings](#tenants-tenant-settings-object) | The settings for the Tenant                           |

### Response

Returns a [tenant](#tenants-tenant-object) if the Tenant was updated. Returns [an error](#errors) if there were validation errors, or the Tenant failed to update.


## Delete Tenant

> Request

```shell
curl "https://api.basistheory.com/tenants/self" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -X "DELETE"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

await bt.tenants.delete();
```

```csharp
using BasisTheory.net.Tenants;

var client = new TenantClient("key_N88mVGsp3sCXkykyN2EFED");

await client.DeleteAsync();
```

```python
import basistheory
from basistheory.api import tenants_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_CxEaZMmFu3UAcuNcCbvBVu")) as api_client:
    tenants_client = tenants_api.TenantsApi(api_client)

    tenants_client.delete()
```

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/tenants/self`
</span>

Delete the Tenant associated with the provided `BT-API-KEY`.

### Permissions

<p class="scopes">
  <span class="scope">tenant:delete</span>
</p>

### Response

Returns [an error](#errors) if the Tenant failed to delete.


## Get Tenant Usage Report

> Request

```shell
curl "https://api.basistheory.com/tenants/self/reports/usage" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const tenantUsageReport = await bt.tenants.retrieveUsageReport();
```

```csharp
using BasisTheory.net.Tenants;

var client = new TenantClient("key_N88mVGsp3sCXkykyN2EFED");

var tenantUsageReport = await client.GetTenantUsageReportAsync();
```

```python
import basistheory
from basistheory.api import tenants_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    tenants_client = tenants_api.TenantsApi(api_client)

    tenant_usage_report = tenants_client.get_tenant_usage_report()
```

> Response

```json
{
  "token_report": {
    "metrics_by_type": {
      "token": {
        "count": 123,
        "last_created_at": "2020-09-15T15:53:00+00:00"
      },
      "card": {
        "count": 456,
        "last_created_at": "2020-09-15T15:53:00+00:00"
      },
      "bank": {
        "count": 789,
        "last_created_at": "2020-09-15T15:53:00+00:00"
      }
    },
    "included_monthly_active_tokens": 50,
    "monthly_active_tokens": 987
  }
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/tenants/self/reports/usage`
</span>

Retrieves the Tenant Usage Report associated with the provided `BT-API-KEY`.

### Permissions

<p class="scopes">
  <span class="scope">report:read</span>
</p>

### Response

Returns a [Tenant Usage Report](#tenants-tenant-usage-report-object) for the provided `BT-API-KEY`. Returns [an error](#errors) if the Tenant Usage Report could not be retrieved.
