// 印刷ダイアログを開く前の処理
function addPrintClass() {
  return new Promise(function (resolve) {
    const $body = document.querySelector('body')
    const $children = $body.children
    const $printArea = document.getElementById('print-area')
    const $printAreaChildren = $printArea.children
    Array.from($children).forEach(function (child) {
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
    console.log('add')
    resolve()
  })
}

function print() {
  return new Promise(function (resolve) {
    //addPrintClass()で画面の変化が終了するのを待つ。これをしないとチャートの描画がおかしくなる。
    setTimeout(() => {
      window.print()
      console.log('print')
      resolve()
    }, 1000)
  })
}

function removePrintClass() {
  return new Promise(function (resolve) {
    const $body = document.querySelector('body')
    const $children = $body.children
    const $printArea = document.getElementById('print-area')
    const $printAreaChildren = $printArea.children

    Array.from($children).forEach(function (child) {
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
    console.log('remove')
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
