import { Controller } from "@hotwired/stimulus"
import lunr from "lunr"

let indexed = false
async function doIndex() {
  try {
    const response = await fetch(this.urlValue);
    const index = await response.json();
    this.lunrIndex = lunr(function () {
      this.field("symbol")
      this.field("name")
      this.field("country")
      this.field("sector")
      this.field("industry")
      index.forEach(doc => this.add(doc))
    })
    this.index = index
  } catch (error) {
    console.log(error)
  }
  finally {
    console.log("indexing complete")
    indexed = true
  }
}

export default class extends Controller {
  static lunrIndex = null
  static values = { url: String }
  static targets = ["input", "results"]
  static index = null

  connect() {
    console.log("Search controller connected!")
    doIndex.call(this)
  }

  search(event) {
    if (!indexed) {
      console.log("indexing...")
      return
    }

    let query = this.inputTarget.value;

    // clean the results if the query is empty
    if (query === "") {
      this.resultsTarget.innerHTML = "";
      this.resultsTarget.classList.add("hidden")
      return;
    }

    let results = this.lunrIndex.search(query)

    if (results.length === 0) {
      this.resultsTarget.innerHTML = "";
      this.resultsTarget.classList.add("hidden")
      return;
    }

    let html = ""
    let index = this.index
    results.forEach(result => {
      let doc = index[result.ref]
      html += `<li class="flex items-center mb-2">
        ${doc.symbol}
        <span class="ml-2">${doc.name}</span>
      </li>`
    })
    this.resultsTarget.innerHTML = html
    this.resultsTarget.classList.remove("hidden")
  }
}
