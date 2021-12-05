function Ejecutar(){
    let consola = document.getElementById('#txtconsol');
        try{
            console.log(consola)
            var result = Analizador.parse(consola);
            console.log(result);
        }catch (e){
    console.log(result);
        }
}

function imprimir(){
    console.log(Analizador.errores);
}