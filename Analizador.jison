%{
    var cadena = '';
    var errores = [];
%}

%lex

%x string 

%%

\s+                                           // Espacios en blanco
"//".*                                       // Comentarios de una linea
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]	        // Comentario Multilinea

"double"                return 'DOUBLE'
"int"                   return 'INT'
"boolean"               return 'BOOLEAN'
"char"                  return 'CHAR'
"float"                 return 'FLOAT'
"String"                return 'STRING'
"null"                  return 'NULL'

"if"					return 'TK_IF'
"else"					return 'TK_ELSE'
"switch"				return 'TK_SWITCH'
"case"					return 'TK_CASE'
"break"					return 'TK_BREAK'
"default"				return 'TK_DEFAULT'
"while"               	return 'TK_WHILE'
"for"					return 'TK_FOR'
"do"					return 'TK_DO'
"continue"				return 'TK_CONTINUE'
"return"				return 'TK_RETURN'
"void"					return 'TK_VOID'
"main"                  return 'TK_MAIN'
"++"					return 'INCREMENTO'
"--"					return 'DECREMENTO'
"in"                                    return 'IN'

"pow"                   return 'TK_POW'
"sqrt"                  return 'TK_SQRT'
"sin"                   return 'TK_SENO'
"cos"                   return 'TK_COSENO'
"tan"                   return 'TK_TANGENTE'
"log10"                 return 'TK_LOGARITMOB10'

"true"                	return 'TRUE'
"false"               	return 'FALSE'

"||"                   	return 'OR'
"&&"                   	return 'AND'

"!="                   	return 'DIFERENTEA'
"=="                   	return 'IGUALIGUAL'
"!"                   	return 'NOT'
"="			return 'IGUAL'
"<="                   	return 'MENORIGUAL'
">="			return 'MAYORIGUAL'
">"                   	return 'MAYOR'
"<"                   	return 'MENOR'

"&"                     return 'CONCATENADOCADENA'
"$"                     return "OPERACIONESALIMPRIMIR"
"#"                     return "OP_VECOTRES"

","                   	return 'TK_COMA'
";"                   	return 'TK_PYC'
"."			return 'TK_PUNTO'
":"			return 'TK_DOSPUNTS'

"*"                   	return 'OP_MULTIPLICACION'
"/"                   	return 'OP_DIVISION'
"-"                   	return 'OP_MENOS'
"+"                   	return 'OP_SUMA'
"^"                   	return 'OP_EXPONENTE'
"%"                   	return 'OP_MODULO'
"?"			return 'OP_TERNARIO'

"("                   	return 'PARENTESIS_ABRE'
")"                   	return 'PARENTESIS_CIERRA'
"{"                   	return 'LlaveAbre'
"}"                   	return 'LlaveCierra'
"["						return 'COR_ABRE'
"]"						return 'COR_CIERRA'

"caracterOfPosition"    return 'TK_CARACTEROFPOSITION'
"subString"             return 'TK_SUBSTRING'
"toLowercase"			return 'TK_TOLOWER'
"toUppercase"			return 'TK_TOUPPER'
"length"				return 'TK_LENGTH'
"print"                 return 'TK_PRINT'
"println"               return 'TK_PRINTLN'
"parse"                 return 'TK_PARSE'
"toInt"                 return 'TK_TOINT'
"toDouble"              return 'TK_TODOUBLE'
"string"                return 'TK_STRINGPARSE'
"typeof"	        return 'TK_TYPEOF'
"struct"                return 'TK_STRUCT'
"begin"                 return 'TK_BEGIN'
"end"                   return 'TK_END'
"push"                  return 'TK_PUSH'
"pop"                   return 'TK_POP'
"function"              return 'TK_FUNCTION'

([a-zA-Z])([a-zA-Z0-9_])*       return 'IDENTIFICADOR'
[']\\\\[']|[']\\\"[']|[']\\\'[']|[']\\n[']|[']\\t[']|[']\\r[']|['].?[']	return 'CARACTER'
[0-9]+("."[0-9]+)+\b	return 'DECI'
[0-9]+					return 'ENTERO'

["]				{ cadena = ''; this.begin("string"); }
<string>[^"\\]+			{ cadena += yytext; }
<string>"\\\""			{ cadena += "\""; }
<string>"\\n"			{ cadena += "\n"; }
<string>\s			{ cadena += " ";  }
<string>"\\t"			{ cadena += "\t"; }
<string>"\\\\"			{ cadena += "\\"; }
<string>"\\\'"			{ cadena += "\'"; }
<string>"\\r"			{ cadena += "\r"; }
<string>["]				{ yytext = cadena; this.popState(); return 'CADENA'; }

<<EOF>>               	return 'EOF'
.                     	{ errores.push({ tipo: "Léxico", error: yytext, linea: yylloc.first_line, columna: yylloc.first_column+1 }); return 'INVALID'; } 

/lex


/* Precedencias */

%left 'OP_TERNARIO'
%left 'OR'
%left 'AND'
%right 'NOT'
%left 'IGUALIGUAL' 'DIFERENTEA' 'MENOR' 'MENORIGUAL' 'MAYOR' 'MAYORIGUAL'
%left 'OP_SUMA' 'OP_MENOS'
%left 'OP_MULTIPLICACION' 'OP_DIVISION' 'OP_MODULO'
%left 'OP_EXPONENTE'
%left 'INCREMENTO','DECREMENTO'
%left umenos
%left 'PARENTESIS_ABRE'

%start ini

%%

ini: ENTRADA EOF { retorno = { parse: $1, errores: errores }; errores = []; return $1; }
    |error EOF   { retorno = { parse: null, errores: errores }; errores = []; return retorno; }
;

ENTRADA: ENTRADA instrucciones { if($2 !=="") $1.push($2); $$ = $1; }
        | instrucciones { if($1 !== "") $$ = [$1]; else $$ = []; alert($1); }
;

instrucciones: MFBody { $$ = $1 }
		| MainBody { $$= $1 }
		| Dec_Var { $$= $1 }
		| Dec_Vect { $$= $1 }
                | Dec_Struct { $$= $1 }
                | LLamada TK_PYC{ $$= $1 }
;
//--------------------------------------------------------------- MAIN ------------------------------------------------------------
MainBody: TK_VOID TK_MAIN PARENTESIS_ABRE PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra { alert($6); return $6; }
        | TK_VOID TK_MAIN error LlaveCierra { $$= ""; errores.push({ tipo: "Sintactico", error: "Declaracion de main invalido", linea: this._$.first_line, columna: this._$.first_column+1 }); console.log(errores) }
;

//-----------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------- METODO FUNCION STRUCT ----------------------------------------------------------
MFBody: Tipos IDENTIFICADOR PARENTESIS_ABRE PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra { $$ = Instruccion.nuevaFuncion($2, null, $6, $1, this._$.first_line, this._$.first_column+1) }
        | Tipos IDENTIFICADOR PARENTESIS_ABRE Params PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra { $$= Instruccion.nuevaFuncion($2, $4, $7, $1, this._$.first_line, this._$.first_column+1) }
        | Tipos IDENTIFICADOR PARENTESIS_ABRE Params PARENTESIS_CIERRA LlaveAbre LlaveCierra { $$= Instruccion.nuevaFuncion($2, $4, [], $1, this._$.first_line, this._$.first_column+1) }
        | Tipos IDENTIFICADOR PARENTESIS_ABRE PARENTESIS_CIERRA LlaveAbre LlaveCierra { $$= Instruccion.nuevaFuncion($2, null, [], $1, this._$.first_line, this._$.first_column+1) }
        | Tipos error LlaveCierra { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de función no válida.", linea: this._$.first_line, columna: this._$.first_column+1 }); }
        | Tipos COR_ABRE COR_CIERRA error LlaveCierra { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de función no válida.", linea: this._$.first_line, columna: this._$.first_column+1 }); }

        | TK_VOID IDENTIFICADOR PARENTESIS_ABRE PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra { $$ = Instruccion.nuevoMetodo($2, null, $6, this._$.first_line, this._$.first_column+1) }
	| TK_VOID IDENTIFICADOR PARENTESIS_ABRE Params PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra { $$ = Instruccion.nuevoMetodo($2, $4, $7, this._$.first_line, this._$.first_column+1) } 
	| TK_VOID IDENTIFICADOR PARENTESIS_ABRE Params PARENTESIS_CIERRA LlaveAbre LlaveCierra { $$ = Instruccion.nuevoMetodo($2, $4, [], this._$.first_line, this._$.first_column+1) } 
	| TK_VOID IDENTIFICADOR PARENTESIS_ABRE PARENTESIS_CIERRA LlaveAbre LlaveCierra { $$ = Instruccion.nuevoMetodo($2, [], [], this._$.first_line, this._$.first_column+1) }
        | TK_VOID error LlaveCierra { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de método no válida.", linea: this._$.first_line, columna: this._$.first_column+1 }); }
;

Dec_Struct: TK_STRUCT IDENTIFICADOR LlaveAbre BodyStruct LlaveCierra TK_PYC { alert("Struct: "+$1+", Nombre: "+$2); return $4; }
        | IDENTIFICADOR IDENTIFICADOR IGUAL IDENTIFICADOR PARENTESIS_ABRE Params PARENTESIS_CIERRA TK_PYC { alert("Nombre Struct: "+$1+", Identificador1: "+$2+", Identificador2: "+$4); return $5; }
        | IDENTIFICADOR IDENTIFICADOR IGUAL IDENTIFICADOR PARENTESIS_ABRE PARENTESIS_CIERRA TK_PYC { alert("Nombre Struct: "+$1+", Identificador1: "+$2+", Identificador2: "+$4); return $1; }
        | IDENTIFICADOR TK_PUNTO IDENTIFICADOR IGUAL Expresiones TK_PYC { alert("Nombre Struct: "+$1+" Identificador: "+$3); return $5; }
;

BodyStruct: s { $$ = $1 }
        | s TK_COMA BodyStruct { $1.push($3); $$=1; return $1; }
;

s: Dec_Var {$$=$1}
        | IDENTIFICADOR IDENTIFICADOR { alert("Nombre: "+$1+", identificador: "+$2); return $2; }
;
//------------------------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------------- PARAMETROS -------------------------------------------------------------
Params: parametros { $$ = [$1];  }
        | Params TK_COMA parametros { $1.push($3); $$=$1; } 
;

parametros: Tipos COR_ABRE COR_CIERRA IDENTIFICADOR { $$ = Instruccion.nuevoParametro($4, {vector: $1}, this._$.first_line, this._$.first_column+1) }
	| Tipos IDENTIFICADOR { $$=Instruccion.nuevoParametro($2, $1, this._$.first_line, this._$.first_column+1) }
        | IDENTIFICADOR IDENTIFICADOR { $$=Instruccion.nuevoParametro($2, {struct: $1}, this._$.first_line, this._$.first_column+1) }
        | Expresiones { $$ = $1}
;
//--------------------------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------------- Instrucciones ------------------------------------------------------------
Instructions: Instructions cuerpo { if($2 !== "") $1.push($2); $$=$1; }
			| cuerpo { if($1 !== "") $$ = [$1]; else $$ = []; }
;

cuerpo: Dec_Var { $$=$1 }
        | Imprimir {$$=$1}
        | SentenciasControl {$$=$1}
        | SentenciasCiclicas {$$=$1}
        | SentenciasTransferencias {$$=$1}
        | Dec_Struct {$$=$1}
        | Dec_Vect {$$=$1}
        | LLamada TK_PYC {$$=$1}
        | error TK_PYC { $$=""; errores.push({ tipo: "Sintactico", error: "Declaracion de instruccion no valida", linea: this._$.first_line, columna: this._$.first_column+1}); }
        | error LlaveCierra { $$=""; errores.push({ tipo: "Sintactico", error: "Declaracion de instruccion no valida", linea: this._$.first_line, columna: this._$.first_column+1}); }
;
//--------------------------------------------------------------------------------------------------------------------------------------

//--------------------------------------------------- Sentencias de Control If y Switch ------------------------------------------------

SentenciasControl: ControlIF { $$ = $1 }
		| CSwitch { $$ = $1 }
;

ControlIF: If { $$=1 }
	| IfElse { $$ = $1 }
	| ElseIf { $$ = $1 }
        | TK_IF error LlaveCierra { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de sentencia If no válida.", linea: this._$.first_line, columna: this._$.first_column+1 }); }
;

If: TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra { $$ = new Instruccion.nuevoIf($3, $6, this._$.first_line, this._$.first_column+1) }
   | TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre LlaveCierra { $$ = new Instruccion.nuevoIf($3, [], this._$.first_line, this._$.first_column+1) }
;

IfElse: TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra TK_ELSE LlaveAbre Instructions LlaveCierra { $$ = new Instruccion.nuevoIfElse($3, $6, $10, this._$.first_line, this._$.first_column+1) }
        | TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre LlaveCierra TK_ELSE LlaveAbre Instructions LlaveCierra { $$ = new Instruccion.nuevoIfElse($3, [], $9, this._$.first_line, this._$.first_column+1) }
        | TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra TK_ELSE LlaveAbre LlaveCierra { $$ = new Instruccion.nuevoIfElse($3, $6, [], this._$.first_line, this._$.first_column+1) }
        | TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre LlaveCierra TK_ELSE LlaveAbre LlaveCierra { $$ = new Instruccion.nuevoIfElse($3, [], [], this._$.first_line, this._$.first_column+1) }
;

ElseIf: TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra TK_ELSE ControlIF { $$ = new Instruccion.nuevoElseIf($3, $6, $9, this._$.first_line, this._$.first_column+1) }
	| TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre LlaveCierra TK_ELSE ControlIF { $$ = new Instruccion.nuevoElseIf($3, [], [], this._$.first_line, this._$.first_column+1) }
;

CSwitch: TK_SWITCH PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre ListCase Default LlaveCierra { $$ = new Instruccion.nuevoSwitch($3, $6, $7, this._$.first_line, this._$.first_column+1)  }
		| TK_SWITCH PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre ListCase LlaveCierra { $$ = new Instruccion.nuevoSwitch($3, $6, null, this._$.first_line, this._$.first_column+1) }
		| TK_SWITCH PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre Default LlaveCierra { $$ = new Instruccion.nuevoSwitch($3, null, $6, this._$.first_line, this._$.first_column+1) }
                | TK_SWITCH error LlaveCierra { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de Switch no válida.", linea: this._$.first_line, columna: this._$.first_column+1 }); }
;

ListCase: ListCase TK_CASE Expresiones TK_DOSPUNTS Instructions { $1.push(new Instruccion.nuevoCaso($3, $5, this._$.first_line, this._$.first_column+1)); $$=$1; }
		| ListCase TK_CASE Expresiones TK_DOSPUNTS { $1.push(new Instruccion.nuevoCaso($3, [], this._$.first_line, this._$.first_column+1)); $$=$1; }
		| TK_CASE Expresiones TK_DOSPUNTS Instructions { $$ = [new Instruccion.nuevoCaso($2, $4, this._$.first_line, this._$.first_column+1)]; }
		| TK_CASE Expresiones TK_DOSPUNTS { $ = [new Instruccion.nuevoCaso($2, [], this._$.first_line, this._$.first_column+1)]; }
                | TK_CASE error TK_DOSPUNTS { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de caso no válida.", linea: this._$.first_line, columna: this._$.first_column+1 }); }
;

Default: TK_DEFAULT TK_DOSPUNTS Instructions { $$ = new Instruccion.nuevoCaso(null, $3, this._$.first_line, this._$.first_column+1); }
		| TK_DEFAULT TK_DOSPUNTS { $$ = new Instruccion.nuevoCaso(null, [], this._$.first_line, this._$.first_column+1); }
;

//--------------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------------- Sentencias Ciclicas ---------------------------------------------------------

SentenciasCiclicas: While { $$=$1 }
                   | For { $$=$1 }
                   | DoWhile { $$=$1 }
;

While: TK_WHILE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra { $$ = new Instruccion.nuevoWhile($3, $6, this._$.first_line,this._$.first_column+1) }
        | TK_WHILE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre LlaveCierra { $$ = new Instruccion.nuevoWhile($3, [], this._$.first_line,this._$.first_column+1) }
        | TK_WHILE error LlaveCierra { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de ciclo While no válida.", linea: this._$.first_line, columna: this._$.first_column+1 }); }
;

DoWhile: TK_DO LlaveAbre Instructions LlaveCierra TK_WHILE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA TK_PYC { $$ = new Instruccion.nuevoDoWhile($7, $3, this._$.first_line,this._$.first_column+1) }
        | TK_DO LlaveAbre LlaveCierra TK_WHILE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA TK_PYC { $$ = new Instruccion.nuevoDoWhile($7, [], this._$.first_line,this._$.first_column+1) } 
        | TK_DO error TK_PYC { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de sentencia Do-While no válida.", linea: this._$.first_line, columna: this._$.first_column+1 }); }
;

For: TK_FOR PARENTESIS_ABRE Dec_Var Expresiones TK_PYC Actualizacion PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra { $9.push($6); $$ = new Instruccion.nuevoFor($3, $4, $9, this._$.first_line,this._$.first_column+1) }
	| TK_FOR PARENTESIS_ABRE Dec_Var Expresiones TK_PYC Actualizacion PARENTESIS_CIERRA LlaveAbre LlaveCierra { $$ = new Instruccion.nuevoFor($3, $4, [$6], this._$.first_line,this._$.first_column+1) }
        | TK_FOR error LlaveCierra { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de ciclo For no válida.", linea: this._$.first_line, columna: this._$.first_column+1 }); }
;

Actualizacion: IDENTIFICADOR IGUAL Expresiones { $$ = Instruccion.nuevaAsignacion($1, $3, this._$.first_line,this._$.first_column+1) }
 		| IDENTIFICADOR INCREMENTO { $$ = Instruccion.nuevaAsignacion($1,
			{ opIzq: { tipo: 'VAL_IDENTIFICADOR', valor: $1, linea: this._$.first_line, columna: this._$.first_column+1 },
  			opDer: { tipo: 'VAL_ENTERO', valor: 1, linea: this._$.first_line, columna: this._$.first_column+1 },
  			tipo: 'SUMA',
  			linea: this._$.first_line,
  			columna: this._$.first_column+1 }, this._$.first_line,this._$.first_column+1) }
		| IDENTIFICADOR DECREMENTO { $$ = Instruccion.nuevaAsignacion($1,
			{ opIzq: { tipo: 'VAL_IDENTIFICADOR', valor: $1, linea: this._$.first_line, columna: this._$.first_column+1 },
  			opDer: { tipo: 'VAL_ENTERO', valor: 1, linea: this._$.first_line, columna: this._$.first_column+1 },
  			tipo: 'RESTA',
  			linea: this._$.first_line,
  			columna: this._$.first_column+1 }, this._$.first_line,this._$.first_column+1) }
;

//--------------------------------------------------------------------------------------------------------------------------------------

//--------------------------------------------------------- Sentencias de Transferencia ------------------------------------------------

SentenciasTransferencias: TK_BREAK TK_PYC { $$ = new Instruccion.nuevoBreak(this._$.first_line, this._$.first_column+1) }
                        | TK_RETURN TK_PYC { $$ = new Instruccion.nuevoReturn(null, this._$.first_line, this._$.first_column+1) }
                        | TK_CONTINUE TK_PYC { $$ = new Instruccion.nuevoContinue(this._$.first_line, this._$.first_column+1) }
                        | TK_RETURN Expresiones TK_PYC { $$ = new Instruccion.nuevoReturn($2, this._$.first_line, this._$.first_column+1) }
;

//--------------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------------------- Impresion -------------------------------------------------------------

 Imprimir: TK_PRINT PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA TK_PYC { alert("Mensaje capturado con "+$1); return $3; }
        | TK_PRINTLN PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA TK_PYC { alert("Mensaje capturado con "+$1); return $3; }
        | TK_PRINT PARENTESIS_ABRE Dec_Vect PARENTESIS_CIERRA TK_PYC { alert("Mensaje capturado con "+$1); return $3; }
        | TK_PRINTLN PARENTESIS_ABRE Dec_Vect PARENTESIS_CIERRA TK_PYC { alert("Mensaje capturado con "+$1); return $3; }
        | TK_PRINT PARENTESIS_ABRE operString PARENTESIS_CIERRA TK_PYC { alert("Mensaje capturado con "+$1); return $3; }
        | TK_PRINTLN PARENTESIS_ABRE operString PARENTESIS_CIERRA TK_PYC { alert("Mensaje capturado con "+$1); return $3; }
        | TK_PRINT error TK_PYC {  $$ = ""; errores.push({ tipo: "Sintáctico", error: "Llamada a función imprimir no válida.", linea: this._$.first_line, columna: this._$.first_column+1 }); }
        | TK_PRINTLN error TK_PYC {  $$ = ""; errores.push({ tipo: "Sintáctico", error: "Llamada a función imprimir no válida.", linea: this._$.first_line, columna: this._$.first_column+1 }); }
 ;
 //---------------------------------------------------------------------------------------------------------------------------------------

//------------------------------------------------------------- Declaraciones -----------------------------------------------------------

 Dec_Var: Tipos IDENTIFICADOR IGUAL Expresiones TK_PYC { $$ = INSTRUCCION.nuevaDeclaracion($2, $4, $1, this._$.first_line,this._$.first_column+1) }
        | Tipos IDENTIFICADOR TK_PYC { $$ = INSTRUCCION.nuevaDeclaracion($2, null, $1, this._$.first_line,this._$.first_column+1) }
        | IDENTIFICADOR IGUAL Expresiones TK_PYC { $$ = INSTRUCCION.nuevaAsignacion($1, $3, this._$.first_line,this._$.first_column+1) }
        | IDENTIFICADOR INCREMENTO TK_PYC { $$ = INSTRUCCION.nuevaAsignacion($1,
			{ opIzq: { tipo: 'VAL_IDENTIFICADOR', valor: $1, linea: this._$.first_line, columna: this._$.first_column+1 },
  			opDer: { tipo: 'VAL_ENTERO', valor: 1, linea: this._$.first_line, columna: this._$.first_column+1 },
  			tipo: 'SUMA',
  			linea: this._$.first_line,
  			columna: this._$.first_column+1 }, this._$.first_line,this._$.first_column+1) }
        | IDENTIFICADOR DECREMENTO TK_PYC { $$ = INSTRUCCION.nuevaAsignacion($1,
			{ opIzq: { tipo: 'VAL_IDENTIFICADOR', valor: $1, linea: this._$.first_line, columna: this._$.first_column+1 },
  			opDer: { tipo: 'VAL_ENTERO', valor: 1, linea: this._$.first_line, columna: this._$.first_column+1 },
  			tipo: 'RESTA',
  			linea: this._$.first_line,
  			columna: this._$.first_column+1 }, this._$.first_line,this._$.first_column+1) }
        | Tipos IDENTIFICADOR { $$ = INSTRUCCION.nuevaDeclaracion($2, null, $1, this._$.first_line,this._$.first_column+1) }

        | IDENTIFICADOR COR_ABRE Expresiones COR_CIERRA IGUAL Expresiones TK_PYC { $$ = INSTRUCCION.modificacionVector($1, $3, $6, this._$.first_line, this._$.first_column+1) }

        | Tipos IDENTIFICADOR IGUAL operString TK_PYC { $$ = INSTRUCCION.nuevaDeclaracion($2, $4, $1, this._$.first_line,this._$.first_column+1) }
        | Tipos error TK_PYC { $$ = ""; errores.push({ tipo: "Sintactico", error: "Declaracion de variable incorrecta", linea: this._$.first_line, columna: this._$.first_column+1 }); console.log(errores) }
;

Dec_Vect: Tipos COR_ABRE COR_CIERRA IDENTIFICADOR IGUAL COR_ABRE Params COR_CIERRA TK_PYC { $$ = INSTRUCCION.nuevoVector($1, null, $4, null, $7, null, this._$.first_line, this._$.first_column+1) }
        | Tipos COR_ABRE COR_CIERRA IDENTIFICADOR IGUAL COR_ABRE COR_CIERRA TK_PYC { $$ = INSTRUCCION.nuevoVector($1, null, $4, null, null, null, this._$.first_line, this._$.first_column+1) }
        | Tipos COR_ABRE COR_CIERRA IDENTIFICADOR IGUAL OP_VECOTRES IDENTIFICADOR TK_PYC {  }
        
        | IDENTIFICADOR TK_PUNTO TK_PUSH PARENTESIS_ABRE Params PARENTESIS_CIERRA TK_PYC {}
        | IDENTIFICADOR TK_PUNTO TK_POP PARENTESIS_ABRE PARENTESIS_CIERRA TK_PYC {}

        | IDENTIFICADOR TK_PUNTO TK_LENGTH PARENTESIS_ABRE PARENTESIS_CIERRA TK_PYC {$$ = new INSTRUCCION.nuevoLength($3, this._$.first_line,this._$.first_column+1)}
        
        | Tipos COR_ABRE COR_CIERRA IDENTIFICADOR IGUAL IDENTIFICADOR opVector TK_PYC {}
        | Tipos COR_ABRE COR_CIERRA IDENTIFICADOR IGUAL opVector TK_PYC {}
        | IDENTIFICADOR opVector {}
        | Tipos COR_ABRE COR_CIERRA error TK_PYC { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de vector no válida.", linea: this._$.first_line, columna: this._$.first_column+1 }); }
;

opVector: OP_VECOTRES simbolos Expresiones {}
        | OP_VECOTRES simbolos Expresiones opVector {}

        | TK_SENO OP_VECOTRES PARENTESIS_ABRE IDENTIFICADOR PARENTESIS_CIERRA {}
        | TK_SENO OP_VECOTRES PARENTESIS_ABRE IDENTIFICADOR PARENTESIS_CIERRA opVector {}
        | TK_SENO OP_VECOTRES PARENTESIS_ABRE opVector PARENTESIS_CIERRA opVector {}
        | TK_SENO OP_VECOTRES PARENTESIS_ABRE opVector PARENTESIS_CIERRA {}

        | TK_COSENO OP_VECOTRES PARENTESIS_ABRE IDENTIFICADOR PARENTESIS_CIERRA {}
        | TK_COSENO OP_VECOTRES PARENTESIS_ABRE IDENTIFICADOR PARENTESIS_CIERRA opVector {}
        | TK_COSENO OP_VECOTRES PARENTESIS_ABRE opVector PARENTESIS_CIERRA opVector {}
        | TK_COSENO OP_VECOTRES PARENTESIS_ABRE opVector PARENTESIS_CIERRA {}

        | TK_TANGENTE OP_VECOTRES PARENTESIS_ABRE IDENTIFICADOR PARENTESIS_CIERRA {}
        | TK_TANGENTE OP_VECOTRES PARENTESIS_ABRE IDENTIFICADOR PARENTESIS_CIERRA opVector {}
        | TK_TANGENTE OP_VECOTRES PARENTESIS_ABRE opVector PARENTESIS_CIERRA opVector {}
        | TK_TANGENTE OP_VECOTRES PARENTESIS_ABRE opVector PARENTESIS_CIERRA {}

        | TK_LOGARITMOB10 OP_VECOTRES PARENTESIS_ABRE IDENTIFICADOR PARENTESIS_CIERRA {}
        | TK_LOGARITMOB10 OP_VECOTRES PARENTESIS_ABRE IDENTIFICADOR PARENTESIS_CIERRA opVector {}
        | TK_LOGARITMOB10 OP_VECOTRES PARENTESIS_ABRE opVector PARENTESIS_CIERRA opVector {}
        | TK_LOGARITMOB10 OP_VECOTRES PARENTESIS_ABRE opVector PARENTESIS_CIERRA {}

        | TK_POW OP_VECOTRES PARENTESIS_ABRE Expresiones TK_COMA IDENTIFICADOR opVector PARENTESIS_CIERRA {}
        | TK_POW OP_VECOTRES PARENTESIS_ABRE Expresiones TK_COMA IDENTIFICADOR PARENTESIS_CIERRA {}
        | TK_POW OP_VECOTRES PARENTESIS_ABRE Expresiones TK_COMA opVector PARENTESIS_CIERRA {}
        | TK_SQRT OP_VECOTRES PARENTESIS_ABRE opVector PARENTESIS_CIERRA {}
;
//--------------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------- Operaciones con String ------------------------------------------------------------
operString: CADENA CONCATENADOCADENA CADENA {}
        | operString CONCATENADOCADENA CADENA {}
        | CADENA OP_EXPONENTE ENTERO {}
        | operString OP_EXPONENTE ENTERO {}
        | IDENTIFICADOR TK_COMA IDENTIFICADOR {}
        | operString TK_COMA IDENTIFICADOR {}
;
//--------------------------------------------------------------------------------------------------------------------------------------

//------------------------------------------------- LLamada a metodos / funciones -------------------------------------------------------

LLamada: IDENTIFICADOR PARENTESIS_ABRE Params PARENTESIS_CIERRA {}
        | IDENTIFICADOR PARENTESIS_ABRE PARENTESIS_CIERRA {}
;
//--------------------------------------------------------------------------------------------------------------------------------------


simbolos: OP_SUMA {}
        | OP_MENOS {}
        | OP_DIVISION {}
        | OP_MULTIPLICACION {}
        | OP_MODULO {}
;

Expresiones: CADENA {$$ = INSTRUCCION.nuevoValor($1, TValores.CADENA, this._$.first_line,this._$.first_column+1)}
            | CARACTER {$$ = INSTRUCCION.nuevoValor($1.trim().substring(1, $1.length - 1), TValores.CARACTER, this._$.first_line,this._$.first_column+1)}
            | TRUE {$$ = INSTRUCCION.nuevoValor($1.trim(), TValores.BOOLEAN, this._$.first_line,this._$.first_column+1)}
            | FALSE {$$ = INSTRUCCION.nuevoValor($1.trim(), TValores.BOOLEAN, this._$.first_line,this._$.first_column+1)}
            | ENTERO {$$ = INSTRUCCION.nuevoValor(Number($1.trim()), TValores.ENTERO, this._$.first_line,this._$.first_column+1)}
            | DECI {$$ = INSTRUCCION.nuevoValor(Number($1.trim()), TValores.DOUBLE, this._$.first_line,this._$.first_column+1)}
            | NULL {$$ = INSTRUCCION.nuevoValor($1, TValores.NULL, this._$.first_line,this._$.first_column+1)}
            | IDENTIFICADOR {$$ = INSTRUCCION.nuevoValor($1.trim(), TValores.IDENTIFICADOR, this._$.first_line,this._$.first_column+1)}

            | PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA {$$=$2;}

            | Expresiones OP_SUMA Expresiones {$$= INSTRUCCION.nuevaOperacionBinaria($1,$3, TOperaciones.SUMA,this._$.first_line,this._$.first_column+1); return Number($1)+Number($3) }
            | Expresiones OP_MENOS Expresiones {$$= INSTRUCCION.nuevaOperacionBinaria($1,$3, TOperaciones.RESTA,this._$.first_line,this._$.first_column+1); return Number($1)-Number($3)}
            | Expresiones OP_DIVISION Expresiones {$$= INSTRUCCION.nuevaOperacionBinaria($1,$3, TOperaciones.DIVISION,this._$.first_line,this._$.first_column+1); return Number($1)/Number($3)}
            | Expresiones OP_MULTIPLICACION Expresiones {$$= INSTRUCCION.nuevaOperacionBinaria($1,$3, TOperaciones.MULTIPLICACION,this._$.first_line,this._$.first_column+1); return Number($1)*Number($3)}
            | Expresiones OP_MODULO Expresiones {$$= INSTRUCCION.nuevaOperacionBinaria($1,$3, TOperaciones.MODULO,this._$.first_line,this._$.first_column+1); return Number($1)%Number($3)}

            | TK_POW PARENTESIS_ABRE Expresiones TK_COMA Expresiones PARENTESIS_CIERRA {$$= INSTRUCCION.nuevaOperacionBinaria($1,$3, TOperaciones.POTENCIA,this._$.first_line,this._$.first_column+1); return Math.pow(Number($3), Number($5)); }
            | TK_SQRT PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$= INSTRUCCION.nuevaOperacionBinaria($1,$3, TOperaciones.RAIZ,this._$.first_line,this._$.first_column+1); return Math.pow(Number($3), Number($5)); return Math.sqrt(Number($3)); }
            | TK_SENO PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$= INSTRUCCION.nuevaOperacionBinaria($1,$3, TOperaciones.SENO,this._$.first_line,this._$.first_column+1); return Math.pow(Number($3), Number($5)); return Math.sin(Number($3)); }
            | TK_COSENO PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$= INSTRUCCION.nuevaOperacionBinaria($1,$3, TOperaciones.COSENO,this._$.first_line,this._$.first_column+1); return Math.pow(Number($3), Number($5)); return Math.cos(Number($3)); }
            | TK_TANGENTE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$= INSTRUCCION.nuevaOperacionBinaria($1,$3, TOperaciones.TANGENTE,this._$.first_line,this._$.first_column+1); return Math.pow(Number($3), Number($5)); return Math.tan(Number($3)); }
            | TK_LOGARITMOB10 PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$= INSTRUCCION.nuevaOperacionBinaria($1,$3, TOperaciones.LOGARITMO,this._$.first_line,this._$.first_column+1); return Math.pow(Number($3), Number($5)); return Math.log10(Number($3)); }

            | Expresiones IGUALIGUAL Expresiones { $$= INSTRUCCION.nuevaOperacionBinaria($1,$3, TOperaciones.IGUALIGUAL,this._$.first_line,this._$.first_column+1); if(Number($1)==Number($3)) alert("son iguales"); else alert("Nel"); }
            | Expresiones MENOR Expresiones { $$= INSTRUCCION.nuevaOperacionBinaria($1,$3, TOperaciones.MENOR,this._$.first_line,this._$.first_column+1); if($1 < Number($3)) alert("Es menor"+$1); else alert("Es mayor"+$3); }
            | Expresiones MENORIGUAL Expresiones { $$= INSTRUCCION.nuevaOperacionBinaria($1,$3, TOperaciones.MENORIGUAL,this._$.first_line,this._$.first_column+1); if($1 <= Number($3)) alert("Es menor o igual "+$1); else alert("Nel, es mayor "+$3); }
            | Expresiones MAYOR Expresiones { $$= INSTRUCCION.nuevaOperacionBinaria($1,$3, TOperaciones.MAYOR,this._$.first_line,this._$.first_column+1); if($1>Number($3)) alert("Es mayor "+$1); else alert("Nel "+$3); }
            | Expresiones MAYORIGUAL Expresiones { $$= INSTRUCCION.nuevaOperacionBinaria($1,$3, TOperaciones.MAYORIGUAL,this._$.first_line,this._$.first_column+1); if($1>=Number($3)) alert("Es mayor o igual "+$1); else alert("Nel, sigue siendo mayot"+$3); }

            | Expresiones OR Expresiones { $$= INSTRUCCION.nuevaOperacionBinaria($1,$3, TOperaciones.OR,this._$.first_line,this._$.first_column+1); }
            | Expresiones AND Expresiones { $$= INSTRUCCION.nuevaOperacionBinaria($1,$3, TOperaciones.AND,this._$.first_line,this._$.first_column+1); }
            | Expresiones DIFERENTEA Expresiones { $$= INSTRUCCION.nuevaOperacionBinaria($1,$3, TOperaciones.DIFERENTEA,this._$.first_line,this._$.first_column+1); if($1!=$3) alert("Son diferentes"); else alert("Nel"); }
            | NOT Expresiones { $$= INSTRUCCION.nuevaOperacionBinaria($2, null, TOperaciones.NOT,this._$.first_line,this._$.first_column+1); }

            | IDENTIFICADOR COR_ABRE Expresiones COR_CIERRA { $$ = INSTRUCCION.modificacionVector($1, $3, $6, this._$.first_line, this._$.first_column+1) }
            | FuncioesReservadas { $$=$1; }
            | Casteos { $$=$1; }
            | Ternario {$$=$1;}
            | IDENTIFICADOR COR_ABRE ENTERO TK_DOSPUNTS	ENTERO COR_CIERRA { return $5; }
            | IDENTIFICADOR COR_ABRE TK_BEGIN TK_DOSPUNTS ENTERO COR_CIERRA { return $5; }
            | IDENTIFICADOR COR_ABRE ENTERO TK_DOSPUNTS	TK_END COR_CIERRA { return $3; }
            | OP_MENOS Expresiones %prec umenos { $$= INSTRUCCION.nuevaOperacionBinaria($2, null, TOperaciones.NEGACION,this._$.first_line,this._$.first_column+1); }
;

Ternario: Expresiones OP_TERNARIO Expresiones TK_DOSPUNTS Expresiones {}
;

//------------------------------------------------------ Reservadas --------------------------------------------------------------------

FuncioesReservadas: FCaracterOfPosition {}
                   | FSubString {}
                   | Flength {}
                   | FToLower {}
                   | FToUpper {}
                   | FTypeof {}
;

FCaracterOfPosition: IDENTIFICADOR TK_PUNTO TK_CARACTEROFPOSITION PARENTESIS_ABRE ENTERO PARENTESIS_CIERRA {}
;

FSubString: IDENTIFICADOR TK_PUNTO TK_SUBSTRING PARENTESIS_ABRE ENTERO TK_COMA ENTERO PARENTESIS_CIERRA {}
;

Flength: IDENTIFICADOR TK_PUNTO TK_LENGTH PARENTESIS_ABRE PARENTESIS_CIERRA {}
;

FToLower: IDENTIFICADOR TK_PUNTO TK_TOLOWER PARENTESIS_ABRE PARENTESIS_CIERRA {}
;

FToUpper: IDENTIFICADOR TK_PUNTO TK_TOUPPER PARENTESIS_ABRE PARENTESIS_CIERRA {}
;

FTypeof: TK_TYPEOF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA {}
;

//--------------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------------------- Casteos ---------------------------------------------------------------
Casteos: parseo {}
        | toTipo {}
        | TK_STRINGPARSE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA {}
;

parseo: Tipos TK_PUNTO TK_PARSE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA {}
;

toTipo: TK_TOINT PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA {}
        | TK_TODOUBLE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA {}
;


//--------------------------------------------------------------------------------------------------------------------------------------


Tipos: STRING { $$ = Tipos.CADENA; }
    | INT { $$ = Tipos.ENTERO; }
    | DOUBLE { $$ = Tipos.DOUBLE; }
    | CHAR { $$ = Tipos.CARACTER; }
    | FLOAT { $$ = Tipos.DOUBLE; }
    | BOOLEAN { $$ = Tipos.BOOLEAN; }
;