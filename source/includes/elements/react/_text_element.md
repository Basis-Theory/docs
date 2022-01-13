# TextElement

```jsx
import {
  TextElement
} from '@basis-theory/basis-theory-react/elements';

const MyForm = () => {  
  return <TextElement id="myInput" />;
}
```

`TextElement` <a href="https://reactjs.org/docs/components-and-props.html" target="_blank">component</a> features a regular text input for collecting any input data, by wrapping the [text element type](#element-types-text-element) functionality and taking care of the React lifecycle.


Property      | Required | Type                 | Updatable | Description
------------- | -------- | -------------------- | --------- | -----------
`id`          | true     | *string*             | false     | String identifier used to retrieve the Element instance for tokenization.<br><i>Note: This is passed through to the `targetId` option.</i>
`style`       | false    | *ElementStyle*       | true      | [Object](#element-style) used to customize the element appearance
`disabled`    | false    | *boolean*            | true      | Boolean used to set the [disabled attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/disabled) of the input(s)
`mask`        | false    | *ElementMask*        | false     | [Array](#element-mask) used to restrict and fill user input using regex and static strings
`transform`   | false    | *ElementTransform*   | true      | `RegExp` object or [array](#element-transform) used to modify user input before sending input to any [services](#elements-services)
`placeholder` | false    | *string*             | true      | String used to customize the [placeholder attribute](https://developer.mozilla.org/docs/Web/HTML/Element/input#attr-placeholder) of the input
`aria-label`  | false    | *string*             | true      | String used to customize the [aria-label attribute](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/ARIA_Techniques/Using_the_aria-label_attribute) of the input
`password`    | false    | *boolean*            | true      | Boolean used to set the text element input type as [password](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/password)
`bt`          | false    | *BasisTheory*        | false     | The `BasisTheory` instance used by the Element. <br><i>Note: this is not required because Elements are capable of consuming the instance from Context. See [`BasisTheoryProvider`](#basistheoryprovider).</i> 
`onReady`     | false    | *function*           | true      | Event listener. See [On Ready](#element-events-on-ready)
`onChange`    | false    | *function*           | true      | Event listener. See [On Change](#element-events-on-change)
`onFocus`     | false    | *function*           | true      | Event listener. See [On Focus](#element-events-on-focus)
`onBlur`      | false    | *function*           | true      | Event listener. See [On Blur](#element-events-on-blur)
`onKeyDown`   | false    | *function*           | true      | Event listener. See [On Keydown](#element-events-on-keydown)
