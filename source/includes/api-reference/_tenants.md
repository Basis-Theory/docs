# Tenants

Tenants provide a way to logically group your Applications and tokens. Common use cases for Tenants may be to create one per environment such as development, QA, and production or to isolate business domains from each other. Tenant data is isolated from other tenants unless explicitly shared.


## Tenant Object

Attribute | Type | Description
--------- | ---- | -----------
`id` | *uuid* | Unique identifier of the Tenants
`owner_id` | *uuid* | The user ID which owns the Tenants
`name` | *string* | The name of the Tenants
`created_at` | *date* | Created date of the Tenant in ISO 8601 format
`modified_at` | *date* | Last modified date of the Tenant in ISO 8601 format

## Tenant Usage Report Object

Attribute | Type | Description
--------- | ---- | -----------
`token_report` | [Token Report](#tenants-token-report-object) | Token Usage Report for Tenant

## Token Report Object

Attribute | Type | Description
--------- | ---- | -----------
`enrichment_limit` | *long (optional)* | Tenant limit to number of enrichment tokens
`free_enriched_token_limit` | *long (optional)* | Tenant limit to number of enriched tokens
`metrics_by_type` | *map\<string, [TokenTypeMetrics](#tenants-token-type-metrics-object)\>* | Token Metrics by [TokenType](#tokens-token-types)
`number_of_enriched_tokens` | *long* | Number of tokens that have been used in a [Reactor](#reactors)
`number_of_enrichments` | *long* | Number of tokens that have been created through a [Reactor](#reactor)

## Token Type Metrics Object

Attribute | Type | Description
--------- | ---- | -----------
`count` | *long* | Number of tokens
`last_created_at` | *date (optional)* | Last created date in ISO 8601 format

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

> Response

```json
{
  "id": "f88da999-b124-4a14-acde-cbc121444f14",
  "owner_id": "97cec6e8-a143-4fb4-9ab0-cf7e49242d21",
  "name": "My Tenant",
  "created_at": "2020-09-15T15:53:00+00:00",
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

> Response

```json
{
  "id": "f88da999-b124-4a14-acde-cbc121444f14",
  "owner_id": "97cec6e8-a143-4fb4-9ab0-cf7e49242d21",
  "name": "My Example Tenant",
  "created_at": "2020-09-15T15:53:00+00:00",
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
  <span class="scope">application:update</span>
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

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/tenants/self`
</span>

Delete the Tenant associated with the provided `X-API-KEY`.

### Permissions

`tenant:write`

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

> Response

```json
{
  "token_report": {
    "enrichment_limit": 1000,
    "free_enriched_token_limit": 1000,
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
    "number_of_enriched_tokens": 123,
    "number_of_enrichments": 100
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
