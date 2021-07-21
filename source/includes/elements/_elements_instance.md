# Elements instance

```jsx
BasisTheory.elements
```

After [initialization](#initialize), **Elements** are available through `BasisTheory` instance. 

## Create Element

```jsx
var cardElement = BasisTheory.elements.create('card', options);
```

This method returns a new instance of an element type.

Parameter | Required | Type                   | Description
--------- | -------- | ----------------       | -----------
`type`    | true     | *string*               | [Type](#element-types) of the element you want to create
`options` | false    | *CreateElementOptions* | [Options](#createlementoptions) for customizing the element

### Element Types

Type      | Input(s) | Description
--------- | -------- | -----------
`card`    | *cardNumber*, *expirationDate* and *cvc* | Fully featured credit card input


<aside class="notice">
  <span>More element types coming soon.</span>
</aside>

### CreateElementOptions

CreateElementOptions provide a quick way to customize an Element before mounting it to your website.

Attribute | Required | Type           | Description
--------- | -------- | -------------- | -----------
`style`   | false    | *ElementStyle* | [Object](#elementstyle) used to customize the element appearance

## Mount Element

```jsx
<div id="my-card"></div>

<script>
  cardElement.mount('#my-card')
</script>
```

This method attaches the element to the DOM, under a specific container.

Parameter  | Required | Type     | Description
---------- | -------- | -------- | -----------
`selector` | true     | *string* | CSS selector that matches the container where your element will be mounted

## Unmount Element

```jsx
cardElement.unmount();
```

Safely removes the element from the DOM, stopping any further communication with it.

## Element Events

```jsx
var subscription = cardElement.on('event-type', (event) => {
  // handle event  
});

subscription.unsubscribe(); // stops listening to the event type
```

You can communicate with elements by listening to events. When you subscribe to an event, you'll get back a <a href="https://rxjs.dev/guide/subscription" target="_blank">Subscription</a> that you can unsubscribe if/when it fits your workflow.

<aside class="notice">
  <span>Make sure to replace 'event-type' with an actual event type.</span>
</aside>


### On Ready

> On Ready

```jsx
cardElement.on('ready', () => {
  // handle ready event 
})
```

This event is triggered when the element has rendered and user is able to start interacting with it.

### On Change

> On Change

```jsx
cardElement.on('change', (changeEvent) => {
  if (changeEvent.complete) {
    // enable submit button  
  } else {
    // disable submit button
    // present validation message
  }
})
```

This event is triggered whenever element's value(s) relevantly change. For example, if the user types data that doesn't change the state of a field between valid/invalid or empty/filled, you shouldn't expect the event to trigger.

Parameter | Required | Type       | Description
--------- | -------- | ---------- | -----------
`event`   | true     | *"change"* | The event type to listen to.
`handler` | true     | *function* | Callback function to be called when the event is fired. Takes in a [ChangeEvent](#changeevent).

#### ChangeEvent

> ChangeEvent example

```jsx
{
  "complete": false,
  "errors": [
    "invalid-field"
  ]
}
```

Attribute  | Type       | Description
---------- | ---------- | -----------
`complete` | *boolean*  | If the element value is well-formed and is ready to be submitted.
`errors`   | *array*    | Array of element validation error types.


### On Focus

> On Focus

```jsx
cardElement.on('focus', (focusEvent) => {
  
})
```

Triggered when an element input is focused.

Parameter | Required | Type       | Description
--------- | -------- | ---------- | -----------
`event`   | true     | *"focus"* | The event type to listen to.
`handler` | true     | *function* | Callback function to be called when the event is fired. Takes in a [FocusEvent](#focusevent).

#### FocusEvent

> FocusEvent example

```jsx
{
  "id": "cardNumber"  
}
```

Attribute  | Type       | Description
---------- | ---------- | -----------
`id`       | *string*   | Input id that triggered the event. Values vary per [element type](#element-type). 

### On Blur

> On Blur

```jsx
cardElement.on('blur', (blurEvent) => {
  
})
```

Triggered when an element input focus is lost.

Parameter | Required | Type       | Description
--------- | -------- | ---------- | -----------
`event`   | true     | *"blur"* | The event type to listen to.
`handler` | true     | *function* | Callback function to be called when the event is fired. Takes in a [BlurEvent](#blurevent).

#### BlurEvent

> BlurEvent example

```jsx
{
  "id": "cardNumber"  
}
```

Attribute  | Type       | Description
---------- | ---------- | -----------
`id`       | *string*   | Input id that triggered the event. Values vary per [element type](#element-type).

### On Keydown

> On Keydown

```jsx
cardElement.on('keydown', (keydownEvent) => {
  
})
```

Triggered when user hits a special key inside an element input.

Parameter | Required | Type       | Description
--------- | -------- | ---------- | -----------
`event`   | true     | *"keydown"* | The event type to listen to.
`handler` | true     | *function* | Callback function to be called when the event is fired. Takes in a [KeydownEvent](#keydownevent).

#### KeydownEvent

> KeydownEvent example

```jsx
{
  "id": "cardNumber",
  "key": "Enter",
  "ctrlKey": false,
  "altKey": false,
  "shiftKey": false,
  "metaKey": false
}
```

Attribute  | Type                  | Description
---------- | ----------            | -----------
`id`       | *string*              | Input id that triggered the event. Values vary per [element type](#element-type).
`key`      | *Escape* or *Enter*   | Key pressed by the user.
`ctrlKey`  | *boolean*             | Flag indicating [`control` key](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/ctrlKey) was pressed when the event occurred.
`altKey`   | *boolean*             | Flag indicating [`alt` key](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/altKey) was pressed when the event occurred.
`shiftKey` | *boolean*             | Flag indicating [`shift` key](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/shiftKey) was pressed when the event occurred.
`metaKey` | *boolean*             | Flag indicating [`meta` key](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/metaKey) was pressed when the event occurred.


## ElementStyle

```jsx
var cardElement = BasisTheory.elements.create('card', {
  style: {
    fonts: [
      "https://fonts.googleapis.com/css2?family=Source+Sans+Pro:ital,wght@0,200;0,300;0,400;0,600;0,700;0,900;1,200;1,300;1,400;1,600;1,700;1,900&display=swap"
    ],
    base: {
      color: "#fff",
      fontWeight: 500,
      fontFamily: "'Source Sans Pro'",
      fontSize: "16px",
      fontSmooth: "antialiased",
      "::placeholder": {
        color: "#6b7294"
      },
      invalid: {
        color: "#ffc7ee"
      },
      complete: {
        color: "#1ad1db"
      }
    }
  }
})
```

Elements are styled through the `ElementStyle` object, which maps state variants and miscellaneous.

Attribute  | Required | Type                   | Description
---------- | -------- | ----------------       | -----------
`fonts`    | false    | *array*                | Array of [Google Fonts](https://fonts.google.com/) URLs
`base`     | false    | *object*               | Base variant style - all other variant styles inherit from this one
`complete` | false    | *object*               | Variant style applied when the element input has valid value
`empty`    | false    | *object*               | Variant style applied when the element input has no value
`invalid`  | false    | *object*               | Variant style applied when the element input has invalid value

You can customize the following pseudo-classes and pseudo-elements inside each variant using a nested object:

- `:hover`
- `:focus`
- `::placeholder`
- `::selection`

Here is a complete list of the supported CSS properties:

- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/background-color" target="_blank">backgroundColor</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/color" target="_blank">color</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/font-family" target="_blank">fontFamily</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/font-size" target="_blank">fontSize</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/font-smooth" target="_blank">fontSmooth</a> (we replace this with the user-agent alternate names automatically)
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/font-style" target="_blank">fontStyle</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/font-variant" target="_blank">fontVariant</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/font-weight" target="_blank">fontWeight</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/line-height" target="_blank">lineHeight</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/letter-spacing" target="_blank">letterSpacing</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/text-align" target="_blank">textAlign</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/padding" target="_blank">padding</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration" target="_blank">textDecoration</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/text-shadow" target="_blank">textShadow</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/text-transform" target="_blank">textTransform</a>


<aside class="notice">
  <span>Variants are resolved per element input. In other words, variant styles will be applied on each element input individually based on their own value.</span>
</aside>

<aside class="warning">
  <span>For security reasons, we currently support only the 1000+ Google Fonts families. If you need a custom font in your <strong>Basis Theory Elements</strong>, don't hesitate to <a href="mailto:support@basistheory.com">reach out</a>.</span>
</aside>
