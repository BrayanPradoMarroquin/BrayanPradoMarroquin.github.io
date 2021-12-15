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
trad = traductor;

function compiler(){
    var informacion = txtEdditor.getValue();
    try {
        var gramatica = Analizador.parse(informacion);
        var global = new Ambito(null, "global");
        var cadena = Global(gramatica, global);
        var salida = txtConsole.setValue(cadena.cadena);
    } catch (error) {
        alert(error);
    }
}

function limpiar(){
    var ed = txtEdditor.setValue(" ");
    var sa = txtConsole.setValue(" ");
    var t = trad.setValue(" ");
}