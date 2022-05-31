## Style

```tsx
var cardElement = BasisTheory.createElement('card', {
  style: {
    fonts: [
      "https://fonts.googleapis.com/css2?family=Source+Sans+Pro:ital,wght@0,200;0,300;0,400;0,600;0,700;0,900;1,200;1,300;1,400;1,600;1,700;1,900&display=swap"
    ],
    base: {
      color: "#fff",
      fontWeight: 500,
      fontFamily: "'Source Sans Pro'",
      fontSize: "16px",
      fontSmooth: "antialiased",
      "::placeholder": {
        color: "#6b7294"
      },
      ":disabled": {
        backgroundColor: "#f0f0f4"
      },
    },
    invalid: {
      color: "#ffc7ee"
    },
    complete: {
      color: "#1ad1db"
    }    
  }
})
```

Elements are styled through the `ElementStyle` object, which maps state variants and miscellaneous.

Attribute  | Required | Type                   | Description
---------- | -------- | ----------------       | -----------
`fonts`    | false    | *array*                | Array of <a href="https://fonts.google.com/" target="_blank">Google Fonts</a> URLs
`base`     | false    | *object*               | Base variant style - all other variant styles inherit from this one
`complete` | false    | *object*               | Variant style applied when the element input has valid value
`empty`    | false    | *object*               | Variant style applied when the element input has no value
`invalid`  | false    | *object*               | Variant style applied when the element input has invalid value

You can customize the following pseudo-classes and pseudo-elements inside each variant using a nested object:

- `:hover`
- `:focus`
- `:disabled`  
- `::placeholder`
- `::selection`

Here is a complete list of the supported CSS properties:

- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/background-color" target="_blank">backgroundColor</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/color" target="_blank">color</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/font-family" target="_blank">fontFamily</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/font-size" target="_blank">fontSize</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/font-smooth" target="_blank">fontSmooth</a> (we replace this with the user-agent alternate names automatically)
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/font-style" target="_blank">fontStyle</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/font-variant" target="_blank">fontVariant</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/font-weight" target="_blank">fontWeight</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/line-height" target="_blank">lineHeight</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/letter-spacing" target="_blank">letterSpacing</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/text-align" target="_blank">textAlign</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/padding" target="_blank">padding</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration" target="_blank">textDecoration</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/text-shadow" target="_blank">textShadow</a>
- <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/text-transform" target="_blank">textTransform</a>


<aside class="notice">
  <span>Variants are resolved per element input. In other words, variant styles will be applied on each element input individually based on their own value.</span>
</aside>

<aside class="warning">
  <span>For security reasons, we currently support only the 1000+ Google Fonts families. If you need a custom font in your <strong>Basis Theory Elements</strong>, don't hesitate to <a href="mailto:support@basistheory.com">reach out</a>.</span>
</aside>
