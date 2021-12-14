function imprimir(){
    var informacion = document.getElementById("txtEdditor").value;
    try{
        var gramatica = Analizador.parse(informacion);
        var global =new Ambito(null, "global");
        var cadena = Global(gramatica, global);
        //var simbolos = global.getArraySimbols();
        //alert(cadena.cadena);
        document.getElementById("txtConsole").innerHTML = cadena.cadena;
    }catch(error){
        alert(error);
    }
}