
# Install / Initialize

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

```javascript
import BasisTheory from '@Basis-Theory/basis-theory-js';

await BasisTheory.init("test_1234567890", { elements: true });
```

> Make sure to replace `test_1234567890` with your API key.

You don't have to install `Hosted Elements` as a separated module or include additional script tags besides `BasisTheory.js`. It will dynamically load them from `js.basistheory.com`, which enables us to keep the highest compliance standards (e.g. PCI compliance). The only thing you have to worry about is adding `elements: true` in `BasisTheory.init` options parameter.

<aside class="warning">
  <span>Hosted Elements are meant to be used on browser environments only. If you installed <code>BasisTheory.js</code> as a module, make sure the instance that loads elements runs on the browser-side code.</span>
</aside>

See [Basis Theory Initialize](#initialize) for more details.
