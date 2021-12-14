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

$(document).ready(function (){
    $("#ejecutar").click(function() {
        try{
            var result = Analizador.parse($("#txtEdditor").val());
            console.log(result)
            $("#txtConsole").html(result);
        }catch(e){
            $("#txtConsole").html(String(e));
        }
    });
});