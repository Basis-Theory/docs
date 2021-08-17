# Tenants

Tenants provide a way to logically group your applications and tokens. Common use cases for tenants may be per environment such as development, QA, and production or to isolate business domains from each other. Tenant data is isolated from each other unless explicitely shared.


## Tenant Object

Attribute | Type | Description
--------- | ---- | -----------
`id` | *uuid* | Unique identifier of the tenant
`owner_id` | *uuid* | The user ID which owns the tenant
`name` | *string* | The name of the tenant
`created_at` | *date* | Created date of the application in ISO 8601 format
`modified_at` | *date* | Last modified date of the application in ISO 8601 format


## Get a Tenant

> Request

```shell
curl "https://api.basistheory.com/tenants/self" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@Basis-Theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const tenant = await bt.tenants.retrieve();
```

```csharp
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

Retrieves the tenant associated with the provided `X-API-KEY`.

### Permissions

<p class="scopes">
  <span class="scope">tenant:read</span>
</p>

### Response

Returns a [tenant](#tenant-object) for the provided `X-API-KEY`. Returns [an error](#errors) if the tenant could not be retrieved.


## Update Tenant

> Request

```shell
curl "https://api.basistheory.com/tenants/self" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -H "Content-Type: application/json"
  -X "PUT"
  -D '{
    "name": "My Example Tenant"
  }'
```

```javascript
import { BasisTheory } from '@Basis-Theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const tenant = await bt.tenants.update({
  name: 'My Example Tenant',
});
```

```csharp
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

Update the tenant associated with the provided `X-API-KEY`.

### Permissions

<p class="scopes">
  <span class="scope">application:update</span>
</p>

### Request Parameters

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | true | *string* | `null` | The name of the tenant. Has a maximum length of `200`

### Response

Returns a [tenant](#tenant-object) if the tenant was updated. Returns [an error](#errors) if there were validation errors or the tenant failed to update.


## Delete Tenant

> Request

```shell
curl "https://api.basistheory.com/tenants/self" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -X "DELETE"
```

```javascript
import { BasisTheory } from '@Basis-Theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

await bt.tenants.delete();
```

```csharp
var client = new TenantClient("key_N88mVGsp3sCXkykyN2EFED");

await client.DeleteAsync();
```

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/tenants/self`
</span>

Delete the tenant associated with the provided `X-API-KEY`.

### Permissions

`tenant:write`

### Response

Returns [an error](#errors) if the tenant failed to delete.
