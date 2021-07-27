# Elements Instance

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
`options` | false    | *CreateElementOptions* | [Options](#createelementoptions) for customizing the element

### CreateElementOptions

CreateElementOptions provide a quick way to customize an Element before mounting it to your website.

Attribute | Required | Type           | Description
--------- | -------- | -------------- | -----------
`style`   | false    | *ElementStyle* | [Object](#element-style) used to customize the element appearance

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
