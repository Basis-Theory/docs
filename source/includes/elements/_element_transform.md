# Element Transform

```jsx
var phoneNumberElement = BasisTheory.elements.create('text', {
  targetId: 'myPhoneNumberElement',
  mask: ['(', /\d/, /\d/, /\d/, ')', /\d/, /\d/, /\d/, '-', /\d/, /\d/, /\d/, /\d/],
  transform: /[()-]/,
})
```

Text elements allow you to modify user input before sending it to any [services](#elements-services) through the
`transform` attribute. It can be set as a `RegExp` object, an array with a `RegExp` object, or an array with a `RegExp`
object at the first index and a string at the second. It works by making use of the [String replace](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/replace)
function. The `RegExp` object and string defined will be used as the first and second argument for the `replace` function,
respectively. If no string is defined, an empty string will be used as the second argument. For instance, the mask for a
US based phone number shown on the right will modify user input to look like this: `(123)456-7890`. The `transform`
attribute, in this case, will modify the user input to remove `(`, `)`, and `-` from the input. The resulting value is
`1234567890` which will be what gets sent to any [services](#elements-services).

<aside class="notice">
  <span>We strip all <code>RegExp</code> object flags defined in the <code>transform</code> and set <code>gu</code> as the flags.</span>
</aside>

<aside class="warning">
  <span>For security and performance reasons, we attempt to detect that the regex provided is valid and not susceptible to catastrophic backtracking. If it fails this validation, we will reject the <a href="#elements-instance-mount-element">mount</a> or <a href="#elements-instance-update-element">update</a> promise.</span>
</aside>
