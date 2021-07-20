# Elements instance

## Create Element

```javascript
var cardElement = BasisTheory.elements.create('card');
```

This method returns an instance of an element type.

Parameter | Required | Type     | Description
--------- | -------- | -------- | -----------
`type`    | true     | *card*   | Type of the element you want to create


<aside class="notice">
  <span>More element types coming soon.</span>
</aside>

## Mount Element

```html
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

```javascript
cardElement.unmount();
```

Safely removes the element from the DOM, stopping any further communication with it.

## Element Events

```javascript
const subscription = element.on('event-type', (event) => {
  // handle event  
});

// subscription.unsubscribe(); // stops listening to the event type
```
> Make sure to replace 'event-type' with an actual event type.

You can communicate with elements by listening to events. When you subscribe to an event, you'll get back a [Subscription](https://rxjs-dev.firebaseapp.com/guide/subscription) that you can unsubscribe if/when it fits your workflow.

### On Ready

```javascript
element.on('ready', () => {
  // handle ready event 
})
```

This event is triggered when the element has rendered and user is able to start interacting with it.

### On Change

```javascript
element.on('change', (changeEvent) => {
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
`event`   | true     | *'change'* | The event type to listen to.
`handler` | true     | *function* | Callback function to be called when the event is fired. Takes in a [ChangeEvent](#changeevent).

#### ChangeEvent

```json
{
  "complete": false,
  "errors": [
    "invalid-field"
  ]
}
```

Attribute  | Type       | Description
---------- | ---------- | -----------
`complete` | *'change'* | If the element value is well-formed and is ready to be submitted.
`errors`   | *array*    | Array of element validation error types
