# Filters

Oftentimes data may be tokenized in one format, but you wish to use this data in a different format within a request.
Several pieces of data may be stored together in a single token (e.g. a user record containing first and last names and contact information), 
but you wish to only use a single piece of that data within a Proxy or Reactor request, 
or you may wish to reformat the data before indexing it for search (e.g. use only the last name, but normalize by uppercasing it).

To allow you complete flexibility, transformation functions called **filters** can be applied within any expression. 
Generally, a variable's value can be transformed by specifying a filter after the `|` symbol:   
`{{ <variable> | <filter> }}`

You can effectively think of this as "piping" a variable into the filter in the same way you may be familiar with the "pipe" operator from Unix-like systems.
Multiple filters can be chained together by "piping" the result of each filter into the next, applying in order from left to right:  
`{{ <variable> | <filter1> | <filter2> | ... }}`

All standard [Liquid filters](https://shopify.github.io/liquid/filters/) are supported within expressions. 
For example, given a token containing a `name` object containing both first and last name properties:

<div class="center-column" style="clear: none;"></div>
```json
{
  "data": {
    "name": "John Doe"
  },
  ...
}
```

We can create an expression to return the upper-cased last name by splitting on the space character, grabbing the last element, and upper-casing:

<div class="center-column" style="clear: none;"></div>
```js
{{ data.name | split: ' ' | last | upcase }}
```

This expression would evaluate to the value `"DOE"`.

In addition to the standard Liquid filters, several custom filters are also available:



## json

Evaluates a [JSON Path](https://goessner.net/articles/JsonPath/) expression ([proposed spec](https://tools.ietf.org/id/draft-goessner-dispatch-jsonpath-00.html)) on the input object.

All standard JSON Path syntax is supported, provided that the expression resolves to a single value.
If the expression resolves to multiple values, the request will result in a 400 error.

While Liquid supports a very similar syntax to JSON path when selecting properties within a JSON object (e.g. `{{ data.bicycle.color }}`),
it does not support more complex JSON Path expressions (e.g. array filter expressions like `$.books[?(@.price < 10)].title`).
The `json` filter provides further flexibility for evaluating complex JSON Path expressions.

### Parameters

| Position | Name               | Type     | Required | Description            |
|----------|--------------------|----------|----------|------------------------|
| 0        | jsonPathExpression | *string* | true     | A JSON Path expression |

### Examples

Given a token with the data:

<div class="center-column" style="clear: none;"></div>
```json
{
  "id": "d35412f4-9d3b-45d8-b051-fe4b7d4e14c5",
  "type": "token",
  "data": { 
    "books": [
      { 
        "category": "fiction",
        "author": "Herman Melville",
        "title": "Moby Dick",
        "isbn": "0-553-21311-3",
        "price": 8.99
      },
      { 
        "category": "fantasy",
        "author": "J. R. R. Tolkien",
        "title": "The Lord of the Rings",
        "isbn": "0-395-19395-8",
        "price": 22.99
      }
    ],
    "bicycle": {
      "color": "red",
      "price": 19.95
    }
  }
}
```

| Expression                                                            | Result                             |
|-----------------------------------------------------------------------|------------------------------------|
| <code>{{ data.bicycle.color }}</code>                                 | "red"                              |
| <code>{{ data &#124; json: '$.bicycle.color' }}</code>                | "red"                              |
| <code>{{ data.bicycle }}</code>                                       | { "color": "red", "price": 19.95 } |
| <code>{{ data &#124; json: '$.books[0].author' }}</code>              | "Herman Melville"                  |
| <code>{{ data &#124; json: '$.books[?(@.price < 10)].title' }}</code> | "Moby Dick"                        |
| <code>{{ data.nonexistent }}</code>                                   | `null`                             |
| <code>{{ data &#124; json: '$.book..author' }}</code>                 | <400 Error>                        |


## last4

Returns the last 4 characters of a string. If the string's length is less than 4, the whole value is returned.

### Parameters

N/A

### Examples

Given a token with the data:

<div class="center-column" style="clear: none;"></div>
```json
{
  "id": "d35412f4-9d3b-45d8-b051-fe4b7d4e14c5",
  "type": "token",
  "data": "36227206271667"
}
```

| Expression                                               | Result |
|----------------------------------------------------------|--------|
| <code>{{ data &#124; last4 }}</code>                     | "1667" |
| <code>{{ data &#124; slice: 12, 2 &#124; last4 }}</code> | "67"   |

## pad_left

Returns a new string of the desired length by padding the input string on the left with the specified `padChar`.

Returns null when provided a null input value.

### Parameters

| Position | Name    | Type   | Required | Description                                      |
|----------|---------|--------|----------|--------------------------------------------------|
| 0        | length  | *int*  | true     | The number of characters in the resulting string |
| 1        | padChar | *char* | true     | A padding character                              |

### Examples

Given a token with the data:

<div class="center-column" style="clear: none;"></div>
```json
{
  "id": "d35412f4-9d3b-45d8-b051-fe4b7d4e14c5",
  "type": "token",
  "data": "1234"
}
```

| Expression                                      | Result   |
|-------------------------------------------------|----------|
| <code>{{ data &#124; pad_left: 6, '0' }}</code> | "001234" |
| <code>{{ data &#124; pad_left: 6, 'X' }}</code> | "XX1234" |
| <code>{{ data &#124; pad_left: 4, '0' }}</code> | "1234"   |
| <code>{{ data &#124; pad_left: 2, '0' }}</code> | "1234"   |

## pad_right

Returns a new string of the desired length by padding the input string on the right with the specified `padChar`.

Returns null when provided a null input value.

### Parameters

| Position | Name    | Type   | Required | Description                                      |
|----------|---------|--------|----------|--------------------------------------------------|
| 0        | length  | *int*  | true     | The number of characters in the resulting string |
| 1        | padChar | *char* | true     | A padding character                              |

### Examples

Given a token with the data:

<div class="center-column" style="clear: none;"></div>
```json
{
  "id": "d35412f4-9d3b-45d8-b051-fe4b7d4e14c5",
  "type": "token",
  "data": "1234"
}
```

| Expression                                      | Result   |
|-------------------------------------------------|----------|
| <code>{{ data &#124; pad_right: 6, '0' }}</code> | "123400" |
| <code>{{ data &#124; pad_right: 6, 'X' }}</code> | "1234XX" |
| <code>{{ data &#124; pad_right: 4, '0' }}</code> | "1234"   |
| <code>{{ data &#124; pad_right: 2, '0' }}</code> | "1234"   |
