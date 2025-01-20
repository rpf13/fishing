import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sort-link"
export default class extends Controller {
  // static stimulus target attributes, whcih are used to reference elements in the DOM
  // they are actually used in the fish_cathces/index.html.erb file in the form_with block hidden attributes
  static targets = ["sort", "direction"]

  updateForm(event) {
    let searchParams = new URL(event.detail.url).searchParams

    this.sortTarget.value = searchParams.get("sort")
    this.directionTarget.value = searchParams.get("direction")
  }
}
