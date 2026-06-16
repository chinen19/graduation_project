import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // モーダルが読み込まれたら表示
    this.element.classList.remove("hidden")
    this.element.classList.add("flex")
    
    // 背景クリックで閉じる
    this.element.addEventListener("click", (e) => {
      if (e.target === this.element) {
        this.close()
      }
    })
  }

  close() {
    this.element.classList.add("hidden")
    this.element.classList.remove("flex")
    // モーダルの中身を空にする
    this.element.innerHTML = '<div class="bg-white rounded-lg shadow-lg max-w-2xl w-full mx-4 max-h-[90vh] overflow-y-auto"></div>'
  }
}