function StartWith(_instruccion, _ambito) {
    var nuevoambito = new Ambito(_ambito, "main");
    var cadena ="";
    var instruc = _instruccion.lista_instrucciones;
    var retorno = Block(instruc, nuevoambito);
    retorno.cadena = cadena + retorno.cadena;
    return retorno;
}