function imprimir(){
    var informacion = document.getElementById("txtEdditor").value;
    try{
        var gramatica = Analizador.parse(informacion);
        var global =new Ambito(null, "global");
        //var cadena = Global(gramatica, global);
        //var simbolos = global.getArraySimbols();
        alert(gramatica);
    }catch(error){
        alert(error);
    }
}