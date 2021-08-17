# Permissions

Permissions are fine-grained control over your application's access to different aspects of your token infrastructure. We suggest limiting the scope of your application to the least amount possible, and to not share them across your internal applications.

Permissions are associated with every application and can be configured when you [create an application](#create-application) or [update an application](#update-application). 

Every API endpoint will document the required permissions needed to perform the operation against the endpoint.

<aside class="notice">
  <span>Dependent permission types are automatically assigned when an application is created or updated. For example, if an application is created with <code>card:read</code>, then the permission of <code>token:read</code> will automatically be assigned.</span>
</aside>


## Permission Object

Attribute | Type | Description
--------- | ---- | -----------
`type` | *string* | Permission type referenced by Basis Theory API endpoints
`description` | *string* | Description of the permission
`application_types` | *array* | List of [application types](#application-types) that can assign the permission


## Permission Types

Permission | Description | Application Types
---------  | ----------- | -----------------
`tenant:read` | Read tenants | `management`
`tenant:update` | Update tenants | `management`
`tenant:delete` | Delete tenants | `management`
`application:read` | Read applications | `management`
`application:create` | Create applications | `management`
`application:update` | Update and regenerate API keys for applications | `management`
`application:create` | Delete applications | `management`
`reactor:read` | Read reactor formulas and reactors | `server_to_server`, `management` | `token:read`
`reactor:create` | Create reactor formulas and reactors | `management`
`reactor:update` | Update reactor formulas and reactors | `management`
`reactor:delete` | Delete reactor formulas and reactors | `management`
`log:read` | Read audit logs | `management`
`token:read` | Read tokens from the vault | `server_to_server`
`token:create` | Create tokens in the vault | `public`, `elements`, `server_to_server`
`token:delete` | Delete tokens from the vault | `server_to_server`
`token:decrypt` | Decrypt generic tokens | `server_to_server`
`card:read` | Read atomic card tokens | `server_to_server`
`card:create` | Create atomic card tokens | `public`, `elements`, `server_to_server`
`card:update` | Update atomic card tokens | `server_to_server`
`card:delete` | Delete atomic card tokens | `server_to_server`
`bank:read` | Read atomic bank tokens | `server_to_server`
`bank:create` | Create atomic bank tokens | `public`, `elements`, `server_to_server`
`bank:update` | Update atomic bank tokens | `server_to_server`
`bank:delete` | Delete atomic bank tokens | `server_to_server`
`bank:decrypt` | Decrypt atomic bank tokens | `server_to_server`


## List Permissions

> Request

```shell
curl "https://api.basistheory.com/permissions" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@Basis-Theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const permissions = await bt.permissions.list();
```

```csharp
var client = new PermissionClient("key_N88mVGsp3sCXkykyN2EFED");

var permissions = await client.GetAsync();
```

> Response

```json
[
  {
    "type": "card:read",
    "description": "Read Payment Card tokens",
    "application_types": [
      "server_to_server"
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


### Response

Returns an array of [permission objects](#permission-object). Returns [an error](#errors) if permissions could not be retrieved.
