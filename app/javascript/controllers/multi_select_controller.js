import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "dropdown", "pills", "hiddenSelect"]

  connect() {
    this._colorIdx = 0
    this.setupEventListeners()
  }

  setupEventListeners() {
    // Setup click listeners for existing dropdown items
    this.dropdownTarget.querySelectorAll("li").forEach((li) => {
      li.addEventListener("mousedown", (e) => this.select(e))
    })
  }

  showDropdown() {
    this.dropdownTarget.classList.remove("hidden")
  }

  hideDropdown() {
    // Add delay to allow click events to fire first
    setTimeout(() => {
      this.dropdownTarget.classList.add("hidden")
    }, 100)
  }

  filter(event) {
    const value = event.target.value.toLowerCase()
    this.dropdownTarget.querySelectorAll("li").forEach((li) => {
      const tagName = li.textContent.toLowerCase()
      li.style.display = tagName.includes(value) ? "" : "none"
    })
  }

  select(event) {
    event.preventDefault()
    const tagId = event.currentTarget.dataset.tagId
    const tagName = event.currentTarget.dataset.tagName

    // Check if already selected
    if (this.pillsTarget.querySelector(`[data-tag-id="${tagId}"]`)) return

    // Add to hidden select
    const option = document.createElement("option")
    option.value = tagId
    option.textContent = tagName
    option.selected = true
    this.hiddenSelectTarget.appendChild(option)

    // Create and add pill
    const pill = this.createPill(tagId, tagName)
    this.pillsTarget.appendChild(pill)

    // Clear input and keep dropdown open
    this.inputTarget.value = ""
    this.showDropdown()
    this.inputTarget.focus()
  }

  createPill(tagId, tagName) {
  const colors = [
    {
        bg: "#5D5899",
        text: "#ffffff",
        dotHover: "rgb(115, 115, 204)"
      }
    ]
    const c = colors[this._colorIdx++ % colors.length]
    
    const pill = document.createElement('span')
    pill.dataset.tagId = tagId
    pill.style.cssText = `display:inline-flex;align-items:center;gap:6px;background:${c.bg};color:${c.text};font-size:12px;font-weight:500;padding:4px 10px 4px 12px;border-radius:999px;`

    const btn = document.createElement('button')
    btn.type = 'button'
    btn.style.cssText = `width:16px;height:16px;border-radius:50%;background:${c.dot};border:none;cursor:pointer;display:flex;align-items:center;justify-content:center;padding:0;color:${c.text};font-size:11px;`
    btn.textContent = '×'
    btn.addEventListener('click', (e) => this.removePill(e, tagId, pill))

    pill.append(document.createTextNode(tagName + ' '), btn)
    return pill
  }

  removePill(event, tagId, pill) {
    event.preventDefault()
    pill.remove()
    const option = this.hiddenSelectTarget.querySelector(`option[value="${tagId}"]`)
    if (option) option.remove()
  }
}


