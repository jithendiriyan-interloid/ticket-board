import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs"
export default class extends Controller {
  static targets = ["tabs","panel"]
  static values = {active:{type:String, default:"activity"}}
  connect() {
    this.showTab(this.activeValue)
  }
  switch (event) {
    this.showTab(event.params.tab)
  }
  showTab(name){
    this.activeValue=name
    this.tabTargets.forEach(tab => {
    const isActive = tab.dataset.tabsTabParam === name
    tab.classList.toggle("border-gray-900", isActive)
    tab.classList.toggle("text-gray-900", isActive)
    tab.classList.toggle("border-transparent", !isActive)
    tab.classList.toggle("text-gray-400", !isActive)
  })
    this.panelTargets.forEach(panel => {
    panel.hidden = panel.dataset.tabsPanel !== name
  })
  }
}
