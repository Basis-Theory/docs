# CardElement

> Using `BasisTheoryProvider`

```jsx
import {
  BasisTheoryProvider,
  CardElement,
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
  return <CardElement id="myCard" /> ; // Element will grab instance from the Context
}
```


> Using `bt` property

```jsx
import {
  CardElement,
  useBasisTheory
} from '@basis-theory/basis-theory-react';

const MyComponent = () => {
  // creates a new instance of BasisTheory class
  const { bt } = useBasisTheory('test_1234567890', { elements: true });

  return <CardElement id="myCard" bt={bt} /> ;
}
```

`CardElement` <a href="https://reactjs.org/docs/components-and-props.html" target="_blank">component</a> features a full credit card form, wrapping the [card element type](#element-types-card-element) functionality and taking care of the React lifecycle.


| Property    | Required | Type               | Updatable | Description                                                                                                                                                                                                      |
|-------------|----------|--------------------|-----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `id`        | true     | *string*           | false     | String identifier used to retrieve the Element instance for tokenization.                                                                                                                                        |
| `bt`        | false    | *BasisTheoryReact* | false     | [Instance](#basistheoryreact) used by the Element. <br><i>Note: this is not required because Elements are capable of consuming the instance from Context. See [`BasisTheoryProvider`](#basistheoryprovider).</i> |
| `style`     | false    | *ElementStyle*     | true      | [Object](#element-style) used to customize the element appearance                                                                                                                                                |
| `disabled`  | false    | *boolean*          | true      | Boolean used to set the [disabled attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/disabled) of the input(s)                                                                              |
| `onReady`   | false    | *function*         | true      | Event Listener. See [On Ready](#element-events-on-ready)                                                                                                                                                         |
| `onChange`  | false    | *function*         | true      | Event Listener. See [On Change](#element-events-on-change)                                                                                                                                                       |
| `onFocus`   | false    | *function*         | true      | Event Listener. See [On Focus](#element-events-on-focus)                                                                                                                                                         |
| `onBlur`    | false    | *function*         | true      | Event Listener. See [On Blur](#element-events-on-blur)                                                                                                                                                           |
| `onKeyDown` | false    | *function*         | true      | Event Listener. See [On Keydown](#element-events-on-keydown)                                                                                                                                                     |

## Card Brands

The CardElement's `onChange` event will return the brand of the credit card. See the following list for possible values:

| Brand            | Value              |
|------------------|--------------------|
| American Express | `american-express` |
| Diners Club      | `diners-club`      |
| Discover         | `discover`         |
| Elo              | `elo`              |
| Hiper            | `hiper`            |
| HiperCard        | `hipercard`        |
| JCB              | `jcb`              |
| Maestro          | `maestro`          |
| Mastercard       | `mastercard`       |
| MIR              | `mir`              |
| UnionPay         | `unionpay`         |
| Visa             | `visa`             |
| Unknown          | `unknown`          |

<aside class="notice">
  <span>If you don't see the card brand you're looking for, please <a href="mailto:support@basistheory.com?subject=CardElement request card brand" target="_blank">contact us</a>!</span>
</aside>
