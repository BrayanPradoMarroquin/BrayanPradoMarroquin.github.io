class Metodo {
    constructor(_id, _lista_parametros, _instrucciones, _linea, _columna) {
        this.id = _id;
        this.lista_parametros = _lista_parametros
        this.instrucciones = _instrucciones
        this.linea = _linea;
        this.columna = _columna
    }
}

class Funcion {
    constructor(_id, _lista_parametros, _instrucciones, _tipo_retorno, _linea, _columna) {
        this.id = _id;
        this.lista_parametros = _lista_parametros
        this.instrucciones = _instrucciones
        this.retorno = _tipo_retorno
        this.linea = _linea;
        this.columna = _columna
    }
}

class Struct{
    constructor(_id, _lista_variables, _linea, _columna){
        this.id = _id;
        this.lista_variables = _lista_variables;
        this.linea = _linea;
        this.columna = _columna;
    }
}