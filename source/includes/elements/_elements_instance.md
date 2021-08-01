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

<aside class="warning">
  <span>Unknown <code>type</code> values will throw an error.</span>
</aside>

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

<aside class="warning">
  <span>Multiple calls to <code>element.mount</code> will result in an error.</span>
</aside>

<aside class="warning">
  <span>If the application key used to initialize `BasisTheory` doesn't exist or doesn't have the required <a href="#permissions">permissions</a>, an error will be thrown by this method.</span>
</aside>

## Update Element

```jsx
cardElement.update(options);
```

Updates the element options the element was initialized with. The values are deep-merged into the previous options.

Parameter | Required | Type                   | Description
--------- | -------- | ----------------       | -----------
`options` | false    | *UpdateElementOptions* | [Options](#updateelementoptions) for customizing the element


### UpdateElementOptions

UpdateElementOptions provide a quick way to change an existing (mounted) Element appearance.

Attribute | Required | Type           | Description
--------- | -------- | -------------- | -----------
`style`   | false    | *ElementStyle* | [Object](#element-style) used to customize the element appearance


## Unmount Element

```jsx
cardElement.unmount();
```

Safely removes the element from the DOM, stopping any further communication with it.

<aside class="warning">
  <span>Trying to mount an element that has been unmounted will result in an error.</span>
</aside>
