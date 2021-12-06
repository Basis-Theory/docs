# Reactor Formulas

Reactor formulas give you the ability to pre-configure custom integrations to securely process, enrich, and associate your tokens.

## Reactor Formula Object

Attribute | Type | Description
--------- | ---- | -----------
`id` | *uuid* | Unique identifier of the Reactor Formula which can be used to [get a Reactor Formula](#reactor-formulas-get-a-reactor-formula)
`name` | *string* | The name of the Reactor Formula. Has a maximum length of `200`
`description` | *string* | The description of the Reactor Formula
`type` | *string* | [Type](#reactor-formulas-reactor-formula-types) of the Reactor Formula
`source_token_type` | *string* | [Source token type](#tokens-token-types) of the Reactor Formula
`icon` | *string* | Base64 [data URL](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs) of the image
`code` | *string* | [Reactor Formula code](#reactor-formulas-reactor-formula-code) which will be executed when the Reactor Formula is processed
`configuration` | *array* | Array of [configuration](#reactor-formulas-reactor-formula-object-reactor-formula-configuration-object) options for configuring a reactor
`request_parameters` | *array* | Array of [request parameters](#reactor-formulas-reactor-formula-object-reactor-formula-request-parameter-object) which will be passed when executing the reactor
`created_at` | *date* | (Optional) Created date of the Reactor Formula in ISO 8601 format
`created_by` | *uuid* | (Optional) The ID of the user or [Application](#applications) that created the Reactor Formula
`modified_at` | *date* | (Optional) Last modified date of the Reactor Formula in ISO 8601 format
`modified_by` | *uuid* | (Optional) The ID of the user or [Application](#applications) that last modified the Reactor Formula

### Reactor Formula Configuration Object

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | true | *string* | `null` | Name of the configuration setting
`description` | false | *string* | `null` | Description of the configuration setting
`type` | true | *string* | `null` | Data type of the configuration setting. Valid values are `string`, `boolean`, and `number`

### Reactor Formula Request Parameter Object

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | true | *string* | `null` | Name of the request parameter
`description` | false | *string* | `null` | Description of the request parameter
`type` | true | *string* | `null` | Data type of the request parameter. Valid values are `string`, `boolean`, and `number`
`optional` | false | *boolean* | `false` | If the request parameter is optional when executing the reactor


## Reactor Formula Code

All Reactor Formula code snippets must export a function which takes in a [context object](#reactor-formulas-reactor-formula-code-context-object) and returns a [token object](#tokens-token-object).

### Reactor Formula Code Context Object

Attribute | Type | Description
--------- | ---- | -----------
`sourceToken` | *object* | The source token that matches the `source_token_type` of the [reactor-formula](#reactor-formulas-reactor-formula-object)
`configuration` | *array* | The configuration defined for the [Reactor object](#reactors-reactor-object)


## Reactor Formula Types

Type | Description
---- | -----------
`official` | Official formulas that are built and supported by Basis Theory and its authorized partners
`private` | Private formulas which are only available to your Tenant


## Create Reactor Formula <span class="beta menu">BETA</span>

> Request

```shell
curl "https://api.basistheory.com/reactor-formulas" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "POST" \
  -d '{
    "name": "My Private Reactor",
    "description": "Securely react a token for another token",
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
        "description": "Configuration description",
        "type": "string"
      }
    ],
    "request_parameters": [
      {
        "name": "REQUEST_PARAMETER_1",
        "description": "Request parameter description",
        "type": "string"
      },
      {
        "name": "REQUEST_PARAMETER_2",
        "description": "Request parameter description",
        "type": "boolean",
        "optional": true
      }
    ]
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const reactorFormula = await bt.reactorFormulas.create({
  name: 'My Private Reactor',
  description: 'Securely exchange token for another token',
  type: 'private',
  sourceTokenType: 'card',
  icon: 'data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==',
  code: '
    module.exports = async function (context) {
      // Do something with `context.configuration.SERVICE_API_KEY`

      return {
        foo: 'bar',
      };
    };
  ',
  configuration: [
    {
      name: 'SERVICE_API_KEY',
      description: 'Configuration description',
      type: 'string',
    },
  ],
  requestParameters: [
    {
      name: 'REQUEST_PARAMETER_1',
      description: 'Request parameter description',
      type: 'string',
    },
    {
      name: 'REQUEST_PARAMETER_2',
      description: 'Request parameter description',
      type: 'boolean',
      optional: true
    }
  ],
});
```

```csharp
using BasisTheory.net.ReactorFormulas;

var client = new ReactorFormulaClient("key_N88mVGsp3sCXkykyN2EFED");

var reactorFormula = await client.CreateAsync(new ReactorFormula {
  Name = "My Private Reactor",
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
  Configuration = new List<ReactorFormulaConfiguration> {
    new ReactorFormulaConfiguration {
      Name = "SERVICE_API_KEY",
      Description = "Configuration description",
      Type = "string"
    }
  },
  RequestParameters = new List<ReactorFormulaRequestParameter> {
    new ReactorFormulaRequestParameter {
      Name = "REQUEST_PARAMETER_1",
      Description = "Request parameter description",
      Type = "string"
    },
    new ReactorFormulaRequestParameter {
      Name = "REQUEST_PARAMETER_2",
      Description = "Request parameter description",
      Type = "boolean",
      IsOptional = true
    }
  }
});
```

> Response

```json
{
  "id": "17069df1-80f4-439e-86a7-4121863e4678",
  "name": "My Private Reactor",
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
      "description": "Configuration description",
      "type": "string"
    }
  ],
  "request_parameters": [
    {
      "name": "REQUEST_PARAMETER_1",
      "description": "Request parameter description",
      "type": "string"
    },
    {
      "name": "REQUEST_PARAMETER_2",
      "description": "Request parameter description",
      "type": "boolean",
      "optional": true
    }
  ],
  "created_by": "c57a0d0d-e8e6-495f-9c79-a317cc21996c",
  "created_at": "2020-09-15T15:53:00+00:00"
}
```

<aside class="warning">
  <span>Creating custom Reactor Formulas is currently in Private Beta. If you would like to be added to the beta program, please <a href="mailto:support@basistheory.com?subject=Reactor Beta Access">contact us</a>!</span>
</aside>

<span class="http-method post">
  <span class="box-method">POST</span>
  `https://api.basistheory.com/reactor-formulas`
</span>

Create a new Reactor Formula for the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">reactor:create</span>
</p>

### Request Parameters

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | true | *string* | `null` | The name of the Reactor Formula. Has a maximum length of `200`
`description` | false | *string* | `null` | The description of the Reactor Formula
`type` | true | *string* | `null` | [Type](#reactor-formulas-reactor-formula-types) of the Reactor Formula
`source_token_type` | true | *string* | `null` | [Source token type](#tokens-token-types) of the Reactor Formula
`icon` | false | *string* | `null` | Base64 [data URL](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs) of the image. Supported image types are: `image/png`, `image/jpg`, and `image/jpeg`
`code` | true | *string* | `null` | [Reactor code](#reactor-formulas-reactor-formula-code) which will be executed when the Reactor Formula is processed
`configuration` | true | *array* | `[]` | Array of [configuration](#reactor-formulas-reactor-formula-object-reactor-formula-configuration-object) options for configuring a Reactor
`request_parameters` | true | *array* | `[]` | Array of [request parameters](#reactor-formulas-reactor-formula-object-reactor-formula-request-parameter-object) which will be passed when executing the Reactor


### Response

Returns an [Reactor Formula](#reactor-formulas-reactor-formula-object) if the Reactor Formula was created. Returns [an error](#errors) if there were validation errors, or the Reactor Formula failed to create.


## List Reactor Formulas

> Request

```shell
curl "https://api.basistheory.com/reactor-formulas" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const reactorFormulas = await bt.reactorFormulas.list();
```

```csharp
using BasisTheory.net.ReactorFormulas;

var client = new ReactorFormulaClient("key_N88mVGsp3sCXkykyN2EFED");

var reactorFormulas = await client.GetAsync();
```

> Response

```json
{
  "pagination": {...}
  "data": [
    {
      "id": "17069df1-80f4-439e-86a7-4121863e4678",
      "name": "My Private Reactor",
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
          "description": "Configuration description",
          "type": "string"
        }
      ],
      "request_parameters": [
        {
          "name": "REQUEST_PARAMETER_1",
          "description": "Request parameter description",
          "type": "string"
        },
        {
          "name": "REQUEST_PARAMETER_2",
          "description": "Request parameter description",
          "type": "boolean",
          "optional": true
        }
      ],
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
  `https://api.basistheory.com/reactor-formulas`
</span>

Get a list of official Reactor Formula and private, Tenant-specific Reactor Formulas.

### Permissions

<p class="scopes">
  <span class="scope">reactor:read</span>
</p>

### Query Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | false | *string* | `null` | Wildcard search of Reactor Formulas by name
`source_token_type` | false | *string* | `null` | Filter Reactor Formulas by [source token type](#tokens-token-types)

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of [Reactor Formulas](#reactor-formulas-reactor-formula-object). Providing any query parameters will filter the results. Returns [an error](#errors) if Reactor Formulas could not be retrieved.


## Get a Reactor Formula

> Request

```shell
curl "https://api.basistheory.com/reactor-formulas/17069df1-80f4-439e-86a7-4121863e4678" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const reactorFormula = await bt.reactorFormulas.retrieve('17069df1-80f4-439e-86a7-4121863e4678');
```

```csharp
using BasisTheory.net.ReactorFormulas;

var client = new ReactorFormulaClient("key_N88mVGsp3sCXkykyN2EFED");

var reactorFormula = await client.GetByIdAsync("17069df1-80f4-439e-86a7-4121863e4678");
```

> Response

```json
{
  "id": "17069df1-80f4-439e-86a7-4121863e4678",
  "name": "My Private Reactor",
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
      "description": "Configuration description",
      "type": "string"
    }
  ],
  "request_parameters": [
    {
      "name": "REQUEST_PARAMETER_1",
      "description": "Request parameter description",
      "type": "string"
    },
    {
      "name": "REQUEST_PARAMETER_2",
      "description": "Request parameter description",
      "type": "boolean",
      "optional": true
    }
  ],
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "modified_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method get">
  <span class="box-method">GET</span>
  `https://api.basistheory.com/reactor-formulas/{id}`
</span> 

Get a Reactor Formula by ID in the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">reactor:read</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the Reactor Formula

### Response

Returns an [Reactor Formula](#reactor-formulas-reactor-formula-object) with the `id` provided. Returns [an error](#errors) if the Reactor Formula could not be retrieved.


## Update Reactor Formula

> Request

```shell
curl "https://api.basistheory.com/reator-formula/17069df1-80f4-439e-86a7-4121863e4678" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "PUT" \
  -d '{
    "name": "My Private Reactor",
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
        "description": "Configuration description",
        "type": "string"
      }
    ],
    "request_parameters": [
      {
        "name": "REQUEST_PARAMETER_1",
        "description": "Request parameter description",
        "type": "string"
      },
      {
        "name": "REQUEST_PARAMETER_2",
        "description": "Request parameter description",
        "type": "boolean",
        "optional": true
      }
    ]
  }'
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

const reactorFormula = await bt.reactorFormulas.update('17069df1-80f4-439e-86a7-4121863e4678', {
  name: 'My Private Reactor',
  description: 'Securely exchange token for another token',
  type: 'private',
  sourceTokenType: 'card',
  icon: 'data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==',
  code: '
    module.exports = async function (context) {
      // Do something with `context.configuration.SERVICE_API_KEY`

      return {
        foo: 'bar',
      };
    };
  ',
  configuration: [
    {
      name: 'SERVICE_API_KEY',
      description: 'Configuration description',
      type: 'string',
    },
  ],
  requestParameters: [
    {
      name: 'REQUEST_PARAMETER_1',
      description: 'Request parameter description',
      type: 'string',
    },
    {
      name: 'REQUEST_PARAMETER_2',
      description: 'Request parameter description',
      type: 'boolean',
      optional: true
    }
  ],
});
```

```csharp
using BasisTheory.net.ReactorFormulas;

var client = new ReactorFormulaClient("key_N88mVGsp3sCXkykyN2EFED");

var reactorFormula = await client.UpdateAsync("17069df1-80f4-439e-86a7-4121863e4678", 
  new ReactorFormula {
    Name = "My Private Reactor",
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
    Configuration = new List<ReactorFormulaConfiguration> {
      new ReactorFormulaConfiguration {
        Name = "SERVICE_API_KEY",
        Description = "Configuration description",
        Type = "string"
      }
    },
    RequestParameters = new List<ReactorFormulaRequestParameter> {
      new ReactorFormulaRequestParameter {
        Name = "REQUEST_PARAMETER_1",
        Description = "Request parameter description",
        Type = "string"
      },
      new ReactorFormulaRequestParameter {
        Name = "REQUEST_PARAMETER_2",
        Description = "Request parameter description",
        Type = "boolean",
        IsOptional = true
      }
    }
  }
);
```

> Response

```json
{
  "id": "17069df1-80f4-439e-86a7-4121863e4678",
  "name": "My Private Reactor",
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
      "description": "Configuration description",
      "type": "string"
    }
  ],
  "request_parameters": [
    {
      "name": "REQUEST_PARAMETER_1",
      "description": "Request parameter description",
      "type": "string"
    },
    {
      "name": "REQUEST_PARAMETER_2",
      "description": "Request parameter description",
      "type": "boolean",
      "optional": true
    }
  ],
  "created_by": "fb124bba-f90d-45f0-9a59-5edca27b3b4a",
  "created_at": "2020-09-15T15:53:00+00:00",
  "modified_by": "34053374-d721-43d8-921c-5ee1d337ef21",
  "modified_at": "2021-03-01T08:23:14+00:00"
}
```

<span class="http-method put">
  <span class="box-method">PUT</span>
  `https://api.basistheory.com/reactor-formulas/{id}`
</span>

Update a Reactor Formula by ID in the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">reactor:update</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the Reactor Formula

### Request Parameters

Attribute | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`name` | true | *string* | `null` | The name of the Reactor Formula. Has a maximum length of `200`
`description` | false | *string* | `null` | The description of the Reactor Formula
`type` | true | *string* | `null` | [Type](#reactor-reactor-types) of the Reactor Formula
`source_token_type` | true | *string* | `null` | [Source token type](#tokens-token-types) of the Reactor Formula
`icon` | false | *string* | `null` | Base64 [data URL](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs) of the image. Supported image types are: `image/png`, `image/jpg`, and `image/jpeg`
`code` | true | *string* | `null` | [Reactor code](#reactor-formulas-reactor-formula-code) which will be executed when the Reactor Formula is processed
`configuration` | true | *array* | `[]` | Array of [configuration](#reactor-formulas-reactor-formula-object-reactor-formula-configuration-object) options for configuring a Reactor
`request_parameters` | true | *array* | `[]` | Array of [request parameters](#reactor-formulas-reactor-formula-object-reactor-formula-request-parameter-object) which will be passed when executing the Reactor

### Response

Returns an [Reactor Formula](#reactor-formulas-reactor-formula-object) if the Reactor Formula was updated. Returns [an error](#errors) if there were validation errors, or the Reactor Formula failed to update.


## Delete Reactor Formula

> Request

```shell
curl "https://api.basistheory.com/reactor-formulas/17069df1-80f4-439e-86a7-4121863e4678" \
  -H "X-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -X "DELETE"
```

```javascript
import { BasisTheory } from '@basis-theory/basis-theory-js';

const bt = await new BasisTheory().init('key_N88mVGsp3sCXkykyN2EFED');

await bt.reactorFormulas.delete('17069df1-80f4-439e-86a7-4121863e4678');
```

```csharp
using BasisTheory.net.ReactorFormulas;

var client = new ReactorFormulaClient("key_N88mVGsp3sCXkykyN2EFED");

await client.DeleteAsync("17069df1-80f4-439e-86a7-4121863e4678");
```

<span class="http-method delete">
  <span class="box-method">DELETE</span>
  `https://api.basistheory.com/reactor-formulas/{id}`
</span>

Delete a Reactor Formula by ID in the Tenant.

### Permissions

<p class="scopes">
  <span class="scope">reactor:delete</span>
</p>

### URI Parameters

Parameter | Required | Type | Default | Description
--------- | -------- | ---- | ------- | -----------
`id` | true | *uuid* | `null` | The ID of the Reactor Formula

### Response

Returns [an error](#errors) if the Reactor Formula failed to delete.
