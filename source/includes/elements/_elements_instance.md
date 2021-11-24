# Elements Instance

```jsx
BasisTheory.elements
```

After [initialization](#initialize), **Elements** are available through `BasisTheory` instance.

## Create Element

```jsx
var cardElement = BasisTheory.elements.create('card', options);

var textElement = BasisTheory.elements.create('text', { targetId: 'myInputId' });
```

This method returns a new instance of an element type.

Parameter | Required | Type                   | Description
--------- | -------- | ----------------       | -----------
`type`    | true     | *string*               | [Type](#element-types) of the element you want to create
`options` | false    | *CreateElementOptions* | [Options](#elements-instance-create-element-create-element-options) for customizing the element

<aside class="warning">
  <span>Unknown <code>type</code> values will throw an error.</span>
</aside>

### Create Element Options

CreateElementOptions provide a quick way to customize an Element before mounting it to your website.

Attribute     | Required | Type                 | Eligible Elements                          | Description
------------- | -------- | -------------------- | ------------------------------------------ | -----------
`style`       | false    | *ElementStyle*       | All                                        | [Object](#element-style) used to customize the element appearance
`targetId`    | true     | *string*             | [TextElement](#element-types-text-element) | String used to identify your element
`mask`        | false    | *ElementMask*        | [TextElement](#element-types-text-element) | [Array](#element-mask) used to restrict and fill user input using regex and static strings
`transform`   | false    | *ElementTransform*   | [TextElement](#element-types-text-element) | `RegExp` object or [array](#element-transform) used to modify user input before sending input to any [services](#elements-services)
`placeholder` | false    | *string*             | [TextElement](#element-types-text-element) | String used to customize the [placeholder attribute](https://developer.mozilla.org/docs/Web/HTML/Element/input#attr-placeholder) of the input

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
  <span>If the Application key used to initialize `BasisTheory` doesn't exist or doesn't have the required <a href="#permissions">permissions</a>, an error will be thrown by this method.</span>
</aside>

## Update Element

```jsx
cardElement.update(options);
```

Updates the element options the element was initialized with. The values are merged into the previous options.

Parameter | Required | Type                   | Description
--------- | -------- | ----------------       | -----------
`options` | false    | *UpdateElementOptions* | [Options](#elements-instance-update-element-updateelementoptions) for customizing the element


### UpdateElementOptions

UpdateElementOptions provide a quick way to change an existing (mounted) Element's appearance and functionality.

Attribute     | Required | Type                 | Eligible elements                           | Description
------------- | -------- | -------------------- | ------------------------------------------- | -----------
`style`       | false    | *ElementStyle*       | All                                         | [Object](#element-style) used to customize the element appearance
`placeholder` | false    | *string*             | [TextElement](#element-types-text-element)  | String used to customize the [placeholder attribute](https://developer.mozilla.org/docs/Web/HTML/Element/input#attr-placeholder) of the input
`transform`   | false    | *ElementTransform*   | [TextElement](#element-types-text-element)  | `RegExp` object or [array](#element-transform) used to modify user input before sending input to any [services](#elements-services)


## Clear Element

```jsx
cardElement.clear();
```

Clears the element input values.

## Unmount Element

```jsx
cardElement.unmount();
```

Safely removes the element from the DOM, stopping any further communication with it.

<aside class="warning">
  <span>Trying to mount an element that has been unmounted will result in an error.</span>
</aside>
