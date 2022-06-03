# Reactor Formulas

Reactor formulas give you the ability to pre-configure custom integrations to securely process, enrich, and associate your tokens.

## Reactor Formula Object

| Attribute            | Type     | Description                                                                                                                         |
|----------------------|----------|-------------------------------------------------------------------------------------------------------------------------------------|
| `id`                 | *uuid*   | Unique identifier of the Reactor Formula which can be used to [get a Reactor Formula](#reactor-formulas-get-a-reactor-formula)      |
| `name`               | *string* | The name of the Reactor Formula. Has a maximum length of `200`                                                                      |
| `description`        | *string* | The description of the Reactor Formula                                                                                              |
| `type`               | *string* | [Type](#reactor-formulas-reactor-formula-types) of the Reactor Formula                                                              |
| `icon`               | *string* | Base64 [data URL](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs) of the image                          |
| `code`               | *string* | [Reactor Formula code](#reactor-formulas-reactor-formula-code) which will be executed when the Reactor Formula is processed         |
| `configuration`      | *array*  | Array of [configuration](#reactor-formulas-reactor-formula-configuration) options for configuring a reactor                         |
| `request_parameters` | *array*  | Array of [request parameters](#reactor-formulas-reactor-formula-request-parameters) which will be passed when executing the reactor |
| `created_at`         | *date*   | (Optional) Created date of the Reactor Formula in ISO 8601 format                                                                   |
| `created_by`         | *uuid*   | (Optional) The ID of the user or [Application](#applications) that created the Reactor Formula                                      |
| `modified_at`        | *date*   | (Optional) Last modified date of the Reactor Formula in ISO 8601 format                                                             |
| `modified_by`        | *uuid*   | (Optional) The ID of the user or [Application](#applications) that last modified the Reactor Formula                                |

## Reactor Formula Configuration

The `configuration` property of a Reactor Formula defines the contract that the `configuration` property must satisfy on all [Reactors](#reactors-reactor-object) created from this formula.
Elements of a Reactor Formula's `configuration` array have the following schema:  

| Attribute     | Required | Type     | Default | Description                                                                                |
|---------------|----------|----------|---------|--------------------------------------------------------------------------------------------|
| `name`        | true     | *string* | `null`  | Name of the configuration setting                                                          |
| `description` | false    | *string* | `null`  | Description of the configuration setting                                                   |
| `type`        | true     | *string* | `null`  | Data type of the configuration setting. Valid values are `string`, `boolean`, and `number` |

Reactor configuration is intended for properties that can be defined once per Reactor and do not change between Reactor invocations.
Complex nested objects (dot-separated names) are not currently supported within a Reactor's `configuration`.

## Reactor Formula Request Parameters

The `request_parameters` array on a Reactor Formula defines the contract that the `args` property must satisfy on each request when [Invoking a Reactor](#reactors-invoke-a-reactor). 
Elements of a Reactor Formula's `request_parameters` array have the following schema:

| Attribute     | Required | Type      | Default | Description                                                                            |
|---------------|----------|-----------|---------|----------------------------------------------------------------------------------------|
| `name`        | true     | *string*  | `null`  | Name of the request parameter. Complex objects can be denoted as `[parent].[child]`    |
| `description` | false    | *string*  | `null`  | Description of the request parameter                                                   |
| `type`        | true     | *string*  | `null`  | Data type of the request parameter. Valid values are `string`, `boolean`, and `number` |
| `optional`    | false    | *boolean* | `false` | If the request parameter is optional when executing the reactor                        |

Request parameters are intended to define any parameters that will be provided to a Reactor at request-time, and may change across Reactor invocations.
Complex objects properties can be passed within the `args` property to a Reactor, and they can be defined by dot-separating levels of the object hierarchy.

Any `args` property not associated with a request parameter is still forwarded to the reactor. This allows you to provide complete complex objects including arrays, in which no type checking is applied. For instance, if no request parameters are declared, it means you can provide any payload when invoking the reactor. 

For example, to pass a `card` object whose schema matches the [Card Object](#atomic-cards-atomic-card-object-card-object) stored within an [Atomic Card](#atomic-cards-atomic-card-object) token and an array of any type, 
a Reactor Formula should define the following request parameters:

| name                    | type     | optional |
|-------------------------|----------|----------|
| `card.number`           | *string* | false    |
| `card.expiration_month` | *number* | false    |
| `card.expiration_year`  | *number* | false    |
| `card.cvc`              | *string* | true     |

As you can see, only the primitive typed request parameters are defined. You could even omit them completely and they would still be forwarded to the Reactor and no validation would be applied.

## Reactor Formula Code

All Reactor Formula code snippets must export a function which takes in a [request object](#reactor-formulas-reactor-formula-code-reactor-formula-request-object) and returns a [response object](#reactor-formulas-reactor-formula-code-reactor-formula-response-object).

### Reactor Formula Request Object

| Attribute       | Type     | Description                                                                                 |
|-----------------|----------|---------------------------------------------------------------------------------------------|
| `args`          | *object* | The arguments that were provided when the [reactor was invoked](#reactors-invoke-a-reactor) |
| `configuration` | *object* | The configuration defined for the [Reactor object](#reactors-reactor-object)                |

### Reactor Formula Response Object

| Attribute  | Type     | Description                                                               |
|------------|----------|---------------------------------------------------------------------------|
| `raw`      | *object* | (Optional) Raw output returned from the Reactor                           |
| `tokenize` | *object* | (Optional) A payload that will be tokenized to produce one or more tokens |

The payload returned in the `tokenize` property will be tokenized in the same way that requests are tokenized via the Tokenize endpoint. 
For more information, see [Tokenize](#tokenize).

Reactor Formula Code is written in Javascript (targeting Node.js v14) and generally follows the structure:

<div class="center-column"></div>
```js
module.exports = async function (req) {
  const { my_arg } = req.args; // access any args provided with the request
  const { MY_CONFIG } = req.configuration; // access any static config defined on the Reactor

  // do anything here!

  return {
      raw: {}, // non-sensitive data that should be returned in plaintext
      tokenize: {} // sensitive data that should be tokenized
  };
};
```

For more information about writing your own code for a Reactor Formula, check out [our guide](https://developers.basistheory.com/guides/run-your-own-code-in-a-reactor/).

## Reactor Formula Types

| Type       | Description                                                                                |
|------------|--------------------------------------------------------------------------------------------|
| `official` | Official formulas that are built and supported by Basis Theory and its authorized partners |
| `private`  | Private formulas which are only available to your Tenant                                   |

<h2 id="reactor-formulas-create-reactor-formula">Create Reactor Formula</h2>

> Request

```shell
curl "https://api.basistheory.com/reactor-formulas" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "POST" \
  -d '{
    "name": "My Private Reactor",
    "description": "Securely react a token for another token",
    "type": "private",
    "icon": "data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",
    "code": "
      module.exports = async function (req) {
        // Do something with `req.configuration.SERVICE_API_KEY`

        return {
          raw: {
            foo: 'bar'
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
        "name": "request_parameter_1",
        "description": "Request parameter description",
        "type": "string"
      },
      {
        "name": "request_parameter_2",
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
  icon: 'data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==',
  code: '
    module.exports = async function (req) {
      // Do something with `req.configuration.SERVICE_API_KEY`

      return {
        raw: {
          foo: 'bar'
        }
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
      name: 'request_parameter_1',
      description: 'Request parameter description',
      type: 'string',
    },
    {
      name: 'request_parameter_2',
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
  Icon = "data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",
  Code = @"
    module.exports = async function (req) {
      // Do something with `req.configuration.SERVICE_API_KEY`

      return {
        raw: {
          foo: 'bar'
        }
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
      Name = "request_parameter_1",
      Description = "Request parameter description",
      Type = "string"
    },
    new ReactorFormulaRequestParameter {
      Name = "request_parameter_2",
      Description = "Request parameter description",
      Type = "boolean",
      IsOptional = true
    }
  }
});
```

```python
import basistheory
from basistheory.api import reactor_formulas_api
from basistheory.model.create_reactor_formula_request import CreateReactorFormulaRequest
from basistheory.model.reactor_formula_configuration import ReactorFormulaConfiguration
from basistheory.model.reactor_formula_request_parameter import ReactorFormulaRequestParameter

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    reactor_formulas_client = reactor_formulas_api.ReactorFormulasApi(
        api_client)

    reactor_formula = reactor_formulas_client.create(create_reactor_formula_request=CreateReactorFormulaRequest(
        name="My Private Reactor",
        description="Securely exchange token for another token",
        type="private",
        icon="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",
        code=" \
            module.exports = async function (req) { \
                // Do something with `req.configuration.SERVICE_API_KEY`" \

                "return { \
                    raw: { \
                        foo: 'bar' \
                    } \
                }; \
            };",
        configuration=[
            ReactorFormulaConfiguration(
                name="SERVICE_API_KEY",
                description="Configuration description",
                type="string"
            )
        ],
        request_parameters=[
            ReactorFormulaRequestParameter(
                name="request_parameter_1",
                description="Request parameter description",
                type="string"
            ),
            ReactorFormulaRequestParameter(
                name="request_parameter_2",
                description="Request parameter description",
                type="boolean",
                optional=True
            )
        ]
    ))
```

```go
package main

import (
  "context"
  "github.com/Basis-Theory/basistheory-go"
)

func main() {
  configuration := basistheory.NewConfiguration()
  apiClient := basistheory.NewAPIClient(configuration)
  contextWithAPIKey := context.WithValue(context.Background(), basistheory.ContextAPIKeys, map[string]basistheory.APIKey{
    "ApiKey": {Key: "key_N88mVGsp3sCXkykyN2EFED"},
  })

  createReactorFormulaModel := *basistheory.NewCreateReactorFormulaModel()
  createReactorFormulaModel.SetName("My Private Reactor")
  createReactorFormulaModel.SetDescription("Securely exchange token for another token")
  createReactorFormulaModel.SetType("private")
  createReactorFormulaModel.SetIcon("data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==")
  createReactorFormulaModel.SetCode(`
  	module.exports = async function (req) {
  	  // Do something with req.configuration.SERVICE_API_KEY
  
  	  return {
  		raw: {
  		  foo: 'bar'
  		}
  	  };
  	};
  `)
  var configurations []basistheory.ReactorFormulaConfigurationModel
  reactorFormulaConfiguration := *basistheory.NewReactorFormulaConfigurationModel()
  reactorFormulaConfiguration.SetName("SERVICE_API_KEY")
  reactorFormulaConfiguration.SetDescription("Configuration description")
  reactorFormulaConfiguration.SetType("string")
  configurations = append(configurations, reactorFormulaConfiguration)
  createReactorFormulaModel.SetConfiguration(configurations)
  var requestParameters []basistheory.ReactorFormulaRequestParameterModel
  reactorFormulaRequestParameter1 := *basistheory.NewReactorFormulaRequestParameterModel()
  reactorFormulaRequestParameter1.SetName("request_parameter_1")
  reactorFormulaRequestParameter1.SetDescription("Request parameter description")
  reactorFormulaRequestParameter1.SetType("string")
  requestParameters = append(requestParameters, reactorFormulaRequestParameter1)
  reactorFormulaRequestParameter2 := *basistheory.NewReactorFormulaRequestParameterModel()
  reactorFormulaRequestParameter2.SetName("request_parameter_2")
  reactorFormulaRequestParameter2.SetDescription("Request parameter description")
  reactorFormulaRequestParameter2.SetType("boolean")
  reactorFormulaRequestParameter2.SetOptional(true)
  requestParameters = append(requestParameters, reactorFormulaRequestParameter2)
  createReactorFormulaModel.SetRequestParameters(requestParameters)

  reactorFormula, response, err := apiClient.ReactorFormulasApi.ReactorFormulaCreate(contextWithAPIKey).CreateReactorFormulaModel(createReactorFormulaModel).Execute()
}
```

> Response

```json
{
  "id": "17069df1-80f4-439e-86a7-4121863e4678",
  "name": "My Private Reactor",
  "description": "Securely exchange token for another token",
  "type": "private",
  "icon": "data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",
  "code": "
    module.exports = async function (req) {
      // Do something with `req.configuration.SERVICE_API_KEY`

      return {
        raw: {
          foo: 'bar',
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
      "name": "request_parameter_1",
      "description": "Request parameter description",
      "type": "string"
    },
    {
      "name": "request_parameter_2",
      "description": "Request parameter description",
      "type": "boolean",
      "optional": true
    }
  ],
  "created_by": "c57a0d0d-e8e6-495f-9c79-a317cc21996c",
  "created_at": "2020-09-15T15:53:00+00:00"
}
```

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

| Attribute            | Required | Type     | Default | Description                                                                                                                                                                       |
|----------------------|----------|----------|---------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `name`               | true     | *string* | `null`  | The name of the Reactor Formula. Has a maximum length of `200`                                                                                                                    |
| `description`        | false    | *string* | `null`  | The description of the Reactor Formula                                                                                                                                            |
| `type`               | true     | *string* | `null`  | [Type](#reactor-formulas-reactor-formula-types) of the Reactor Formula                                                                                                            |
| `icon`               | false    | *string* | `null`  | Base64 [data URL](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs) of the image. Supported image types are: `image/png`, `image/jpg`, and `image/jpeg` |
| `code`               | true     | *string* | `null`  | [Reactor code](#reactor-formulas-reactor-formula-code) which will be executed when the Reactor Formula is processed                                                               |
| `configuration`      | true     | *array*  | `[]`    | Array of [configuration](#reactor-formulas-reactor-formula-configuration) options for configuring a Reactor                                                                       |
| `request_parameters` | true     | *array*  | `[]`    | Array of [request parameters](#reactor-formulas-reactor-formula-request-parameters) which will be passed when executing the Reactor                                               |

### Response

Returns a [Reactor Formula](#reactor-formulas-reactor-formula-object) if the Reactor Formula was created. Returns [an error](#errors) if there were validation errors, or the Reactor Formula failed to create.


## List Reactor Formulas

> Request

```shell
curl "https://api.basistheory.com/reactor-formulas" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
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

```python
import basistheory
from basistheory.api import reactor_formulas_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    reactor_formulas_client = reactor_formulas_api.ReactorFormulasApi(
        api_client)
    
    reactor_formulas = reactor_formulas_client.get()
```

```go
package main

import (
  "context"
  "github.com/Basis-Theory/basistheory-go"
)

func main() {
  configuration := basistheory.NewConfiguration()
  apiClient := basistheory.NewAPIClient(configuration)
  contextWithAPIKey := context.WithValue(context.Background(), basistheory.ContextAPIKeys, map[string]basistheory.APIKey{
    "ApiKey": {Key: "key_N88mVGsp3sCXkykyN2EFED"},
  })

  reactorFormulas, response, err := apiClient.ReactorFormulasApi.ReactorFormulasGet(contextWithAPIKey).Execute()
}
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
      "icon": "data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",
      "code": "
        module.exports = async function (req) {
          // Do something with `req.configuration.SERVICE_API_KEY`

          return {
            raw: {
              foo: 'bar'
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
          "name": "request_parameter_1",
          "description": "Request parameter description",
          "type": "string"
        },
        {
          "name": "request_parameter_2",
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

| Parameter           | Required | Type     | Default | Description                                                  |
|---------------------|----------|----------|---------|--------------------------------------------------------------|
| `name`              | false    | *string* | `null`  | Wildcard search of Reactor Formulas by name                  |

### Response

Returns a [paginated object](#pagination) with the `data` property containing an array of [Reactor Formulas](#reactor-formulas-reactor-formula-object). Providing any query parameters will filter the results. Returns [an error](#errors) if Reactor Formulas could not be retrieved.


## Get a Reactor Formula

> Request

```shell
curl "https://api.basistheory.com/reactor-formulas/17069df1-80f4-439e-86a7-4121863e4678" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED"
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

```python
import basistheory
from basistheory.api import reactor_formulas_api

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    reactor_formulas_client = reactor_formulas_api.ReactorFormulasApi(
        api_client)
    
    reactor_formula = reactor_formulas_client.get_by_id("17069df1-80f4-439e-86a7-4121863e4678")
```

```go
package main

import (
  "context"
  "github.com/Basis-Theory/basistheory-go"
)

func main() {
  configuration := basistheory.NewConfiguration()
  apiClient := basistheory.NewAPIClient(configuration)
  contextWithAPIKey := context.WithValue(context.Background(), basistheory.ContextAPIKeys, map[string]basistheory.APIKey{
    "ApiKey": {Key: "key_N88mVGsp3sCXkykyN2EFED"},
  })

  reactorFormula, response, err := apiClient.ReactorFormulasApi.ReactorFormulaGetById(contextWithAPIKey, "17069df1-80f4-439e-86a7-4121863e4678").Execute()
}
```

> Response

```json
{
  "id": "17069df1-80f4-439e-86a7-4121863e4678",
  "name": "My Private Reactor",
  "description": "Securely exchange token for another token",
  "type": "private",
  "icon": "data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",
  "code": "
    module.exports = async function (req) {
      // Do something with `req.configuration.SERVICE_API_KEY`

      return {
        raw: {
          foo: 'bar',
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
      "name": "request_parameter_1",
      "description": "Request parameter description",
      "type": "string"
    },
    {
      "name": "request_parameter_2",
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

| Parameter | Required | Type   | Default | Description                   |
|-----------|----------|--------|---------|-------------------------------|
| `id`      | true     | *uuid* | `null`  | The ID of the Reactor Formula |

### Response

Returns a [Reactor Formula](#reactor-formulas-reactor-formula-object) with the `id` provided. Returns [an error](#errors) if the Reactor Formula could not be retrieved.


## Update Reactor Formula

> Request

```shell
curl "https://api.basistheory.com/reator-formula/17069df1-80f4-439e-86a7-4121863e4678" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
  -H "Content-Type: application/json" \
  -X "PUT" \
  -d '{
    "name": "My Private Reactor",
    "description": "Securely exchange token for another token",
    "type": "private",
    "icon": "data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",
    "code": "
      module.exports = async function (req) {
        // Do something with `req.configuration.SERVICE_API_KEY`

        return {
          raw: {
            foo: 'bar'
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
        "name": "request_parameter_1",
        "description": "Request parameter description",
        "type": "string"
      },
      {
        "name": "request_parameter_2",
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
  icon: 'data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==',
  code: '
    module.exports = async function (req) {
      // Do something with `req.configuration.SERVICE_API_KEY`

      return {
        raw: {
          foo: 'bar',
        }
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
      name: 'request_parameter_1',
      description: 'Request parameter description',
      type: 'string',
    },
    {
      name: 'request_parameter_2',
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
    Icon = "data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",
    Code = @"
      module.exports = async function (req) {
        // Do something with `req.configuration.SERVICE_API_KEY`

        return {
          raw: {
            foo: 'bar'
          }
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
        Name = "request_parameter_1",
        Description = "Request parameter description",
        Type = "string"
      },
      new ReactorFormulaRequestParameter {
        Name = "request_parameter_2",
        Description = "Request parameter description",
        Type = "boolean",
        IsOptional = true
      }
    }
  }
);
```

```python
import basistheory
from basistheory.api import reactor_formulas_api
from basistheory.model.update_reactor_formula_request import UpdateReactorFormulaRequest
from basistheory.model.reactor_formula_configuration import ReactorFormulaConfiguration
from basistheory.model.reactor_formula_request_parameter import ReactorFormulaRequestParameter

with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    reactor_formulas_client = reactor_formulas_api.ReactorFormulasApi(
        api_client)

    reactor_formula = reactor_formulas_client.update("17069df1-80f4-439e-86a7-4121863e4678", update_reactor_formula_request=UpdateReactorFormulaRequest(
        name="My Private Reactor",
        description="Securely exchange token for another token",
        type="private",
        icon="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",
        code=" \
            module.exports = async function (req) { \
                // Do something with `req.configuration.SERVICE_API_KEY`" \

                "return { \
                    raw: { \
                        foo: 'bar' \
                    } \
                }; \
            };",
        configuration=[
            ReactorFormulaConfiguration(
                name="SERVICE_API_KEY",
                description="Configuration description",
                type="string"
            )
        ],
        request_parameters=[
            ReactorFormulaRequestParameter(
                name="request_parameter_1",
                description="Request parameter description",
                type="string"
            ),
            ReactorFormulaRequestParameter(
                name="request_parameter_2",
                description="Request parameter description",
                type="boolean",
                optional=True
            )
        ]
    ))

```

```go
package main

import (
  "context"
  "github.com/Basis-Theory/basistheory-go"
)

func main() {
  configuration := basistheory.NewConfiguration()
  apiClient := basistheory.NewAPIClient(configuration)
  contextWithAPIKey := context.WithValue(context.Background(), basistheory.ContextAPIKeys, map[string]basistheory.APIKey{
    "ApiKey": {Key: "key_N88mVGsp3sCXkykyN2EFED"},
  })

  updateReactorFormulaModel := *basistheory.NewUpdateReactorFormulaModel()
  updateReactorFormulaModel.SetName("My Private Reactor")
  updateReactorFormulaModel.SetDescription("Securely exchange token for another token")
  updateReactorFormulaModel.SetType("private")
  updateReactorFormulaModel.SetIcon("data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==")
  updateReactorFormulaModel.SetCode(`
  	module.exports = async function (req) {
  	  // Do something with req.configuration.SERVICE_API_KEY
  
  	  return {
  		raw: {
  		  foo: 'bar'
  		}
  	  };
  	};
  `)

  var configurations []basistheory.ReactorFormulaConfigurationModel
  reactorFormulaConfiguration := *basistheory.NewReactorFormulaConfigurationModel()
  reactorFormulaConfiguration.SetName("SERVICE_API_KEY")
  reactorFormulaConfiguration.SetDescription("Configuration description")
  reactorFormulaConfiguration.SetType("string")
  configurations = append(configurations, reactorFormulaConfiguration)
  updateReactorFormulaModel.SetConfiguration(configurations)
  var requestParameters []basistheory.ReactorFormulaRequestParameterModel
  reactorFormulaRequestParameter1 := *basistheory.NewReactorFormulaRequestParameterModel()
  reactorFormulaRequestParameter1.SetName("request_parameter_1")
  reactorFormulaRequestParameter1.SetDescription("Request parameter description")
  reactorFormulaRequestParameter1.SetType("string")
  requestParameters = append(requestParameters, reactorFormulaRequestParameter1)
  reactorFormulaRequestParameter2 := *basistheory.NewReactorFormulaRequestParameterModel()
  reactorFormulaRequestParameter2.SetName("request_parameter_2")
  reactorFormulaRequestParameter2.SetDescription("Request parameter description")
  reactorFormulaRequestParameter2.SetType("boolean")
  reactorFormulaRequestParameter2.SetOptional(true)
  requestParameters = append(requestParameters, reactorFormulaRequestParameter2)
  updateReactorFormulaModel.SetRequestParameters(requestParameters)

  reactorFormula, response, err := apiClient.ReactorFormulasApi.ReactorFormulaUpdate(contextWithAPIKey, "17069df1-80f4-439e-86a7-4121863e4678").UpdateReactorFormulaModel(updateReactorFormulaModel).Execute()
}
```

> Response

```json
{
  "id": "17069df1-80f4-439e-86a7-4121863e4678",
  "name": "My Private Reactor",
  "description": "Securely exchange token for another token",
  "type": "private",
  "icon": "data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",
  "code": "
    module.exports = async function (req) {
      // Do something with `req.configuration.SERVICE_API_KEY`

      return {
        raw: {
          foo: 'bar',
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
      "name": "request_parameter_1",
      "description": "Request parameter description",
      "type": "string"
    },
    {
      "name": "request_parameter_2",
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

| Parameter | Required | Type   | Default | Description                   |
|-----------|----------|--------|---------|-------------------------------|
| `id`      | true     | *uuid* | `null`  | The ID of the Reactor Formula |

### Request Parameters

| Attribute            | Required | Type     | Default | Description                                                                                                                                                                       |
|----------------------|----------|----------|---------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `name`               | true     | *string* | `null`  | The name of the Reactor Formula. Has a maximum length of `200`                                                                                                                    |
| `description`        | false    | *string* | `null`  | The description of the Reactor Formula                                                                                                                                            |
| `type`               | true     | *string* | `null`  | [Type](#reactor-reactor-types) of the Reactor Formula                                                                                                                             |
| `icon`               | false    | *string* | `null`  | Base64 [data URL](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs) of the image. Supported image types are: `image/png`, `image/jpg`, and `image/jpeg` |
| `code`               | true     | *string* | `null`  | [Reactor code](#reactor-formulas-reactor-formula-code) which will be executed when the Reactor Formula is processed                                                               |
| `configuration`      | true     | *array*  | `[]`    | Array of [configuration](#reactor-formulas-reactor-formula-configuration) options for configuring a Reactor                                         |
| `request_parameters` | true     | *array*  | `[]`    | Array of [request parameters](#reactor-formulas-reactor-formula-request-parameters) which will be passed when executing the Reactor                  |

### Response

Returns a [Reactor Formula](#reactor-formulas-reactor-formula-object) if the Reactor Formula was updated. Returns [an error](#errors) if there were validation errors, or the Reactor Formula failed to update.


## Delete Reactor Formula

> Request

```shell
curl "https://api.basistheory.com/reactor-formulas/17069df1-80f4-439e-86a7-4121863e4678" \
  -H "BT-API-KEY: key_N88mVGsp3sCXkykyN2EFED" \
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

```python
with basistheory.ApiClient(configuration=basistheory.Configuration(api_key="key_N88mVGsp3sCXkykyN2EFED")) as api_client:
    reactor_formulas_client = reactor_formulas_api.ReactorFormulasApi(
        api_client)
    
    reactor_formulas = reactor_formulas_client.delete("17069df1-80f4-439e-86a7-4121863e4678")
```

```go
package main

import (
  "context"
  "github.com/Basis-Theory/basistheory-go"
)

func main() {
  configuration := basistheory.NewConfiguration()
  apiClient := basistheory.NewAPIClient(configuration)
  contextWithAPIKey := context.WithValue(context.Background(), basistheory.ContextAPIKeys, map[string]basistheory.APIKey{
    "ApiKey": {Key: "key_N88mVGsp3sCXkykyN2EFED"},
  })

  response, err := apiClient.ReactorFormulasApi.ReactorFormulaDelete(contextWithAPIKey, "17069df1-80f4-439e-86a7-4121863e4678").Execute()
}
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

| Parameter | Required | Type   | Default | Description                   |
|-----------|----------|--------|---------|-------------------------------|
| `id`      | true     | *uuid* | `null`  | The ID of the Reactor Formula |

### Response

Returns [an error](#errors) if the Reactor Formula failed to delete.
