# Transformations

Oftentimes data may be tokenized in one format, but you wish to use this data in a different format within a request.
For example, several pieces of data may be stored together in a complex object such as an Atomic Card token,
but you wish to only use a single piece of that data within a request.

For this purpose, we offer the ability to apply transformation functions to a detokenization expression. 
A token can be transformed by specifying a transformation expression after the `|` symbol:   
`{{ <tokenId> | <transformation> }}`

You can effectively think of this as "piping" the token data into the transformation function in the same way you may be familiar with the "pipe" operator from Unix-like systems.
Multiple transformations can be chained together by "piping" the result of each function into the next, applying in order from left to right:  
`{{ <tokenId> | <transformation1> | <transformation2> | ... }}`

The following sections document the supported library of transformation functions.

## JSON Path Expressions

Complex data is typically tokenized as a JSON object within a token's data. In order to facilitate transformations on this
JSON data, [JSON Path](https://tools.ietf.org/id/draft-goessner-dispatch-jsonpath-00.html) expressions can be applied to a token's data:  
`{{<tokenId> | <jsonPathExpression>}}`

All standard JSON Path syntax is supported, provided that the expression resolves to a single value. 
If the expression resolves to multiple values, the request will result in a 400 error.
If the expression does not resolve to any value, then the expression will resolve to the value `null`.

## Examples

Given a token with the data:

<div class="center-column" style="clear: none;"></div>
```json
{
  "id": "d35412f4-9d3b-45d8-b051-fe4b7d4e14c5",
  "type": "token",
  "data": { 
    "book": [
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

| Expression                                                                                | Result                             |
|-------------------------------------------------------------------------------------------|------------------------------------|
| <code>{{d35412f4-9d3b-45d8-b051-fe4b7d4e14c5 &#124; $.bicycle.color}}</code>              | "red"                              |
| <code>{{d35412f4-9d3b-45d8-b051-fe4b7d4e14c5 &#124; $.bicycle}}</code>                    | { "color": "red", "price": 19.95 } |
| <code>{{d35412f4-9d3b-45d8-b051-fe4b7d4e14c5 &#124; $.book[0]}}.author</code>             | "Herman Melville"                  |
| <code>{{d35412f4-9d3b-45d8-b051-fe4b7d4e14c5 &#124; $.book[(@.price < 10)]}}.title</code> | "Moby Dick"                        |
| <code>{{d35412f4-9d3b-45d8-b051-fe4b7d4e14c5 &#124; $.nonexistent</code>                  | `null`                             |
| <code>{{d35412f4-9d3b-45d8-b051-fe4b7d4e14c5 &#124; $.book..author</code>                 | <400 Error>                        |
