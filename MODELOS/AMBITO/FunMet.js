class CMetodo {
    constructor(_id, _lista_parametros, _instrucciones, _linea, _columna) {
        this.id = _id;
        this.lista_parametros = _lista_parametros
        this.instrucciones = _instrucciones
        this.linea = _linea;
        this.columna = _columna
    }
}

class CFuncion {
    constructor(_id, _lista_parametros, _instrucciones, _tipo_retorno, _linea, _columna) {
        this.id = _id;
        this.lista_parametros = _lista_parametros
        this.instrucciones = _instrucciones
        this.retorno = _tipo_retorno
        this.linea = _linea;
        this.columna = _columna
    }
}