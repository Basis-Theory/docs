# Applications

Your ability to authenticate to the API is granted by creating Applications, each application type has differnet usages to create the most fine-grained control over your tokens and infrastructure possible. Below, we describe each application type and their usages.


## Application Types

Name | Type | Description
---- | ---- | -----------
Server-to-Server | `server_to_server` | Used for tokenizing, retrieving, and decrypting data within backend services where the `API key` can be secured
Public | `public` | Used for tokenizing data directly within your mobile or browser application
Elements | `elements` | Used for tokenizing data with the Basis Theory Elements module 
Management | `management` | Used for managing all aspects of your token infrastructure such as [creating an applications](#create-application)


## Create Application

> Create Application Request Example:

```shell
curl "api.basistheory.com/applications" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -H "Content-Type: application/json"
  -X "POST"
  -D '{
    "name": "My Example App",
    "type": "server_to_server",
    "permissions": [
      "card:create",
      "card:read",
      "token:write",
      "token:read"
    ]
  }'
```

> Create Application Response Example:

```json
{
  "id": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "owner_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Example App",
  "key": "key_FZ8RmaxoGc73lbmF2cpmUJ",
  "type": "server_to_server",
  "created_at": "2020-09-15T15:53:00+00:00",
  "permissions": [
    "card:create",
    "card:read",
    "token:write",
    "token:read"
  ]
}
```

POST `https://api.basistheory.com/applications`

Create a new application for the tenant.

### Permissions

`application:write`

### Request Schema

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | true | *string* | `null` | The name of the application. Has a maximum length of `200`
`type` | true | *string* | `null` | [Application](#application-types) of the application
`permissions` | false | *array* | `[]` | [Perimissions](#permission-types) for the application

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the application which can be used to [get an application](#get-an-application)
`owner_id` | *string* | The tenant ID which owns the application
`name` | *string* | The name of the application
`key` | *string* | The API key which should be used for authenticating against Basis Theory API endpoints
`type` | *string* | Application type which restricts available permissions
`created_at` | *string* | Created date of the application in ISO 8601 format
`permissions` | *array* | List of [permission](#permission-types) for the application

### Response Messages

Code | Description
---- | -----------
`201` | Application successfully created
`400` | Invalid request body. See [Errors](#errors) response for details
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions


## List Applications

> List Applications Request Example:

```shell
curl "api.basistheory.com/applications" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> Applications Response Example:

```json
{
  "pagination": {...}
  "data": [
    {
      "id": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
      "owner_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
      "name": "My Example App",
      "type": "server_to_server",
      "created_at": "2020-09-15T15:53:00+00:00",
      "modified_at": "2021-03-01T08:23:14+00:00",
      "permissions": [
        "card:create",
        "card:read",
        "token:write",
        "token:read"
      ]
    },
    {...},
    {...}
  ]
}
```

GET `https://api.basistheory.com/applications`

Get a list of applications for the tenant.

### Permissions

`application:read`

### Response Schema

Returns the [Pagination](#pagination) schema. The `data` attribute in the response contains an array of applications with the following schema:

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the application which can be used to [get an application](#get-an-application)
`owner_id` | *string* | The tenant ID which owns the application
`name` | *string* | The name of the application
`type` | *string* | Application type which restricts available permissions
`created_at` | *string* | Created date of the application in ISO 8601 format
`modified_at` | *string* | Last modified date of the application in ISO 8601 format
`permissions` | *array* | List of [permission](#permission-types) for the application

### Response Messages

Code | Description
---- | -----------
`200` | Applications successfully retrieved
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | The application was not found


## Get an Application

> Get an Application Request Example:

```shell
curl "api.basistheory.com/applications/fe1f9ba4-474e-44b9-b949-110cdba9d662" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> Applications Response Example:

```json
{
  "id": "fe1f9ba4-474e-44b9-b949-110cdba9d662",
  "owner_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Management App",
  "type": "management",
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_at": "2021-03-01T08:23:14+00:00",
  "permissions": [
    "application:read",
    "application:write"
  ]
}
```

GET `https://api.basistheory.com/applications/{id}`

Get an application by ID in the tenant.

### Permissions

`application:read`

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *string* | `null` | The ID of the application

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the application which can be used to [get an application](#get-an-application)
`owner_id` | *string* | The tenant ID which owns the application
`name` | *string* | The name of the application
`type` | *string* | Application type which restricts available permissions
`created_at` | *string* | Created date of the application in ISO 8601 format
`modified_at` | *string* | Last modified date of the application in ISO 8601 format
`permissions` | *array* | List of [permission](#permission-types) for the application

### Response Messages

Code | Description
---- | -----------
`200` | Application successfully retrieved
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | The application was not found


## Update Application

> Update Application Request Example:

```shell
curl "api.basistheory.com/applications/fb124bba-f90d-45f0-9a59-5edca27b3b4a" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -H "Content-Type: application/json"
  -X "PUT"
  -D '{
    "name": "My Example App",
    "permissions": [
      "application:read",
      "application:write"
    ]
  }'
```

> Update Application Response Example:

```json
{
  "id": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "owner_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "name": "My Example App",
  "type": "server_to_server",
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_at": "2021-03-01T08:23:14+00:00",
  "permissions": [
    "application:read",
    "application:write"
  ]
}
```

PUT `https://api.basistheory.com/applications/{id}`

Update an application by ID in the tenant.

### Permissions

`application:write`

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *string* | `null` | The ID of the application

### Request Schema

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | true | *string* | `null` | The name of the application. Has a maximum length of `200`
`permissions` | false | *array* | `[]` | [Perimissions](#permission-types) for the application

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the application which can be used to [get an application](#get-an-application)
`owner_id` | *string* | The tenant ID which owns the application
`name` | *string* | The name of the application
`type` | *string* | Application type which restricts available permissions
`created_at` | *string* | Created date of the application in ISO 8601 format
`modified_at` | *string* | Last modified date of the application in ISO 8601 format
`permissions` | *array* | List of [permission](#permission-types) for the application

### Response Messages

Code | Description
---- | -----------
`200` | Application successfully updated
`400` | Invalid request body. See [Errors](#errors) response for details
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | The application was not found


## Regenerate API Key

> Regenerate Application API Key Request Example:

```shell
curl "api.basistheory.com/applications/fb124bba-f90d-45f0-9a59-5edca27b3b4a/regenerate" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -X "POST"
```

> Regenerate Application API Key Response Example:

```json
{
  "id": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "key": "key_FZ8RmaxoGc73lbmF2cpmUJ",
  "modified_at": "2021-03-01T08:23:14+00:00"
}
```

POST `https://api.basistheory.com/applications/{id}/regenerate`

Regenerate the API key for an application.

<aside class="warning">
WARNING - Regenerating the API key for an application will immediately invalidate the previous API key associated with the application.
</aside>

### Permissions

`application:write`

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *string* | `null` | The ID of the application

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the application which can be used to [get an application](#get-an-application)
`key` | *string* | The API key which should be used for authenticating against Basis Theory API endpoints
`modified_at` | *string* | Last modified date of the application in ISO 8601 format

### Response Messages

Code | Description
---- | -----------
`200` | Application API Key successfully regenerated
`400` | Invalid request body. See [Errors](#errors) response for details
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | The application was not found


## Delete Application

> Delete Application Request Example:

```shell
curl "api.basistheory.com/applications/fb124bba-f90d-45f0-9a59-5edca27b3b4a" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -X "DELETE"
```

DELETE `https://api.basistheory.com/applications/{id}`

Delete an application by ID in the tenant.

### Permissions

`application:write`

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *string* | `null` | The ID of the application

### Response Messages

Code | Description
---- | -----------
`204` | Application successfully deleted
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | The application was not found
