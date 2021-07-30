# Element Events

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


## On Ready

```jsx
cardElement.on('ready', () => {
  // handle ready event 
})
```

This event is triggered when the element has rendered and user is able to start interacting with it.

## On Change

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

This event is triggered whenever element's value(s) change. For example, if the user types data that doesn't change the state of a field between valid/invalid or empty/filled, you shouldn't expect the event to trigger.

Parameter | Required | Type       | Description
--------- | -------- | ---------- | -----------
`event`   | true     | *"change"* | The event type to listen to.
`handler` | true     | *function* | Callback function to be called when the event is fired. Takes in a [ChangeEvent](#changeevent).

### ChangeEvent

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


## On Focus

```jsx
cardElement.on('focus', (focusEvent) => {
  
})
```

Triggered when an element input is focused.

Parameter | Required | Type       | Description
--------- | -------- | ---------- | -----------
`event`   | true     | *"focus"* | The event type to listen to.
`handler` | true     | *function* | Callback function to be called when the event is fired. Takes in a [FocusEvent](#focusevent).

### FocusEvent

```jsx
{
  "id": "cardNumber"  
}
```

Attribute  | Type       | Description
---------- | ---------- | -----------
`id`       | *string*   | Input id that triggered the event. Values vary per [element type](#element-types).

## On Blur

```jsx
cardElement.on('blur', (blurEvent) => {
  
})
```

Triggered when an element input focus is lost.

Parameter | Required | Type       | Description
--------- | -------- | ---------- | -----------
`event`   | true     | *"blur"* | The event type to listen to.
`handler` | true     | *function* | Callback function to be called when the event is fired. Takes in a [BlurEvent](#blurevent).

### BlurEvent

```jsx
{
  "id": "cardNumber"  
}
```

Attribute  | Type       | Description
---------- | ---------- | -----------
`id`       | *string*   | Input id that triggered the event. Values vary per [element type](#element-types).

## On Keydown

```jsx
cardElement.on('keydown', (keydownEvent) => {
  
})
```

Triggered when user hits a special key inside an element input.

Parameter | Required | Type       | Description
--------- | -------- | ---------- | -----------
`event`   | true     | *"keydown"* | The event type to listen to.
`handler` | true     | *function* | Callback function to be called when the event is fired. Takes in a [KeydownEvent](#keydownevent).

### KeydownEvent

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
`id`       | *string*              | Input id that triggered the event. Values vary per [element type](#element-types).
`key`      | *Escape* or *Enter*   | Key pressed by the user.
`ctrlKey`  | *boolean*             | Flag indicating <a href="https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/ctrlKey" target="_blank">`control` key</a> was pressed when the event occurred.
`altKey`   | *boolean*             | Flag indicating <a href="https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/altKey" target="_blank">`alt` key</a> was pressed when the event occurred.
`shiftKey` | *boolean*             | Flag indicating <a href="https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/shiftKey" target="_blank">`shift` key</a> was pressed when the event occurred.
`metaKey` | *boolean*             | Flag indicating <a href="https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/metaKey" target="_blank">`meta` key</a> was pressed when the event occurred.