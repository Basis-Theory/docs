# Hosted Elements

```
  BasisTheory.elements
```

**BasisTheory Hosted Elements** are simple, secure, developer-friendly inputs that empowers consumers to collect sensitive data from their users directly to Basis Theory certified vault.

Think about it as a portal that we open within your site that allows users to seamlessly tokenize information and never notice they are interacting with our technology. Here is how we make it possible:

- We allow you to own your UX, by fully customizing how **hosted elements** will look like;
- Inputs and forms are simple to use, yet we enable you to interact with them similar to how you do with native elements, so you never lose track of your users;

# Install / Initialize

```shell
// checkout other language tabs
```

```html
<script src="https://js.basistheory.com"></script>

<!-- Somewhere in your site code -->
<script>
    window.addEventListener('load', async () => {
      await BasisTheory.init("test_1234567890", { elements: true });
      // use BasisTheory.elements
    });  
</script>
```

```javascript--node
const BasisTheory = require('@Basis-Theory/basis-theory-js');

BasisTheory.init("test_1234567890", { elements: true }).then(() => {
  // use BasisTheory.elements
})
```

```typescript
import BasisTheory from '@Basis-Theory/basis-theory-js';

await BasisTheory.init("test_1234567890", { elements: true });
// use BasisTheory.elements
```
> Make sure to replace `test_1234567890` with your API key.

You don't have to install `Hosted Elements` as a separated module or include additional script tags besides `BasisTheory.js`. It will dynamically load them from `js.basistheory.com`, which enables us to keep the highest compliance standards (e.g. PCI compliance). The only thing you have to worry about is adding `elements: true` in `BasisTheory.init` options parameter.

<aside class="warning">
  Hosted Elements are meant to be used on browser environments only. If you installed <code>BasisTheory.js</code> as a module, make sure the instance that loads elements runs on the browser-side code.
</aside>

See [Basis Theory Initialize](#initialize) for more details.

# Elements instance

## Create Element

```javascript
var cardElement = BasisTheory.elements.create('card');
```

This method returns an instance of an element type.

Parameter | Required | Type     | Description
--------- | -------- | -------- | -----------
`type`    | true     | *'card'* | Type of the element you want to create


<aside class="notice">
  More element types coming soon.
</aside>

# Element instance

## Mount Element

```shell
// checkout html language tab
```

```html
<div id="my-card"></div>

<script>
  cardElement.mount('#my-card')
</script>
```

```javascript--node
// checkout html language tab
```

```typescript
// checkout html language tab
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

# Store Credit Card

```javascript
BasisTheory.elements.storeCreditCard({
  card: cardElement,
  billingDetails: {
    name: 'Fiona Theory'  
  }
}).then((token) => {
  console.log(token.id); // token to store
  console.log(JSON.stringify(token.card)); // redacted card data
});
```

Allows secure submission and tokenization of a card element. Returns a `Promise` that resoles to the tokenized card data. See [CardModel](#cardmodel) for the resolved value type.

Internally, `BasisTheory.elements.storeCreditCard` calls [Create Atomic Card API](#create-atomic-card).

You can fetch this same data later with [Get an Atomic Card API](#get-an-atomic-card).

<aside class="notice">
  Notice that the actual card data never leaves the hosted element (iframe) other than to hit our secure API endpoints. 
</aside>

## storeCreditCard Errors

```javascript
BasisTheory.elements.storeCreditCard(...).catch(error => {
  // handle error
});
```

In case `storeCreditCard` throws an error, that could be related to client-side validation or an unaccepted request from the server.

Attribute    | Type       | Scope  | Description
------------ | ---------- | ------ | -----------
`validation` | *array*    | client | Array of element validation error types, in case of client-side error.
`response`   | *object*   | server | Response body sent from the server.
`status`     | *number*   | both   | Response HTTP status or `-1` if the request never left the client (i.e. connection issues)
