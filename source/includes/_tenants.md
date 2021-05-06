# Tenants

Tenants provide a way to logically group your applications and tokens. Common use cases for tenants may be per environment such as development, QA, and production or to isolate business domains from each other. Tenant data is isolated from each other unless explicitely shared.

## Get a Tenant

> Get a Tenant Request Example:

```shell
curl "api.basistheory.com/tenants/self" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> Tenant Response Example:

```json
{
  "id": "f88da999-b124-4a14-acde-cbc121444f14",
  "owner_id": "97cec6e8-a143-4fb4-9ab0-cf7e49242d21",
  "name": "My Tenant",
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method get">GET</span> `https://api.basistheory.com/tenants/self`

Retrieves the tenant associated with the provided `X-API-KEY`.

### Permissions

<p class="scopes">
  <span class="scope">tenant:read</span>
</p>

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the tenant
`owner_id` | *string* | The user ID which owns the tenant
`name` | *string* | The name of the tenant
`created_at` | *string* | Created date of the application in ISO 8601 format
`modified_at` | *string* | Last modified date of the application in ISO 8601 format

### Response Messages

Code | Description
---- | -----------
`200` | Tenant successfully retrieved
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | The tenant was not found


## Update Tenant

> Update Tenant Request Example:

```shell
curl "api.basistheory.com/tenants/self" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -H "Content-Type: application/json"
  -X "PUT"
  -D '{
    "name": "My Example Tenant"
  }'
```

> Update Tenant Response Example:

```json
{
  "id": "f88da999-b124-4a14-acde-cbc121444f14",
  "owner_id": "97cec6e8-a143-4fb4-9ab0-cf7e49242d21",
  "name": "My Example Tenant",
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method put">PUT</span> `https://api.basistheory.com/tenants/self`

Update the tenant associated with the provided `X-API-KEY`.

### Permissions

<p class="scopes">
  <span class="scope">application:update</span>
</p>

### Request Schema

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | true | *string* | `null` | The name of the tenant. Has a maximum length of `200`

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the tenant
`owner_id` | *string* | The user ID which owns the tenant
`name` | *string* | The name of the tenant
`created_at` | *string* | Created date of the application in ISO 8601 format
`modified_at` | *string* | Last modified date of the application in ISO 8601 format

### Response Messages

Code | Description
---- | -----------
`200` | Tenant successfully updated
`400` | Invalid request body. See [Errors](#errors) response for details
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | The tenant was not found


## Delete Tenant

> Delete Tenant Request Example:

```shell
curl "api.basistheory.com/tenants/self" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -X "DELETE"
```

<span class="http-method delete">DELETE</span> `https://api.basistheory.com/tenants/self`

Delete the tenant associated with the provided `X-API-KEY`.

### Permissions

`tenant:write`

### Response Messages

Code | Description
---- | -----------
`204` | Tenant successfully deleted
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | The tenant was not found