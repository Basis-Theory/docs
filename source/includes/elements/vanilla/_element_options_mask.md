## Mask

```tsx
var phoneNumberElement = BasisTheory.createElement('text', {
  targetId: 'myPhoneNumberElement',
  mask: ['(', /\d/, /\d/, /\d/, ')', /\d/, /\d/, /\d/, '-', /\d/, /\d/, /\d/, /\d/]
})
```

Text elements can restrict and fill user input by using the `mask` attribute. It consists of an array of `RegExp`
objects and strings, used to restrict and fill input, respectively. The position of each item in the mask array
corresponds to the restriction or fill used for that input's position. The length of the array determines how long an
input is allowed to be. For example, the mask for a US based phone number shown on the right will have the following
rules:

* The input must be at most 13 characters long
* Only digits are allowed in the 2-4, 6-8, 10-13 positions
* '(' will be filled in the 1 position 
* ')' will be filled in the 5 position
* '-' will be filled in the 8 position

The mask will be displayed as the user is typing, and will be used as the value for [tokenization](#tokenization)
performed with that text element. If the value does not satisfy the mask in its entirety, the field is
considered incomplete. This is reflected in the [on change events](#element-events-on-change) and will fail validation
before [tokenization](#tokenization).

<aside class="notice">
  <span>Once set, we do not currently allow updating the mask. If you need to update the mask programmatically, don't hesitate to <a href="mailto:support@basistheory.com">reach out</a>.</span>
</aside>

<aside class="warning">
  <span>For security and performance reasons, we attempt to detect that the regex provided is valid and not susceptible to catastrophic backtracking. If it fails this validation, we will reject the <a href="#elements-instance-mount-element">mount</a> promise.</span>
</aside>
