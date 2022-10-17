// 印刷ダイアログを開く前の処理
// 印刷しない箇所を非表示にする
function addPrintClass() {
  return new Promise(function (resolve) {
    const $wrapperEnd = document.getElementsByClassName('wrapper__end')
    const $wrapperStart = document.getElementById('wrapper__start').children

    const $mainChildren = document.querySelector('main').children
    const $printAreaChildren = document.getElementById('print-area').children

    Array.from($wrapperEnd).forEach(function (child) {
      child.classList.add('print-off')
    })

    Array.from($wrapperStart).forEach(function (child) {
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
      if (child.classList.contains('print-page')) {
        child.classList.add('print-page-on')
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
  const $wrapperStart = document.getElementById('wrapper__start').children
  const $wrapperEnd = document.getElementsByClassName('wrapper__end')
  const $mainChildren = document.querySelector('main').children
  const $printAreaChildren = document.getElementById('print-area').children

  Array.from($wrapperStart).forEach(function (child) {
    if (child.classList.contains('print-off')) {
      child.classList.remove('print-off')
    }
  })

  Array.from($wrapperEnd).forEach(function (child) {
    child.classList.remove('print-off')
  })

  Array.from($mainChildren).forEach(function (child) {
    if (child.classList.contains('print-off')) {
      child.classList.remove('print-off')
    }
  })

  Array.from($printAreaChildren).forEach(function (child) {
    if (child.classList.contains('print-page-on')) {
      child.classList.remove('print-page-on')
    }
  })
}

document.addEventListener('turbolinks:load', () => {
  const $button = document.getElementById('print-button')
  if (!$button) {
    return false
  }
  $button.addEventListener('click', () => {
    addPrintClass().then(print)
  })
})

window.addEventListener('afterprint', () => {
  removePrintClass()
})
