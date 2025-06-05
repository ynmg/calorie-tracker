import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ingredients"
export default class extends Controller {
  static targets = ["input", "details", "food", "ingredients"]
  static values = { url: String }

  connect() {
    this.token = document.querySelector('meta[name="csrf-token"]').content
  }

  find(e) {
    e.preventDefault();
    console.log("hello");
    const userInput = this.inputTarget.value;
    const apiKey = "0xF8edQRnGlNQ5IcSj7cTwWqZNYcFYH3gXECfetx";
    const url = `https://api.nal.usda.gov/fdc/v1/foods/search?api_key=${apiKey}&query=${userInput}`;

    // Show loading text
    this.detailsTarget.innerHTML = "<p>Loading...</p>";

    fetch(url, {
      method: "GET",
    })
      .then((response) => {
        return response.json();
      })
      .then((data) => {
        const foods = data.foods.slice(0, 20);
        const ul = document.createElement("ul");
        ul.insertAdjacentHTML("afterbegin", "<h2>Results</h2>");

        foods.forEach((food) => {
          const foodObj = {
            description: this.formatDescription(food.description),
            calories: food.foodNutrients.find(
              (nutrient) => nutrient.nutrientName === "Energy"
            )?.value,
          };
          const li = document.createElement("li");
          li.classList = "search-result";
          li.textContent = `name: ${foodObj.description}, calories: ${foodObj.calories}`;
          li.insertAdjacentHTML(
            "beforeend",
            `
              <button class="search-result" data-action="click->ingredients#save"> <i class="fa fa-check"></i>
              </button>
            `
          );
          ul.appendChild(li);
        });

        // Replace loading text with results
        this.detailsTarget.innerHTML = ""; // Clear the loading text
        this.detailsTarget.insertAdjacentElement("afterbegin", ul);
      })
      .catch((error) => {
        console.error("Error fetching data:", error);
        this.detailsTarget.innerHTML = "<p>Something went wrong. Please try again.</p>";
      });
  }

  formatDescription = (description) => {
    if (!description) {
      return "";
    }
    return description.charAt(0).toUpperCase() + description.slice(1).toLowerCase();
  };

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
      button.style.background = "#9EBC8A"
      const selectElements = this.ingredientsTargets.map((target) => {
        return target.querySelector("select")
      })
      const existingOptionsCollection = selectElements[0].children //html
      const existingOptions = Array.from(existingOptionsCollection)  //first one value is not a number -> select ingredient
      // find highest number in array
      const ids = existingOptions.map(option => Number.parseInt(option.value)).filter(Boolean)
      console.log(ids)
      const lastId = Math.max(...ids) + 1  //ids = array, Math.max seperate each value, ... turn an array to a seperate value
      // for debug console.log(existingOptions)
      // for debug console.log(lastId)
      selectElements.forEach((selectElement) => {
        selectElement.insertAdjacentHTML(
          "beforeend",
          `<option value=${lastId.toString()}>${name}</option>`
        )
      })
    })
  }
}
