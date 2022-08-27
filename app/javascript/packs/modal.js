document.addEventListener('turbolinks:load', () => {
  // モーダルウィンドウを表示するボタンを取得します。
  const $show = document.getElementById('show-modal')

  // ボタンのクリックイベントを追加します。
  $show.addEventListener('click', () => {
    // モーダルウィンドウを表示します。
    const $modal = document.getElementById('modal-window')
    $modal.classList.add('is-active') // is-activeクラスを追加
  })

  // モーダルウィンドウを閉じるボタンを取得します。
  const $close = document.getElementById('close-modal')
  // ボタンのクリックイベントを追加します。
  $close.addEventListener('click', () => {
    // モーダルウィンドウを閉じます。
    const $modal = document.getElementById('modal-window')
    $modal.classList.remove('is-active') // is-activeクラスを削除
  })
})
