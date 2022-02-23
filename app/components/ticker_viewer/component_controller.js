import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["change"]

    connect() {
        console.log("ticker controller")
    }

    toggle(event) {
        if (event.currentTarget.dataset.priceType == "price") {
            this.changeTarget.innerHTML = event.currentTarget.dataset.percentChange + "%"
            event.currentTarget.dataset.priceType = "percent"
        } else {
            this.changeTarget.innerHTML = event.currentTarget.dataset.priceChange
            event.currentTarget.dataset.priceType = "price"
        }
    }
}
