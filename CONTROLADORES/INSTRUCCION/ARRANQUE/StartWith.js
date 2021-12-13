function StartWith(_instruccion, _ambito) {
    const Main = new CMetodo(_instruccion.nombre, _instruccion.lista_valores, _instruccion.lista_instrucciones, _instruccion.linea, _instruccion.columna);
    if(_ambito.existeSimbolo(Main.id) != false){
        return `Error: Ya existe una variable con el mismo identificador '${Main.id}'\nLínea: ${Main.linea} Columna: ${Main.columna}\n`
    }
    else if (_ambito.existeFuncion(Main.id) != false) {
        return `Error: El método '${Main.id}' ya existe.\nLínea: ${Main.linea} Columna: ${Main.columna}\n`
    }
    _ambito.addFuncion(Main.id, Main)
    return null
}