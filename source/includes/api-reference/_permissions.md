# Permissions

Permissions offer fine-grained control over your Application's access to different aspects of your token infrastructure.
We suggest limiting the scope of your Application to the least amount possible, and to not share them across your
internal services.

Permissions are associated with every Application and can be configured when
you [create an Application](#applications-create-application)
or [update an Application](#applications-update-application).

Every API endpoint will document the required permissions needed to perform the operation against the endpoint.

## Permission Object

| Attribute           | Type                                                                                        | Description |
|---------------------|---------------------------------------------------------------------------------------------|-------------|
| `type`              | *                                                                                           |             |
| string*             | Permission type referenced by Basis Theory API endpoints                                    |             |
| `description`       | *                                                                                           |             |
| string*             | Description of the permission                                                               |             |
| `application_types` | *                                                                                           |             |
| array*              | List of [application types](#applications-application-types) that can assign the permission |             |

## Permission Types

| Permission           | Description                                                                                                                                                                      | Application Types                        |
|----------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------|
| `tenant:read`        | Read Tenants                                                                                                                                                                     | `management`                             |
| `tenant:update`      | Update Tenants                                                                                                                                                                   | `management`                             |
| `tenant:delete`      | Delete Tenants                                                                                                                                                                   | `management`                             |
| `application:read`   | Read Applications                                                                                                                                                                | `management`                             |
| `application:create` | Create Applications                                                                                                                                                              | `management`                             |
| `application:update` | Update and regenerate API keys for Applications                                                                                                                                  | `management`                             |
| `application:create` | Delete Applications                                                                                                                                                              | `management`                             |
| `reactor:read`       | Read Reactor Formulas and Reactors                                                                                                                                               | `server_to_server`, `management`         | `token:read`
| `reactor:create`     | Create Reactors Formulas and Reactors                                                                                                                                            | `management`                             |
| `reactor:update`     | Update Reactors Formulas and Reactors                                                                                                                                            | `management`                             |
| `reactor:delete`     | Delete Reactors Formulas and Reactors                                                                                                                                            | `management`                             |
| `log:read`           | Read audit logs                                                                                                                                                                  | `management`                             |
| `token:read`         | (deprecated) Read tokens from the vault. Replaced by new [Token Permission](#permissions-token-permission-types) `token:general:read:low`                                        | `server_to_server`                       |
| `token:create`       | (deprecated) Create tokens in the vault. Replaced by [Token Permission](#permissions-token-permission-types) `token:general:create`                                              | `public`, `elements`, `server_to_server` |
| `token:delete`       | (deprecated) Delete tokens from the vault. Replaced by [Token Permission](#permissions-token-permission-types) `token:general:delete`                                            | `server_to_server`                       |
| `token:decrypt`      | (deprecated) Decrypt tokens. Replaced by [Token Permission](#permissions-token-permission-types) `token:general:read:high`                                                       | `server_to_server`                       |
| `card:read`          | (deprecated) Read Atomic Card tokens. Replaced by [Token Permission](#permissions-token-permission-types) `token:pci:read:low`                                                   | `server_to_server`                       |
| `card:create`        | (deprecated) Create Atomic Card tokens. Replaced by [Token Permission](#permissions-token-permission-types) `token:pci:create`                                                   | `public`, `elements`, `server_to_server` |
| `card:update`        | (deprecated) Update Atomic Card tokens. Replaced by [Token Permission](#permissions-token-permission-types) `token:pci:update`                                                   | `server_to_server`                       |
| `card:delete`        | (deprecated) Delete Atomic Card tokens. Replaced by [Token Permission](#permissions-token-permission-types) `token:pci:delete:delete`                                            | `server_to_server`                       |
| `card:use`           | (deprecated) Use Atomic Card tokens in Proxy or Reactor. Replaced by [Token Permission](#permissions-token-permission-types) `token:pci:use:proxy` and `token:pci:use:reactor`   | `server_to_server`                       |
| `bank:read`          | (deprecated) Read Atomic Bank tokens. Replaced by [Token Permission](#permissions-token-permission-types) `token:bank:read:low`                                                  | `server_to_server`                       |
| `bank:create`        | (deprecated) Create Atomic Bank tokens. Replaced by [Token Permission](#permissions-token-permission-types) `token:bank:create`                                                  | `public`, `elements`, `server_to_server` |
| `bank:update`        | (deprecated) Update Atomic Bank tokens. Replaced by [Token Permission](#permissions-token-permission-types) `token:bank:update`                                                  | `server_to_server`                       |
| `bank:delete`        | (deprecated) Delete Atomic Bank tokens. Replaced by [Token Permission](#permissions-token-permission-types) `token:bank:delete`                                                  | `server_to_server`                       |
| `bank:decrypt`       | (deprecated) Decrypt Atomic Bank tokens. Replaced by [Token Permission](#permissions-token-permission-types) `token:bank:read:high`                                              | `server_to_server`                       |
| `bank:use`           | (deprecated) Use Atomic Bank tokens in Proxy or Reactor. Replaced by [Token Permission](#permissions-token-permission-types) `token:bank:use:proxy` and `token:bank:use:reactor` | `server_to_server`                       |

## Token Permission Types

All Token permissions follow the form of `token:<classification>:<operation>:<scope?>`.

| Permission                                   | Description                                                                                                           | Application Types                        |
|----------------------------------------------|-----------------------------------------------------------------------------------------------------------------------|------------------------------------------|
| `token:<classification>:create`              | Create Tokens in [\<classification\>](#tokens-token-classifications)                                                  | `public`, `elements`, `server_to_server` |
| `token:<classification>:read:<impact_level>` | Read Tokens in [\<classification\>](#tokens-token-classifications) at [\<impact_level\>](#tokens-token-impact-levels) | `server_to_server`                       |
| `token:<classification>:update`              | Update Tokens in [\<classification\>](#tokens-token-classifications)                                                  | `server_to_server`                       |
| `token:<classification>:delete`              | Delete Tokens in [\<classification\>](#tokens-token-classifications)                                                  | `server_to_server`                       |
| `token:<classification>:use:proxy`           | Use Tokens in [\<classification\>](#tokens-token-classifications) via [Proxy](#proxy)                                 | `server_to_server`                       |
| `token:<classification>:use:reactor`         | Use Tokens in [\<classification\>](#tokens-token-classifications) via [Reactor](#reactors)                            | `server_to_server`                       |

## List Permissions

> Request

```shell
curl "https://api.basistheory.com/permissions" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import {BasisTheory} from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const permissions = await bt.permissions.list();
```

```csharp
using BasisTheory.net.Permissions;

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
  {
    ...
  },
  {
    ...
  }
]
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/permissions`
</span>

### Response

Returns an array of [permission objects](#permissions-permission-object). Returns [an error](#errors) if permissions
could not be retrieved.
