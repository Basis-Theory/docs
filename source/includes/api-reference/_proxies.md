# Proxies

Proxies are...


<aside class="notice">
  <span>If you are looking for how to invoke a Proxy, head over <a href="#proxy">here</a>.</span>
</aside>

## Proxy Object

[//]: # (TODO review table links) 

| Attribute            | Type     | Description                                                                                |
|----------------------|----------|--------------------------------------------------------------------------------------------|
| `id`                 | *uuid*   | Unique identifier of the Proxy which can be used to [get a Proxy](#proxies-get-a-proxy)    |
| `key`                | *string* | Auto-generated key used to [invoke a particular Proxy](#proxy-todo)                        |
| `name`               | *string* | The name of the Proxy                                                                      |
| `destination_url`    | *string* | The URL to proxy requests to                                                               |
| `request_reactor_id` | *string* | The [Reactor](#reactors) to invoke when the Proxy is requested                             |
| `tenant_id`          | *uuid*   | The [Tenant](#tenants) ID which owns the Proxy                                             |
| `created_by`         | *uuid*   | (Optional) The ID of the user or [Application](#applications) that created the Proxy       |
| `created_at`         | *string* | (Optional) Created date of the Proxy in ISO 8601 format                                    |
| `modified_by`        | *uuid*   | (Optional) The ID of the user or [Application](#applications) that last modified the Proxy |
| `modified_at`        | *date*   | (Optional) Last modified date of the Proxy in ISO 8601 format                              |

## Create a Proxy

> Request

```shell
curl "https://api.basistheory.com/proxies" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "POST" \
  -d '{
    "name": "My Proxy",
    "destination_url": "https://example.com/api",
    "request_reactor_id": "5b493235-6917-4307-906a-2cd6f1a90b13"
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const proxy = await bt.proxies.create({
  name: 'My Proxy',
  destinationUrl: 'https://example.com/api',
  requestReactorId: '5b493235-6917-4307-906a-2cd6f1a90b13'
});
```

```csharp
using BasisTheory.net.Proxies;

var client = new ProxyClient("key_N88mVGsp3sCXkykyN2EFED");

var proxy = await client.CreateAsync(new Proxy {
  Name = "My Proxy",
  DestinationUrl = "https://example.com/api",
  RequestReactorId = "5b493235-6917-4307-906a-2cd6f1a90b13"
});
```

```python
TODO
```

```go
TODO
```

> Response

```json
{
  "id": "433013a6-a614-4e1e-b2aa-5fba67aa85e6",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Proxy",
  "key": "e29a50980ca5",
  "destination_url": "https://example.com/api",
  "request_reactor_id": "5b493235-6917-4307-906a-2cd6f1a90b13",
  "created_by": "3ce0dceb-fd0b-4471-8006-c51243c9ef7a",
  "created_at": "2020-09-15T15:53:00+00:00"
}
```

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/proxies`
</span>

Creates a new Proxy for the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">proxy:create</span>
</p>


### Request Parameters

| Attribute            | Required | Type     | Default | Description                                                    |
|----------------------|----------|----------|---------|----------------------------------------------------------------|
| `name`               | true     | *string* | `null`  | The name of the Proxy. Has a maximum length of `200`           |
| `destination_url`    | true     | *string* | `null`  | The URL to proxy requests to                                   |
| `request_reactor_id` | true     | *string* | `null`  | The [Reactor](#reactors) to invoke when the Proxy is requested |

### Response

Returns a [Proxy](#proxies-proxy-object) if the Proxy was created. Returns [an error](#errors) if there were validation errors, or the Proxy failed to create.


## List Proxies

> Request

```shell
curl "https://api.basistheory.com/proxies" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const proxies = await bt.proxies.list();
```

```csharp
using BasisTheory.net.Proxies;

var client = new ProxyClient("key_N88mVGsp3sCXkykyN2EFED");

var proxies = await client.GetAsync();
```

```python
TODO
```

```go
TODO
```

> Response

```json
{
  "pagination": {...}
  "data": [
    {
      "id": "433013a6-a614-4e1e-b2aa-5fba67aa85e6",
      "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
      "name": "My Proxy",
      "key": "e29a50980ca5",
      "destination_url": "https://example.com/api",
      "request_reactor_id": "5b493235-6917-4307-906a-2cd6f1a90b13",
      "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
      "created_at": "2020-09-15T15:53:00+00:00",
      "modified_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
      "modified_at": "2021-03-01T08:23:14+00:00"
    },
    {...},
    {...}
  ]
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/proxies`
</span>

Get a list of proxies for the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">proxy:read</span>
</p>

### Query Parameters

| Parameter | Required | Type     | Default | Description                                                     |
|-----------|----------|----------|---------|-----------------------------------------------------------------|
| `id`      | false    | *array*  | `[]`    | An optional list of Proxy ID's to filter the list of proxies by |
| `name`    | false    | *string* | `null`  | Wildcard search of proxies by name                              |

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of [proxies](#proxies-proxy-object). Providing any query parameters will filter the results. Returns [an error](#errors) if proxies could not be retrieved.


## Get a Proxy

> Request

```shell
curl "https://api.basistheory.com/proxies/5b493235-6917-4307-906a-2cd6f1a90b13" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const proxy = await bt.proxies.retrieve('5b493235-6917-4307-906a-2cd6f1a90b13');
```

```csharp
using BasisTheory.net.Proxies;

var client = new ProxyClient("key_N88mVGsp3sCXkykyN2EFED");

var proxy = await client.GetByIdAsync("5b493235-6917-4307-906a-2cd6f1a90b13");
```

```python
TODO
```

```go
TODO
```

> Response

```json
{
  "id": "433013a6-a614-4e1e-b2aa-5fba67aa85e6",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Proxy",
  "key": "e29a50980ca5",
  "destination_url": "https://example.com/api",
  "request_reactor_id": "5b493235-6917-4307-906a-2cd6f1a90b13",
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "modified_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/proxies/{id}`
</span> 

Get a Proxy by ID in the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">proxy:read</span>
</p>

### URI Parameters

| Parameter | Required | Type   | Default | Description         |
|-----------|----------|--------|---------|---------------------|
| `id`      | true     | *uuid* | `null`  | The ID of the proxy |

### Response

Returns a [Proxy](#proxies-proxy-object) with the `id` provided. Returns [an error](#errors) if the Proxy could not be retrieved.


## Update Proxy

> Request

```shell
curl "https://api.basistheory.com/proxies/5b493235-6917-4307-906a-2cd6f1a90b13" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "PUT" \
  -d '{
    "name": "My Proxy",
    "destination_url": "https://example.com/api",
    "request_reactor_id": "5b493235-6917-4307-906a-2cd6f1a90b13"
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const proxy = await bt.proxies.update('5b493235-6917-4307-906a-2cd6f1a90b13', {
  name: 'My Proxy',
  destinationUrl: 'https://example.com/api',
  requestReactorId: '5b493235-6917-4307-906a-2cd6f1a90b13'
});
```

```csharp
using BasisTheory.net.Proxies;

var client = new ProxyClient("key_N88mVGsp3sCXkykyN2EFED");

var proxy = await client.UpdateAsync("5b493235-6917-4307-906a-2cd6f1a90b13", 
  new Proxy {
    Name = "My Proxy",
    DestinationUrl = "https://example.com/api",
    RequestReactorId = "5b493235-6917-4307-906a-2cd6f1a90b13"
  }
);
```

```python
TODO
```

```go
TODO
```

> Response

```json
{

  "id": "433013a6-a614-4e1e-b2aa-5fba67aa85e6",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Proxy",
  "key": "e29a50980ca5",
  "destination_url": "https://example.com/api",
  "request_reactor_id": "5b493235-6917-4307-906a-2cd6f1a90b13",
  "created_by": "3ce0dceb-fd0b-4471-8006-c51243c9ef7a",
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_by": "34053374-d721-43d8-921c-5ee1d337ef21",
  "modified_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method put">
  <span class="box-method">PUT</span>
  `https://api.basistheory.com/proxies/{id}`
</span>

Update a Proxy by ID in the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">proxy:update</span>
</p>

### URI Parameters

| Parameter | Required | Type   | Default | Description         |
|-----------|----------|--------|---------|---------------------|
| `id`      | true     | *uuid* | `null`  | The ID of the proxy |

### Request Parameters

| Attribute            | Required | Type     | Default | Description                                                    |
|----------------------|----------|----------|---------|----------------------------------------------------------------|
| `name`               | true     | *string* | `null`  | The name of the Proxy. Has a maximum length of `200`           |
| `destination_url`    | true     | *string* | `null`  | The URL to proxy requests to                                   |
| `request_reactor_id` | true     | *string* | `null`  | The [Reactor](#reactors) to invoke when the Proxy is requested |

### Response

Returns a [Proxy](#proxies-proxy-object) if the Proxy was updated. Returns [an error](#errors) if there were validation errors, or the Proxy failed to update.


## Delete Proxy

> Request

```shell
curl "https://api.basistheory.com/proxies/fb124bba-f90d-45f0-9a59-5edca27b3b4a" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -X "DELETE"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

await bt.proxies.delete('fb124bba-f90d-45f0-9a59-5edca27b3b4a');
```

```csharp
using BasisTheory.net.Proxies;

var client = new ProxyClient("key_N88mVGsp3sCXkykyN2EFED");

await client.DeleteAsync("fb124bba-f90d-45f0-9a59-5edca27b3b4a");
```

```python
import basistheory
from basistheory.api import proxies_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    proxies_client = proxies_api.ProxiesApi(api_client)

    proxies_client.delete("fb124bba-f90d-45f0-9a59-5edca27b3b4a")
```

```go
package main

import (
  "context"
  "github.com/Basis-Theory/basistheory-go"
)

func main() {
  configuration := basistheory.NewConfiguration()
  apiClient := basistheory.NewAPIClient(configuration)
  contextWithAPIKey := context.WithValue(context.Background(), basistheory.ContextAPIKeys, map[string]basistheory.APIKey{
    "ApiKey": {Key: "key_N88mVGsp3sCXkykyN2EFED"},
  })

  response, err := apiClient.ProxiesApi.ProxyDelete(contextWithAPIKey, "fb124bba-f90d-45f0-9a59-5edca27b3b4a").Execute()
}
```

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/proxies/{id}`
</span>

Delete a Proxy by ID in the Tenant.

### Permissions

`proxy:delete`

### URI Parameters

| Parameter | Required | Type   | Default | Description           |
|-----------|----------|--------|---------|-----------------------|
| `id`      | true     | *uuid* | `null`  | The ID of the proxy |

### Response

Returns [an error](#errors) if the Proxy failed to delete.
