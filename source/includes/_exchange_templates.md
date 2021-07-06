# Exchange Templates

Exchange templates give you the ability to pre-configure custom integrations to securely process and associate your tokens.


## Exchange Template Types

Type | Description
---- | -----------
`official` | Official templates that are built and supported by Basis Theory and its authorized partners
`private` | Private templates which are only available to your tenant


## Create Exchange Template

> Create Exchange Template Request Example:

```shell
curl "https://api.basistheory.com/exchange-templates" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -H "Content-Type: application/json"
  -X "POST"
  -D '{
    "name": "My Private Exchange",
    "description": "Securely exchange token for another token",
    "type": "private",
    "source_token_type": "card",
    "icon": "data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",
    "code": "
      module.exports = async function (context) {
        // Do something with `context.configuration.SERVICE_API_KEY`

        return {
          foo: 'bar',
        };
      };
    ",
    "configuration": [
      {
        "name": "SERVICE_API_KEY",
        "type": "string"
      }
    ]
  }'
```

> Create Exchange Template Response Example:

```json
{
  "id": "17069df1-80f4-439e-86a7-4121863e4678",
  "name": "My Private Exchange",
  "description": "Securely exchange token for another token",
  "type": "private",
  "source_token_type": "card",
  "icon": "data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",
  "code": "
    module.exports = async function (context) {
      // Do something with `context.configuration.SERVICE_API_KEY`

      return {
        data: {
          foo: 'bar',
        },
        metadata: {
          nonSensitiveField: 'Non-Sensitive Value'
        }
      };
    };
  ",
  "configuration": [
    {
      "name": "SERVICE_API_KEY",
      "type": "string"
    }
  ],
  "created_at": "2020-09-15T15:53:00+00:00"
}
```

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/exchange-templates`
</span>

Create a new exchange template for the tenant.

### Permissions

<p class="scopes">
  <span class="scope">exchange:create</span>
</p>

### Request Schema

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | true | *string* | `null` | The name of the exchange template. Has a maximum length of `200`
`description` | false | *string* | `null` | The description of the exchange template
`type` | true | *string* | `null` | [Type](#exchange-template-types) of the exchange template
`source_token_type` | true | *string* | `null` | [Source token type](#token-types) of the exchange template
`icon` | false | *string* | `null` | Base64 [data URL](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs) of the image. Supported image types are: `image/png`, `image/jpg`, and `image/jpeg`
`code` | true | *string* | `null` | [Code snippet](#exchange-template-code-schema) which will be executed when the exchange template is processed
`configuration` | true | *array* | `[]` | Array of [exchange template configuration](#exchange-template-configuration-schema) options for configuring an exchange

### Exchange Template Code Schema

All exchange template code snippets must export a function which takes in a [context object](#exchange-template-code-context-schema) and returns a [token object](#exchange-template-code-response-schema). An example code snippet is:

### Exchange Template Code Context Schema

Attribute | Type | Description
--------- | ---- | -----------
`sourceToken` | *object* | The source token that matches the `source_token_type` of the [exchange template](#exchange-templates)
`configuration` | *array* | The configuration defined for the [exchange](#exchanges)

### Exchange Template Code Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`data` | *any* | The data field which will be used for [creating the token](#create-token)
`metadata` | *any* | The metadata field which will be used for [creating the token](#create-token)


### Exchange Template Configuration Schema

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | true | *string* | `null` | Name of the configuration setting
`type` | true | *string* | `null` | Data type of the configuration setting. Valid values are `string`, `boolean`, and `number`

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the exchange template which can be used to [get an exchange template](#get-an-exchange-template)
`name` | true | *string* | `null` | The name of the exchange template. Has a maximum length of `200`
`description` | false | *string* | `null` | The description of the exchange template
`type` | true | *string* | `null` | [Type](#exchange-template-types) of the exchange template
`source_token_type` | true | *string* | `null` | [Source token type](#token-types) of the exchange template
`icon` | false | *string* | `null` | Base64 [data URL](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs) of the image
`code` | true | *string* | `null` | [Code snippet](#exchange-template-code-schema) which will be executed when the exchange template is processed
`configuration` | true | *array* | `[]` | Array of [exchange template configuration](#exchange-template-configuration-schema) options for configuring an exchange
`created_at` | *string* | Created date of the exchange template in ISO 8601 format

### Response Messages

Code | Description
---- | -----------
`201` | Exchange template successfully created
`400` | Invalid request body. See [Errors](#errors) response for details
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions

<aside class="notice">
  <span>Creating custom private exchange templates is currently in beta status. If you would like to be added to the beta program, please <a href="mailto:support@basistheory.com?subject=Exchange Template Beta Access">contact us</a>!</span>
</aside>


## List Exchange Templates

> List Exchange Templates Request Example:

```shell
curl "https://api.basistheory.com/exchange-templates" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> Exchange Templates Response Example:

```json
{
  "pagination": {...}
  "data": [
    {
      "id": "17069df1-80f4-439e-86a7-4121863e4678",
      "name": "My Private Exchange",
      "description": "Securely exchange token for another token",
      "type": "private",
      "source_token_type": "card",
      "icon": "data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",
      "code": "
        module.exports = async function (context) {
          // Do something with `context.configuration.SERVICE_API_KEY`

          return {
            data: {
              foo: 'bar',
            },
            metadata: {
              nonSensitiveField: 'Non-Sensitive Value'
            }
          };
        };
      ",
      "configuration": [
        {
          "name": "SERVICE_API_KEY",
          "type": "string"
        }
      ],
      "created_at": "2020-09-15T15:53:00+00:00",
      "modified_at": "2021-03-01T08:23:14+00:00"
    },
    {...},
    {...}
  ]
}
```

> List Exchange Templates by Name Request Example:

```shell
curl "https://api.basistheory.com/exchange-templates?name=My+Private+Exchange" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> List Exchange Templates by Source Token Type Request Example:

```shell
curl "https://api.basistheory.com/exchange-templates?source_token_type=bank" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/exchange-templates`
</span>

Get a list of official exchange templates and exchange templates for the tenant.

### Permissions

<p class="scopes">
  <span class="scope">exchange:read</span>
</p>

### Query Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | false | *string* | `null` | Wildcard search of exchange templates by name
`source_token_type` | false | *string* | `null` | Filter exchange templates by [source token type](#token-types)

### Response Schema

Returns the [Pagination](#pagination) schema. The `data` attribute in the response contains an array of exchange templates with the following schema:

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the exchange template which can be used to [get an exchange template](#get-an-exchange-template)
`name` | true | *string* | `null` | The name of the exchange template. Has a maximum length of `200`
`description` | false | *string* | `null` | The description of the exchange template
`type` | true | *string* | `null` | [Type](#exchange-template-types) of the exchange template
`source_token_type` | true | *string* | `null` | [Source token type](#token-types) of the exchange template
`icon` | false | *string* | `null` | Base64 [data URL](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs) of the image
`code` | true | *string* | `null` | [Code snippet](#exchange-template-code-schema) which will be executed when the exchange template is processed
`configuration` | true | *array* | `[]` | Array of [exchange template configuration](#exchange-template-configuration-schema) options for configuring an exchange
`created_at` | *string* | Created date of the exchange template in ISO 8601 format
`modified_at` | *string* | Modified date of the exchange template in ISO 8601 format

### Response Messages

Code | Description
---- | -----------
`200` | Exchange templates successfully retrieved
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions


## Get an Exchange Template

> Get an Exchange Template Request Example:

```shell
curl "https://api.basistheory.com/exchange-templates/17069df1-80f4-439e-86a7-4121863e4678" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

> Exchange Template Response Example:

```json
{
  "id": "17069df1-80f4-439e-86a7-4121863e4678",
  "name": "My Private Exchange",
  "description": "Securely exchange token for another token",
  "type": "private",
  "source_token_type": "card",
  "icon": "data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",
  "code": "
    module.exports = async function (context) {
      // Do something with `context.configuration.SERVICE_API_KEY`

      return {
        data: {
          foo: 'bar',
        },
        metadata: {
          nonSensitiveField: 'Non-Sensitive Value'
        }
      };
    };
  ",
  "configuration": [
    {
      "name": "SERVICE_API_KEY",
      "type": "string"
    }
  ],
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/exchange-templates/{id}`
</span> 

Get an exchange template by ID in the tenant.

### Permissions

<p class="scopes">
  <span class="scope">exchange:read</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *string* | `null` | The ID of the exchange template

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the exchange template which can be used to [get an exchange template](#get-an-exchange-template)
`name` | true | *string* | `null` | The name of the exchange template. Has a maximum length of `200`
`description` | false | *string* | `null` | The description of the exchange template
`type` | true | *string* | `null` | [Type](#exchange-template-types) of the exchange template
`source_token_type` | true | *string* | `null` | [Source token type](#token-types) of the exchange template
`icon` | false | *string* | `null` | Base64 [data URL](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs) of the image
`code` | true | *string* | `null` | [Code snippet](#exchange-template-code-schema) which will be executed when the exchange template is processed
`configuration` | true | *array* | `[]` | Array of [exchange template configuration](#exchange-template-configuration-schema) options for configuring an exchange
`created_at` | *string* | Created date of the exchange template in ISO 8601 format
`modified_at` | *string* | Modified date of the exchange template in ISO 8601 format

### Response Messages

Code | Description
---- | -----------
`200` | Exchange template successfully retrieved
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | The exchange template was not found


## Update Exchange Template

> Update Exchange Template Request Example:

```shell
curl "https://api.basistheory.com/exchange-templates/17069df1-80f4-439e-86a7-4121863e4678" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -H "Content-Type: application/json"
  -X "PUT"
  -D '{
    "name": "My Private Exchange",
    "description": "Securely exchange token for another token",
    "type": "private",
    "source_token_type": "card",
    "icon": "data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",
    "code": "
      module.exports = async function (context) {
        // Do something with `context.configuration.SERVICE_API_KEY`

        return {
          foo: 'bar',
        };
      };
    ",
    "configuration": [
      {
        "name": "SERVICE_API_KEY",
        "type": "string"
      }
    ]
  }'
```

> Update Exchange Template Response Example:

```json
{
  "id": "17069df1-80f4-439e-86a7-4121863e4678",
  "name": "My Private Exchange",
  "description": "Securely exchange token for another token",
  "type": "private",
  "source_token_type": "card",
  "icon": "data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",
  "code": "
    module.exports = async function (context) {
      // Do something with `context.configuration.SERVICE_API_KEY`

      return {
        data: {
          foo: 'bar',
        },
        metadata: {
          nonSensitiveField: 'Non-Sensitive Value'
        }
      };
    };
  ",
  "configuration": [
    {
      "name": "SERVICE_API_KEY",
      "type": "string"
    }
  ],
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method put">
  <span class="box-method">PUT</span>
  `https://api.basistheory.com/exchange-templates/{id}`
</span>

Update an exchange template by ID in the tenant.

### Permissions

<p class="scopes">
  <span class="scope">exchange:update</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *string* | `null` | The ID of the exchange template

### Request Schema

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | true | *string* | `null` | The name of the exchange template. Has a maximum length of `200`
`description` | false | *string* | `null` | The description of the exchange template
`type` | true | *string* | `null` | [Type](#exchange-template-types) of the exchange template
`source_token_type` | true | *string* | `null` | [Source token type](#token-types) of the exchange template
`icon` | false | *string* | `null` | Base64 [data URL](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs) of the image. Supported image types are: `image/png`, `image/jpg`, and `image/jpeg`
`code` | true | *string* | `null` | [Code snippet](#exchange-template-code-schema) which will be executed when the exchange template is processed
`configuration` | true | *array* | `[]` | Array of [exchange template configuration](#exchange-template-configuration-schema) options for configuring an exchange

### Response Schema

Attribute | Type | Description
--------- | ---- | -----------
`id` | *string* | Unique identifier of the exchange template which can be used to [get an exchange template](#get-an-exchange-template)
`name` | true | *string* | `null` | The name of the exchange template. Has a maximum length of `200`
`description` | false | *string* | `null` | The description of the exchange template
`type` | true | *string* | `null` | [Type](#exchange-template-types) of the exchange template
`source_token_type` | true | *string* | `null` | [Source token type](#token-types) of the exchange template
`icon` | false | *string* | `null` | Base64 [data URL](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs) of the image
`code` | true | *string* | `null` | [Code snippet](#exchange-template-code-schema) which will be executed when the exchange template is processed
`configuration` | true | *array* | `[]` | Array of [exchange template configuration](#exchange-template-configuration-schema) options for configuring an exchange
`created_at` | *string* | Created date of the exchange template in ISO 8601 format
`modified_at` | *string* | Last modified date of the exchange template in ISO 8601 format

### Response Messages

Code | Description
---- | -----------
`200` | Exchange template successfully updated
`400` | Invalid request body. See [Errors](#errors) response for details
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | The exchange template was not found


## Delete Exchange Template

> Delete Exchange Template Request Example:

```shell
curl "https://api.basistheory.com/exchange-templates/17069df1-80f4-439e-86a7-4121863e4678" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -X "DELETE"
```

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/exchange-templates/{id}`
</span>

Delete an exchange template by ID in the tenant.

### Permissions

`exchange:delete`

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *string* | `null` | The ID of the exchange template

### Response Messages

Code | Description
---- | -----------
`204` | Exchange template successfully deleted
`401` | A missing or invalid `X-API-KEY` was provided
`403` | The provided `X-API-KEY` does not have the required permissions
`404` | The exchange template was not found
