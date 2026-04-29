import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "chevron"]

  toggle() {
    const open = !this.menuTarget.classList.contains("hidden")
    if (open) {
      this.close()
    } else {
      this.open()
    }
  }

  open() {
    this.menuTarget.classList.remove("hidden")
    this.menuTarget.style.opacity = "0"
    this.menuTarget.style.transform = "translateY(-6px) scale(0.97)"
    this.menuTarget.style.transition = "opacity 150ms ease, transform 150ms ease"

    requestAnimationFrame(() => {
      this.menuTarget.style.opacity = "1"
      this.menuTarget.style.transform = "translateY(0) scale(1)"
    })

    this.chevronTarget.style.transform = "rotate(180deg)"
  }

  close() {
    this.menuTarget.style.opacity = "0"
    this.menuTarget.style.transform = "translateY(-6px) scale(0.97)"
    setTimeout(() => this.menuTarget.classList.add("hidden"), 150)
    this.chevronTarget.style.transform = "rotate(0deg)"
  }

  closeOnOutsideClick(event) {
    if (!this.element.contains(event.target)) {
      this.close()
    }
  }
}