# Element Methods

Once you have your [created](#elements-instance-create-element) and [mounted](#elements-instance-mount-element) an element instance, you can invoke the methods below, depending on the element type:

| Name    | Resulting Type | Eligible Elements                                                 | Description                                               |
|---------|----------------|-------------------------------------------------------------------|-----------------------------------------------------------|
| `clear` | *void*         | All                                                               | Clears the element input(s) value.                        |
| `focus`  | *void*        | All                                                               | Focuses on the element input.                             |
| `blur`  | *void*         | All                                                               | Blurs the element input.                                  |
| `month` | *number*       | [cardExpirationDate](#element-types-card-expiration-date-element) | Resolves to the one-based month value of the input date.  |
| `year`  | *number*       | [cardExpirationDate](#element-types-card-expiration-date-element) | Resolves to the four-digit year value of the input date.  |