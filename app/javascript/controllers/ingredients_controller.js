import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ingredients"
export default class extends Controller {
  connect() {
    console.log('Hello');
  }

  find(e) {
    e.preventDefault()
    console.log('Clicked');
  }
}
