# `useBasisTheory`

```jsx
import { 
  useBasisTheory
} from '@basis-theory/basis-theory-react';

const App = () => {
  // creates a new instance of BasisTheory class
  const { bt, error } = useBasisTheory('test_1234567890', { elements: true });
  
  if (bt) {
    // able to call BasisTheory methods
  }
  
  return <MyComponent />;
}
```

The `useBasisTheory` <a href="https://reactjs.org/docs/hooks-intro.html" target="_blank">hook</a> offers an easy way to initialize the SDK. There are two ways to use it:

- Passing [init parameters](#initialize) creates a new instance of `BasisTheory` class and initializes it automatically.
- Passing no parameters will try to grab the `BasisTheory` instance from the `Context` see [BasisTheoryProvider](#basistheoryprovider).

During `BasisTheory` initialization, `useBasisTheory` will return `undefined` for the `bt` property. This is helpful to prevent having to deal with the initialization `Promise` in your components lifecycle.


<aside class="warning">
  <span>Initialization errors, such as bad API key, are caught and held in the <code>error</code> property.</span>
</aside>
