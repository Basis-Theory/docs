# Logs

## Log Object

| Attribute     | Type     | Description                                                                             |
|---------------|----------|-----------------------------------------------------------------------------------------|
| `tenant_id`   | *uuid*   | The [Tenant](#tenants) ID which owns the entity                                         |
| `actor_id`    | *uuid*   | (Optional) The ID of the actor which performed the operation                            |
| `actor_type`  | *string* | (Optional) The type of actor which performed the operation (e.g. `user`, `application`) |
| `entity_type` | *string* | The entity type of the log (e.g. `token`, `card`, `bank`, `application`, `tenant`)      |
| `entity_id`   | *string* | The unique identifier of the `entity_type`                                              |
| `operation`   | *string* | The log operation (e.g. create, update, read, delete)                                   |
| `message`     | *string* | The log message                                                                         |
| `created_at`  | *date*   | Created date of the token in ISO 8601 format                                            |


## List Logs

> Request

```shell
curl "https://api.basistheory.com/logs" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const logs = await bt.logs.list();
```

```csharp
using BasisTheory.net.Logs;

var client = new LogClient("key_N88mVGsp3sCXkykyN2EFED");

var logs = await client.GetAsync();
```

```python
import basistheory
from basistheory.api import logs_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    logs_client = logs_api.LogsApi(api_client)

    logs = logs_client.get()
```

> Response

```json
{
  "pagination": {...},
  "data": [
    {
      "tenant_id": "77cb0024-123e-41a8-8ff8-a3d5a0fa8a08",
      "actor_id": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
      "actor_type": "application",
      "entity_type": "token",
      "entity_id": "c06d0789-0a38-40be-b7cc-c28a718f76f1",
      "operation": "read",
      "message": "Token retrieved",
      "created_at": "2021-03-01T08:23:14+00:00"
    },
    {...},
    {...}
  ]
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/logs`
</span>

Get a list of logs for the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">log:read</span>
</p>

### Query Parameters

| Parameter     | Required | Type     | Default | Description                                                                                                    |
|---------------|----------|----------|---------|----------------------------------------------------------------------------------------------------------------|
| `entity_type` | false    | *string* | `null`  | An optional entity type to filter the list of logs by. (e.g. `token`, `card`, `bank`, `application`, `tenant`) |
| `entity_id`   | false    | *string* | `null`  | The unique identifier of the `entity_type` to filter the list of logs by.                                      |
| `start_date`  | false    | *date*   | `null`  | An ISO 8601 formatted date to filter logs where `created_at` is greater than or equal to                       |
| `end_date`    | false    | *date*   | `null`  | An ISO 8601 formatted date to filter logs where `created_at` is less than                                      |

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of [logs](#log-object). Providing any query parameters will filter the results. Returns [an error](#errors) if logs could not be retrieved.
