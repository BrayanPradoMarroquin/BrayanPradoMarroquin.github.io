function Aritmetica(_expresion, _ambito) {
    switch (_expresion.tipo) {
        case TIPO_OPERACION.SUMA:
            return suma(_expresion.opIzq, _expresion.opDer, _ambito)

        case TIPO_OPERACION.RESTA:
            return resta(_expresion.opIzq, _expresion.opDer, _ambito)

        case TIPO_OPERACION.MULTIPLICACION:
            return multiplicacion(_expresion.opIzq, _expresion.opDer, _ambito)

        case TIPO_OPERACION.DIVISION:
            return division(_expresion.opIzq, _expresion.opDer, _ambito)

        case TIPO_OPERACION.POTENCIA:
            return potencia(_expresion.opIzq, _expresion.opDer, _ambito)

        case TIPO_OPERACION.RAIZ:
            return raiz(_expresion.opDer, _ambito)

        case TIPO_OPERACION.MODULO:
            return modulo(_expresion.opIzq, _expresion.opDer, _ambito)

        case TIPO_OPERACION.NEGACION:
            return negacion(_expresion.opIzq, _ambito)

        case TIPO_OPERACION.SENO:
            return seno(_expresion.opDer, _ambito)
        
        case TIPO_OPERACION.COSENO:
            return coseno(_expresion.opDer, _ambito)

        case TIPO_OPERACION.TANGETE:
            return tangente(_expresion.opDer, _ambito)

        case TIPO_OPERACION.LOGARITMO:
            return logaritmo(_expresion.opDer, _ambito)

        default:
            break;
    }
}

//LISTA PARA EJECUTAR
function suma(_opIzq, _opDer, _ambito) {
    var cadena = "";
    var opIzq = Operacion(_opIzq, _ambito); if (opIzq.err) return opIzq;
    if (opIzq.cadena) cadena = opIzq.cadena;
    if (opIzq.retorno)
        opIzq = opIzq.retorno;
    var opDer = Operacion(_opDer, _ambito); if (opDer.err) return opDer;
    if (opDer.cadena) cadena = opDer.cadena;
    if (opDer.retorno)
        opDer = opDer.retorno;
    const tipoRes = TipoResultado(opIzq.tipo, opDer.tipo, TIPO_OPERACION.SUMA)
    var op1, op2, resultado;
    if (tipoRes != null) {
        switch (tipoRes) {
            case TIPO_DATO.ENTERO:
                op1 = 0;
                op2 = 0;
                if (opIzq.tipo == TIPO_DATO.CARACTER)
                    op1 = opIzq.valor.charCodeAt(0);
                else
                    op1 = Number(opIzq.valor);

                if (opDer.tipo == TIPO_DATO.CARACTER)
                    op2 = opDer.valor.charCodeAt(0);
                else
                    op2 = Number(opDer.valor);
               //PARA CUANDO ES LA PRIMERA RONDA DE VALORES
               if((opIzq.ubicacion==null) && (opDer.ubicacion==null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "+", _opDer.valor, _opDer.tipo)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DE LOS DOS LADOS
                }else if((opIzq.ubicacion!=null) && (opDer.ubicacion!=null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "+", opDer.ubicacion, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO IZQUIERDO 
                }else if((opIzq.ubicacion!=null) && (opDer.ubicacion==null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "+", _opDer.valor, _opDer.tipo)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO DERECHO
                }else if((opIzq.ubicacion==null) && (opDer.ubicacion!=null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "+", opDer.ubicacion, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                }
                resultado = op1 + op2;
                return {
                    valor: resultado,
                    tipo: tipoRes,
                    linea: _opIzq.linea,
                    columna: _opIzq.columna,
                    cadena: cadena,
                    ubicacion: respuesta.ubicacion
                }

            case TIPO_DATO.DOBLE:
                op1 = 0.0;
                op2 = 0.0;
                if (opIzq.tipo == TIPO_DATO.CARACTER)
                    op1 = opIzq.valor.charCodeAt(0);
                else
                    op1 = Number(opIzq.valor);

                if (opDer.tipo == TIPO_DATO.CARACTER)
                    op2 = opDer.valor.charCodeAt(0);
                else
                    op2 = Number(opDer.valor);
                //PARA CUANDO ES LA PRIMERA RONDA DE VALORES
                if((opIzq.ubicacion==null) && (opDer.ubicacion==null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "+", _opDer.valor, _opDer.tipo)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DE LOS DOS LADOS
                }else if((opIzq.ubicacion!=null) && (opDer.ubicacion!=null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "+", opDer.ubicacion, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO IZQUIERDO 
                }else if((opIzq.ubicacion!=null) && (opDer.ubicacion==null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "+", _opDer.valor, _opDer.tipo)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO DERECHO
                }else if((opIzq.ubicacion==null) && (opDer.ubicacion!=null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "+", opDer.ubicacion, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                }
                resultado = op1 + op2;
                return {
                    valor: resultado,
                    tipo: tipoRes,
                    linea: _opIzq.linea,
                    columna: _opIzq.columna,
                    cadena: cadena,
                    ubicacion: respuesta.ubicacion
                }

            case TIPO_DATO.CADENA:
                resultado = ""
                if(opIzq.tipo === TIPO_DATO.LISTA){
                    resultado = opIzq.print_val + opDer.valor.toString();
                }else{
                    resultado = opIzq.valor.toString() + opDer.valor.toString();
                }
                
                if(opDer.tipo === TIPO_DATO.LISTA){
                    resultado = opIzq.valor.toString() + opDer.print_val;
                }else{
                    resultado = opIzq.valor.toString() + opDer.valor.toString();
                }
                return {
                    valor: resultado,
                    tipo: tipoRes,
                    linea: _opIzq.linea,
                    columna: _opIzq.columna,
                    cadena: cadena
                }

            default:
                break;
        }
    }
    var respuesta = (opIzq.tipo === null ? opIzq.valor : "") + (opDer.tipo === null ? opDer.valor : "")
    return {
        err: respuesta + '\nError: no se puede realizar la operación suma.\nLínea: ' + _opIzq.linea + " Columna: " + _opIzq.columna + "\n",
        tipo: null,
        linea: _opIzq.linea,
        columna: _opIzq.columna
    }
}

//LISTA PARA EJECUTAR
function resta(_opIzq, _opDer, _ambito) {
    var cadena = "";
    var opIzq = Operacion(_opIzq, _ambito); if (opIzq.err) return opIzq;
    if (opIzq.cadena) cadena = opIzq.cadena;
    if (opIzq.retorno)
        opIzq = opIzq.retorno;
    var opDer = Operacion(_opDer, _ambito); if (opDer.err) return opDer;
    if (opDer.cadena) cadena = opDer.cadena;
    if (opDer.retorno)
        opDer = opDer.retorno;
    const tipoRes = TipoResultado(opIzq.tipo, opDer.tipo, TIPO_OPERACION.RESTA)
    var op1, op2, resultado;
    if (tipoRes != null) {
        switch (tipoRes) {
            case TIPO_DATO.ENTERO:
                op1 = 0;
                op2 = 0;
                if (opIzq.tipo == TIPO_DATO.CARACTER)
                    op1 = opIzq.valor.charCodeAt(0);
                else
                    op1 = Number(opIzq.valor);

                if (opDer.tipo == TIPO_DATO.CARACTER)
                    op2 = opDer.valor.charCodeAt(0);
                else
                    op2 = Number(opDer.valor);
                //PARA CUANDO ES LA PRIMERA RONDA DE VALORES
                if((opIzq.ubicacion==null) && (opDer.ubicacion==null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "-", _opDer.valor, _opDer.tipo)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DE LOS DOS LADOS
                }else if((opIzq.ubicacion!=null) && (opDer.ubicacion!=null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "-", opDer.ubicacion, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO IZQUIERDO 
                }else if((opIzq.ubicacion!=null) && (opDer.ubicacion==null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "-", _opDer.valor, _opDer.tipo)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO DERECHO
                }else if((opIzq.ubicacion==null) && (opDer.ubicacion!=null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "-", opDer.ubicacion, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                }
                resultado = op1 - op2;
                return {
                    valor: resultado,
                    tipo: tipoRes,
                    linea: _opIzq.linea,
                    columna: _opIzq.columna,
                    cadena: cadena,
                    ubicacion: respuesta.ubicacion
                }

            case TIPO_DATO.DOBLE:
                op1 = 0.0;
                op2 = 0.0;
                if (opIzq.tipo == TIPO_DATO.CARACTER)
                    op1 = opIzq.valor.charCodeAt(0);
                else
                    op1 = Number(opIzq.valor);

                if (opDer.tipo == TIPO_DATO.CARACTER)
                    op2 = opDer.valor.charCodeAt(0);
                else
                    op2 = Number(opDer.valor);
                //PARA CUANDO ES LA PRIMERA RONDA DE VALORES
                if((opIzq.ubicacion==null) && (opDer.ubicacion==null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "-", _opDer.valor, _opDer.tipo)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DE LOS DOS LADOS
                }else if((opIzq.ubicacion!=null) && (opDer.ubicacion!=null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "-", opDer.ubicacion, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO IZQUIERDO 
                }else if((opIzq.ubicacion!=null) && (opDer.ubicacion==null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "-", _opDer.valor, _opDer.tipo)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO DERECHO
                }else if((opIzq.ubicacion==null) && (opDer.ubicacion!=null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "-", opDer.ubicacion, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                }
                resultado = op1 - op2;
                return {
                    valor: resultado,
                    tipo: tipoRes,
                    linea: _opIzq.linea,
                    columna: _opIzq.columna,
                    cadena: cadena,
                    ubicacion: respuesta.ubicacion
                }

            default:
                break;
        }
    }
    var respuesta = (opIzq.tipo === null ? opIzq.valor : "") + (opDer.tipo === null ? opDer.valor : "")
    return {
        err: respuesta + '\nError: no se puede realizar la operación resta.\nLínea: ' + _opIzq.linea + " Columna: " + _opIzq.columna + "\n",
        tipo: null,
        linea: _opIzq.linea,
        columna: _opIzq.columna
    }
}

//LISTA PARA EJECUTAR
function multiplicacion(_opIzq, _opDer, _ambito) {
    var cadena = "";
    var opIzq = Operacion(_opIzq, _ambito); if (opIzq.err) return opIzq;
    if (opIzq.cadena) cadena = opIzq.cadena;
    if (opIzq.retorno)
        opIzq = opIzq.retorno;
    var opDer = Operacion(_opDer, _ambito); if (opDer.err) return opDer;
    if (opDer.cadena) cadena = opDer.cadena;
    if (opDer.retorno)
        opDer = opDer.retorno;
    const tipoRes = TipoResultado(opIzq.tipo, opDer.tipo, TIPO_OPERACION.MULTIPLICACION)
    var op1, op2, resultado, trad;
    if (tipoRes != null) {
        switch (tipoRes) {
            case TIPO_DATO.ENTERO:
                op1 = 0;
                op2 = 0;
                if (opIzq.tipo == TIPO_DATO.CARACTER)
                    op1 = opIzq.valor.charCodeAt(0);
                else
                    op1 = Number(opIzq.valor);

                if (opDer.tipo == TIPO_DATO.CARACTER)
                    op2 = opDer.valor.charCodeAt(0);
                else
                    op2 = Number(opDer.valor);
                if((_opIzq.valor!=null) && (_opDer.valor!=null)){
                    //PARA CUANDO ES LA PRIMERA RONDA DE VALORES
                    if((opIzq.ubicacion==null) && (opDer.ubicacion==null)){
                        respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "*", _opDer.valor, _opDer.tipo)
                        Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                    //PARA CUANDO HUBIERON OPERACIONES DE LOS DOS LADOS
                    }else if((opIzq.ubicacion!=null) && (opDer.ubicacion!=null)){
                        respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "*", opDer.ubicacion, "GUARDA")
                        Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                    //PARA CUANDO HUBIERON OPERACIONES DEL LADO IZQUIERDO 
                    }else if((opIzq.ubicacion!=null) && (opDer.ubicacion==null)){
                        respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "*", _opDer.valor, _opDer.tipo)
                        Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                    //PARA CUANDO HUBIERON OPERACIONES DEL LADO DERECHO
                    }else if((opIzq.ubicacion==null) && (opDer.ubicacion!=null)){
                        respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "*", opDer.ubicacion, "GUARDA")
                        Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                    }
                }
                
                resultado = op1 * op2;
                //if((_opIzq.valor!=null) && (_opDer.valor!=null)){
                    return {
                        valor: resultado,
                        tipo: tipoRes,
                        linea: _opIzq.linea,
                        columna: _opIzq.columna,
                        cadena: cadena,
                        ubicacion: respuesta.ubicacion
                    }    
               /* }else{
                    return {
                        valor: resultado,
                        tipo: tipoRes,
                        linea: _opIzq.linea,
                        columna: _opIzq.columna,
                        cadena: cadena
                    //}
                }*/
                
            case TIPO_DATO.DOBLE:
                op1 = 0.0;
                op2 = 0.0;
                if (opIzq.tipo == TIPO_DATO.CARACTER)
                    op1 = opIzq.valor.charCodeAt(0);
                else
                    op1 = Number(opIzq.valor);

                if (opDer.tipo == TIPO_DATO.CARACTER)
                    op2 = opDer.valor.charCodeAt(0);
                else
                    op2 = Number(opDer.valor);
                                if (opDer.tipo == TIPO_DATO.CARACTER)
                    op2 = opDer.valor.charCodeAt(0);
                else
                    op2 = Number(opDer.valor);
                if((_opIzq.valor!=null) && (_opDer.valor!=null)){
                        //PARA CUANDO ES LA PRIMERA RONDA DE VALORES
                    if((opIzq.ubicacion==null) && (opDer.ubicacion==null)){
                        respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "*", _opDer.valor, _opDer.tipo)
                        Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                    //PARA CUANDO HUBIERON OPERACIONES DE LOS DOS LADOS
                    }else if((opIzq.ubicacion!=null) && (opDer.ubicacion!=null)){
                        respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "*", opDer.ubicacion, "GUARDA")
                        Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                    //PARA CUANDO HUBIERON OPERACIONES DEL LADO IZQUIERDO 
                    }else if((opIzq.ubicacion!=null) && (opDer.ubicacion==null)){
                        respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "*", _opDer.valor, _opDer.tipo)
                        Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                    //PARA CUANDO HUBIERON OPERACIONES DEL LADO DERECHO
                    }else if((opIzq.ubicacion==null) && (opDer.ubicacion!=null)){
                        respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "*", opDer.ubicacion, "GUARDA")
                        Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                    }
                }
                resultado = op1 * op2;
                return {
                    valor: resultado,
                    tipo: tipoRes,
                    linea: _opIzq.linea,
                    columna: _opIzq.columna,
                    cadena: cadena,
                    ubicacion: respuesta.ubicacion
                }

            default:
                break;
        }
    }
    var respuesta = (opIzq.tipo === null ? opIzq.valor : "") + (opDer.tipo === null ? opDer.valor : "")
    return {
        err: respuesta + '\nError: no se puede realizar la operación multiplicación.\nLínea: ' + _opIzq.linea + " Columna: " + _opIzq.columna + "\n",
        tipo: null,
        linea: _opIzq.linea,
        columna: _opIzq.columna
    }
}

//LISTA PARA EJECUTAR
function division(_opIzq, _opDer, _ambito) {
    var cadena = "";
    var opIzq = Operacion(_opIzq, _ambito); if (opIzq.err) return opIzq;
    if (opIzq.cadena) cadena = opIzq.cadena;
    if (opIzq.retorno)
        opIzq = opIzq.retorno;
    var opDer = Operacion(_opDer, _ambito); if (opDer.err) return opDer;
    if (opDer.cadena) cadena = opDer.cadena;
    if (opDer.retorno)
        opDer = opDer.retorno;
    const tipoRes = TipoResultado(opIzq.tipo, opDer.tipo, TIPO_OPERACION.DIVISION)
    var op1, op2, resultado;
    if (tipoRes != null) {
        switch (tipoRes) {

            case TIPO_DATO.DOBLE:
                op1 = 0.0;
                op2 = 0.0;
                if (opIzq.tipo == TIPO_DATO.CARACTER)
                    op1 = opIzq.valor.charCodeAt(0);
                else
                    op1 = Number(opIzq.valor);

                if (opDer.tipo == TIPO_DATO.CARACTER)
                    op2 = opDer.valor.charCodeAt(0);
                else
                    op2 = Number(opDer.valor);
                if (op2 == 0) {
                    return {
                        err: '\nError: no es permitida la división entre 0.\nLínea: ' + _opDer.linea + " Columna: " + _opDer.columna + "\n",
                        tipo: null,
                        linea: _opDer.linea,
                        columna: _opDer.columna
                    }
                }
                //PARA CUANDO ES LA PRIMERA RONDA DE VALORES
                if((opIzq.ubicacion==null) && (opDer.ubicacion==null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "/", _opDer.valor, _opDer.tipo)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DE LOS DOS LADOS
                }else if((opIzq.ubicacion!=null) && (opDer.ubicacion!=null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "/", opDer.ubicacion, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO IZQUIERDO 
                }else if((opIzq.ubicacion!=null) && (opDer.ubicacion==null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "/", _opDer.valor, _opDer.tipo)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO DERECHO
                }else if((opIzq.ubicacion==null) && (opDer.ubicacion!=null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "/", opDer.ubicacion, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                }
                resultado = op1 / op2;
                return {
                    valor: resultado,
                    tipo: tipoRes,
                    linea: _opIzq.linea,
                    columna: _opIzq.columna,
                    cadena: cadena,
                    ubicacion: respuesta.ubicacion
                }

            default:
                break;
        }
    }
    var respuesta = (opIzq.tipo === null ? opIzq.valor : "") + (opDer.tipo === null ? opDer.valor : "")
    return {
        err: respuesta + '\nError: no se puede realizar la operación división.\nLínea: ' + _opIzq.linea + " Columna: " + _opIzq.columna + "\n",
        tipo: null,
        linea: _opIzq.linea,
        columna: _opIzq.columna
    }
}

//PENDIENTE PARA VER COMO EJECUTARLA 
function potencia(_opIzq, _opDer, _ambito) {
    var cadena = "";
    var opIzq = Operacion(_opIzq, _ambito); if (opIzq.err) return opIzq;
    if (opIzq.cadena) cadena = opIzq.cadena;
    if (opIzq.retorno)
        opIzq = opIzq.retorno;
    var opDer = Operacion(_opDer, _ambito); if (opDer.err) return opDer;
    if (opDer.cadena) cadena = opDer.cadena;
    if (opDer.retorno)
        opDer = opDer.retorno;
    const tipoRes = TipoResultado(opIzq.tipo, opDer.tipo, TIPO_OPERACION.POTENCIA)
    var op1, op2, resultado;
    if (tipoRes != null) {
        switch (tipoRes) {
            case TIPO_DATO.ENTERO:
                op1 = 0;
                op2 = 0;
                if (opIzq.tipo == TIPO_DATO.CARACTER)
                    op1 = opIzq.valor.charCodeAt(0);
                else
                    op1 = Number(opIzq.valor);

                if (opDer.tipo == TIPO_DATO.CARACTER)
                    op2 = opDer.valor.charCodeAt(0);
                else
                    op2 = Number(opDer.valor);
                    //PARA CUANDO ES LA PRIMERA RONDA DE VALORES
                if((opIzq.ubicacion==null) && (opDer.ubicacion==null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "POTENCIA", _opDer.valor, _opDer.tipo)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DE LOS DOS LADOS
                }else if((opIzq.ubicacion!=null) && (opDer.ubicacion!=null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "POTENCIA", opDer.ubicacion, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO IZQUIERDO 
                }else if((opIzq.ubicacion!=null) && (opDer.ubicacion==null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "POTENCIA", _opDer.valor, _opDer.tipo)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO DERECHO
                }else if((opIzq.ubicacion==null) && (opDer.ubicacion!=null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "POTENCIA", opDer.ubicacion, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                }
                resultado = op1 ** op2;
                return {
                    valor: resultado,
                    tipo: tipoRes,
                    linea: _opIzq.linea,
                    columna: _opIzq.columna,
                    cadena: cadena,
                    ubicacion: respuesta.ubicacion
                }
            case TIPO_DATO.DOBLE:
                op1 = 0.0;
                op2 = 0.0;
                if (opIzq.tipo == TIPO_DATO.CARACTER)
                    op1 = opIzq.valor.charCodeAt(0);
                else
                    op1 = Number(opIzq.valor);

                if (opDer.tipo == TIPO_DATO.CARACTER)
                    op2 = opDer.valor.charCodeAt(0);
                else
                    op2 = Number(opDer.valor);
                //PARA CUANDO ES LA PRIMERA RONDA DE VALORES
                if((opIzq.ubicacion==null) && (opDer.ubicacion==null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "POTENCIA", _opDer.valor, _opDer.tipo)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DE LOS DOS LADOS
                }else if((opIzq.ubicacion!=null) && (opDer.ubicacion!=null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "POTENCIA", opDer.ubicacion, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO IZQUIERDO 
                }else if((opIzq.ubicacion!=null) && (opDer.ubicacion==null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "POTENCIA", _opDer.valor, _opDer.tipo)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO DERECHO
                }else if((opIzq.ubicacion==null) && (opDer.ubicacion!=null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "POTENCIA", opDer.ubicacion, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                }
                resultado = op1 ** op2;
                return {
                    valor: resultado,
                    tipo: tipoRes,
                    linea: _opIzq.linea,
                    columna: _opIzq.columna,
                    cadena: cadena,
                    ubicacion: respuesta.ubicacion
                }
            case TIPO_DATO.CADENA:
                op1 = 0;
                op2 = 0;
                if (opIzq.tipo == TIPO_DATO.CARACTER)
                    op1 = opIzq.valor.charCodeAt(0);
                else
                    op1 = (opIzq.valor);

                if (opDer.tipo == TIPO_DATO.CARACTER)
                    op2 = opDer.valor.charCodeAt(0);
                else
                    op2 = Number(opDer.valor);
                    for(let i =0; i <op2; i++){
                        if(i==0){
                            resultado = op1;
                        }else{
                            resultado = resultado + op1;
                        }
                    }
                    resultado = resultado;
                return {
                    valor: resultado,
                    tipo: tipoRes,
                    linea: _opIzq.linea,
                    columna: _opIzq.columna,
                    cadena: cadena
                }
            default:
                break;
        }
    }
    var respuesta = (opIzq.tipo === null ? opIzq.valor : "") + (opDer.tipo === null ? opDer.valor : "")
    return {
        err: respuesta + '\nError: no se puede realizar la operación potencia.\nLínea: ' + _opIzq.linea + " Columna: " + _opIzq.columna + "\n",
        tipo: null,
        linea: _opIzq.linea,
        columna: _opIzq.columna
    }
}

//PENDIENTE PARA VER COMO EJECUTARLA
function modulo(_opIzq, _opDer, _ambito) {
    var cadena = "";
    var opIzq = Operacion(_opIzq, _ambito); if (opIzq.err) return opIzq;
    if (opIzq.cadena) cadena = opIzq.cadena;
    if (opIzq.retorno)
        opIzq = opIzq.retorno;
    var opDer = Operacion(_opDer, _ambito); if (opDer.err) return opDer;
    if (opDer.cadena) cadena = opDer.cadena;
    if (opDer.retorno)
        opDer = opDer.retorno;
    const tipoRes = TipoResultado(opIzq.tipo, opDer.tipo, TIPO_OPERACION.MODULO)
    var op1, op2, resultado;
    if (tipoRes != null) {
        switch (tipoRes) {

            case TIPO_DATO.DOBLE:
                op1 = 0.0;
                op2 = 0.0;
                if (opIzq.tipo == TIPO_DATO.CARACTER)
                    op1 = opIzq.valor.charCodeAt(0);
                else
                    op1 = Number(opIzq.valor);

                if (opDer.tipo == TIPO_DATO.CARACTER)
                    op2 = opDer.valor.charCodeAt(0);
                else
                    op2 = Number(opDer.valor);
                if (op2 == 0) {
                    return {
                        err: '\nError: no es permitida la operación módulo 0.\nLínea: ' + _opDer.linea + " Columna: " + _opDer.columna + "\n",
                        tipo: null,
                        linea: _opDer.linea,
                        columna: _opDer.columna
                    }
                }
                //PARA CUANDO ES LA PRIMERA RONDA DE VALORES
                if((opIzq.ubicacion==null) && (opDer.ubicacion==null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "fmod", _opDer.valor, _opDer.tipo)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DE LOS DOS LADOS
                }else if((opIzq.ubicacion!=null) && (opDer.ubicacion!=null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "fmod", opDer.ubicacion, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO IZQUIERDO 
                }else if((opIzq.ubicacion!=null) && (opDer.ubicacion==null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "fmod", _opDer.valor, _opDer.tipo)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO DERECHO
                }else if((opIzq.ubicacion==null) && (opDer.ubicacion!=null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "fmod", opDer.ubicacion, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                }
                resultado = op1 % op2;
                return {
                    valor: resultado,
                    tipo: tipoRes,
                    linea: _opIzq.linea,
                    columna: _opIzq.columna,
                    cadena: cadena,
                    ubicacion: respuesta.ubicacion
                }

            default:
                break;
        }
    }
    var respuesta = (opIzq.tipo === null ? opIzq.valor : "") + (opDer.tipo === null ? opDer.valor : "")
    return {
        err: respuesta + '\nError: no se puede realizar la operación módulo.\nLínea: ' + _opIzq.linea + " Columna: " + _opIzq.columna + "\n",
        tipo: null,
        linea: _opIzq.linea,
        columna: _opIzq.columna
    }
}

//PENDIENTE PARA VER COMO EJECUTARLA
function negacion(_opIzq, _ambito) {
    var cadena = "";
    var opIzq = Operacion(_opIzq, _ambito); if (opIzq.err) return opIzq;
    if (opIzq.cadena) cadena = opIzq.cadena;
    if (opIzq.retorno)
        opIzq = opIzq.retorno;
    const tipoRes = TipoResultado(opIzq.tipo, null, TIPO_OPERACION.NEGACION)
    var resultado;
    if (tipoRes != null) {
        switch (tipoRes) {
            case TIPO_DATO.ENTERO:
                resultado = 0 - Number(opIzq.valor)
                return {
                    valor: resultado,
                    tipo: tipoRes,
                    linea: _opIzq.linea,
                    columna: _opIzq.columna,
                    cadena: cadena
                }

            case TIPO_DATO.DOBLE:
                resultado = 0.0 - Number(opIzq.valor)
                return {
                    valor: resultado,
                    tipo: tipoRes,
                    linea: _opIzq.linea,
                    columna: _opIzq.columna,
                    cadena: cadena
                }

            default:
                break;
        }
    }
    var respuesta = opIzq.tipo === null ? opIzq.valor : "";
    return {
        err: respuesta + '\nError: no se puede realizar la operación negación unaria.\nLínea: ' + _opIzq.linea + " Columna: " + _opIzq.columna + "\n",
        tipo: null,
        linea: _opIzq.linea,
        columna: _opIzq.columna
    }
}

//PENDIENTE PARA VER COMO EJECUTARLA
function seno(_opIzq, _ambito){
    var cadena = "";
    var opIzq = Operacion(_opIzq, _ambito); if (opIzq.err) return opIzq;
    if (opIzq.cadena) cadena = opIzq.cadena;
    if (opIzq.retorno)
        opIzq = opIzq.retorno;
    const tipoRes = TipoResultado(opIzq.tipo, null, TIPO_OPERACION.SENO);
    var resultado, respuesta;
    if (tipoRes != null) {
        switch (tipoRes) {
            case TIPO_DATO.DOBLE:
                //PARA CUANDO ES LA PRIMERA RONDA DE VALORES
                if((opIzq.ubicacion==null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "SENO", 0, null)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DE LOS DOS LADOS
                }else if((opIzq.ubicacion!=null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "SENO", 0, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO IZQUIERDO 
                }else if((opIzq.ubicacion!=null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "SENO", 0, null)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO DERECHO
                }else if((opIzq.ubicacion==null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "SENO", 0, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                }
                resultado = Math.sin(Number(opIzq.valor)) 
                return {
                    valor: resultado,
                    tipo: tipoRes,
                    linea: _opIzq.linea,
                    columna: _opIzq.columna,
                    cadena: cadena, 
                    ubicacion: respuesta.ubicacion 
                }
            default:
                break;
        }
    }
}

//PENDIENTE PARA VER COMO EJECUTARLA
function coseno(_opIzq, _ambito){
    var cadena = "";
    var opIzq = Operacion(_opIzq, _ambito); if (opIzq.err) return opIzq;
    if (opIzq.cadena) cadena = opIzq.cadena;
    if (opIzq.retorno)
        opIzq = opIzq.retorno;
    const tipoRes = TipoResultado(opIzq.tipo, null, TIPO_OPERACION.COSENO);
    var resultado;
    if (tipoRes != null) {
        switch (tipoRes) {
            case TIPO_DATO.DOBLE:
                //PARA CUANDO ES LA PRIMERA RONDA DE VALORES
                if((opIzq.ubicacion==null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "COSENO", 0, null)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DE LOS DOS LADOS
                }else if((opIzq.ubicacion!=null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "COSENO", 0, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO IZQUIERDO 
                }else if((opIzq.ubicacion!=null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "COSENO", 0, null)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO DERECHO
                }else if((opIzq.ubicacion==null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "COSENO", 0, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                }
                resultado = Math.cos(Number(opIzq.valor)) 
                return {
                    valor: resultado,
                    tipo: tipoRes,
                    linea: _opIzq.linea,
                    columna: _opIzq.columna,
                    cadena: cadena,
                    ubicacion: respuesta.ubicacion
                }
            default:
                break;
        }
    }
}

//PENDIENTE PARA VER COMO EJECUTARLA
function tangente(_opIzq, _ambito){
    var cadena = "";
    var opIzq = Operacion(_opIzq, _ambito); if (opIzq.err) return opIzq;
    if (opIzq.cadena) cadena = opIzq.cadena;
    if (opIzq.retorno)
        opIzq = opIzq.retorno;
    const tipoRes = TipoResultado(opIzq.tipo, null, TIPO_OPERACION.TANGETE);
    var resultado;
    if (tipoRes != null) {
        switch (tipoRes) {
            case TIPO_DATO.DOBLE:
                if((opIzq.ubicacion==null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "TAN", 0, null)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DE LOS DOS LADOS
                }else if((opIzq.ubicacion!=null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "TAN", 0, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO IZQUIERDO 
                }else if((opIzq.ubicacion!=null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "TAN", 0, null)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO DERECHO
                }else if((opIzq.ubicacion==null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "TAN", 0, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                }
                resultado = Math.tan(Number(opIzq.valor)) 
                return {
                    valor: resultado,
                    tipo: tipoRes,
                    linea: _opIzq.linea,
                    columna: _opIzq.columna,
                    cadena: cadena,
                    ubicacion: respuesta.ubicacion
                }
            default:
                break;
        }
    }
}

//PENDIENTE PARA VER COMO EJECUTARLA
function logaritmo(_opIzq, _ambito){
    var cadena = "";
    var opIzq = Operacion(_opIzq, _ambito); if (opIzq.err) return opIzq;
    if (opIzq.cadena) cadena = opIzq.cadena;
    if (opIzq.retorno)
        opIzq = opIzq.retorno;
    const tipoRes = TipoResultado(opIzq.tipo, null, TIPO_OPERACION.LOGARITMO);
    var resultado;
    if (tipoRes != null) {
        switch (tipoRes) {
            case TIPO_DATO.DOBLE:
                if((opIzq.ubicacion==null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "LOG", 0, null)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DE LOS DOS LADOS
                }else if((opIzq.ubicacion!=null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "LOG", 0, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO IZQUIERDO 
                }else if((opIzq.ubicacion!=null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "LOG", 0, null)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO DERECHO
                }else if((opIzq.ubicacion==null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "LOG", 0, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                }
                resultado = Math.log10(Number(opIzq.valor)) 
                return {
                    valor: resultado,
                    tipo: tipoRes,
                    linea: _opIzq.linea,
                    columna: _opIzq.columna,
                    cadena: cadena,
                    ubicacion: respuesta.ubicacion
                }
            default:
                break;
        }
    }
}

//PENDIENTE PARA VER COMO EJECUTARLA
function raiz(_opIzq, _ambito){
    var cadena = "";
    var opIzq = Operacion(_opIzq, _ambito); if (opIzq.err) return opIzq;
    if (opIzq.cadena) cadena = opIzq.cadena;
    if (opIzq.retorno)
        opIzq = opIzq.retorno;
    const tipoRes = TipoResultado(opIzq.tipo, null, TIPO_OPERACION.RAIZ);
    var resultado, respuesta;
    if (tipoRes != null) {
        switch (tipoRes) {
            case TIPO_DATO.DOBLE:
                //PARA CUANDO ES LA PRIMERA RONDA DE VALORES
                if((opIzq.ubicacion==null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "RAIZ", 0, null)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DE LOS DOS LADOS
                }else if((opIzq.ubicacion!=null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "RAIZ", 0, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO IZQUIERDO 
                }else if((opIzq.ubicacion!=null)){
                    respuesta = T_Aritmetica(opIzq.ubicacion, "GUARDA", "RAIZ", 0, null)
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                //PARA CUANDO HUBIERON OPERACIONES DEL LADO DERECHO
                }else if((opIzq.ubicacion==null)){
                    respuesta = T_Aritmetica(_opIzq.valor, _opIzq.tipo, "RAIZ", 0, "GUARDA")
                    Lista_Traducciones.push(new Traductor_id(respuesta.ubicacion, null, respuesta.traducciones, null, "ARITMETICA"))
                }
                resultado = Math.sqrt(Number(opIzq.valor)) 
                return {
                    valor: resultado,
                    tipo: tipoRes,
                    linea: _opIzq.linea,
                    columna: _opIzq.columna,
                    cadena: cadena,
                    ubicacion: respuesta.ubicacion
                }
            default:
                break;
        }
    }
}

