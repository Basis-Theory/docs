
# Initialize

> CDN

```jsx
<script>
  <!-- you can initialize it wherever it suits your workflow best -->
  <!-- here we are waiting for the window to load, to make sure BasisTheory instance -->
  <!-- has been injected in the window variable -->
  window.addEventListener('load', async () => {
    try {
      await BasisTheory.init('test_1234567890', { elements: true });      
      // use BasisTheory.elements
    } catch (e) {
      // handle errors that could happen while loading elements script
    } 
  });  
</script>
```

> Module

```jsx
import BasisTheory from '@Basis-Theory/basis-theory-js';

const bt = await new BasisTheory.init('test_1234567890', { elements: true });
// use bt.elements
```


After [installing](#install-sdk) **BasisTheory.js**, simply initialize it with `elements: true` so it dynamically loads **Elements** module.

<aside class="warning">
  <span>Elements are meant to be used on browser environments only. If you installed <code>BasisTheory.js</code> as a module, make sure the instance that loads elements runs on the browser-side code.</span>
</aside>

<aside class="warning">
  <span>If you try to call <code>BasisTheory.elements</code> before calling <code>BasisTheory.init</code>, or before its Promise has been fulfilled, you will get an error.</span>
</aside>

<aside class="notice">
  <span>Friendly reminder to replace <code>test_1234567890</code> with a valid <a href="#authentication">Elements application key</a>.</span>
</aside>
