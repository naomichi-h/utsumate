// 印刷ダイアログを開く前の処理
function addPrintClass() {
  return new Promise(function (resolve) {
    const $bodyChildren = document.querySelector('body').children
    const $mainChildren = document.querySelector('main').children
    const $printAreaChildren = document.getElementById('print-area').children

    Array.from($bodyChildren).forEach(function (child) {
      if (child.id !== 'main') {
        child.classList.add('print-off')
      }
    })

    Array.from($mainChildren).forEach(function (child) {
      if (child.id !== 'print-area') {
        child.classList.add('print-off')
      }
    })

    Array.from($printAreaChildren).forEach(function (child) {
      if (child.classList.contains('report-list')) {
        child.classList.add('print-1page')
      } else {
        child.classList.add('print-width')
      }
    })

    resolve()
  })
}

function print() {
  return new Promise(function (resolve) {
    // addPrintClass()で画面の変化が終了するのを待つ。これをしないとチャートの描画がおかしくなる。
    setTimeout(() => {
      window.print()

      resolve()
    }, 1000)
  })
}

function removePrintClass() {
  return new Promise(function (resolve) {
    const $bodyChildren = document.querySelector('body').children
    const $mainChildren = document.querySelector('main').children
    const $printAreaChildren = document.getElementById('print-area').children

    Array.from($bodyChildren).forEach(function (child) {
      if (child.classList.contains('print-off')) {
        child.classList.remove('print-off')
      }
    })

    Array.from($mainChildren).forEach(function (child) {
      if (child.classList.contains('print-off')) {
        child.classList.remove('print-off')
      }
    })

    Array.from($printAreaChildren).forEach(function (child) {
      if (child.classList.contains('report-list')) {
        child.classList.remove('print-1page')
      } else {
        child.classList.remove('print-width')
      }
    })

    resolve()
  })
}

document.addEventListener('turbolinks:load', () => {
  const $button = document.getElementById('print-button')
  if (!$button) {
    return false
  }
  $button.addEventListener('click', () => {
    addPrintClass().then(print).then(removePrintClass)
  })
})
