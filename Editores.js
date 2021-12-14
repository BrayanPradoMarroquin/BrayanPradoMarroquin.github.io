var edit = CodeMirror.fromTextArea(document.getElementById('txtEdditor'), {
    mode: "text/x-java",
    theme: "lesser-dark",
    lineNumbers: true,
    autoCloseTags: true
});
edit.setSize("600", "590");

var oup = CodeMirror.fromTextArea(document.getElementById('txtConsole'), {
    mode: "text/x-java",
    theme: "lesser-dark",
    lineNumbers: true,
    autoCloseTags: true
});
oup.setSize("600", "590");

var traductor = CodeMirror.fromTextArea(document.getElementById('trad'), {
    mode: "text/x-java",
    theme: "lesser-dark",
    lineNumbers: true,
    autoCloseTags: true
});
traductor.setSize("600", "680");

txtEdditor = edit;
txtConsole = oup;

function compiler(){
    var entrada = txtEdditor.getValue();
    try {
        var result = Analizador.parse(entrada);
        console.log(result);
        var salida = txtConsole.setValue(String(result));
    } catch (e) {
        console.log(e)
    }
}