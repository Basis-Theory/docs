# CardElement

```jsx
import {
  CardElement
} from '@basis-theory/basis-theory-react/elements';

const MyForm = () => {  
  return <CardElement id="myCard" />;
}
```

`CardElement` <a href="https://reactjs.org/docs/components-and-props.html" target="_blank">component</a> features a full credit card collector, by wrapping the [card element type](#element-types-card-element) functionality and taking care of its lifecycle.


Property    | Required | Type           | Updatable | Description
----------- | -------- | -------------- | --------- | -----------
`id`        | true     | *string*       | false     |String identifier used to retrieve the Element instance for tokenization.
`style`     | false    | *ElementStyle* | true      | [Object](#element-style) used to customize the element appearance
`disabled`  | false    | *boolean*      | true      | Boolean used to set the [disabled attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/disabled) of the input(s)
`bt`        | false    | *BasisTheory*  | false     | The `BasisTheory` instance used by the Element. <br><i>Note: this is not required because Elements are capable of consuming the instance from Context. See [`BasisTheoryProvider`](#basistheoryprovider).</i>
`onReady`   | false    | *function*     | true      | Event Listener. See [On Ready](#element-events-on-ready)
`onChange`  | false    | *function*     | true      | Event Listener. See [On Change](#element-events-on-change)
`onFocus`   | false    | *function*     | true      | Event Listener. See [On Focus](#element-events-on-focus)
`onBlur`    | false    | *function*     | true      | Event Listener. See [On Blur](#element-events-on-blur)
`onKeyDown` | false    | *function*     | true      | Event Listener. See [On Keydown](#element-events-on-keydown)
