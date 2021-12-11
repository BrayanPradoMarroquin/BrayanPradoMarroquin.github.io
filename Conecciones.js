function imprimir(){
    var informacion = document.getElementById("txtEdditor").value;
    try{
        var gramatica = Analizador.parse(informacion);
        alert(gramatica);
    }catch(error){
        alert(error);
    }
    
}