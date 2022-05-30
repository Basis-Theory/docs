# Elements Instance

After [initialization](#initialize), **Elements** are available through `BasisTheory` instance.

## Create Element

```jsx
var cardElement = BasisTheory.createElement('card', options);

var textElement = BasisTheory.createElement('text', { targetId: 'myInputId', ...options });
```

This lifecycle method returns a new instance of an element type.

| Parameter | Required | Type     | Description                                              |
|-----------|----------|----------|----------------------------------------------------------|
| `type`    | true     | *string* | [Type](#element-types) of the element you want to create |
| `options` | false    | *object* | [Options](#element-options) for customizing the element  |

<aside class="warning">
  <span>Unknown <code>type</code> values will throw an error.</span>
</aside>

## Mount Element

```jsx
<div id="my-card"></div>

<script>
  cardElement.mount('#my-card')
</script>
```

This lifecycle method attaches the element to the DOM, under a specific container.

| Parameter  | Required | Type     | Description                                                                |
|------------|----------|----------|----------------------------------------------------------------------------|
| `selector` | true     | *string* | CSS selector that matches the container where your element will be mounted |

<aside class="warning">
  <span>Multiple calls to <code>element.mount</code> will result in an error.</span>
</aside>

<aside class="warning">
  <span>If the Application key used to initialize <code>BasisTheory</code> doesn't exist or doesn't have the required <a href="#permissions">permissions</a>, an error will be thrown by this method.</span>
</aside>

## Update Element

```jsx
cardElement.update(options);
```

This lifecycle method updates the element options the element was initialized with. The values are merged into the previous options.

| Parameter | Required | Type     | Description                                             |
|-----------|----------|----------|---------------------------------------------------------|
| `options` | false    | *object* | [Options](#element-options) for customizing the element |

## Clear Element

```jsx
cardElement.clear();
```

Clears the element input(s) value.

## Unmount Element

```jsx
cardElement.unmount();
```

This lifecycle method safely removes the element from the DOM, stopping any further communication with it.

<aside class="warning">
  <span>Trying to mount an element that has been unmounted will result in an error.</span>
</aside>
