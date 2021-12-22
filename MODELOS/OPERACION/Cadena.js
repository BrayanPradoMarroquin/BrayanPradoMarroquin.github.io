function procesarCadena(_expresion, _ambito) {
    var Pro = Operacion(_expresion, _ambito);
    if(_expresion.tipo=="VAL_IDENTIFICADOR"){
        recu = T_imprimir(_expresion.valor)
        Lista_Traducciones.push(new Traductor_id(null, null, recu, null, "IMPRIMIR"))
    }else{
        recu = T_imprimir2(Pro.ubicacion)
        Lista_Traducciones.push(new Traductor_id(null, null, recu, null, "IMPRIMIR"))
    }
    
    return Pro;
}