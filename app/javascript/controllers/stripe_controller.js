import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="stripe"
export default class extends Controller {
  static values = {
    publicKey: String,
    sessionId: String
  }

  connect() {
    this.stripe = Stripe(this.publicKeyValue)
  }

  handleCheckout(e) {
    e.preventDefault()
    const button = e.currentTarget
    const originalText = button.textContent
    button.disabled = true
    button.textContent = 'Processing...'

    this.stripe.redirectToCheckout({
      sessionId: this.sessionIdValue,
    }).then(result => {
      if (result.error) {
        console.error('Stripe Checkout error:', result.error.message)
        button.disabled = false
        button.textContent = originalText
      }
    })
  }
}
