# Tenants

Tenants provide a way to logically group your Applications and tokens. Common use cases for Tenants may be to create one per environment such as development, QA, and production or to isolate business domains from each other. Tenant data is isolated from other tenants unless explicitly shared.


## Tenant Object

Attribute | Type | Description
--------- | ---- | -----------
`id` | *uuid* | Unique identifier of the Tenants
`owner_id` | *uuid* | The user ID which owns the Tenants
`name` | *string* | The name of the Tenants
`created_by` | *uuid* | (Optional) The ID of the user that created the Tenant
`created_at` | *date* | (Optional) Created date of the Tenant in ISO 8601 format
`modified_by` | *uuid* | (Optional) The ID of the user or [Application](#applications) that last modified the Tenant
`modified_at` | *date* | (Optional) Last modified date of the Tenant in ISO 8601 format

## Tenant Usage Report Object

Attribute | Type | Description
--------- | ---- | -----------
`token_report` | [Token Report](#tenants-token-report-object) | Token Usage Report for Tenant

## Token Report Object

Attribute | Type | Description
--------- | ---- | -----------
`metrics_by_type` | *map\<string, [TokenTypeMetrics](#tenants-token-type-metrics-object)\>* | Token Metrics by [TokenType](#tokens-token-types)
`included_monthly_active_tokens` | *long* | Number of included monthly active tokens for the billing plan
`monthly_active_tokens` | *long* | Number of tokens that have been created, read, updated, or decrypted in the current month

## Token Type Metrics Object

Attribute | Type | Description
--------- | ---- | -----------
`count` | *long* | Number of tokens
`last_created_at` | *date* | (Optional) Last created date in ISO 8601 format

## Get a Tenant

> Request

```shell
curl "https://api.basistheory.com/tenants/self" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
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
# Coming Soon!
```

> Response

```json
{
  "id": "f88da999-b124-4a14-acde-cbc121444f14",
  "owner_id": "97cec6e8-a143-4fb4-9ab0-cf7e49242d21",
  "name": "My Tenant",
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

Retrieves the Tenant associated with the provided `X-API-KEY`.

### Permissions

<p class="scopes">
  <span class="scope">tenant:read</span>
</p>

### Response

Returns a [Tenants](#tenants-tenant-object) for the provided `X-API-KEY`. Returns [an error](#errors) if the Tenant could not be retrieved.


## Update Tenant

> Request

```shell
curl "https://api.basistheory.com/tenants/self" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "PUT" \
  -d '{
    "name": "My Example Tenant"
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const tenant = await bt.tenants.update({
  name: 'My Example Tenant',
});
```

```csharp
using BasisTheory.net.Tenants;

var client = new TenantClient("key_N88mVGsp3sCXkykyN2EFED");

var tenant = await client.UpdateAsync(new Tenant {
  Name = "My Example Tenant"
});
```

```python
# Coming Soon!
```

> Response

```json
{
  "id": "f88da999-b124-4a14-acde-cbc121444f14",
  "owner_id": "97cec6e8-a143-4fb4-9ab0-cf7e49242d21",
  "name": "My Example Tenant",
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

Update the Tenant associated with the provided `X-API-KEY`.

### Permissions

<p class="scopes">
  <span class="scope">tenant:update</span>
</p>

### Request Parameters

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | true | *string* | `null` | The name of the Tenant. Has a maximum length of `200`

### Response

Returns a [tenant](#tenants-tenant-object) if the Tenant was updated. Returns [an error](#errors) if there were validation errors, or the Tenant failed to update.


## Delete Tenant

> Request

```shell
curl "https://api.basistheory.com/tenants/self" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
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
# Coming Soon!
```

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/tenants/self`
</span>

Delete the Tenant associated with the provided `X-API-KEY`.

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
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
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
# Coming Soon!
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

Retrieves the Tenant Usage Report associated with the provided `X-API-KEY`.

### Permissions

<p class="scopes">
  <span class="scope">report:read</span>
</p>

### Response

Returns a [Tenant Usage Report](#tenants-tenant-usage-report-object) for the provided `X-API-KEY`. Returns [an error](#errors) if the Tenant Usage Report could not be retrieved.
