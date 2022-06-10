# Reactors


## Reactor Object

| Attribute       | Type                                                          |      | Description                                                                                                                                                                                                                            |
| --------------- | ------------------------------------------------------------- | :--- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `id`            | *uuid*                                                        |      | Unique identifier of the Reactor which can be used to [get a Reactor](#reactors-get-a-reactor)                                                                                                                                         |
| `tenant_id`     | *uuid*                                                        |      | The [Tenant](#tenants) ID which owns the reactor                                                                                                                                                                                       |
| `name`          | *string*                                                      |      | The name of the reactor                                                                                                                                                                                                                |
| `formula`       | *[Reactor Formula](#reactor-formulas-reactor-formula-object)* |      | Reactor Formula this Reactor is configured for                                                                                                                                                                                         |
| `configuration` | *map*                                                         |      | A key-value map of all configuration name and values for a [Reactor Formula configuration](#reactor-formulas-reactor-formula-configuration)                                                                                            |
| `application`   | *[Application](#applications-application-object)*             |      | (Optional) This Application's permissions are injected into a pre-configured <a href="https://www.npmjs.com/package/@basis-theory/basis-theory-js" target="_blank">Node.js BasisTheory</a> instance passed into the Reactor's runtime. |
| `created_by`    | *uuid*                                                        |      | (Optional) The ID of the user or [Application](#applications) that created the Reactor                                                                                                                                                 |
| `created_at`    | *string*                                                      |      | (Optional) Created date of the Reactor in ISO 8601 format                                                                                                                                                                              |
| `modified_by`   | *uuid*                                                        |      | (Optional) The ID of the user or [Application](#applications) that last modified the Reactor                                                                                                                                           |
| `modified_at`   | *date*                                                        |      | (Optional) Last modified date of the Reactor in ISO 8601 format                                                                                                                                                                        |

## Create Reactor

> Request

```shell
curl "https://api.basistheory.com/reactors" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "POST" \
  -d '{
    "name": "My Reactor",
    "configuration": {
      "SERVICE_API_KEY": "key_abcd1234"
    },
    "formula": {
      "id": "17069df1-80f4-439e-86a7-4121863e4678"
    },
    "application": {
      "id": "45c124e7-6ab2-4899-b4d9-1388b0ba9d04"
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
  application: {
    id: '45c124e7-6ab2-4899-b4d9-1388b0ba9d04'
  }
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
  },
  Application = new Application {
    Id = new Guid("45c124e7-6ab2-4899-b4d9-1388b0ba9d04")
  }
});
```

```python
import basistheory
from basistheory.api import reactors_api
from basistheory.model.create_reactor_request import CreateReactorRequest
from basistheory.model.reactor_formula import ReactorFormula
from basistheory.model.application import Application

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    reactors_client = reactors_api.ReactorsApi(api_client)

    reactor = reactors_client.create(create_reactor_request=CreateReactorRequest(
        name="My Reactor",
        configuration={
            "SERVICE_API_KEY": "key_abcd134"
        },
        formula=ReactorFormula(
            id="17069df1-80f4-439e-86a7-4121863e4678"
        ),
        application=Application(
            id="45c124e7-6ab2-4899-b4d9-1388b0ba9d04"
        )
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

  createReactorRequest := *basistheory.NewCreateReactorRequest("My Reactor")
  createReactorRequest.SetConfiguration(map[string]string{
    "SERVICE_API_KEY": "key_abcd134",
  })
  reactorFormula := *basistheory.NewReactorFormula()
  reactorFormula.SetId("17069df1-80f4-439e-86a7-4121863e4678")
  createReactorRequest.SetFormula(reactorFormula)
  application := *basistheory.NewApplication()
  application.SetId("45c124e7-6ab2-4899-b4d9-1388b0ba9d04")
  createReactorRequest.SetApplication(application)

  reactor, httpResponse, error := apiClient.ReactorsApi.Create(contextWithAPIKey).CreateReactorRequest(createReactorRequest).Execute()
}
```

> Response

```json
{
  "id": "5b493235-6917-4307-906a-2cd6f1a90b13",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Reactor",
  "formula": {...},
  "application": {...},
  "configuration": {
    "SERVICE_API_KEY": "key_abcd1234"
  },
  "created_by": "3ce0dceb-fd0b-4471-8006-c51243c9ef7a",
  "created_at": "2020-09-15T15:53:00+00:00"
}
```

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/reactors`
</span>

Create a new Reactor from a Reactor Formula for the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">reactor:create</span>
</p>

### Request Parameters

| Attribute        | Required | Type     | Default | Description                                                                                                                                 |
| ---------------- | -------- | -------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`           | true     | *string* | `null`  | The name of the reactor. Has a maximum length of `200`                                                                                      |
| `configuration`  | true     | *object* | `null`  | A key-value map of all configuration name and values for a [Reactor Formula configuration](#reactor-formulas-reactor-formula-configuration) |
| `formula.id`     | true     | *uuid*   | `null`  | Unique identifier of the [Reactor Formula](#reactor-formulas-reactor-formula-object) to configure a Reactor for                             |
| `application.id` | false    | *uuid*   | `null`  | Unique identifier of the [Application](#applications-application-object) to configure a Reactor with                                        |

The `configuration` object must satisfy the name and type constraints defined by the [Reactor Formula's](#reactor-formulas-reactor-formula-object) `configuration` property.

### Response

Returns a [Reactor](#reactors-reactor-object) if the Reactor was created. Returns [an error](#errors) if there were validation errors, or the Reactor failed to create.


## List Reactors

> Request

```shell
curl "https://api.basistheory.com/reactors" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
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

```python
import basistheory
from basistheory.api import reactors_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    reactors_client = reactors_api.ReactorsApi(api_client)

    reactors = reactors_client.get()
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

  reactors, httpResponse, err := apiClient.ReactorsApi.Get(contextWithAPIKey).Execute()
}
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
  `https://api.basistheory.com/reactors`
</span>

Get a list of reactors for the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">reactor:read</span>
</p>

### Query Parameters

| Parameter | Required | Type     | Default | Description                                                        |
| --------- | -------- | -------- | ------- | ------------------------------------------------------------------ |
| `id`      | false    | *array*  | `[]`    | An optional list of Reactor ID's to filter the list of reactors by |
| `name`    | false    | *string* | `null`  | Wildcard search of reactors by name                                |

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of [reactors](#reactors-reactor-object). Providing any query parameters will filter the results. Returns [an error](#errors) if reactors could not be retrieved.


## Get a Reactor

> Request

```shell
curl "https://api.basistheory.com/reactors/5b493235-6917-4307-906a-2cd6f1a90b13" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
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

```python
import basistheory
from basistheory.api import reactors_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    reactors_client = reactors_api.ReactorsApi(api_client)

    reactor = reactors_client.get_by_id("5b493235-6917-4307-906a-2cd6f1a90b13")
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

  reactor, httpResponse, err := apiClient.ReactorsApi.GetById(contextWithAPIKey, "5b493235-6917-4307-906a-2cd6f1a90b13").Execute()
}
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
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "modified_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/reactors/{id}`
</span> 

Get a Reactor by ID in the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">reactor:read</span>
</p>

### URI Parameters

| Parameter | Required | Type   | Default | Description           |
| --------- | -------- | ------ | ------- | --------------------- |
| `id`      | true     | *uuid* | `null`  | The ID of the reactor |

### Response

Returns a [Reactor](#reactors-reactor-object) with the `id` provided. Returns [an error](#errors) if the Reactor could not be retrieved.


## Update Reactor

> Request

```shell
curl "https://api.basistheory.com/reactors/5b493235-6917-4307-906a-2cd6f1a90b13" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "PUT" \
  -d '{
    "name": "My Reactor",
    "configuration": {
      "SERVICE_API_KEY": "key_abcd1234"
    },
    "application": {
      "id": "45c124e7-6ab2-4899-b4d9-1388b0ba9d04"
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
  application: {
    id: '45c124e7-6ab2-4899-b4d9-1388b0ba9d04'
  }
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
    },
    Application = new Application {
      Id = new Guid("45c124e7-6ab2-4899-b4d9-1388b0ba9d04")
    }
  }
);
```

```python
import basistheory
from basistheory.api import reactors_api
from basistheory.model.update_reactor_request import UpdateReactorRequest
from basistheory.model.application import Application

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    reactors_client = reactors_api.ReactorsApi(api_client)

    reactor = reactors_client.update("5b493235-6917-4307-906a-2cd6f1a90b13", update_reactor_request=UpdateReactorRequest(
        name="My Reactor",
        configuration={
            "SERVICE_API_KEY": "key_abcd134"
        },
        application=Application(
            id="45c124e7-6ab2-4899-b4d9-1388b0ba9d04"
        )
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

  updateReactorRequest := *basistheory.NewUpdateReactorRequest("My Reactor")
  updateReactorRequest.SetConfiguration(map[string]string{
    "SERVICE_API_KEY": "key_abcd134",
  })
  application := *basistheory.NewApplication()
  application.SetId("45c124e7-6ab2-4899-b4d9-1388b0ba9d04")
  updateReactorRequest.SetApplication(application)

  reactor, httpResponse, err := apiClient.ReactorsApi.Update(contextWithAPIKey, "5b493235-6917-4307-906a-2cd6f1a90b13").UpdateReactorRequest(updateReactorRequest).Execute()
}
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
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_by": "34053374-d721-43d8-921c-5ee1d337ef21",
  "modified_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method put">
  <span class="box-method">PUT</span>
  `https://api.basistheory.com/reactors/{id}`
</span>

Update a Reactor by ID in the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">reactor:update</span>
</p>

### URI Parameters

| Parameter | Required | Type   | Default | Description           |
| --------- | -------- | ------ | ------- | --------------------- |
| `id`      | true     | *uuid* | `null`  | The ID of the reactor |

### Request Parameters

| Attribute        | Required | Type     | Default | Description                                                                                                                                 |
| ---------------- | -------- | -------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`           | true     | *string* | `null`  | The name of the reactor. Has a maximum length of `200`                                                                                      |
| `configuration`  | true     | *object* | `null`  | A key-value map of all configuration name and values for a [Reactor Formula configuration](#reactor-formulas-reactor-formula-configuration) |
| `application.id` | false    | *uuid*   | `null`  | Unique identifier of the [Application](#applications-application-object) to configure a Reactor with                                        |

### Response

Returns a [Reactor](#reactors-reactor-object) if the Reactor was updated. Returns [an error](#errors) if there were validation errors, or the Reactor failed to update.


## Delete Reactor

> Request

```shell
curl "https://api.basistheory.com/reactors/fb124bba-f90d-45f0-9a59-5edca27b3b4a" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
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

```python
import basistheory
from basistheory.api import reactors_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    reactors_client = reactors_api.ReactorsApi(api_client)

    reactors_client.delete("fb124bba-f90d-45f0-9a59-5edca27b3b4a")
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

  httpResponse, err := apiClient.ReactorsApi.Delete(contextWithAPIKey, "fb124bba-f90d-45f0-9a59-5edca27b3b4a").Execute()
}
```

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/reactors/{id}`
</span>

Delete a Reactor by ID in the Tenant.

### Permissions

`reactor:delete`

### URI Parameters

| Parameter | Required | Type   | Default | Description           |
| --------- | -------- | ------ | ------- | --------------------- |
| `id`      | true     | *uuid* | `null`  | The ID of the reactor |

### Response

Returns [an error](#errors) if the Reactor failed to delete.


## Invoke a Reactor

> Request

```shell
curl "https://api.basistheory.com/reactors/5b493235-6917-4307-906a-2cd6f1a90b13/react" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "POST" \
  -d '{
    "args": {
      "card": "{{fe7c0a36-eb45-4f68-b0a0-791de28b29e4}}",
      "customer_id": "myCustomerId1234"
    }
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const reactResponse = await bt.reactors.react('5b493235-6917-4307-906a-2cd6f1a90b13', {
  args: {
    card: '{{fe7c0a36-eb45-4f68-b0a0-791de28b29e4}}',
    customer_id: 'myCustomerId1234',
  },
});
```

```csharp
using BasisTheory.net.Reactors;
using BasisTheory.net.Reactors.Requests;

var client = new ReactorClient("key_N88mVGsp3sCXkykyN2EFED");

var reactResponse = await client.ReactAsync("5b493235-6917-4307-906a-2cd6f1a90b13", 
  new ReactRequest {
    Arguments = new {
      card = "{{fe7c0a36-eb45-4f68-b0a0-791de28b29e4}}",
      customer_id = "myCustomerId1234"
    }
  });
```

```python
import basistheory
from basistheory.api import reactors_api
from basistheory.model.react_request import ReactRequest

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    reactors_client = reactors_api.ReactorsApi(api_client)

    react_response = reactors_client.react("5b493235-6917-4307-906a-2cd6f1a90b13", react_request=ReactRequest(
        args={
          "card":"{{fe7c0a36-eb45-4f68-b0a0-791de28b29e4}}",
          "customer_id": "myCustomerId1234"
        }
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

  reactRequest := *basistheory.NewReactRequest()
  reactRequest.SetArgs(map[string]interface{}{
    "card": "{{fe7c0a36-eb45-4f68-b0a0-791de28b29e4}}",
    "customer_id": "myCustomerId1234",
  })

  reacthttpResponse, httpResponse, err := apiClient.ReactorsApi.React(contextWithAPIKey, "5b493235-6917-4307-906a-2cd6f1a90b13").ReactRequest(reactRequest).Execute()
}
```


<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/reactors/{id}/react`
</span>

Invoke a reactor by ID.

### Permissions

<p class="scopes">
  <span class="scope">token:&lt;classification&gt;:use:reactor</span>
</p>

Depending on the [classification(s)](#tokens-token-classifications) of Tokens used within a Reactor, the corresponding `token:<classification>:use:reactor` permission is required - 
this permission grants the Reactor access to detokenize tokens of any impact level with this classification.

At least one `token:<classification>:use:reactor` permission is required to invoke a Reactor.

### URI Parameters

| Parameter | Required | Type   | Default | Description           |
| --------- | -------- | ------ | ------- | --------------------- |
| `id`      | true     | *uuid* | `null`  | The ID of the Reactor |

### Request Parameters
| Parameter | Required | Type     | Default | Description                                                                                                                                                                        |
| --------- | -------- | -------- | ------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `args`    | false    | *object* | `null`  | Arguments to provide to the reactor. These arguments must contain the declared [request parameters](#reactor-formulas-reactor-formula-request-parameters) for the reactor formula. |

### Reactor Request Parameters
The reactor will be executed with a `req` object that contains the following properties

| Parameter       | Description                                                                                                                                                            |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `args`          | Detokenized arguments to provided to the reactor.                                                                                                                      |
| `args.body`     | Detokenized request body when executed in the context of a [proxy](#proxy) request.                                                                                    |
| `args.headers`  | Request headers when executed in the context of a [proxy](#proxy) request.                                                                                             |
| `configuration` | A key-value map of all configuration name and values when creating the [Reactor](#reactor-reactor-object)                                                              |
| `bt`            | A pre-configured Basis Theory JS instance for the [application](#reactors-reactor-object) defined with the Reactor. This will be `null` if no application was defined. |

### Response

Returns a [Reactor Response](#reactors-invoke-a-reactor-reactor-response-object) if the Reactor completed successfully. Returns [an error](#errors) if the Reactor failed.
Errors generated from Reactors will be translated to the common Basis Theory Error format. See [Reactor Errors](#errors-reactor-errors) for more details.

### Reactor Response Object
| Attribute     | Type     | Description                                                                                                                                                                             |
| ------------- | -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `tokens`      | *object* | (Optional) [Token(s)](#tokens-token-object) created from the `tokenize` block of the Reactor Formula [response](#reactor-formulas-reactor-formula-code-reactor-formula-response-object) |
| `raw`         | *object* | (Optional) Raw output returned from the Reactor                                                                                                                                         |
| `raw.body`    | *object* | (Required if [proxy](#proxy) request) The `body` forwarded to the destination for the [proxy](https://docs.basistheory.com/#proxy) request                                              |
| `raw.headers` | *object* | (Required if [proxy](#proxy) request) The `headers` forwarded to the destination for the [proxy](https://docs.basistheory.com/#proxy) request                                           |

### Validation

When invoking a reactor, the `args` must satisfy the `request_parameters` contract declared by the [Reactor Formula](#reactor-formulas-reactor-formula-object).
The names of properties passed within `args` must match the names of each of the declared `request_parameters` - this comparison is case-sensitive.
Additional arguments included within `args` that are not declared as request parameters will be removed from the request.

Nested objects may be passed within `args`, as long as each sub-property is declared as a request parameter, dot-separating levels of the object hierarchy. 
For example, we may have a Reactor Formula with complex request parameters declared as:

| name                 | type     | optional |
| -------------------- | -------- | -------- |
| `request_id`         | *string* | false    |
| `user.first_name`    | *string* | false    |
| `user.last_name`     | *string* | false    |
| `user.address.city`  | *string* | true     |
| `user.address.state` | *string* | true     |

Then the following arguments would constitute a valid Reactor request:

<div class="center-column"></div>
```json
{
  "args": {
    "request_id": "d29e8a27-bfdb-4d26-9f13-29bdeafc9bfe",
    "user": {
      "first_name": "John",
      "last_name": "Doe",
      "address": {
        "city": "Seattle",
        "state": "WA"
      }
    }
  }
}
```

All required `request_parameters` must be included within the `args` on each request.
If a request parameter was defined with `optional: false` and a value for this parameter is not provided within `args`, the request will be rejected with a 400 error.

Each argument must match the `type` on the corresponding request parameter, and if the type does not match, auto casting to the declared type will be attempted. 
For example, say a request parameter is declared with type `number` but the string value `"123"` is provided. This value can be cast to a number, so the reactor would receive the numeric value `123`. 
However, if the string value `"non-numeric"` were provided, a 400 error would be returned because the value cannot be cast to a number.

### Detokenization

In order to use tokenized data within a reactor, the `args` parameter may contain one or more [detokenization expressions](/detokenization#detokenization-expressions).
When any detokenization expressions are detected, Basis Theory will attempt to [detokenize](/detokenization) and inject the raw token data into the `args` forwarded to the Reactor function.

Reactor request `args` may contain a mixture of detokenization expressions and raw plaintext data. 

Tokens containing complex data may be detokenized into a Reactor request, including Bank and Card token types.
When tokens with complex data are detokenized, the entire JSON data payload will be included within the `args`. 
For an example, see [Use Complex Tokens](/detokenization#examples-use-complex-tokens).

If the `args` passed into a Reactor contain additional properties that have not been declared as request parameters on the Reactor Formula,
those properties will be automatically removed and not sent on the request to the Reactor function.

Validation is performed on the resulting request after detokenization, so several required request parameters may be supplied by detokenizing
a single complex token that contains several of the request parameters. 

At most, 100 tokens may be detokenized within a single Reactor request.

<aside class="notice">
  <span>For more detailed examples about how to detokenize within Reactors, check out our <a href="/detokenization#examples">Detokenization Examples</a>.</span>
</aside>
