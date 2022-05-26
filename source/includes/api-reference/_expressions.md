# Expressions

Expressions allow you to define custom projections and transformations on token data 
and are based on the [Liquid template language](https://shopify.github.io/liquid).

Expressions are supported within the `search_indexes` property when [creating a token](#tokens-create-token).

In their simplest form, these are expressions of the form `{{ data.<property> }}` where the token's data will be bound to the `data` variable within the expression.

## Filters

Filters allow you to transform data into the format you need, regardless of how it is formatted within your token's data. 
For example, if your token's data contains a card number, you may want to only use the last 4 digits, which is possible using filters.

Filters are functions placed within your expression and are delineated by the pipe character `|`. It is possible to chain multiple filters together, and they are evaluated in order from left to right:
`{{ data.<property> | <filter1> | <filter2> ... }}`.

In addition to the broad list of [filters](https://shopify.github.io/liquid/filters/abs/) supported by Liquid, we provide several custom filters that will allow you to format your data easily.

### last4

Returns the last 4 characters of a string. If the string's length is less than 4, the whole value is returned.

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

### json

Allows formatting JSON data by applying [JSON Path](https://goessner.net/articles/JsonPath/) expressions ([proposed spec](https://tools.ietf.org/id/draft-goessner-dispatch-jsonpath-00.html)).

All standard JSON Path syntax is supported, provided that the expression resolves to a single value.
If the expression resolves to multiple values, the request will result in a 400 error.

While Liquid supports a very similar syntax to JSON path when selecting properties within a JSON object (e.g. `{{ data.bicycle.color }}`),
it does not support more complex JSON Path expressions (e.g. array filter expressions like `$.books[?(@.price < 10)].title`).
The `json` filter provides additional flexibility for evaluating complex JSON Path expressions.

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
 
