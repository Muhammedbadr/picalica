import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["star"]

  connect() {
    // Optional: add logic here to highlight stars on hover
  }

  // This function runs when a star is clicked
  highlight(event) {
    const clickedValue = Number(event.currentTarget.dataset.value);
    const groupName = event.currentTarget.dataset.group;

    // Reset all stars in this group to gray
    this.starTargets.forEach((star) => {
      if (star.dataset.group === groupName) {
        star.classList.remove("text-yellow-400");
        star.classList.add("text-gray-300");
      }
    });

    // Highlight stars up to the clicked value
    this.starTargets.forEach((star) => {
      const starValue = Number(star.dataset.value);
      if (star.dataset.group === groupName && starValue <= clickedValue) {
        star.classList.remove("text-gray-300");
        star.classList.add("text-yellow-400");
      }
    });
  }
}