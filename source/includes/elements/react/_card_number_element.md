# CardNumberElement

> Using `BasisTheoryProvider`

```tsx
import {
  BasisTheoryProvider,
  CardNumberElement,
  useBasisTheory
} from '@basis-theory/basis-theory-react';

const App = () => {
  // creates a new instance of BasisTheory class
  const { bt } = useBasisTheory('test_1234567890', { elements: true });

  return <BasisTheoryProvider bt={bt}>
    <MyComponent />
  </BasisTheoryProvider>;
}

const MyComponent = () => {
  return <CardNumberElement id="cardNumber" /> ; // Element will grab instance from the Context
}
```


> Using `bt` property

```tsx
import {
  CardNumberElement,
  useBasisTheory
} from '@basis-theory/basis-theory-react';

const MyComponent = () => {
  // creates a new instance of BasisTheory class
  const { bt } = useBasisTheory('test_1234567890', { elements: true });
  
  return <CardNumberElement id="cardNumber" bt={bt} /> ;
}
```

The `CardNumberElement` <a href="https://reactjs.org/docs/components-and-props.html" target="_blank">component</a> features a card number input, by wrapping the [`cardNumber` element type](#element-types-card-number-element) functionality and taking care of the React lifecycle.


| Property       | Required | Type               | Updatable | Description                                                                                                                                                                                                      |
|----------------|----------|--------------------|-----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `id`           | true     | *string*           | false     | String identifier used to retrieve the Element instance for tokenization.<br><i>Note: This is passed through to the `targetId` option.</i>                                                                       |
| `bt`           | false    | *BasisTheoryReact* | false     | [Instance](#basistheoryreact) used by the Element. <br><i>Note: this is not required because Elements are capable of consuming the instance from Context. See [`BasisTheoryProvider`](#basistheoryprovider).</i> |
| `style`        | false    | *object*           | true      | [Object](#element-options-style) used to customize the element appearance                                                                                                                                        |
| `disabled`     | false    | *boolean*          | true      | Boolean used to set the [disabled attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/disabled) of the input(s)                                                                              |
| `autoComplete` | false    | *string*           | true      | String used to set the [autocomplete attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/autocomplete) of the input(s). Expected values are: `off` (default), or `on`.                       |
| `iconPosition` | false    | *string*           | true      | String used to determine the position of the card brand icon. Expected values are: `left` (default), `right` or `none`.                                                                                          |
| `placeholder`  | false    | *string*           | true      | String used to customize the [placeholder attribute](https://developer.mozilla.org/docs/Web/HTML/Element/input#attr-placeholder) of the input                                                                    |
| `aria-label`   | false    | *string*           | true      | String used to customize the [aria-label attribute](https://developer.mozilla.org/docs/Web/Accessibility/ARIA/ARIA_Techniques/Using_the_aria-label_attribute) of the input                                       |
| `onReady`      | false    | *function*         | true      | Event listener. See [On Ready](#element-events-on-ready)                                                                                                                                                         |
| `onChange`     | false    | *function*         | true      | Event listener. See [On Change](#element-events-on-change)                                                                                                                                                       |
| `onFocus`      | false    | *function*         | true      | Event listener. See [On Focus](#element-events-on-focus)                                                                                                                                                         |
| `onBlur`       | false    | *function*         | true      | Event listener. See [On Blur](#element-events-on-blur)                                                                                                                                                           |
| `onKeyDown`    | false    | *function*         | true      | Event listener. See [On Keydown](#element-events-on-keydown)                                                                                                                                                     |
| `ref`          | false    | *object/function*  | false     | [Ref object](https://reactjs.org/docs/refs-and-the-dom.html)/[Callback ref function](https://reactjs.org/docs/refs-and-the-dom.html) to store/receive the Element instance.                             |