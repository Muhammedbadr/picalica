import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  submit() {
    // If the controller is on the input field, use .form
    // If it's on the form, use this.element
    const form = this.element.closest('form') || this.element;
    form.requestSubmit();
  }
}