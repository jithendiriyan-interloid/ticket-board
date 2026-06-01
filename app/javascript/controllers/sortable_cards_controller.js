import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  static values = {
    statusId: Number
  }

  connect() {
    this.sortable = Sortable.create(this.element, {
      group: "board-cards",
      animation: 150,
      draggable: "[data-card-id], [data-task-id]",
      ghostClass: "opacity-50",
      onEnd: this.move.bind(this)
    })
  }

  disconnect() {
    this.sortable?.destroy()
  }

  move(event) {
    const cardId = event.item.dataset.cardId
    const taskId = event.item.dataset.taskId
    const boardId = event.item.dataset.boardId
    const statusId = event.to.dataset.sortableCardsStatusIdValue
    const token = document.querySelector("meta[name='csrf-token']")?.content
    const isTask = taskId !== undefined
    const itemSelector = isTask ? "[data-task-id]" : "[data-card-id]"
    const position = Array.from(event.to.querySelectorAll(itemSelector)).indexOf(event.item) + 1
    const url = isTask ? `/tasks/${taskId}/move` : `/boards/${boardId}/cards/${cardId}/move`

    fetch(url, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": token,
        "Accept": "application/json"
      },
      body: JSON.stringify({
        status_id: statusId,
        position: position
      })
    }).then((response) => {
      if (!response.ok) window.location.reload()
    }).catch(() => window.location.reload())
  }
}
