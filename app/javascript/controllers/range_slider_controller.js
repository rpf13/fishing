import { Controller } from "@hotwired/stimulus"

import noUiSlider from 'nouislider'
import wNumb from 'wnumb'

// Connects to data-controller="range-slider"
// the static values are defined in the HTML data attributes in the index.html.erb file
// and are used to set the range of the slider. They are passed to the noUiSlider.create method
// in the connect method. They are read via JavaScript out of the DOM and passed to the noUiSlider
export default class extends Controller {
  static targets = ["slider", "currentMin", "currentMax"]
  static values = {min: Number, max: Number}

  connect() {
    const existingSlider = this.sliderTarget.firstElementChild;
    if (existingSlider) {
      existingSlider.remove();
    }

    this.slider = noUiSlider.create(this.sliderTarget, {
      range: {
        'min': this.minValue,
        'max': this.maxValue
      },
      start: [this.currentMinTarget.value, this.currentMaxTarget.value],
      step: 1,
      connect: [false, true, false],
      tooltips: [wNumb({ decimals: 0 }), wNumb({ decimals: 0 })],
    })
    this.slider.on('update', (values, handle, unencoded) => {
      const target =
        (handle == 0) ? this.currentMinTarget : this.currentMaxTarget

      target.value = Math.round(unencoded[handle])

      target.dispatchEvent(new CustomEvent('input', {bubbles: true }))
    })
  }

  disconnect() {
    this.slider.destroy()
  }
}
