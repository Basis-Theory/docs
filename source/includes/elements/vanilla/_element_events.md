# Element Events

```tsx
var subscription = cardElement.on('event-type', (event) => {
  // handle event  
});

subscription.unsubscribe(); // stops listening to the event type
```

You can communicate with Elements by listening to events. When you subscribe to an event, you'll get back a <a href="https://rxjs.dev/guide/subscription" target="_blank">Subscription</a> that you can unsubscribe if/when it fits your workflow.

<aside class="notice">
  <span>Make sure to replace 'event-type' with an actual event type.</span>
</aside>

<aside class="warning">
  <span>Calling <code>on</code> using an unknown <code>event</code> type will result in an error.</span>
</aside>

## On Ready

```tsx
cardElement.on('ready', () => {
  // handle ready event 
})
```

This event is triggered when the element has rendered and user is able to start interacting with it.

## On Change

```tsx
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

| Parameter | Required | Type       | Description                                                                                                              |
|-----------|----------|------------|--------------------------------------------------------------------------------------------------------------------------|
| `event`   | true     | *"change"* | The event type to listen to.                                                                                             |
| `handler` | true     | *function* | Callback function to be called when the event is fired. Takes in a [ChangeEvent](#element-events-on-change-changeevent). |

### ChangeEvent

```tsx
{
  "complete": false,
  "empty": false,
  "errors": [
    {...},
    {...}
  ],
  "cardBrand": "american-express"
}
```

| Attribute   | Type      | Eligible Elements                                                                       | Description                                                                                                                                                                              |
|-------------|-----------|-----------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `complete`  | *boolean* | All                                                                                     | If the element value is well-formed and is ready to be submitted.                                                                                                                        |
| `empty`     | *boolean* | All                                                                                     | Whether the element is empty. Multi-input Elements will be `empty` only if all inputs are.                                                                                               |
| `errors`    | *array*   | All                                                                                     | Array of [FieldError](#element-events-on-change-fielderror).                                                                                                                             |
| `cardBrand` | *string*  | [card](#element-types-card-element)<br>[cardNumber](#element-types-card-number-element) | (Optional) The credit card [brand](#element-options-card-brands) (e.g. `'american-express'`, `'visa'`, `'unknown'`). The value defaults to `'unknown'` until a card brand is recognized. |

### FieldError

```tsx
{
  "targetId": "cardNumber",
  "type": "invalid"
}
```

| Attribute  | Type                          | Description                                                                        |
|------------|-------------------------------|------------------------------------------------------------------------------------|
| `targetId` | *string*                      | Input id that triggered the error. Values vary per [element type](#element-types). |
| `type`     | *"invalid"* or *"incomplete"* | Type of the error.                                                                 |

## On Focus

```tsx
cardElement.on('focus', (focusEvent) => {
  
})
```

Triggered when an element input is focused.

| Parameter | Required | Type       | Description                                                                                                           |
|-----------|----------|------------|-----------------------------------------------------------------------------------------------------------------------|
| `event`   | true     | *"focus"*  | The event type to listen to.                                                                                          |
| `handler` | true     | *function* | Callback function to be called when the event is fired. Takes in a [FocusEvent](#element-events-on-focus-focusevent). |

### FocusEvent

```tsx
{
  "targetId": "cardNumber"  
}
```

| Attribute  | Type     | Description                                                                        |
|------------|----------|------------------------------------------------------------------------------------|
| `targetId` | *string* | Input id that triggered the event. Values vary per [element type](#element-types). |

## On Blur

```tsx
cardElement.on('blur', (blurEvent) => {
  
})
```

Triggered when an element input focus is lost.

| Parameter | Required | Type       | Description                                                                                                        |
|-----------|----------|------------|--------------------------------------------------------------------------------------------------------------------|
| `event`   | true     | *"blur"*   | The event type to listen to.                                                                                       |
| `handler` | true     | *function* | Callback function to be called when the event is fired. Takes in a [BlurEvent](#element-events-on-blur-blurevent). |

### BlurEvent

```tsx
{
  "targetId": "cardNumber"  
}
```

| Attribute  | Type     | Description                                                                        |
|------------|----------|------------------------------------------------------------------------------------|
| `targetId` | *string* | Input id that triggered the event. Values vary per [element type](#element-types). |

## On Keydown

```tsx
cardElement.on('keydown', (keydownEvent) => {
  
})
```

Triggered when user hits a special key inside an element input.

| Parameter | Required | Type        | Description                                                                                                                 |
|-----------|----------|-------------|-----------------------------------------------------------------------------------------------------------------------------|
| `event`   | true     | *"keydown"* | The event type to listen to.                                                                                                |
| `handler` | true     | *function*  | Callback function to be called when the event is fired. Takes in a [KeydownEvent](#element-events-on-keydown-keydownevent). |

### KeydownEvent

```tsx
{
  "targetId": "cardNumber",
  "key": "Enter",
  "ctrlKey": false,
  "altKey": false,
  "shiftKey": false,
  "metaKey": false
}
```

| Attribute  | Type                | Description                                                                                                                                                             |
|------------|---------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `targetId` | *string*            | Input targetId that triggered the event. Values vary per [element type](#element-types).                                                                                |
| `key`      | *Escape* or *Enter* | Key pressed by the user.                                                                                                                                                |
| `ctrlKey`  | *boolean*           | Flag indicating <a href="https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/ctrlKey" target="_blank">`control` key</a> was pressed when the event occurred. |
| `altKey`   | *boolean*           | Flag indicating <a href="https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/altKey" target="_blank">`alt` key</a> was pressed when the event occurred.      |
| `shiftKey` | *boolean*           | Flag indicating <a href="https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/shiftKey" target="_blank">`shift` key</a> was pressed when the event occurred.  |
| `metaKey`  | *boolean*           | Flag indicating <a href="https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/metaKey" target="_blank">`meta` key</a> was pressed when the event occurred.    |
