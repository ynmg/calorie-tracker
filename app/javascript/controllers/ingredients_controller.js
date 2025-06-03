import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ingredients"
export default class extends Controller {
  static targets = ["input", "details", "food", "ingredients"]
  static values = { url: String }

  connect() {
    this.token = document.querySelector('meta[name="csrf-token"]').content
  }

  find(e) {
    e.preventDefault()
    console.log("hello");
    const userInput = this.inputTarget.value
    const apiKey = "0xF8edQRnGlNQ5IcSj7cTwWqZNYcFYH3gXECfetx"

    const url = `https://api.nal.usda.gov/fdc/v1/foods/search?api_key=${apiKey}&query=${userInput}`

    fetch(url, {
      method: "GET",
    })
      .then((response) => {
        return response.json()
      })
      .then((data) => {
        const foods = data.foods.slice(0, 20)
        const ul = document.createElement("ul")
        ul.insertAdjacentHTML("afterbegin", "<h2>Results</h2>")
        foods.forEach((food) => {
          const foodObj = {
            description: food.description,
            calories: food.foodNutrients.find(
              (nutrient) => nutrient.nutrientName === "Energy"
            )?.value,
          }
          const li = document.createElement("li")
          li.textContent = `name: ${foodObj.description}, calories: ${foodObj.calories}`
          li.insertAdjacentHTML(
            "beforeend",
            `
              <button data-action="click->ingredients#save">save ingredient</button>
            `
          )
          ul.appendChild(li)
        })
        this.detailsTarget.insertAdjacentElement("afterbegin", ul)
      })
  }

  save(e) {
    const button = e.currentTarget
    const liElement = e.currentTarget.parentElement
    const text = liElement.innerText

    const textArray = text.split(":")
    const calories = Number.parseInt(
      textArray[textArray.length - 1].trim().match(/\d+/)[0]
    )
    const name = textArray[1]
      .replace(/calories/g, "")
      .replace(/,/g, "")
      .trim()
    const url = this.urlValue
    const formData = new FormData()
    formData.append("ingredient[name]", name)
    formData.append("ingredient[calories]", calories)

    fetch(url, {
      method: "POST",
      body: formData,
      headers: {
        "X-CSRF-Token": this.token,
      },
    }).then((response) => {
      button.style.background = "green"
      const selectElements = this.ingredientsTargets.map((target) => {
        return target.querySelector("select")
      })

      const existingOptionsCount = selectElements[0].children.length
      selectElements.forEach((selectElement) => {
        selectElement.insertAdjacentHTML(
          "beforeend",
          `<option value=${existingOptionsCount}>${name}</option>`
        )
      })
    })
  }
}
