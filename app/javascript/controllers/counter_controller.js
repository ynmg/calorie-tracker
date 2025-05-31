import { Controller } from "@hotwired/stimulus"
import { CountUp } from "countup.js"

// Connects to data-controller="counter"
export default class extends Controller {
  static values = { end: Number }

  connect() {
    const countUp = new CountUp(this.element, this.endValue)
    if (!countUp.error) {
      countUp.start()
    } else {
      console.error(countUp.error)
    }
  }
}
