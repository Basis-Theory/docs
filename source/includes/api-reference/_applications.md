# Applications

Your ability to authenticate to the API is granted by creating Applications, each Application type has different usages to create the most fine-grained control over your tokens and infrastructure possible. Below, we describe each Application Type and their usages.

## Application Object

Attribute | Type | Description
--------- | ---- | -----------
`id` | *uuid* | Unique identifier of the Application which can be used to [get an Application](#applications-get-an-application)
`tenant_id` | *uuid* | The [Tenant](#tenants) ID which owns the Application
`name` | *string* | The name of the Application
`key` | *string* | The API key which should be used for authenticating against Basis Theory API endpoints
`type` | *string* | [Application type](#applications-application-types) of the Application
`permissions` | *array* | List of [permissions](#permissions-permission-types) for the Application
`created_at` | *date* | Created date of the Application in ISO 8601 format
`modified_at` | *date* | Last modified date of the Application in ISO 8601 format


## Application Types

Name | Type | Description
---- | ---- | -----------
Server-to-Server | `server_to_server` | Used for tokenizing, retrieving, and decrypting data within backend services where the `API key` can be secured
Client-side Application | `public` | Used for tokenizing data directly within your mobile or browser application
Elements | `elements` | Used for tokenizing data with the Basis Theory Elements module 
Management | `management` | Used for managing all aspects of your token infrastructure such as [creating an Application](#applications-create-application)


## Create Application

> Request

```shell
curl "https://api.basistheory.com/applications" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "POST" \
  -d '{
    "name": "My Example App",
    "type": "server_to_server",
    "permissions": [
      "card:create",
      "card:read",
      "token:create",
      "token:read"
    ]
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const application = await bt.applications.create({
  name: 'My Example App',
  type: 'server_to_server',
  permissions: [
    'card:create',
    'card:read',
    'token:create',
    'token:read',
  ],
});
```

```csharp
using BasisTheory.net.Applications;

var client = new ApplicationClient("key_N88mVGsp3sCXkykyN2EFED");

var application = await client.CreateAsync(new Application {
  Name = "My Example App",
  Type = "server_to_server",
  Permissions = new List<string> {
    "card:create",
    "card:read",
    "token:create",
    "token:read"
  }
});
```

> Response

```json
{
  "id": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Example App",
  "key": "key_FZ8RmaxoGc73lbmF2cpmUJ",
  "type": "server_to_server",
  "permissions": [
    "card:create",
    "card:read",
    "token:create",
    "token:read"
  ],
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

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | true | *string* | `null` | The name of the Application. Has a maximum length of `200`
`type` | true | *string* | `null` | [Application](#applications-application-types) of the application
`permissions` | false | *array* | `[]` | [Permissions](#permissions-permission-types) for the application

### Response

Returns an [application](#applications-application-object) if the application was created. Returns [an error](#errors) if there were validation errors, or the application failed to create.


## List Applications

> Request

```shell
curl "https://api.basistheory.com/applications" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
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

> Response

```json
{
  "pagination": {...}
  "data": [
    {
      "id": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
      "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
      "name": "My Example App",
      "type": "server_to_server",
      "permissions": [
        "card:create",
        "card:read",
        "token:create",
        "token:read"
      ],
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
  `https://api.basistheory.com/applications`
</span>

Get a list of applications for the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">application:read</span>
</p>

### Query Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | false | *array* | `[]` | An optional list of application ID's to filter the list of applications by

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of [applications](#applications-application-object). Providing any query parameters will filter the results. Returns [an error](#errors) if applications could not be retrieved.


## Get an Application

> Request

```shell
curl "https://api.basistheory.com/applications/fe1f9ba4-474e-44b9-b949-110cdba9d662" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
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

> Response

```json
{
  "id": "fe1f9ba4-474e-44b9-b949-110cdba9d662",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Management App",
  "type": "management",
  "permissions": [
    "application:read",
    "application:write"
  ],
  "created_at": "2020-09-15T15:53:00+00:00",
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

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the application

### Response

Returns an [application](#applications-application-object) with the `id` provided. Returns [an error](#errors) if the application could not be retrieved.


## Get an Application by Key

> Request

```shell
curl "https://api.basistheory.com/applications/key" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
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

> Response

```json
{
  "id": "fe1f9ba4-474e-44b9-b949-110cdba9d662",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Management App",
  "type": "management",
  "permissions": [
    "application:read",
    "application:write"
  ],
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/applications/key`
</span>

Get an application by key in the Tenant. Will use the `X-API-KEY` header to lookup the application.

### Permissions

<p class="scopes">
  <span class="scope">application:read</span>
</p>

### Response

Returns a [application](#applications-application-object) for the provided `X-API-KEY`. Returns [an error](#errors) if the application could not be retrieved.


## Update Application

> Request

```shell
curl "https://api.basistheory.com/applications/fb124bba-f90d-45f0-9a59-5edca27b3b4a" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json"
  -X "PUT" \
  -d '{
    "name": "My Example App",
    "permissions": [
      "application:read",
      "application:write"
    ]
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const application = await bt.applications.update('fb124bba-f90d-45f0-9a59-5edca27b3b4a', {
  name: 'My Example App',
  permissions: [
    'card:create',
    'card:read',
    'token:create',
    'token:read',
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
      "card:create",
      "card:read",
      "token:create",
      "token:read"
    }
  }
);
```

> Response

```json
{
  "id": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Example App",
  "type": "management",
  "permissions": [
    "application:read",
    "application:write"
  ],
  "created_at": "2020-09-15T15:53:00+00:00",
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

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the application

### Request Parameters

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | true | *string* | `null` | The name of the application. Has a maximum length of `200`
`permissions` | false | *array* | `[]` | [Permissions](#permissions-permission-types) for the application

### Response

Returns an [application](#applications-application-object) if the application was updated. Returns [an error](#errors) if there were validation errors, or the application failed to update.


## Regenerate API Key

> Request

```shell
curl "https://api.basistheory.com/applications/fb124bba-f90d-45f0-9a59-5edca27b3b4a/regenerate" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
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

> Response

```json
{
  "id": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Example App",
  "key": "key_FZ8RmaxoGc73lbmF2cpmUJ",
  "type": "server_to_server",
  "permissions": [
    "card:create",
    "card:read",
    "token:create",
    "token:read"
  ],
  "created_at": "2020-09-15T15:53:00+00:00",
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

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the application

### Response

Returns an [application](#applications-application-object) with the new `key` property populated. Returns [an error](#errors) if there were validation errors, or the application key failed to regenerate.


## Delete Application

> Request

```shell
curl "https://api.basistheory.com/applications/fb124bba-f90d-45f0-9a59-5edca27b3b4a" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
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

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/applications/{id}`
</span>

Delete an application by ID in the Tenant.

### Permissions

`application:delete`

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the application

### Response

Returns [an error](#errors) if the application failed to delete.
