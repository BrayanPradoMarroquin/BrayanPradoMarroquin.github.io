function DecStruct(_instruccion, _ambito){
    const nuevoStruct = new Struct(_instruccion.id, _instruccion.lista_variables, _instruccion.linea, _instruccion.columna)
    if (_ambito.existeSimbolo(nuevoStruct.id) != false){
        return `Error: Ya existe una variable con el mismo identificador '${nuevoStruct.id}'\nLínea: ${nuevoStruct.linea} Columna: ${nuevoStruct.columna}\n`
    }else if(_ambito.existeFuncion(nuevoStruct.id) != false){
        return `Error: El Struct '${nuevoStruct.id}' ya existe.\nLínea: ${nuevoStruct.linea} Columna: ${nuevoStruct.columna}\n`
    }
    _ambito.addFuncion(nuevoStruct.id, nuevoStruct)
    return null
}