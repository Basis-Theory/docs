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



### json


