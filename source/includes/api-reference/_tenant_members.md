# Tenant Members

Tenant Members enable user management operations within the context of a Tenant.
New members can be invited via e-mail to join an existing tenant. 
Upon accepting a Tenant Invitation, a new Tenant Member will be created.

## Tenant Member Object

| Attribute     | Type                                         | Description                                                                                        |
|---------------|----------------------------------------------|----------------------------------------------------------------------------------------------------|
| `id`          | *uuid*                                       | Unique identifier of the Tenant Member                                                             |
| `tenant_id`   | *uuid*                                       | The [Tenant](#tenants-tenant-object) ID that the membership is attached                            |
| `role`        | *string*                                     | The role assigned to the Tenant Member                                                             |
| `user`        | *[user object](#tenant-members-user-object)* | The User which this membership is attached to                                                      |
| `created_by`  | *uuid*                                       | (Optional) The ID of the User that created the Tenant Member                                       |
| `created_at`  | *date*                                       | (Optional) Created date of the Tenant Member in ISO 8601 format                                    |
| `modified_by` | *uuid*                                       | (Optional) The ID of the User or [Application](#applications) that last modified the Tenant Member |
| `modified_at` | *date*                                       | (Optional) Last modified date of the Tenant Member in ISO 8601 format                              |

## User Object

| Attribute    | Type     | Description                                     |
|--------------|----------|-------------------------------------------------|
| `id`         | *uuid*   | Unique identifier of the User                   |
| `email`      | *string* | (Optional) The e-mail address of the User       |
| `first_name` | *string* | (Optional) The User's first name                |
| `last_name`  | *string* | (Optional) The User's last name                 |
| `picture`    | *string* | (Optional) A URI pointing to the User's picture |

## Tenant Invitation Object

| Attribute     | Type     | Description                                                                                                                                                                                                                                                            |
|---------------|----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `id`          | *uuid*   | Unique identifier of the Tenant Invitation                                                                                                                                                                                                                             |
| `tenant_id`   | *uuid*   | The [Tenant](#tenants-tenant-object) ID that the invitation is tied to. When the invitation is accepted, a new Tenant Member will be created in this Tenant.                                                                                                           |
| `email`       | *string* | The invitee's e-mail address                                                                                                                                                                                                                                           |
| `status`      | *string* | The status of the invitation (i.e. `PENDING` or `EXPIRED`)                                                                                                                                                                                                             |
| `expires_at`  | *date*   | The expiration date of the invitation is ISO 8601 format. By default, the invitation expires 72 hours from the time it was created. Invitations can be resent to extend the expiration, but doing so will invalidate the previous invitation link sent to the invitee. |
| `created_by`  | *uuid*   | (Optional) The ID of the User that created the Tenant Invitation                                                                                                                                                                                                       |
| `created_at`  | *date*   | (Optional) Created date of the Tenant Invitation in ISO 8601 format                                                                                                                                                                                                    |
| `modified_by` | *uuid*   | (Optional) The ID of the User or [Application](#applications) that last modified the Tenant Invitation                                                                                                                                                                 |
| `modified_at` | *date*   | (Optional) Last modified date of the Tenant Invitation in ISO 8601 format                                                                                                                                                                                              |


## List Tenant Members

> Request

```shell
curl "https://api.basistheory.com/tenants/self/members" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const tenantMembers = await bt.tenants.listMembers();
```

```csharp
using BasisTheory.net.Tenants;

var client = new TenantClient("key_N88mVGsp3sCXkykyN2EFED");

var tenantMembers = await client.GetMembersAsync();
```

```python
# Coming Soon!
```

> Response

```json
{
  "pagination": {...},
  "data": [
    {
      "id": "5540a02f-99e7-46de-8f41-1b3cf7b2a3d2",
      "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
      "role": "ADMIN",
      "user": {
        "id": "dc5fca8c-dd54-41df-98fc-50d7a1e7fb4d",
        "email": "jane@doe.com",
        "first_name": "Jane",
        "last_name": "Doe",
        "picture": ""
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
  `https://api.basistheory.com/tenants/self/members`
</span>

Get a list of Tenant Members for the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">tenant:member:read</span>
</p>

### Query Parameters

| Parameter | Required | Type      | Default | Description                                                                                                     |
|-----------|----------|-----------|---------|-----------------------------------------------------------------------------------------------------------------|
| `user_id` | false    | *uuid*    | `null`  | One to many User IDs to query for. Multiple IDs can be passed in the form `?user_id=<value1>&user_id=<value2>`. |
| `page`    | false    | *integer* | `1`     | Page number of the results to return.                                                                           |
| `size`    | false    | *integer* | `20`    | Number of the results to return per page. Maximum size of 50 results.                                           |

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of [Tenant Members](#tenant-members-tenant-member-object). Providing any query parameters will filter the results. Returns [an error](#errors) if Tenant Members could not be retrieved.


## Delete Tenant Member

> Request

```shell
curl "https://api.basistheory.com/tenants/self/members/5540a02f-99e7-46de-8f41-1b3cf7b2a3d2" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -X "DELETE"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

await bt.tenants.deleteMember('5540a02f-99e7-46de-8f41-1b3cf7b2a3d2');
```

```csharp
using BasisTheory.net.Tenants;

var client = new TenantClient("key_N88mVGsp3sCXkykyN2EFED");

await client.DeleteMemberAsync("5540a02f-99e7-46de-8f41-1b3cf7b2a3d2");
```

```python
# Coming Soon!
```

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/tenants/self/members/{id}`
</span>

Delete a Tenant Member by ID from the Tenant. Deleting a Tenant Member will revoke all access from the Tenant.

### Permissions

`tenant:member:delete`

### URI Parameters

| Parameter | Required | Type   | Default | Description                 |
|-----------|----------|--------|---------|-----------------------------|
| `id`      | true     | *uuid* | `null`  | The ID of the Tenant Member |

### Response

Returns [an error](#errors) if the Tenant Member could not be deleted.


## Create Tenant Invitation

> Request

```shell
curl "https://api.basistheory.com/tenants/self/invitations" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "POST" \
  -d '{
    "email": "jane@doe.com",
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const createdInvitation = await bt.tenants.createInvitations({
  email: 'jane@doe.com',
});
```

```csharp
using BasisTheory.net.Tenants;

var client = new TenantClient("key_N88mVGsp3sCXkykyN2EFED");

var createdInvitation = await client.CreateInvitationAsync(new TenantInvitation
{
    Email = "jane@doe.com"
});
```

```python
# Coming Soon!
```

> Response

```json
{
  "id": "fb32ea26-2185-4ad2-a7bf-2fe69c00ae13",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "email": "jane@doe.com",
  "status": "PENDING",
  "expires_at": "2020-09-18T15:53:00+00:00",
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00"
}
```

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/tenants/self/invitations`
</span>

Invite a new member to join this Tenant. Creating a Tenant Invitation will send an e-mail to the recipient containing a link to accept the invitation.

### Permissions

<p class="scopes">
  <span class="scope">tenant:invitation:create</span>
</p>

### Request Parameters

| Attribute     | Required | Type     | Default | Description                                                                                                                       |
|---------------|----------|----------|---------|-----------------------------------------------------------------------------------------------------------------------------------|
| `email`       | true     | *string* | `null`  | The invitee's e-mail address. Has to be a well-formed e-mail address ([RFC 5322](https://datatracker.ietf.org/doc/html/rfc5322)). |

### Response

Returns a [Tenant Invitation](#tenant-members-tenant-inviation-object) if the Tenant Invitation was created. Returns [an error](#errors) if there were validation errors, or the Tenant Invitation failed to create.


## Resend Tenant Invitation

> Request

```shell
curl "https://api.basistheory.com/tenants/self/invitations/fb32ea26-2185-4ad2-a7bf-2fe69c00ae13/resend" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "POST"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const resentInvitation = await bt.tenants.resendInvitation('fb32ea26-2185-4ad2-a7bf-2fe69c00ae13');
```

```csharp
using BasisTheory.net.Tenants;

var client = new TenantClient("key_N88mVGsp3sCXkykyN2EFED");

var resentInvitation = await client.ResendInvitationAsync("fb32ea26-2185-4ad2-a7bf-2fe69c00ae13");
```

```python
# Coming Soon!
```

> Response

```json
{
  "id": "fb32ea26-2185-4ad2-a7bf-2fe69c00ae13",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "email": "jane@doe.com",
  "status": "PENDING",
  "expires_at": "2020-09-18T15:53:00+00:00",
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00"
}
```

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/tenants/self/invitations/{id}/resend`
</span>

Resend a pending or expired Tenant Invitation. Resending the invitation will extend the expiration by 72 hours and invalidate any previous invitation link(s) sent to the recipient.

### Permissions

<p class="scopes">
  <span class="scope">tenant:invitation:create</span>
  <span class="scope">tenant:invitation:update</span>
</p>

### Response

Returns a [Tenant Invitation](#tenant-members-tenant-inviation-object) if the Tenant Invitation was resent. Returns [an error](#errors) if there were validation errors, or the Tenant Invitation failed to resend.


## List Tenant Invitations

> Request

```shell
curl "https://api.basistheory.com/tenants/self/invitations" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const invitations = await bt.tenants.listInvitations();
```

```csharp
using BasisTheory.net.Tenants;

var client = new TenantClient("key_N88mVGsp3sCXkykyN2EFED");

var invitations = await client.GetInvitationsAsync();
```

```python
# Coming Soon!
```

> Response

```json
{
  "pagination": {...},
  "data": [
    {
      "id": "fb32ea26-2185-4ad2-a7bf-2fe69c00ae13",
      "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
      "email": "jane@doe.com",
      "status": "PENDING",
      "expires_at": "2020-09-18T15:53:00+00:00",
      "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
      "created_at": "2020-09-15T15:53:00+00:00"
    },
    {...},
    {...}
  ]
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/tenants/self/invitations`
</span>

Get a list of Tenant Invitations for the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">tenant:invitation:read</span>
</p>

### Query Parameters

| Parameter | Required | Type      | Default | Description                                                            |
|-----------|----------|-----------|---------|------------------------------------------------------------------------|
| `page`    | false    | *integer* | `1`     | Page number of the results to return.                                  |
| `size`    | false    | *integer* | `20`    | Number of the results to return per page. Maximum size of 100 results. |

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of [Tenant Invitations](#tenant-members-tenant-invitation-object).
Providing any query parameters will filter the results.
Returns [an error](#errors) if Tenant Invitations could not be retrieved.


## Get a Tenant Invitation

> Request

```shell
curl "https://api.basistheory.com/tenants/self/invitations/fb32ea26-2185-4ad2-a7bf-2fe69c00ae13" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const invitation = await bt.tenants.retrieveInvitation('fb32ea26-2185-4ad2-a7bf-2fe69c00ae13');
```

```csharp
using BasisTheory.net.Tenants;

var client = new TenantClient("key_N88mVGsp3sCXkykyN2EFED");

var invitation = await client.GetInvitationByIdAsync("fb32ea26-2185-4ad2-a7bf-2fe69c00ae13");
```

```python
# Coming Soon!
```

> Response

```json
{
  "id": "fb32ea26-2185-4ad2-a7bf-2fe69c00ae13",
  "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
  "email": "jane@doe.com",
  "status": "PENDING",
  "expires_at": "2020-09-18T15:53:00+00:00",
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00"
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/tenants/self/invitations/{id}`
</span> 

Get a Tenant Invitation by ID in the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">tenant:invitation:read</span>
</p>

### URI Parameters

| Parameter | Required | Type   | Default | Description                     |
|-----------|----------|--------|---------|---------------------------------|
| `id`      | true     | *uuid* | `null`  | The ID of the Tenant Invitation |

### Response

Returns a [Tenant Invitation](#tenant-members-tenant-invitation-object) with the `id` provided. Returns [an error](#errors) if the Tenant Invitation could not be retrieved.

## Delete Tenant Invitation

> Request

```shell
curl "https://api.basistheory.com/tenants/self/invitations/fb32ea26-2185-4ad2-a7bf-2fe69c00ae13" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -X "DELETE"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

await bt.tenants.deleteInvitation('fb32ea26-2185-4ad2-a7bf-2fe69c00ae13');
```

```csharp
using BasisTheory.net.Tenants;

var client = new TenantClient("key_N88mVGsp3sCXkykyN2EFED");

await client.DeleteInvitationAsync("fb32ea26-2185-4ad2-a7bf-2fe69c00ae13");
```

```python
# Coming Soon!
```

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/tenants/self/invitations/{id}`
</span>

Delete a Tenant Invitation by ID from the Tenant.
Deleting a Tenant Invitation will invalidate any outstanding invitation links sent to the recipient.

### Permissions

`tenant:invitation:delete`

### URI Parameters

| Parameter | Required | Type   | Default | Description                     |
|-----------|----------|--------|---------|---------------------------------|
| `id`      | true     | *uuid* | `null`  | The ID of the Tenant Invitation |

### Response

Returns [an error](#errors) if the Tenant Invitation could not be deleted.
