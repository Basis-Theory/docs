# Permissions

Permissions are fine-grained control over your application's access to different aspects of your token infrastructure. We suggest limiting the scope of your application to the least amount possible, and to not share them across your internal applications.

Permissions are associated with every application and can be configured when you [create an application](#create-application) or [update an application](#update-application). 

Every API endpoint will document the required permissions needed to perform the operation against the endpoint.


## Permission Types

Permission | Description | Application Types | Dependencies
---------  | ----------- | ----------------- | ------------
`token:read` | Read tokens from the vault | `server_to_server` | *N/A*
`token:write` | Write tokens to the vault | `public`, `elements`, `server_to_server` | *N/A*
`application:read` | Read applications | `management` | *N/A*
`application:write` | Create, edit, delete, and regenerate API keys for applications | `management` | *N/A*
`card:read` | Read atomic card tokens | `server_to_server` | `token:read`
`card:create` | Create atomic card tokens | `public`, `elements`, `server_to_server` | `token:write`
`card:update` | Update atomic card tokens | `server_to_server` | `token:write`
`card:delete` | Delete atomic card tokens | `server_to_server` | `token:write`


## List Permissions

> List Permissions Request Example:

```shell
curl "api.basistheory.com/permissions" \
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

GET `https://api.basistheory.com/permissions`

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`type` | *string* | Permission type referenced by Basis Theory API endpoints
`description` | *string* | Description of the permission
`application_types` | *array* | List of [application types](#application-types) that can assign the permission
`dependencies` | *array* | List of downstream [permission types](#permission-types) which are required for this permission type

<aside class="notice">
Dependent permission types are automatically assigned when an application is created or updated. For example, if an application is created with `card:read`, then the permission of `token:read` will automatically be assigned.
</aside>

### Response Messages

Code | Description
---- | -----------
`200` | Permissions successfully retrieved
`401` | A missing or invalid `X-API-KEY` was provided