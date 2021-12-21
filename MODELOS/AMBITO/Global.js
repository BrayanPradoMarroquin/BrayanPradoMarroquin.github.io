function Global(_instrucciones, _ambito) {
    var cadena = { cadena: "", errores: [] };

    var contStart = 0;
    for (let i = 0; i < _instrucciones.length; i++) {
        if (_instrucciones[i].tipo === TIPO_INSTRUCCION.MAIN) {
            contStart++;
            if (contStart > 1) {
                cadena.cadena = `Error: No es posible ejecutar más de un Main.\nLínea: ${String(_instrucciones[i].linea)} Columna: ${String(_instrucciones[i].columna)}\n`;
                cadena.errores.push({
                    tipo: 'Semántico',
                    error: "No es posible ejecutar más de un Main.",
                    linea: _instrucciones[i].linea,
                    columna: _instrucciones[i].columna
                });
                return cadena;
            }

        }
    }
    if (contStart == 0) {
        cadena.cadena = `Error: No se ha encontrado ninguna sentencia Main.\n`;
        cadena.errores.push({
            tipo: 'Semántico',
            error: "No se ha encontrado ninguna sentencia Main.",
            linea: "-",
            columna: "-"
        });
        return cadena;
    }

    for (let i = 0; i < _instrucciones.length; i++) {
        if (_instrucciones[i].tipo === TIPO_INSTRUCCION.NUEVO_METODO) {
            var mensaje = DecMetodo(_instrucciones[i], _ambito)
            if (mensaje != null) {
                var error = String(mensaje);
                cadena.cadena += error;
                cadena.errores.push({
                    tipo: 'Semántico',
                    error: error.substring(error.indexOf("Error") + 7, error.indexOf("Línea") - 1),
                    linea: error.substring(error.indexOf("Línea") + 7, error.indexOf("Columna") - 1),
                    columna: error.substring(error.indexOf("Columna") + 9),
                });
            }
        }else if (_instrucciones[i].tipo === TIPO_INSTRUCCION.NUEVA_FUNCION) {
            var mensaje = DecFuncion(_instrucciones[i], _ambito)
            if (mensaje != null) {
                var error = String(mensaje);
                cadena.cadena += error;
                cadena.errores.push({
                    tipo: 'Semántico',
                    error: error.substring(error.indexOf("Error") + 7, error.indexOf("Línea") - 1),
                    linea: error.substring(error.indexOf("Línea") + 7, error.indexOf("Columna") - 1),
                    columna: error.substring(error.indexOf("Columna") + 9),
                });
            }
        }
    }
    for (let i = 0; i < _instrucciones.length; i++) {
        if (_instrucciones[i].tipo === TIPO_INSTRUCCION.DECLARACION) {
            var mensaje = Declaracion(_instrucciones[i], _ambito)
            if (mensaje) {
                if (mensaje.cadena)
                    cadena.cadena += mensaje.cadena
                if (mensaje.err) {
                    var error = String(mensaje.err);
                    cadena.cadena += error;
                    cadena.errores.push({
                        tipo: 'Semántico',
                        error: error.substring(error.indexOf("Error") + 7, error.indexOf("Línea") - 1),
                        linea: error.substring(error.indexOf("Línea") + 7, error.indexOf("Columna") - 1),
                        columna: error.substring(error.indexOf("Columna") + 9),
                    });
                }
            }
        }else if (_instrucciones[i].tipo === TIPO_INSTRUCCION.ASIGNACION) {
            var mensaje = Asignacion(_instrucciones[i], _ambito)
            if (mensaje) {
                if (mensaje.cadena)
                    cadena.cadena += mensaje.cadena
                if (mensaje.err) {
                    var error = String(mensaje.err);
                    cadena.cadena += error;
                    cadena.errores.push({
                        tipo: 'Semántico',
                        error: error.substring(error.indexOf("Error") + 7, error.indexOf("Línea") - 1),
                        linea: error.substring(error.indexOf("Línea") + 7, error.indexOf("Columna") - 1),
                        columna: error.substring(error.indexOf("Columna") + 9),
                    });
                }
            }
        }
    }

    // Ejecutar Main
    var instruccion;
    for (let i = 0; i < _instrucciones.length; i++) {
        if (_instrucciones[i].tipo === TIPO_INSTRUCCION.MAIN) {
            instruccion = _instrucciones[i];
            break;
        }
    }
    var mensaje = StartWith(instruccion, _ambito)
    if (mensaje.cadena)
        cadena.cadena += mensaje.cadena
    if (mensaje.err) {
        var error = String(mensaje.err);
        cadena.cadena += error;
        cadena.errores.push({
            tipo: 'Semántico',
            error: error.substring(error.indexOf("Error") + 7, error.indexOf("Línea") - 1),
            linea: error.substring(error.indexOf("Línea") + 7, error.indexOf("Columna") - 1),
            columna: error.substring(error.indexOf("Columna") + 9),
        });
    }
    if (mensaje.errores) {
        for (let i = 0; i < mensaje.errores.length; i++) {
            const err = mensaje.errores[i];
            cadena.errores.push(err);
        }
    }

    return cadena
}