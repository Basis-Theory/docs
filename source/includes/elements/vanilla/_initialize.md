
# Initialize

> CDN

```tsx
<script>
  // you can initialize it wherever it suits your workflow best
  // here we are waiting for the window to load, to make sure BasisTheory instance
  // has been injected in the window variable
  window.addEventListener('load', async () => {
    try {
      // global/window variable BasisTheory is an instance, but requires initialization
      await BasisTheory.init('test_1234567890', { elements: true });      
      // use Elements
    } catch (e) {
      // handle errors that could happen while loading elements script
    } 
  });  
</script>
```

> Module

```tsx
import { BasisTheory } from '@basis-theory/basis-theory-js';

// In this context BasisTheory is a class
const bt = await new BasisTheory().init('test_1234567890', { elements: true });
// use Elements
```

Initialize `BasisTheory` with `elements: true` so it dynamically loads **Elements** module.

Parameter | Required | Type                     | Description
--------- | -------- | ------------------------ | -----------
`apiKey`  | true     | *string*                 | The API Key used to identify an [Application](/api-reference#applications).
`options` | false    | *BasisTheoryInitOptions* | [Options](#initialize-permission-types-basis-theory-init-options) for initializing the `BasisTheory` instance.
<!-- Options link above looks weird because of how Slate generates them -->

### Basis Theory Init Options

Attribute  | Required | Type       | Description
---------- | -------- | ---------- | -----------
`elements` | false    | *boolean*  | Boolean used to indicate whether the `BasisTheory` instance will have Elements capabilities.

<aside class="warning">
  <span>Elements are meant to be used in browser environments only. If you installed <code>BasisTheory.js</code> as a module, make sure the instance that loads elements runs on the browser-side code.</span>
</aside>

<aside class="warning">
  <span>If you try to to use any Elements feature before calling <code>BasisTheory.init</code>, or before its Promise has been fulfilled, you will get an error.</span>
</aside>

<aside class="notice">
  <span>Friendly reminder to replace <code>test_1234567890</code> with a valid <a href="/api-reference/#applications-application-types">Public Application key</a>.</span>
</aside>
