/**
 * MultiSelect Component
 * Handles tag selection with dropdown filtering and pill display
 * Production-ready vanilla JavaScript implementation
 */

class MultiSelectComponent {
  constructor(wrapper) {
    this.wrapper = wrapper
    this.input = wrapper.querySelector('[data-multi-select-target="input"]')
    this.dropdown = wrapper.querySelector('[data-multi-select-target="dropdown"]')
    this.pills = wrapper.querySelector('[data-multi-select-target="pills"]')
    this.hiddenSelect = wrapper.querySelector('[data-multi-select-target="hiddenSelect"]')

    if (!this.input || !this.dropdown || !this.pills || !this.hiddenSelect) {
      console.error('MultiSelect: Missing required elements')
      return
    }

    this.init()
  }

  init() {
    this.attachInputListeners()
    this.attachDropdownListeners()
  }

  attachInputListeners() {
    this.input.addEventListener('focus', () => this.showDropdown())
    this.input.addEventListener('blur', () => this.hideDropdown())
    this.input.addEventListener('input', (e) => this.filterDropdown(e.target.value))
  }

  attachDropdownListeners() {
    this.dropdown.querySelectorAll('li').forEach((li) => {
      li.addEventListener('mousedown', (e) => this.selectTag(e, li))
    })
  }

  showDropdown() {
    this.dropdown.classList.remove('hidden')
  }

  hideDropdown() {
    // Delay to allow mousedown event to fire
    setTimeout(() => {
      this.dropdown.classList.add('hidden')
    }, 100)
  }

  filterDropdown(searchValue) {
    const value = searchValue.toLowerCase()
    this.dropdown.querySelectorAll('li').forEach((li) => {
      const tagName = li.textContent.toLowerCase()
      li.style.display = tagName.includes(value) ? '' : 'none'
    })
  }

  selectTag(event, li) {
    event.preventDefault()
    const tagId = li.dataset.tagId
    const tagName = li.dataset.tagName

    // Prevent duplicates
    if (this.pills.querySelector(`[data-tag-id="${tagId}"]`)) {
      return
    }

    // Add to hidden select
    const option = document.createElement('option')
    option.value = tagId
    option.textContent = tagName
    option.selected = true
    this.hiddenSelect.appendChild(option)

    // Create and add pill
    const pill = this.createPill(tagId, tagName)
    this.pills.appendChild(pill)

    // Reset input and focus
    this.input.value = ''
    this.showDropdown()
    this.input.focus()
  }

  createPill(tagId, tagName) {
    const pill = document.createElement('span')
    pill.className = 'bg-indigo-500 text-white px-3 py-1 rounded-full text-sm flex items-center gap-2'
    pill.dataset.tagId = tagId

    const textNode = document.createTextNode(tagName + ' ')
    pill.appendChild(textNode)

    const button = document.createElement('button')
    button.type = 'button'
    button.className = 'ml-1 text-xs font-bold'
    button.textContent = '×'
    button.addEventListener('click', (e) => this.removePill(e, tagId, pill))

    pill.appendChild(button)
    return pill
  }

  removePill(event, tagId, pill) {
    event.preventDefault()
    pill.remove()

    const option = this.hiddenSelect.querySelector(`option[value="${tagId}"]`)
    if (option) {
      option.remove()
    }
  }
}

// Initialize all multi-select components on the page
document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('[data-controller="multi-select"]').forEach((wrapper) => {
    new MultiSelectComponent(wrapper)
  })
})

export { MultiSelectComponent }
