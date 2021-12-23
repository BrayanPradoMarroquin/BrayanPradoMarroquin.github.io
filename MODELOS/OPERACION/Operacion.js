function Operacion(_expresion, _ambito) {
    if (_expresion.tipo === TIPO_VALOR.DOBLE || _expresion.tipo === TIPO_VALOR.BOOLEANO ||
        _expresion.tipo === TIPO_VALOR.CADENA || _expresion.tipo === TIPO_VALOR.IDENTIFICADOR ||
        _expresion.tipo === TIPO_VALOR.CARACTER || _expresion.tipo === TIPO_VALOR.ENTERO) {
        return ValorExpresion(_expresion, _ambito)
    }
    else if (_expresion.tipo === TIPO_OPERACION.SUMA || _expresion.tipo === TIPO_OPERACION.RESTA
        || _expresion.tipo === TIPO_OPERACION.MULTIPLICACION || _expresion.tipo === TIPO_OPERACION.DIVISION
        || _expresion.tipo === TIPO_OPERACION.POTENCIA || _expresion.tipo === TIPO_OPERACION.MODULO
        || _expresion.tipo === TIPO_OPERACION.NEGACION || _expresion.tipo === TIPO_OPERACION.SENO 
        || _expresion.tipo === TIPO_OPERACION.COSENO || _expresion.tipo === TIPO_OPERACION.TANGETE
        || _expresion.tipo === TIPO_OPERACION.LOGARITMO || _expresion.tipo === TIPO_OPERACION.RAIZ){
        return Aritmetica(_expresion, _ambito)
    }
    else if (_expresion.tipo === TIPO_OPERACION.IGUALIGUAL || _expresion.tipo === TIPO_OPERACION.DIFERENTE ||
        _expresion.tipo === TIPO_OPERACION.MENOR || _expresion.tipo === TIPO_OPERACION.MENORIGUAL ||
        _expresion.tipo === TIPO_OPERACION.MAYOR || _expresion.tipo === TIPO_OPERACION.MAYORIGUAL) {
        return Relacional(_expresion, _ambito)
    }
    else if (_expresion.tipo === TIPO_OPERACION.OR || _expresion.tipo === TIPO_OPERACION.AND || _expresion.tipo === TIPO_OPERACION.NOT) {
        return Logica(_expresion, _ambito)
    }
    else if (_expresion.tipo === TIPO_INSTRUCCION.TERNARIO) {
        return operadorTernario(_expresion, _ambito)
    }
    else if (_expresion.tipo === TIPO_INSTRUCCION.CASTEO) {
        return casteo(_expresion, _ambito)
    }
    else if (_expresion.tipo === TIPO_INSTRUCCION.ACCESO) {
        switch (_expresion.tipo_dato) {
            case TIPO_DATO.VECTOR:
                return AccesoVector(_expresion, _ambito);
            case TIPO_DATO.LISTA:
                return accesoLista(_expresion, _ambito);
        }
    }
    else if (_expresion.tipo === TIPO_INSTRUCCION.TO_LOWER) {
        return to_Lower(_expresion, _ambito);
    }
    else if (_expresion.tipo === TIPO_INSTRUCCION.TO_UPPER) {
        return to_Upper(_expresion, _ambito);
    }
    else if (_expresion.tipo === TIPO_INSTRUCCION.LENGTH) {
        return get_length(_expresion, _ambito);
    }
    else if (_expresion.tipo === TIPO_INSTRUCCION.TRUNCATE) {
        return truncate(_expresion, _ambito);
    }
    else if (_expresion.tipo === TIPO_INSTRUCCION.ROUND) {
        return round(_expresion, _ambito);
    }
    else if (_expresion.tipo === TIPO_INSTRUCCION.TYPEOF) {
        return typeOf(_expresion, _ambito);
    }
    else if(_expresion.tipo === TIPO_INSTRUCCION.CARACTEROFPOSITION){
        return CaracterOfPosition(_expresion, _ambito);
    }
    else if (_expresion.tipo === TIPO_INSTRUCCION.SUBSTRING){
        return SubString(_expresion, _ambito);
    }
    else if (_expresion.tipo === TIPO_INSTRUCCION.TOSTRING) {
        return to_String(_expresion, _ambito);
    }
    else if (_expresion.tipo === TIPO_INSTRUCCION.TOCHARLIST) {
        return to_CharList(_expresion, _ambito);
    }
    else if (_expresion.tipo === TIPO_INSTRUCCION.LLAMADA) {
        var retorno = Ll_Metodo(_expresion, _ambito);
        if (retorno.err) return retorno;
        if (retorno.retorno == null)
            return { err: `Error: El método '${_expresion.nombre}' no retorna ningún valor.\nLínea: ${_expresion.linea} Columna: ${_expresion.columna}.\n` };
        if (retorno.retorno != null) {
            if (retorno.retorno.retorno) {
                retorno.cadena = retorno.retorno.cadena;
                retorno.retorno = retorno.retorno.retorno;
            }
        }
        return retorno;
    }
    else {
        return { err: `Error. Expresión no procesada.\nLínea: ${_expresion.linea} Columna: ${_expresion.columna}\n` };
    }
}