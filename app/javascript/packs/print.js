function printA4(){
    //プリントしたいエリア以外に、非表示のcssが付与されたclassを追加
    const body = document.querySelector('body');
    const children = body.children;

    Array.from(children).forEach(function(child) {
        if (child.id !== 'print-area') {
            child.classList.add('print-off')
        }
    });

    window.print();

    //window.print()を実行した後、非表示用のclass「print-off」を削除
    Array.from(children).forEach(function(child) {
        if (child.classList.contains('print-off')) {
            child.classList.remove('print-off');
        }
    });
}

document.addEventListener('turbolinks:load', () => {
    const button = document.getElementById("print-button")
    if (!button){ return false;}
    button.addEventListener("click", () => { printA4() })
})