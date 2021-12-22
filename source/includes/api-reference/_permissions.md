# Permissions

Permissions offer fine-grained control over your Application's access to different aspects of your token infrastructure. We suggest limiting the scope of your Application to the least amount possible, and to not share them across your internal services.

Permissions are associated with every Application and can be configured when you [create an Application](#applications-create-application) or [update an Application](#applications-update-application). 

Every API endpoint will document the required permissions needed to perform the operation against the endpoint.


## Permission Object

Attribute | Type | Description
--------- | ---- | -----------
`type` | *string* | Permission type referenced by Basis Theory API endpoints
`description` | *string* | Description of the permission
`application_types` | *array* | List of [application types](#applications-application-types) that can assign the permission


## Permission Types

Permission | Description | Application Types
---------  | ----------- | -----------------
`tenant:read` | Read Tenants | `management`
`tenant:update` | Update Tenants | `management`
`tenant:delete` | Delete Tenants | `management`
`application:read` | Read Applications | `management`
`application:create` | Create Applications | `management`
`application:update` | Update and regenerate API keys for Applications | `management`
`application:create` | Delete Applications | `management`
`reactor:read` | Read Reactor Formulas and Reactors | `server_to_server`, `management` | `token:read`
`reactor:create` | Create Reactors Formulas and Reactors | `management`
`reactor:update` | Update Reactors Formulas and Reactors | `management`
`reactor:delete` | Delete Reactors Formulas and Reactors | `management`
`log:read` | Read audit logs | `management`
`token:read` | Read tokens from the vault | `server_to_server`
`token:create` | Create tokens in the vault | `public`, `elements`, `server_to_server`
`token:delete` | Delete tokens from the vault | `server_to_server`
`token:decrypt` | Decrypt tokens | `server_to_server`
`card:read` | Read Atomic Card tokens | `server_to_server`
`card:create` | Create Atomic Card tokens | `public`, `elements`, `server_to_server`
`card:update` | Update Atomic Card tokens | `server_to_server`
`card:delete` | Delete Atomic Card tokens | `server_to_server`
`bank:read` | Read Atomic Bank tokens | `server_to_server`
`bank:create` | Create Atomic Bank tokens | `public`, `elements`, `server_to_server`
`bank:update` | Update Atomic Bank tokens | `server_to_server`
`bank:delete` | Delete Atomic Bank tokens | `server_to_server`
`bank:decrypt` | Decrypt Atomic Bank tokens | `server_to_server`


## List Permissions

> Request

```shell
curl "https://api.basistheory.com/permissions" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const permissions = await bt.permissions.list();
```

```csharp
using BasisTheory.net.Permissions;

var client = new PermissionClient("key_N88mVGsp3sCXkykyN2EFED");

var permissions = await client.GetAsync();
```

```python
# Coming Soon!
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

Returns an array of [permission objects](#permissions-permission-object). Returns [an error](#errors) if permissions could not be retrieved.
