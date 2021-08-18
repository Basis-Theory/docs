# Reactors


## Reactor Object

Attribute | Type | Description
--------- | ---- | -----------
`id` | *uuid* | Unique identifier of the reactor which can be used to [get a reactor](#get-an-reactor)
`tenant_id` | *uuid* | The [tenant](#tenants) ID which owns the reactor
`name` | *string* | The name of the reactor
`formula` | *[reactor formula](#reactor-formla-object)* | Reactor formula this reactor is configured for
`configuration` | *map* | A key-value map of all configuration name and values for an [reactor formula configuration](#reactor-formula-configuration-object)
`created_at` | *string* | Created date of the reactor in ISO 8601 format
`modified_at` | *string* | Last modified date of the reactor in ISO 8601 format


## Create Reactor

> Request

```shell
curl "https://api.basistheory.com/reactors" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "POST" \
  -d '{
    "name": "My Reactor",
    "configuration": {
      "SERVICE_API_KEY": "key_abcd1234"
    },
    "formula": {
      "id": "17069df1-80f4-439e-86a7-4121863e4678"
    }
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const reactor = await bt.reactors.create({
  name: 'My Reactor',
  configuration: {
    SERVICE_API_KEY: 'key_abcd1234',
  },
  formula: {
    id: '17069df1-80f4-439e-86a7-4121863e4678',
  },
});
```

```csharp
using BasisTheory.net.Reactors;

var client = new ReactorClient("key_N88mVGsp3sCXkykyN2EFED");

var reactor = await client.CreateAsync(new Reactor {
  Name = "My Reactor",
  Configuration = new Dictionary<string, string> {
    { "SERVICE_API_KEY", "key_abcd1234" }
  },
  Formula = new Formula {
    Id = new Guid("17069df1-80f4-439e-86a7-4121863e4678")
  }
});
```

> Response

```json
{
  "id": "5b493235-6917-4307-906a-2cd6f1a90b13",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Reactor",
  "formula": {...},
  "configuration": {
    "SERVICE_API_KEY": "key_abcd1234"
  },
  "created_at": "2020-09-15T15:53:00+00:00"
}
```

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/reactors`
</span>

Create a new reactor from a reactor formula for the tenant.

### Permissions

<p class="scopes">
  <span class="scope">reactor:create</span>
</p>

### Request Parameters

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | true | *string* | `null` | The name of the reactor. Has a maximum length of `200`
`configuration` | true | *object* | `null` | A key-value map of all configuration name and values for an [reactor formula configuration](#reactor-formula-configuration-object)
`formula.id` | true | *uuid* | `null` | Unique identifier of the [reactor formula](#reactor-formula-object) to configure a reactor for

### Response

Returns an [reactor](#reactor-object) if the reactor was created. Returns [an error](#errors) if there were validation errors or the reactor failed to create.


## List Reactors

> Request

```shell
curl "https://api.basistheory.com/reactors" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const reactors = await bt.reactors.list();
```

```csharp
using BasisTheory.net.Reactors;

var client = new ReactorClient("key_N88mVGsp3sCXkykyN2EFED");

var reactors = await client.GetAsync();
```

> Response

```json
{
  "pagination": {...}
  "data": [
    {
      "id": "5b493235-6917-4307-906a-2cd6f1a90b13",
      "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
      "name": "My Reactor",
      "formula": {...},
      "configuration": {
        "SERVICE_API_KEY": "key_abcd1234"
      },
      "created_at": "2020-09-15T15:53:00+00:00",
      "modified_at": "2021-03-01T08:23:14+00:00"
    },
    {...},
    {...}
  ]
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/reactors`
</span>

Get a list of reactors for the tenant.

### Permissions

<p class="scopes">
  <span class="scope">reactor:read</span>
</p>

### Query Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | false | *array* | `[]` | An optional list of reactor ID's to filter the list of reactors by
`name` | false | *string* | `null` | Wildcard search of reactors by name
`source_token_type` | false | *string* | `null` | Filter reactors by reactor formulas [source token type](#token-types)

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of [reactors](#reactor-object). Providing any query parameters will filter the results. Returns [an error](#errors) if reactors could not be retrieved.


## Get a Reactor

> Request

```shell
curl "https://api.basistheory.com/reactors/5b493235-6917-4307-906a-2cd6f1a90b13" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const reactor = await bt.reactors.retrieve('5b493235-6917-4307-906a-2cd6f1a90b13');
```

```csharp
using BasisTheory.net.Reactors;

var client = new ReactorClient("key_N88mVGsp3sCXkykyN2EFED");

var reactor = await client.GetByIdAsync("5b493235-6917-4307-906a-2cd6f1a90b13");
```

> Response

```json
{
  "id": "5b493235-6917-4307-906a-2cd6f1a90b13",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Reactor",
  "formula": {...},
  "configuration": {
    "SERVICE_API_KEY": "key_abcd1234"
  },
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/reactors/{id}`
</span> 

Get a reactor by ID in the tenant.

### Permissions

<p class="scopes">
  <span class="scope">reactor:read</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the reactor

### Response

Returns an [reactor](#reactor-object) with the `id` provided. Returns [an error](#errors) if the reactor could not be retrieved.


## Update Reactor

> Request

```shell
curl "https://api.basistheory.com/reactors/5b493235-6917-4307-906a-2cd6f1a90b13" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "PUT" \
  -d '{
    "name": "My Reactor",
    "configuration": {
      "SERVICE_API_KEY": "key_abcd1234"
    }
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const reactor = await bt.reactors.update('5b493235-6917-4307-906a-2cd6f1a90b13', {
  name: 'My Reactor',
  configuration: {
    SERVICE_API_KEY: 'key_abcd1234',
  },
});
```

```csharp
using BasisTheory.net.Reactors;

var client = new ReactorClient("key_N88mVGsp3sCXkykyN2EFED");

var reactor = await client.UpdateAsync("5b493235-6917-4307-906a-2cd6f1a90b13", 
  new Reactor {
    Name = "My Reactor",
    Configuration = new Dictionary<string, string> {
      { "SERVICE_API_KEY", "key_abcd1234" }
    }
  }
);
```

> Response

```json
{
  "id": "5b493235-6917-4307-906a-2cd6f1a90b13",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Reactor",
  "formula": {...},
  "configuration": {
    "SERVICE_API_KEY": "key_abcd1234"
  },
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method put">
  <span class="box-method">PUT</span>
  `https://api.basistheory.com/reactors/{id}`
</span>

Update a reactor by ID in the tenant.

### Permissions

<p class="scopes">
  <span class="scope">reactor:update</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the reactor

### Request Parameters

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | true | *string* | `null` | The name of the reactor. Has a maximum length of `200`
`configuration` | true | *object* | `null` | A key-value map of all configuration name and values for an [reactor formula configuration](#reactor-formula-configuration-object)

### Response

Returns an [reactor](#reactor-object) if the reactor was updated. Returns [an error](#errors) if there were validation errors or the reactor failed to update.


## Delete Reactor

> Request

```shell
curl "https://api.basistheory.com/reactors/fb124bba-f90d-45f0-9a59-5edca27b3b4a" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -X "DELETE"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

await bt.reactors.delete('fb124bba-f90d-45f0-9a59-5edca27b3b4a');
```

```csharp
using BasisTheory.net.Reactors;

var client = new ReactorClient("key_N88mVGsp3sCXkykyN2EFED");

await client.DeleteAsync("fb124bba-f90d-45f0-9a59-5edca27b3b4a");
```

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/reactors/{id}`
</span>

Delete a reactor by ID in the tenant.

### Permissions

`reactor:delete`

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the reactor

### Response

Returns [an error](#errors) if the reactor failed to delete.
