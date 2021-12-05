let Editar = document.getElementById('Consola');

function Ejecutar(){
    try{
        console.log(Editar)
        var result = Analizador.parse(Editar);
        console.log(result);
        
    }catch (e){
        console.log(result);
    }
}

