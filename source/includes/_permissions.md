# Permissions

Permissions are fine-grained control over your application's access to different aspects of your token infrastructure. We suggest limiting the scope of your application to the least amount possible, and to not share them across your internal applications.

Permissions are associated with every application and can be configured when you [create an application](#create-application) or [update an application](#update-application). 

Every API endpoint will document the required permissions needed to perform the operation against the endpoint.


## Permission Types

Permission | Description | Application Types | Dependencies
---------  | ----------- | ----------------- | ------------
`tenant:read` | Read tenants | `management` | *N/A*
`tenant:update` | Update tenants | `management` | *N/A*
`tenant:delete` | Delete tenants | `management` | *N/A*
`application:read` | Read applications | `management` | *N/A*
`application:write` | Create, edit, delete, and regenerate API keys for applications | `management` | *N/A*
`exchange:read` | Read exchange templates and exchanges | `server_to_server`, `management` | `token:read`
`exchange:create` | Create exchange templates and exchanges | `management` | `token:read`, `token:create`
`exchange:update` | Update exchange templates and exchanges | `management` | `token:read`, `token:create`
`exchange:delete` | Delete exchange templates and exchanges | `management` | `token:delete`
`log:read` | Read audit logs | `management` | *N/A*
`token:read` | Read tokens from the vault | `server_to_server`, `management` | *N/A*
`token:create` | Create tokens in the vault | `public`, `elements`, `server_to_server`, `management` | *N/A*
`token:delete` | Delete tokens from the vault | `server_to_server`, `management` | *N/A*
`card:read` | Read atomic card tokens | `server_to_server` | `token:read`
`card:create` | Create atomic card tokens | `public`, `elements`, `server_to_server` | `token:create`
`card:update` | Update atomic card tokens | `server_to_server` | `token:create`
`card:delete` | Delete atomic card tokens | `server_to_server` | `token:delete`
`bank:read` | Read atomic bank tokens | `server_to_server` | `token:read`
`bank:create` | Create atomic bank tokens | `public`, `elements`, `server_to_server` | `token:create`
`bank:update` | Update atomic bank tokens | `server_to_server` | `token:create`
`bank:delete` | Delete atomic bank tokens | `server_to_server` | `token:delete`
`bank:decrypt` | Decrypt atomic bank tokens | `server_to_server` | `token:read`


## List Permissions

> List Permissions Request Example:

```shell
curl "https://api.basistheory.com/permissions" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> Permissions Response Example:

```json
[
  {
    "type": "card:read",
    "description": "Read Payment Card tokens",
    "application_types": [
      "server_to_server"
    ],
    "dependencies": [
      "token:read"
    ]
  }, 
  {...},
  {...}
]
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/permissions`
</span>

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`type` | *string* | Permission type referenced by Basis Theory API endpoints
`description` | *string* | Description of the permission
`application_types` | *array* | List of [application types](#application-types) that can assign the permission
`dependencies` | *array* | List of downstream [permission types](#permission-types) which are required for this permission type

<aside class="notice">
  <span>Dependent permission types are automatically assigned when an application is created or updated. For example, if an application is created with <code>card:read</code>, then the permission of <code>token:read</code> will automatically be assigned.</span>
</aside>

### Response Messages

Code | Description
---- | -----------
`200` | Permissions successfully retrieved
`401` | A missing or invalid `X-API-KEY` was provided
