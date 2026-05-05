import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["categorySelect", "subSelect", "input"]

  connect() {
    this.filterSubs() // on page load, show correct subs if editing
  }

  filterSubs() {
    const catId = this.categorySelectTarget.value
    const options = this.subSelectTarget.querySelectorAll(".sub-option")

    options.forEach(opt => {
      opt.hidden = opt.dataset.category !== catId
    })

    // Reset sub if current selection doesn't belong to new category
    const current = this.subSelectTarget.value
    const currentOpt = this.subSelectTarget.querySelector(`option[value="${current}"]`)
    if (!current || currentOpt?.dataset.category !== catId) {
      this.subSelectTarget.value = ""
      this.inputTarget.value = ""
    }
  }

  pickSub() {
    this.inputTarget.value = this.subSelectTarget.value
  }
}