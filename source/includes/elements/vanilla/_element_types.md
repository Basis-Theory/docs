# Element Types

## Card Element

The `"card"` element type features a one-liner credit card collector containing the following inputs:

- *cardNumber*
- *expirationDate*
- *cvc*

<div class="hero_elements-example">
  <div class="elements-example-content">
    <div class="elements-example-header">
      <div class="elements-example-window">
        <div class="elements-example-action"></div>
        <div class="elements-example-action"></div>
        <div class="elements-example-action"></div>
      </div>
      <span>Live Card Element</span>
    </div>
    <div class="elements-example-form-wrapper">
      <div class="element" id="types-card-element"></div>
    </div>
  </div>
</div>

<script defer>
  window.addEventListener('load', () => {
    window.cardElement = BasisTheory.createElement('card');
    cardElement.mount('#types-card-element');  
  });
</script>

## Text Element

The `"text"` element type is a secure replacement for the `<input>` tag and enables collecting user `string` data.

<div class="hero_elements-example">
  <div class="elements-example-content">
    <div class="elements-example-header">
      <div class="elements-example-window">
        <div class="elements-example-action"></div>
        <div class="elements-example-action"></div>
        <div class="elements-example-action"></div>
      </div>
      <span>Live Text Element</span>
    </div>
    <div class="elements-example-form-wrapper">
      <div class="element" id="types-text-element"></div>
    </div>
  </div>
</div>

<script defer>
  window.addEventListener('load', () => {
    window.textElement = BasisTheory.createElement('text', {
      targetId: 'elementTypesTextElement',
      placeholder: 'John Doe',
    });
    textElement.mount('#types-text-element');  
  });
</script>

## Card Number Element

The `"cardNumber"` element type renders a card number input and an optional card icon, featuring automatic brand detection, input validation
and masking.

<div class="hero_elements-example">
  <div class="elements-example-content">
    <div class="elements-example-header">
      <div class="elements-example-window">
        <div class="elements-example-action"></div>
        <div class="elements-example-action"></div>
        <div class="elements-example-action"></div>
      </div>
      <span>Live Card Number Element</span>
    </div>
    <div class="elements-example-form-wrapper">
      <div class="element" id="types-card-number-element"></div>
    </div>
  </div>
</div>

<script defer>
  window.addEventListener('load', () => {
    window.cardNumberElement = BasisTheory.createElement('cardNumber', {
      targetId: 'elementTypesCardNumberElement',
    });
    window.cardNumberElement.mount('#types-card-number-element');
    window.cardNumberElement.on('change', ({ cardBrand }) => {
      window.cardVerificationCodeElement?.update({ cardBrand });
    });
  });
</script>

## Card Expiration Date Element

The `"cardExpirationDate"` element type features a month/year formatted input with validation. The date must be between current month and 20 years in the future.

<div class="hero_elements-example">
  <div class="elements-example-content">
    <div class="elements-example-header">
      <div class="elements-example-window">
        <div class="elements-example-action"></div>
        <div class="elements-example-action"></div>
        <div class="elements-example-action"></div>
      </div>
      <span>Live Card Expiration Date Element</span>
    </div>
    <div class="elements-example-form-wrapper">
      <div class="element" id="types-card-expiration-date-element"></div>
    </div>
  </div>
</div>

<script defer>
  window.addEventListener('load', () => {
    window.cardExpirationDateElement = BasisTheory.createElement('cardExpirationDate', {
      targetId: 'elementTypesCardExpirationDateElement',
    });
    window.cardExpirationDateElement.mount('#types-card-expiration-date-element');  
  });
</script>

## Card Verification Code Element

The `"cardVerificationCode"` element type is used to collect the card security code.

<div class="hero_elements-example">
  <div class="elements-example-content">
    <div class="elements-example-header">
      <div class="elements-example-window">
        <div class="elements-example-action"></div>
        <div class="elements-example-action"></div>
        <div class="elements-example-action"></div>
      </div>
      <span>Live Card Verification Code Element</span>
    </div>
    <div class="elements-example-form-wrapper">
      <div class="element" id="types-card-verification-code-element"></div>
    </div>
  </div>
</div>

<script defer>
  window.addEventListener('load', () => {
    window.cardVerificationCodeElement = BasisTheory.createElement('cardVerificationCode', {
      targetId: 'elementTypesCardVerificationCodeElement',
    });
    window.cardVerificationCodeElement.mount('#types-card-verification-code-element');  
  });
</script>
