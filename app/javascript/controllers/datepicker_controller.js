import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"; // You need to import this to use new flatpickr()

// export default class extends Controller {
//   connect() {
//     flatpickr(this.element)
//   }
// }
export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      dateFormat: this.element.dataset.datepickerFormat || "Y-m-d",
      // altFormat: "F j, Y",
      maxDate: this.element.dataset.datepickerMaxDate || null
    });
  }
}
