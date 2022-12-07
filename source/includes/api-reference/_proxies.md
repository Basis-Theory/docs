# Proxies

Proxies provide a way to pre-configure static routes when calling [Basis Theory's Proxy](#proxy). They require you to set a destination URL for where the request will be forwarded to, require authentication to call the proxy, and configure a [Reactor](#reactors) which can be executed as part of the request to transform the request body and headers.

Proxies can be utilized for both inbound and outbound calls for things such as webhooks, enabling 3rd parties to call your API or making API calls to 3rd party partners and providers.

<aside class="notice">
  <span>If you are looking for how to invoke a Proxy, head over <a href="#proxy">here</a>.</span>
</aside>

## Proxy Object

| Attribute            | Type                                                 | Description                                                                                                                                                                                                                             |
| -------------------- | ---------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `id`                 | *uuid*                                               | Unique identifier of the Proxy which can be used to [get a Proxy](#proxies-get-a-proxy)                                                                                                                                                 |
| `key`                | *string*                                             | Auto-generated key used to [invoke a particular Proxy](#proxy-proxying-requests)                                                                                                                                                        |
| `name`               | *string*                                             | The name of the Proxy                                                                                                                                                                                                                   |
| `destination_url`    | *string*                                             | The URL to proxy requests to                                                                                                                                                                                                            |
| `tenant_id`          | *uuid*                                               | The [Tenant](#tenants) ID which owns the Proxy                                                                                                                                                                                          |
| `require_auth`       | *boolean*                                            | Require a `BT-API-KEY` request header for authentication and authorization                                                                                                                                                              |
| `request_transform`  | *[Proxy Transform](#proxies-proxy-transform-object)* | (Optional) Transform code which will be executed against the proxy's request before sending to the destination.                                                                                                                         |
| `response_transform` | *[Proxy Transform](#proxies-proxy-transform-object)* | (Optional) Transform code which will be executed against the destination's response before returning the proxy response.                                                                                                                |
| `application_id`     | *string*                                             | (Optional) This Application's API key is injected into a pre-configured <a href="https://www.npmjs.com/package/@basis-theory/basis-theory-js" target="_blank">Node.js BasisTheory</a> instance passed into the Proxy Transform runtime. |
| `configuration`      | *map*                                                | (Optional) A key-value map of all configuration name and values for a [Proxy Transform](#proxies-proxy-transform-object)                                                                                                                |
| `created_by`         | *uuid*                                               | (Optional) The ID of the user or [Application](#applications) that created the Proxy                                                                                                                                                    |
| `created_at`         | *string*                                             | (Optional) Created date of the Proxy in ISO 8601 format                                                                                                                                                                                 |
| `modified_by`        | *uuid*                                               | (Optional) The ID of the user or [Application](#applications) that last modified the Proxy                                                                                                                                              |
| `modified_at`        | *date*                                               | (Optional) Last modified date of the Proxy in ISO 8601 format                                                                                                                                                                           |

## Proxy Transform Object

| Attribute | Type     | Description                                                                                            |
| --------- | -------- | ------------------------------------------------------------------------------------------------------ |
| `code`    | *string* | [Transform code](#proxies-transform-code) which will be executed when the Proxy transform is processed |

## Transform Code

All transform code snippets must export a function which takes in a [request object](#proxies-transform-code-transform-request-object) and returns a [response object](#proxies-transform-code-transform-response-object).

### Transform Request Object

This is the object passed as a parameter to the transform function.

| Attribute       | Type                                                                                                                      | Description                                                             |
|-----------------|---------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| `args`          | *object*                                                                                                                  | The arguments containing the `body` and `headers` attributes            |
| `configuration` | *object*                                                                                                                  | The configuration defined for the [Proxy object](#proxies-proxy-object) |
| `bt`            | A pre-configured Basis Theory JS instance if an `application` was configured on the [Proxy object](#proxies-proxy-object) |

### Transform Response Object

This is the object that must be returned by the transform function.

| Attribute | Type     | Description                                      |
| --------- | -------- | ------------------------------------------------ |
| `body`    | *object* | Processed body for the proxy request/response    |
| `headers` | *object* | Processed headers for the proxy request/response |

Transform Code is written in Javascript (targeting Node.js v16) and generally follows the structure:

<div class="center-column"></div>
```js
module.exports = async function (req) {
  const { bt, args } = req;
  const { body, headers } = args; // access any args provided with the transform request
  const { MY_CONFIG } = req.configuration; // access any static config defined on the Proxy

  // do anything here!
  const processedBody = ...; // do something with body
  const processedHeaders = ...; // do something with headers

  return {
      body: processedBody, // Proxy request/response body
      headers: processedHeaders // Proxy request/response headers
  };
};
```

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
    "request_transform": {
      "code": "
        module.exports = async function (req) {
          // Do something with `req.configuration.SERVICE_API_KEY`

          return {
            headers: req.args.headers,
            body: req.args.body
          };
        };
      "
    },
    "response_transform": {
      "code": "
        module.exports = async function (req) {
          // Do something with `req.configuration.SERVICE_API_KEY`

          return {
            headers: req.args.headers,
            body: req.args.body
          };
        };
      "
    },
    "configuration": {
      "SERVICE_API_KEY": "key_abcd1234"
    },
    "application": {
      "id": "45c124e7-6ab2-4899-b4d9-1388b0ba9d04"
    },
    "require_auth": true
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const proxy = await bt.proxies.create({
  name: 'My Proxy',
  destinationUrl: 'https://example.com/api',
  requestTransform: {
    code: '
      module.exports = async function (req) {
        // Do something with `req.configuration.SERVICE_API_KEY`

        return {
          headers: req.args.headers,
          body: req.args.body
        };
      };
    '
  },
  responseTransform: {
    code: '
      module.exports = async function (req) {
        // Do something with `req.configuration.SERVICE_API_KEY`

        return {
          headers: req.args.headers,
          body: req.args.body
        };
      };
    '
  },
  configuration: {
    SERVICE_API_KEY: 'key_abcd1234',
  },
  application: {
    id: '45c124e7-6ab2-4899-b4d9-1388b0ba9d04'
  },
  requireAuth: true
});
```

```csharp
using BasisTheory.net.Proxies;

var client = new ProxyClient("key_N88mVGsp3sCXkykyN2EFED");

var proxy = await client.CreateAsync(new ProxyCreateRequest {
  Name = "My Proxy",
  DestinationUrl = "https://example.com/api",
  RequestTransform = new RequestTransform {
    Code = @"
      module.exports = async function (req) {
        // Do something with `req.configuration.SERVICE_API_KEY`

        return {
          headers: req.args.headers,
          body: req.args.body
        };
      };
    "
  },
  ResponseTransform = new RequestTransform {
    Code = @"
      module.exports = async function (req) {
        // Do something with `req.configuration.SERVICE_API_KEY`

        return {
          headers: req.args.headers,
          body: req.args.body
        };
      };
    "
  },
  Configuration = new Dictionary<string, string> {
    { "SERVICE_API_KEY", "key_abcd1234" }
  },
  Application = new Application {
    Id = new Guid("45c124e7-6ab2-4899-b4d9-1388b0ba9d04")
  },
  RequireAuthentication: true
});
```

```python
import basistheory
from basistheory.api import proxies_api
from basistheory.model.create_proxy_request import CreateProxyRequest

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    proxy_client = proxies_api.ProxiesApi(api_client)

    proxy = proxy_client.create(create_proxy_request=CreateProxyRequest(
        name="My Proxy",
        destination_url="https://example.com/api",
        requeset_transform=ProxyTransform(
            code=" \
                module.exports = async function (req) { \
                  // Do something with `req.configuration.SERVICE_API_KEY` \

                  "return { \
                    headers: req.args.headers, \
                    body: req.args.body \
                  }; \
                };"
        ),
        response_transform=ProxyTransform(
            code=" \
                module.exports = async function (req) { \
                  // Do something with `req.configuration.SERVICE_API_KEY` \

                  "return { \
                    headers: req.args.headers, \
                    body: req.args.body \
                  }; \
                };"
        ),
        configuration={
            "SERVICE_API_KEY": "key_abcd134"
        },
        application=Application(
            id="45c124e7-6ab2-4899-b4d9-1388b0ba9d04"
        ),
        require_auth=True
    ))
```

```go
package main

import (
  "context"
  "github.com/Basis-Theory/basistheory-go/v3"
)

func main() {
  configuration := basistheory.NewConfiguration()
  apiClient := basistheory.NewAPIClient(configuration)
  contextWithAPIKey := context.WithValue(context.Background(), basistheory.ContextAPIKeys, map[string]basistheory.APIKey{
    "ApiKey": {Key: "key_N88mVGsp3sCXkykyN2EFED"},
  })

  createProxyRequest := *basistheory.NewCreateProxyRequest("My Proxy", "https://example.com/api")
  requestTransform := *basistheory.NewProxyTransform()
  requestTransform.SetCode(`
    module.exports = async function (req) {
      // Do something with req.configuration.SERVICE_API_KEY

      return {
        headers: req.args.headers,
        body: req.args.body
      };
    };
  `)
  createProxyRequest.SetRequestTransform(requestTransform)
  responseTransform := *basistheory.NewProxyTransform()
  responseTransform.SetCode(`
    module.exports = async function (req) {
      // Do something with req.configuration.SERVICE_API_KEY

      return {
        headers: req.args.headers,
        body: req.args.body
      };
    };
  `)
  createProxyRequest.SetResponseTransform(responseTransform)
  createProxyRequest.SetConfiguration(map[string]string{
    "SERVICE_API_KEY": "key_abcd134",
  })
  application := *basistheory.NewApplication()
  application.SetId("45c124e7-6ab2-4899-b4d9-1388b0ba9d04")
  createProxyRequest.SetApplication(application)
  createProxyRequest.SetRequireAuth(true)

  proxy, httpResponse, err := apiClient.ProxiesApi.Create(contextWithAPIKey).CreateProxyRequest(createProxyRequest).Execute()
}
```

> Response

```json
{
  "id": "433013a6-a614-4e1e-b2aa-5fba67aa85e6",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Proxy",
  "key": "e29a50980ca5",
  "destination_url": "https://example.com/api",
  "request_transform": {
    "code": "
      module.exports = async function (req) {
        // Do something with req.configuration.SERVICE_API_KEY

        return {
          headers: req.args.headers,
          body: req.args.body
        };
      };
    "
  },
  "response_transform": {
    "code": "
      module.exports = async function (req) {
        // Do something with req.configuration.SERVICE_API_KEY

        return {
          headers: req.args.headers,
          body: req.args.body
        };
      };
    "
  },
  "configuration": {
    "SERVICE_API_KEY": "key_abcd1234"
  },
  "application_id": "45c124e7-6ab2-4899-b4d9-1388b0ba9d04",
  "require_auth": true,
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

| Attribute            | Required | Type                                                 | Default | Description                                                                                                                                                                                                                  |
| -------------------- | -------- | ---------------------------------------------------- | ------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`               | true     | *string*                                             | `null`  | The name of the Proxy. Has a maximum length of `200`                                                                                                                                                                         |
| `destination_url`    | true     | *string*                                             | `null`  | The URL to proxy requests to                                                                                                                                                                                                 |
| `request_transform`  | false    | *[Proxy Transform](#proxies-proxy-transform-object)* | `null`  | Transform code which will be executed against the proxy's request before sending to the destination.                                                                                                                         |
| `response_transform` | false    | *[Proxy Transform](#proxies-proxy-transform-object)* | `null`  | Transform code which will be executed against the destination's response before returning the proxy response.                                                                                                                |
| `application`        | false    | *[Application](#applications-application-object)*    | `null`  | This Application's API key is injected into a pre-configured <a href="https://www.npmjs.com/package/@basis-theory/basis-theory-js" target="_blank">Node.js BasisTheory</a> instance passed into the Proxy Transform runtime. |
| `configuration`      | false    | *map*                                                | `null`  | A key-value map of all configuration name and values for a [Proxy Transform](#proxies-proxy-transform-object)                                                                                                                |
| `require_auth`       | false    | *boolean*                                            | `true`  | Require a `BT-API-KEY` request header for authentication and authorization                                                                                                                                                   |

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
import basistheory
from basistheory.api import proxies_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    proxy_client = proxies_api.ProxiesApi(api_client)

    proxies = proxy_client.get()
```

```go
package main

import (
  "context"
  "github.com/Basis-Theory/basistheory-go/v3"
)

func main() {
  configuration := basistheory.NewConfiguration()
  apiClient := basistheory.NewAPIClient(configuration)
  contextWithAPIKey := context.WithValue(context.Background(), basistheory.ContextAPIKeys, map[string]basistheory.APIKey{
    "ApiKey": {Key: "key_N88mVGsp3sCXkykyN2EFED"},
  })

  proxies, httpResponse, err := apiClient.ProxiesApi.Get(contextWithAPIKey).Execute()
}
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
      "request_transform": {
        "code": "
          module.exports = async function (req) {
            // Do something with req.configuration.SERVICE_API_KEY

            return {
              headers: req.args.headers,
              body: req.args.body
            };
          };
        "
      },
      "response_transform": {
        "code": "
          module.exports = async function (req) {
            // Do something with req.configuration.SERVICE_API_KEY

            return {
              headers: req.args.headers,
              body: req.args.body
            };
          };
        "
      },
      "configuration": {
        "SERVICE_API_KEY": "key_abcd1234"
      },
      "application_id": "45c124e7-6ab2-4899-b4d9-1388b0ba9d04",
      "require_auth": true,
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
| --------- | -------- | -------- | ------- | --------------------------------------------------------------- |
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
import basistheory
from basistheory.api import proxies_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    proxy_client = proxies_api.ProxiesApi(api_client)

    application = proxy_client.get_by_id("5b493235-6917-4307-906a-2cd6f1a90b13")

```

```go
package main

import (
  "context"
  "github.com/Basis-Theory/basistheory-go/v3"
)

func main() {
  configuration := basistheory.NewConfiguration()
  apiClient := basistheory.NewAPIClient(configuration)
  contextWithAPIKey := context.WithValue(context.Background(), basistheory.ContextAPIKeys, map[string]basistheory.APIKey{
    "ApiKey": {Key: "key_N88mVGsp3sCXkykyN2EFED"},
  })

  proxy, httpResponse, err := apiClient.ProxiesApi.GetById(contextWithAPIKey, "433013a6-a614-4e1e-b2aa-5fba67aa85e6").Execute()
}
```

> Response

```json
{
  "id": "433013a6-a614-4e1e-b2aa-5fba67aa85e6",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Proxy",
  "key": "e29a50980ca5",
  "destination_url": "https://example.com/api",
  "request_transform": {
    "code": "
      module.exports = async function (req) {
        // Do something with req.configuration.SERVICE_API_KEY

        return {
          headers: req.args.headers,
          body: req.args.body
        };
      };
    "
  },
  "response_transform": {
    "code": "
      module.exports = async function (req) {
        // Do something with req.configuration.SERVICE_API_KEY

        return {
          headers: req.args.headers,
          body: req.args.body
        };
      };
    "
  },
  "configuration": {
    "SERVICE_API_KEY": "key_abcd1234"
  },
  "application_id": "45c124e7-6ab2-4899-b4d9-1388b0ba9d04",
  "require_auth": true,
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
| --------- | -------- | ------ | ------- | ------------------- |
| `id`      | true     | *uuid* | `null`  | The ID of the proxy |

### Response

Returns a [Proxy](#proxies-proxy-object) with the `id` provided. Returns [an error](#errors) if the Proxy could not be retrieved.


## Update Proxy

> Request

```shell
curl "https://api.basistheory.com/proxies/433013a6-a614-4e1e-b2aa-5fba67aa85e6" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "PUT" \
  -d '{
    "name": "My Proxy",
    "destination_url": "https://example.com/api",
    "request_transform": {
      "code": "
        module.exports = async function (req) {
          // Do something with `req.configuration.SERVICE_API_KEY`

          return {
            headers: req.args.headers,
            body: req.args.body
          };
        };
      "
    },
    "response_transform": {
      "code": "
        module.exports = async function (req) {
          // Do something with `req.configuration.SERVICE_API_KEY`

          return {
            headers: req.args.headers,
            body: req.args.body
          };
        };
      "
    },
    "configuration": {
      "SERVICE_API_KEY": "key_abcd1234"
    },
    "application": {
      "id": "45c124e7-6ab2-4899-b4d9-1388b0ba9d04"
    },
    "require_auth": true
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const proxy = await bt.proxies.update('433013a6-a614-4e1e-b2aa-5fba67aa85e6', {
  name: 'My Proxy',
  destinationUrl: 'https://example.com/api',
  requestTransform: {
    code: '
      module.exports = async function (req) {
        // Do something with `req.configuration.SERVICE_API_KEY`

        return {
          headers: req.args.headers,
          body: req.args.body
        };
      };
    '
  },
  responseTransform: {
    code: '
      module.exports = async function (req) {
        // Do something with `req.configuration.SERVICE_API_KEY`

        return {
          headers: req.args.headers,
          body: req.args.body
        };
      };
    '
  },
  configuration: {
    SERVICE_API_KEY: 'key_abcd1234',
  },
  application: {
    id: '45c124e7-6ab2-4899-b4d9-1388b0ba9d04'
  },
  requireAuth: true
});
```

```csharp
using BasisTheory.net.Proxies;

var client = new ProxyClient("key_N88mVGsp3sCXkykyN2EFED");

var proxy = await client.UpdateAsync("433013a6-a614-4e1e-b2aa-5fba67aa85e6", 
  new ProxyUpdateRequest {
    Name = "My Proxy",
    DestinationUrl = "https://example.com/api",
    RequestTransform = new RequestTransform {
      Code = @"
        module.exports = async function (req) {
          // Do something with `req.configuration.SERVICE_API_KEY`

          return {
            headers: req.args.headers,
            body: req.args.body
          };
        };
      "
    },
    ResponseTransform = new RequestTransform {
      Code = @"
        module.exports = async function (req) {
          // Do something with `req.configuration.SERVICE_API_KEY`

          return {
            headers: req.args.headers,
            body: req.args.body
          };
        };
      "
    },
    Configuration = new Dictionary<string, string> {
      { "SERVICE_API_KEY", "key_abcd1234" }
    },
    Application = new Application {
      Id = new Guid("45c124e7-6ab2-4899-b4d9-1388b0ba9d04")
    },
    RequireAuthentication = true
  }
);
```

```python
import basistheory
from basistheory.api import proxies_api
from basistheory.model.update_proxy_request import UpdateProxyRequest

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    proxy_client = proxies_api.ProxiesApi(api_client)

    application = proxy_client.update("433013a6-a614-4e1e-b2aa-5fba67aa85e6", update_proxy_request=UpdateProxyRequest(
        name="My Proxy",
        destination_url="https://example.com/api",
        requeset_transform=ProxyTransform(
            code=" \
                module.exports = async function (req) { \
                  // Do something with `req.configuration.SERVICE_API_KEY` \

                  "return { \
                    headers: req.args.headers, \
                    body: req.args.body \
                  }; \
                };"
        ),
        response_transform=ProxyTransform(
            code=" \
                module.exports = async function (req) { \
                  // Do something with `req.configuration.SERVICE_API_KEY` \

                  "return { \
                    headers: req.args.headers, \
                    body: req.args.body \
                  }; \
                };"
        ),
        configuration={
            "SERVICE_API_KEY": "key_abcd134"
        },
        application=Application(
            id="45c124e7-6ab2-4899-b4d9-1388b0ba9d04"
        ),
        require_auth=True
    ))
```

```go
package main

import (
  "context"
  "github.com/Basis-Theory/basistheory-go/v3"
)

func main() {
  configuration := basistheory.NewConfiguration()
  apiClient := basistheory.NewAPIClient(configuration)
  contextWithAPIKey := context.WithValue(context.Background(), basistheory.ContextAPIKeys, map[string]basistheory.APIKey{
    "ApiKey": {Key: "key_N88mVGsp3sCXkykyN2EFED"},
  })

  updateProxyRequest := *basistheory.NewUpdateProxyRequest("My Proxy", "https://example.com/api")
  requestTransform := *basistheory.NewProxyTransform()
  requestTransform.SetCode(`
    module.exports = async function (req) {
      // Do something with req.configuration.SERVICE_API_KEY

      return {
        headers: req.args.headers,
        body: req.args.body
      };
    };
  `)
  updateProxyRequest.SetRequestTransform(requestTransform)
  responseTransform := *basistheory.NewProxyTransform()
  responseTransform.SetCode(`
    module.exports = async function (req) {
      // Do something with req.configuration.SERVICE_API_KEY

      return {
        headers: req.args.headers,
        body: req.args.body
      };
    };
  `)
  updateProxyRequest.SetResponseTransform(responseTransform)
  updateProxyRequest.SetConfiguration(map[string]string{
    "SERVICE_API_KEY": "key_abcd134",
  })
  application := *basistheory.NewApplication()
  application.SetId("45c124e7-6ab2-4899-b4d9-1388b0ba9d04")
  updateProxyRequest.SetApplication(application)
  updateProxyRequest.SetRequireAuth(true)

  proxy, httpResponse, err := apiClient.ProxiesApi.Update(contextWithAPIKey, "433013a6-a614-4e1e-b2aa-5fba67aa85e6").UpdateProxyRequest(updateProxyRequest).Execute()
}
```

> Response

```json
{

  "id": "433013a6-a614-4e1e-b2aa-5fba67aa85e6",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Proxy",
  "key": "e29a50980ca5",
  "destination_url": "https://example.com/api",
  "request_transform": {
    "code": "
      module.exports = async function (req) {
        // Do something with req.configuration.SERVICE_API_KEY

        return {
          headers: req.args.headers,
          body: req.args.body
        };
      };
    "
  },
  "response_transform": {
    "code": "
      module.exports = async function (req) {
        // Do something with req.configuration.SERVICE_API_KEY

        return {
          headers: req.args.headers,
          body: req.args.body
        };
      };
    "
  },
  "configuration": {
    "SERVICE_API_KEY": "key_abcd1234"
  },
  "application_id": "45c124e7-6ab2-4899-b4d9-1388b0ba9d04",
  "require_auth": true,
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
| --------- | -------- | ------ | ------- | ------------------- |
| `id`      | true     | *uuid* | `null`  | The ID of the proxy |

### Request Parameters

| Attribute            | Required | Type                                                 | Default | Description                                                                                                                                                                                                                  |
| -------------------- | -------- | ---------------------------------------------------- | ------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`               | true     | *string*                                             | `null`  | The name of the Proxy. Has a maximum length of `200`                                                                                                                                                                         |
| `destination_url`    | true     | *string*                                             | `null`  | The URL to proxy requests to                                                                                                                                                                                                 |
| `request_transform`  | false    | *[Proxy Transform](#proxies-proxy-transform-object)* | `null`  | Transform code which will be executed against the proxy's request before sending to the destination.                                                                                                                         |
| `response_transform` | false    | *[Proxy Transform](#proxies-proxy-transform-object)* | `null`  | Transform code which will be executed against the destination's response before returning the proxy response.                                                                                                                |
| `application`        | false    | *[Application](#applications-application-object)*    | `null`  | This Application's API key is injected into a pre-configured <a href="https://www.npmjs.com/package/@basis-theory/basis-theory-js" target="_blank">Node.js BasisTheory</a> instance passed into the Proxy Transform runtime. |
| `configuration`      | false    | *map*                                                | `null`  | A key-value map of all configuration name and values for a [Proxy Transform](#proxies-proxy-transform-object)                                                                                                                |
| `require_auth`       | false    | *boolean*                                            | `true`  | Require a `BT-API-KEY` request header for authentication and authorization                                                                                                                                                   |

### Response

Returns a [Proxy](#proxies-proxy-object) if the Proxy was updated. Returns [an error](#errors) if there were validation errors, or the Proxy failed to update.


## Delete Proxy

> Request

```shell
curl "https://api.basistheory.com/proxies/433013a6-a614-4e1e-b2aa-5fba67aa85e6" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -X "DELETE"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

await bt.proxies.delete('433013a6-a614-4e1e-b2aa-5fba67aa85e6');
```

```csharp
using BasisTheory.net.Proxies;

var client = new ProxyClient("key_N88mVGsp3sCXkykyN2EFED");

await client.DeleteAsync("433013a6-a614-4e1e-b2aa-5fba67aa85e6");
```

```python
import basistheory
from basistheory.api import proxies_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    proxies_client = proxies_api.ProxiesApi(api_client)

    proxies_client.delete("433013a6-a614-4e1e-b2aa-5fba67aa85e6")
```

```go
package main

import (
  "context"
  "github.com/Basis-Theory/basistheory-go/v3"
)

func main() {
  configuration := basistheory.NewConfiguration()
  apiClient := basistheory.NewAPIClient(configuration)
  contextWithAPIKey := context.WithValue(context.Background(), basistheory.ContextAPIKeys, map[string]basistheory.APIKey{
    "ApiKey": {Key: "key_N88mVGsp3sCXkykyN2EFED"},
  })

  httpResponse, err := apiClient.ProxiesApi.Delete(contextWithAPIKey, "433013a6-a614-4e1e-b2aa-5fba67aa85e6").Execute()
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

| Parameter | Required | Type   | Default | Description         |
| --------- | -------- | ------ | ------- | ------------------- |
| `id`      | true     | *uuid* | `null`  | The ID of the proxy |

### Response

Returns [an error](#errors) if the Proxy failed to delete.
