# Exchange Templates

Exchange templates give you the ability to pre-configure custom integrations to securely process, enrich, and associate your tokens.

<aside class="notice">
  <span>Creating exchange templates is currently in beta status. If you would like to be added to the beta program, please <a href="mailto:support@basistheory.com?subject=Exchange Template Beta Access">contact us</a>!</span>
</aside>


## Exchange Template Object

Attribute | Type | Description
--------- | ---- | -----------
`id` | *uuid* | Unique identifier of the exchange template which can be used to [get an exchange template](#get-an-exchange-template)
`name` | true | *string* | `null` | The name of the exchange template. Has a maximum length of `200`
`description` | *string* | `null` | The description of the exchange template
`type` | *string* | `null` | [Type](#exchange-template-types) of the exchange template
`source_token_type` | *string* | `null` | [Source token type](#token-types) of the exchange template
`icon` | false | *string* | `null` | Base64 [data URL](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs) of the image
`code` | true | *string* | `null` | [Exchange code](#exchange-template-code) which will be executed when the exchange template is processed
`configuration` | true | *array* | `[]` | Array of [configuration](#exchange-template-configuration-object) options for configuring an exchange
`created_at` | *date* | Created date of the exchange template in ISO 8601 format
`modified_at` | *date* | Modified date of the exchange template in ISO 8601 format

### Exchange Template Configuration Object

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | true | *string* | `null` | Name of the configuration setting
`type` | true | *string* | `null` | Data type of the configuration setting. Valid values are `string`, `boolean`, and `number`


## Exchange Template Code

All exchange template code snippets must export a function which takes in a [context object](#exchange-template-code-context-object) and returns a [token object](#token-object).

### Exchange Template Code Context Object

Attribute | Type | Description
--------- | ---- | -----------
`sourceToken` | *object* | The source token that matches the `source_token_type` of the [exchange template](#exchange-template-object)
`configuration` | *array* | The configuration defined for the [exchange object](#exchange-object)


## Exchange Template Types

Type | Description
---- | -----------
`official` | Official templates that are built and supported by Basis Theory and its authorized partners
`private` | Private templates which are only available to your tenant


## Create Exchange Template

> Request

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

```csharp
var client = new ExchangeTemplateClient("key_N88mVGsp3sCXkykyN2EFED");

var exchangeTemplate = await client.CreateAsync(new ExchangeTemplate {
  Name = "My Private Exchange",
  Description = "Securely exchange token for another token",
  Type = "private",
  SourceTokenType = "card",
  Icon = "data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",
  Code = @"
    module.exports = async function (context) {
      // Do something with `context.configuration.SERVICE_API_KEY`

      return {
        foo: 'bar',
      };
    };
  ",
  Configuration = new List<ExchangeTemplateConfiguration> {
    new ExchangeTemplateConfiguration {
      Name = "SERVICE_API_KEY",
      Type = "string"
    }
  }
});
```

> Response

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

### Request Parameters

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | true | *string* | `null` | The name of the exchange template. Has a maximum length of `200`
`description` | false | *string* | `null` | The description of the exchange template
`type` | true | *string* | `null` | [Type](#exchange-template-types) of the exchange template
`source_token_type` | true | *string* | `null` | [Source token type](#token-types) of the exchange template
`icon` | false | *string* | `null` | Base64 [data URL](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs) of the image. Supported image types are: `image/png`, `image/jpg`, and `image/jpeg`
`code` | true | *string* | `null` | [Exchange code](#exchange-template-code) which will be executed when the exchange template is processed
`configuration` | true | *array* | `[]` | Array of [configuration](#exchange-template-configuration-object) options for configuring an exchange


### Response

Returns an [exchange template](#exchange-template-object) if the exchange template was created. Returns [an error](#errors) if there were validation errors or the exchange template failed to create.


## List Exchange Templates

> Request

```shell
curl "https://api.basistheory.com/exchange-templates" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```csharp
var client = new ExchangeTemplateClient("key_N88mVGsp3sCXkykyN2EFED");

var exchangeTemplates = await client.GetAsync();
```

> Response

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

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/exchange-templates`
</span>

Get a list of official exchange templates and private, tenant-specific exchange templates.

### Permissions

<p class="scopes">
  <span class="scope">exchange:read</span>
</p>

### Query Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | false | *string* | `null` | Wildcard search of exchange templates by name
`source_token_type` | false | *string* | `null` | Filter exchange templates by [source token type](#token-types)

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of [exchange templates](#exchange-template-object). Providing any query parameters will filter the results. Returns [an error](#errors) if exchange templates could not be retrieved.


## Get an Exchange Template

> Request

```shell
curl "https://api.basistheory.com/exchange-templates/17069df1-80f4-439e-86a7-4121863e4678" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```csharp
var client = new ExchangeTemplateClient("key_N88mVGsp3sCXkykyN2EFED");

var exchangeTemplate = await client.GetByIdAsync("17069df1-80f4-439e-86a7-4121863e4678");
```

> Response

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
`id` | true | *uuid* | `null` | The ID of the exchange template

### Response

Returns an [exchange template](#exchange-template-object) with the `id` provided. Returns [an error](#errors) if the exchange template could not be retrieved.


## Update Exchange Template

> Request

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

```csharp
var client = new ExchangeTemplateClient("key_N88mVGsp3sCXkykyN2EFED");

var exchangeTemplate = await client.UpdateAsync("17069df1-80f4-439e-86a7-4121863e4678", 
  new ExchangeTemplate {
    Name = "My Private Exchange",
    Description = "Securely exchange token for another token",
    Type = "private",
    SourceTokenType = "card",
    Icon = "data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",
    Code = @"
      module.exports = async function (context) {
        // Do something with `context.configuration.SERVICE_API_KEY`

        return {
          foo: 'bar',
        };
      };
    ",
    Configuration = new List<ExchangeTemplateConfiguration> {
      new ExchangeTemplateConfiguration {
        Name = "SERVICE_API_KEY",
        Type = "string"
      }
    }
  }
);
```

> Response

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
`id` | true | *uuid* | `null` | The ID of the exchange template

### Request Parameters

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | true | *string* | `null` | The name of the exchange template. Has a maximum length of `200`
`description` | false | *string* | `null` | The description of the exchange template
`type` | true | *string* | `null` | [Type](#exchange-template-types) of the exchange template
`source_token_type` | true | *string* | `null` | [Source token type](#token-types) of the exchange template
`icon` | false | *string* | `null` | Base64 [data URL](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs) of the image. Supported image types are: `image/png`, `image/jpg`, and `image/jpeg`
`code` | true | *string* | `null` | [Exchange code](#exchange-template-code) which will be executed when the exchange template is processed
`configuration` | true | *array* | `[]` | Array of [configuration](#exchange-template-configuration-object) options for configuring an exchange

### Response

Returns an [exchange template](#exchange-template-object) if the exchange template was updated. Returns [an error](#errors) if there were validation errors or the exchange template failed to update.


## Delete Exchange Template

> Request

```shell
curl "https://api.basistheory.com/exchange-templates/17069df1-80f4-439e-86a7-4121863e4678" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
  -X "DELETE"
```

```csharp
var client = new ExchangeTemplateClient("key_N88mVGsp3sCXkykyN2EFED");

await client.DeleteAsync("17069df1-80f4-439e-86a7-4121863e4678");
```

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/exchange-templates/{id}`
</span>

Delete an exchange template by ID in the tenant.

### Permissions

<p class="scopes">
  <span class="scope">exchange:delete</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the exchange template

### Response

Returns [an error](#errors) if the exchange template failed to delete.