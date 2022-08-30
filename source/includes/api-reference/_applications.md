# Applications

Your ability to authenticate to the API is granted by creating Applications, each Application type has different usages to create the most fine-grained control over your tokens and infrastructure possible. Below, we describe each Application Type and their usages.

## Application Object

| Attribute     | Type     | Description                                                                                                      |
|---------------|----------|------------------------------------------------------------------------------------------------------------------|
| `id`          | *uuid*   | Unique identifier of the Application which can be used to [get an Application](#applications-get-an-application) |
| `tenant_id`   | *uuid*   | The [Tenant](#tenants) ID which owns the Application                                                             |
| `name`        | *string* | The name of the Application                                                                                      |
| `key`         | *string* | The API key which should be used for authenticating against Basis Theory API endpoints                           |
| `type`        | *string* | [Application type](#applications-application-types) of the Application                                           |
| `permissions` | *array*  | List of [permissions](#permissions-permission-types) for the Application                                         |
| `created_by`  | *uuid*   | (Optional) The ID of the user or [Application](#applications) that created the Application                       |
| `created_at`  | *date*   | (Optional) Created date of the Application in ISO 8601 format                                                    |
| `modified_by` | *uuid*   | (Optional) The ID of the user or [Application](#applications) that last modified the Application                 |
| `modified_at` | *date*   | (Optional) Last modified date of the Application in ISO 8601 format                                              |

## Application Types

| Name       | Type         | Description                                                                                                                    |
|------------|--------------|--------------------------------------------------------------------------------------------------------------------------------|
| Private    | `private`    | Used for tokenizing, retrieving, and decrypting data within backend services where the `API key` can be secured                |
| Public     | `public`     | Used for tokenizing data directly within your mobile or browser application                                                    |
| Management | `management` | Used for managing all aspects of your token infrastructure such as [creating an Application](#applications-create-application) |

## Create Application

> Request

```shell
curl "https://api.basistheory.com/applications" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "POST" \
  -d '{
    "name": "My Example App",
    "type": "private",
    "permissions": [
      "token:general:create",
      "token:general:read:low"
      "token:pci:create",
      "token:pci:read:low",
    ]
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const application = await bt.applications.create({
  name: 'My Example App',
  type: 'private',
  permissions: [
    'token:general:create',
    'token:general:read:low',
    'token:pci:create',
    'token:pci:read:low',
  ],
});
```

```csharp
using BasisTheory.net.Applications;

var client = new ApplicationClient("key_N88mVGsp3sCXkykyN2EFED");

var application = await client.CreateAsync(new Application {
  Name = "My Example App",
  Type = "private",
  Permissions = new List<string> {
    "token:general:create",
    "token:general:read:low",
    "token:pci:create",
    "token:pci:read:low"
  }
});
```

```python
import basistheory
from basistheory.api import applications_api
from basistheory.model.create_application_request import CreateApplicationRequest

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    application_client = applications_api.ApplicationsApi(api_client)

    application = application_client.create(create_application_request=CreateApplicationRequest(
        name="My Example App",
        type="private",
        permissions=[
            "token:general:create",
            "token:general:read:low",
            "token:pci:create",
            "token:pci:read:low"
        ]
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

  createApplicationRequest := *basistheory.NewCreateApplicationRequest(applicationName, applicationType)
  createApplicationRequest.SetPermissions([]string{
    "token:general:create",
    "token:general:read:low",
    "token:pci:create",
    "token:pci:read:low",
  })

  application, httpResponse, err := apiClient.ApplicationsApi.Create(contextWithAPIKey).CreateApplicationRequest(createApplicationRequest).Execute()
}
```

> Response

```json
{
  "id": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Example App",
  "key": "key_FZ8RmaxoGc73lbmF2cpmUJ",
  "type": "private",
  "permissions": [
    "token:general:create",
    "token:general:read:low",
    "token:pci:create",
    "token:pci:read:low"
  ],
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00"
}
```

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/applications`
</span>

Create a new Application for the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">application:create</span>
</p>

### Request Parameters

| Attribute     | Required | Type     | Default | Description                                                            |
|---------------|----------|----------|---------|------------------------------------------------------------------------|
| `name`        | true     | *string* | `null`  | The name of the Application. Has a maximum length of `200`             |
| `type`        | true     | *string* | `null`  | [Application type](#applications-application-types) of the application |
| `permissions` | true     | *array*  | `[]`    | [Permissions](#permissions-permission-types) for the application       |

### Response

Returns an [Application](#applications-application-object) if the application was created. Returns [an error](#errors) if there were validation errors, or the application failed to create.


## List Applications

> Request

```shell
curl "https://api.basistheory.com/applications" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const applications = await bt.applications.list();
```

```csharp
using BasisTheory.net.Applications;

var client = new ApplicationClient("key_N88mVGsp3sCXkykyN2EFED");

var applications = await client.GetAsync();
```

```python
import basistheory
from basistheory.api import applications_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    application_client = applications_api.ApplicationsApi(api_client)

    applications = application_client.get()
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

  applications, httpResponse, err := apiClient.ApplicationsApi.Get(contextWithAPIKey).Execute()
}
```

> Response

```json
{
  "pagination": {...}
  "data": [
    {
      "id": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
      "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
      "name": "My Example App",
      "type": "private",
      "permissions": [
        "token:general:create",
        "token:general:read:low",
        "token:pci:create",
        "token:pci:read:low"
      ],
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
  `https://api.basistheory.com/applications`
</span>

Get a list of applications for the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">application:read</span>
</p>

### Query Parameters

| Parameter | Required | Type    | Default | Description                                                                |
|-----------|----------|---------|---------|----------------------------------------------------------------------------|
| `id`      | false    | *array* | `[]`    | An optional list of application ID's to filter the list of applications by |

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of [applications](#applications-application-object). Providing any query parameters will filter the results. Returns [an error](#errors) if applications could not be retrieved.


## Get an Application

> Request

```shell
curl "https://api.basistheory.com/applications/fe1f9ba4-474e-44b9-b949-110cdba9d662" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const application = await bt.applications.retrieve('fe1f9ba4-474e-44b9-b949-110cdba9d662');
```

```csharp
using BasisTheory.net.Applications;

var client = new ApplicationClient("key_N88mVGsp3sCXkykyN2EFED");

var application = await client.GetByIdAsync("fe1f9ba4-474e-44b9-b949-110cdba9d662");
```

```python
import basistheory
from basistheory.api import applications_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    application_client = applications_api.ApplicationsApi(api_client)

    application = application_client.get_by_id("fe1f9ba4-474e-44b9-b949-110cdba9d662")
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
  
  application, httpResponse, err := apiClient.ApplicationsApi.GetById(contextWithAPIKey, "fe1f9ba4-474e-44b9-b949-110cdba9d662").Execute()
}
```

> Response

```json
{
  "id": "fe1f9ba4-474e-44b9-b949-110cdba9d662",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Management App",
  "type": "management",
  "permissions": [
    "application:create",
    "application:read"
  ],
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "modified_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/applications/{id}`
</span> 

Get an application by ID in the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">application:read</span>
</p>

### URI Parameters

| Parameter | Required | Type   | Default | Description               |
|-----------|----------|--------|---------|---------------------------|
| `id`      | true     | *uuid* | `null`  | The ID of the application |

### Response

Returns an [Application](#applications-application-object) with the `id` provided. Returns [an error](#errors) if the application could not be retrieved.


## Get an Application by Key

> Request

```shell
curl "https://api.basistheory.com/applications/key" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const application = await bt.applications.retrieveByKey();
```

```csharp
using BasisTheory.net.Applications;

var client = new ApplicationClient("key_N88mVGsp3sCXkykyN2EFED");

var application = await client.GetByKeyAsync();
```

```python
import basistheory
from basistheory.api import applications_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    application_client = applications_api.ApplicationsApi(api_client)

    application = application_client.get_by_key()
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

  application, httpResponse, err := apiClient.ApplicationsApi.GetByKey(contextWithCreatedAppAPIKey).Execute()
}
```

> Response

```json
{
  "id": "fe1f9ba4-474e-44b9-b949-110cdba9d662",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Management App",
  "type": "management",
  "permissions": [
    "application:create",
    "application:read"
  ],
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "modified_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/applications/key`
</span>

Get an application by key in the Tenant. Will use the `BT-API-KEY` header to lookup the application.

### Permissions

<p class="scopes">
  <span class="scope">application:read</span>
</p>

### Response

Returns an [Application](#applications-application-object) for the provided `BT-API-KEY`. Returns [an error](#errors) if the application could not be retrieved.


## Update Application

> Request

```shell
curl "https://api.basistheory.com/applications/fb124bba-f90d-45f0-9a59-5edca27b3b4a" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json"
  -X "PUT" \
  -d '{
    "name": "My Example App",
    "permissions": [
      "application:create",
      "application:read"
    ]
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const application = await bt.applications.update('fb124bba-f90d-45f0-9a59-5edca27b3b4a', {
  name: 'My Example App',
  permissions: [
    'application:create',
    'application:read'
  ],
});
```

```csharp
using BasisTheory.net.Applications;

var client = new ApplicationClient("key_N88mVGsp3sCXkykyN2EFED");

var application = await client.UpdateAsync("fb124bba-f90d-45f0-9a59-5edca27b3b4a", 
  new Application {
    Name = "My Example App",
    Permissions = new List<string> {
      "application:create",
      "application:read"
    }
  }
);
```

```python
import basistheory
from basistheory.api import applications_api
from basistheory.model.update_application_request import UpdateApplicationRequest

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    application_client = applications_api.ApplicationsApi(api_client)

    application = application_client.update("fb124bba-f90d-45f0-9a59-5edca27b3b4a", update_application_request=UpdateApplicationRequest(
        name="My Example App",
        permissions=[
          "application:create",
          "application:read"
        ]
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

  updateApplicationRequest := basistheory.NewUpdateApplicationRequest(updatedApplicationName)
  updateApplicationRequest.SetPermissions([]string{
    "application:create",
    "application:read",
  })

  application, httpResponse, err := apiClient.ApplicationsApi.Update(contextWithAPIKey, "fb124bba-f90d-45f0-9a59-5edca27b3b4a").UpdateApplicationRequest(updateApplicationRequest).Execute()
}
```

> Response

```json
{
  "id": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Example App",
  "type": "management",
  "permissions": [
    "application:create",
    "application:read"
  ],
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "modified_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method put">
  <span class="box-method">PUT</span>
  `https://api.basistheory.com/applications/{id}`
</span>

Update an application by ID in the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">application:update</span>
</p>

### URI Parameters

| Parameter | Required | Type   | Default | Description               |
|-----------|----------|--------|---------|---------------------------|
| `id`      | true     | *uuid* | `null`  | The ID of the application |

### Request Parameters

| Attribute     | Required | Type     | Default | Description                                                      |
|---------------|----------|----------|---------|------------------------------------------------------------------|
| `name`        | true     | *string* | `null`  | The name of the application. Has a maximum length of `200`       |
| `permissions` | true     | *array*  | `[]`    | [Permissions](#permissions-permission-types) for the application |

### Response

Returns an [Application](#applications-application-object) if the application was updated. Returns [an error](#errors) if there were validation errors, or the application failed to update.


## Regenerate API Key

> Request

```shell
curl "https://api.basistheory.com/applications/fb124bba-f90d-45f0-9a59-5edca27b3b4a/regenerate" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -X "POST"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const application = await bt.applications.regenerateKey('fb124bba-f90d-45f0-9a59-5edca27b3b4a');
```

```csharp
using BasisTheory.net.Applications;

var client = new ApplicationClient("key_N88mVGsp3sCXkykyN2EFED");

var application = await client.RegenerateKeyAsync("fb124bba-f90d-45f0-9a59-5edca27b3b4a");
```

```python
import basistheory
from basistheory.api import applications_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    application_client = applications_api.ApplicationsApi(api_client)

    application = application_client.regenerate_key("fb124bba-f90d-45f0-9a59-5edca27b3b4a")
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

  application, httpResponse, err := apiClient.ApplicationsApi.RegenerateKey(contextWithAPIKey, "fb124bba-f90d-45f0-9a59-5edca27b3b4a").Execute()
}
```

> Response

```json
{
  "id": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Example App",
  "key": "key_FZ8RmaxoGc73lbmF2cpmUJ",
  "type": "private",
  "permissions": [
    "token:general:create",
    "token:general:read:low",
    "token:pci:create",
    "token:pci:read:low"
  ],
  "created_by": "c57a0d0d-e8e6-495f-9c79-a317cc21996c",
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_by": "a23699d2-1d55-4927-83f9-e76779f1c1c1",
  "modified_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/applications/{id}/regenerate`
</span>

Regenerate the API key for an application.

<aside class="warning">
  <span>WARNING - Regenerating the API key for an application will immediately invalidate the previous API key associated with the application.</span>
</aside>

### Permissions

<p class="scopes">
  <span class="scope">application:update</span>
</p>

### URI Parameters

| Parameter | Required | Type   | Default | Description               |
|-----------|----------|--------|---------|---------------------------|
| `id`      | true     | *uuid* | `null`  | The ID of the application |

### Response

Returns an [Application](#applications-application-object) with the new `key` property populated. Returns [an error](#errors) if there were validation errors, or the application key failed to regenerate.


## Delete Application

> Request

```shell
curl "https://api.basistheory.com/applications/fb124bba-f90d-45f0-9a59-5edca27b3b4a" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -X "DELETE"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

await bt.applications.delete('fb124bba-f90d-45f0-9a59-5edca27b3b4a');
```

```csharp
using BasisTheory.net.Applications;

var client = new ApplicationClient("key_N88mVGsp3sCXkykyN2EFED");

await client.DeleteAsync("fb124bba-f90d-45f0-9a59-5edca27b3b4a");
```

```python
import basistheory
from basistheory.api import applications_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    application_client = applications_api.ApplicationsApi(api_client)

    application_client.delete("fb124bba-f90d-45f0-9a59-5edca27b3b4a")
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

  httpResponse, err := apiClient.ApplicationsApi.Delete(contextWithAPIKey, "fb124bba-f90d-45f0-9a59-5edca27b3b4a").Execute()
}
```

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/applications/{id}`
</span>

Delete an application by ID in the Tenant.

### Permissions

`application:delete`

### URI Parameters

| Parameter | Required | Type   | Default | Description               |
|-----------|----------|--------|---------|---------------------------|
| `id`      | true     | *uuid* | `null`  | The ID of the application |

### Response

Returns [an error](#errors) if the application failed to delete.
