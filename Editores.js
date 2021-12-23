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

var arbolito = CodeMirror.fromTextArea(document.getElementById('textAST'), {
    mode: "text/x-java",
    theme: "lesser-dark",
    lineNumbers: true,
    autoCloseTags: true
});
arbolito.setSize("600", "680");

txtEdditor = edit;
txtConsole = oup;
trad = traductor;
textAST = arbolito;

function compiler(){
    if(txtEdditor.getValue() == ""){
        alert("Ingresa una entrada");
    }else{
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
}

function limpiar(){
    txtEdditor.setValue("");
    txtConsole.setValue("");
    trad.setValue("");
    textAST.setValue("");
}

function mostrarAST(){
    textAST.setValue("Aqui se genera el AST\n");
}