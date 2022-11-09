# Element Methods

Once you have [created](#elements-instance-create-element) and [mounted](#elements-instance-mount-element) an element instance, you can invoke the methods below:

| Name      | Resulting Type | Eligible Elements                                                 | Description                                                                                                               |
|-----------|----------------|-------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------|
| `clear`   | *void*         | All                                                               | Clears the element input(s) value.                                                                                        |
| `focus`   | *void*         | All                                                               | Focuses on the element input.                                                                                             |
| `blur`    | *void*         | All                                                               | Blurs the element input.                                                                                                  |
| `month`   | *number*       | [cardExpirationDate](#element-types-card-expiration-date-element) | Data-parsing method that resolves to the one-based month value of the input date.                                         |
| `year`    | *number*       | [cardExpirationDate](#element-types-card-expiration-date-element) | Data-parsing method that resolves to the four-digit year value of the input date.                                         |
| `setValue`| *void*         | All                                                               | Accepts a [`DataElementReference`](#data-element-reference) from a retrieved token and safely sets it as the input value. |

### Data Element Reference

During Elements initialization, an internal `iframe` is created and attached to the client window.
This Element is responsible for retrieving tokens and storing the returned token data, while providing a reference to it in the form of a `DataElementReference`.

The values provided by the `DataElementReference` returned are used on the `setValue` method to find the referenced plain token data and set them onto the input. 

See below the attributes that make up the `DataElementRefence`:

Attribute       | Type                   | Description
--------------- | ---------------------- | -----------
`correlationId` | *string*               | Identifier that correlates values from the same `retrieve` response together
`elementId`     | *string*               | Identifier for the internal `DataElement` iframe
`path`          | *string*               | Path for the different nested objects inside of `data` in the retrieved token 