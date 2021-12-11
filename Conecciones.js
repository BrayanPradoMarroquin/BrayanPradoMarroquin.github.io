function imprimir(){
    var informacion = document.getElementById("txtEdditor").value;
    try{
        var gramatica = Analizador.parse(informacion);
        var respuesta = Global(gramatica, "Global");
        alert(respuesta.cadena);
    }catch(error){
        alert(error);
    }
    
}