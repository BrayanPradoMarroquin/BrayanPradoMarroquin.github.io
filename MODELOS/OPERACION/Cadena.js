function procesarCadena(_expresion, _ambito) {
    recu = T_imprimir(_expresion.valor)
    Lista_Traducciones.push(new Traductor_id(null, null, recu, null, "IMPRIMIR"))
    return Operacion(_expresion, _ambito);
}