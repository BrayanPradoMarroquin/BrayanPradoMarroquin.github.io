%{
    var cadena = '';
    var errores = [];
%}

%lex

%x string 

%%

\s+                                           // Espacios en blanco
"//".*                                       // Comentarios de una linea
[/][][^][]+([^/][^][]+)*[/]	        // Comentario Multilinea

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
"while"               	                return 'TK_WHILE'
"for"					return 'TK_FOR'
"do"					return 'TK_DO'
"continue"				return 'TK_CONTINUE'
"return"				return 'TK_RETURN'
"void"					return 'TK_VOID'
"main"                                  return 'TK_MAIN'
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
"$"                     return 'OPERACIONESALIMPRIMIR'
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
"["			return 'COR_ABRE'
"]"		        return 'COR_CIERRA'

"caracterOfPosition"    return 'TK_CARACTEROFPOSITION'
"subString"             return 'TK_SUBSTRING'
"toLowercase"		return 'TK_TOLOWER'
"toUppercase"		return 'TK_TOUPPER'
"length"		return 'TK_LENGTH'
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
        | instrucciones { if($1 !== "") $$ = [$1]; else $$ = []; }
;

instrucciones: MFBody { $$ = $1 }
		| MainBody { $$= $1 }
		| Dec_Var { $$= $1 }
		| Dec_Vect { $$= $1 }
                | Dec_Struct { $$= $1 }
                | LLamada TK_PYC{ $$= $1 }
;
//--------------------------------------------------------------- MAIN ------------------------------------------------------------
MainBody: TK_VOID TK_MAIN PARENTESIS_ABRE PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra { $$ = Instruccion.nuevoStart("main", [], $6, this.$.first_line, this.$.first_column+1) }
        | TK_VOID TK_MAIN error LlaveCierra { $$= ""; errores.push({ tipo: "Sintactico", error: "Declaracion de main invalido", linea: this.$.first_line, columna: this.$.first_column+1 }); console.log(errores) }
;

//-----------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------- METODO FUNCION STRUCT ----------------------------------------------------------
MFBody: Tipos IDENTIFICADOR PARENTESIS_ABRE PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra { $$ = Instruccion.nuevaFuncion($2, null, $6, $1, this.$.first_line, this.$.first_column+1) }
        | Tipos IDENTIFICADOR PARENTESIS_ABRE Params PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra { $$= Instruccion.nuevaFuncion($2, $4, $7, $1, this.$.first_line, this.$.first_column+1) }
        | Tipos IDENTIFICADOR PARENTESIS_ABRE Params PARENTESIS_CIERRA LlaveAbre LlaveCierra { $$= Instruccion.nuevaFuncion($2, $4, [], $1, this.$.first_line, this.$.first_column+1) }
        | Tipos IDENTIFICADOR PARENTESIS_ABRE PARENTESIS_CIERRA LlaveAbre LlaveCierra { $$= Instruccion.nuevaFuncion($2, null, [], $1, this.$.first_line, this.$.first_column+1) }
        | Tipos error LlaveCierra { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de función no válida.", linea: this.$.first_line, columna: this.$.first_column+1 }); }
        | Tipos COR_ABRE COR_CIERRA error LlaveCierra { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de función no válida.", linea: this.$.first_line, columna: this.$.first_column+1 }); }

        | TK_VOID IDENTIFICADOR PARENTESIS_ABRE PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra { $$ = Instruccion.nuevoMetodo($2, null, $6, this.$.first_line, this.$.first_column+1) }
	| TK_VOID IDENTIFICADOR PARENTESIS_ABRE Params PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra { $$ = Instruccion.nuevoMetodo($2, $4, $7, this.$.first_line, this.$.first_column+1) } 
	| TK_VOID IDENTIFICADOR PARENTESIS_ABRE Params PARENTESIS_CIERRA LlaveAbre LlaveCierra { $$ = Instruccion.nuevoMetodo($2, $4, [], this.$.first_line, this.$.first_column+1) } 
	| TK_VOID IDENTIFICADOR PARENTESIS_ABRE PARENTESIS_CIERRA LlaveAbre LlaveCierra { $$ = Instruccion.nuevoMetodo($2, [], [], this.$.first_line, this.$.first_column+1) }
        | TK_VOID error LlaveCierra { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de método no válida.", linea: this.$.first_line, columna: this.$.first_column+1 }); }
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

parametros: Tipos COR_ABRE COR_CIERRA IDENTIFICADOR { $$ = Instruccion.nuevoParametro($4, {vector: $1}, this.$.first_line, this.$.first_column+1) }
	| Tipos IDENTIFICADOR { $$=Instruccion.nuevoParametro($2, $1, this.$.first_line, this.$.first_column+1) }
        | IDENTIFICADOR IDENTIFICADOR { $$=Instruccion.nuevoParametro($2, {struct: $1}, this.$.first_line, this.$.first_column+1) }
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
        | error TK_PYC { $$=""; errores.push({ tipo: "Sintactico", error: "Declaracion de instruccion no valida", linea: this.$.first_line, columna: this.$.first_column+1}); }
        | error LlaveCierra { $$=""; errores.push({ tipo: "Sintactico", error: "Declaracion de instruccion no valida", linea: this.$.first_line, columna: this.$.first_column+1}); }
;
//--------------------------------------------------------------------------------------------------------------------------------------

//--------------------------------------------------- Sentencias de Control If y Switch ------------------------------------------------

SentenciasControl: ControlIF { $$ = $1 }
		| CSwitch { $$ = $1 }
;

ControlIF: If { $$=$1 }
	| IfElse { $$ = $1 }
	| ElseIf { $$ = $1 }
        | TK_IF error LlaveCierra { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de sentencia If no válida.", linea: this.$.first_line, columna: this.$.first_column+1 }); }
;

If: TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra { $$ = new Instruccion.nuevoIf($3, $6, this.$.first_line, this.$.first_column+1) }
   | TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre LlaveCierra { $$ = new Instruccion.nuevoIf($3, [], this.$.first_line, this.$.first_column+1) }
;

IfElse: TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra TK_ELSE LlaveAbre Instructions LlaveCierra { $$ = new Instruccion.nuevoIfElse($3, $6, $10, this.$.first_line, this.$.first_column+1) }
        | TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre LlaveCierra TK_ELSE LlaveAbre Instructions LlaveCierra { $$ = new Instruccion.nuevoIfElse($3, [], $9, this.$.first_line, this.$.first_column+1) }
        | TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra TK_ELSE LlaveAbre LlaveCierra { $$ = new Instruccion.nuevoIfElse($3, $6, [], this.$.first_line, this.$.first_column+1) }
        | TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre LlaveCierra TK_ELSE LlaveAbre LlaveCierra { $$ = new Instruccion.nuevoIfElse($3, [], [], this.$.first_line, this.$.first_column+1) }
;

ElseIf: TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra TK_ELSE ControlIF { $$ = new Instruccion.nuevoElseIf($3, $6, $9, this.$.first_line, this.$.first_column+1) }
	| TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre LlaveCierra TK_ELSE ControlIF { $$ = new Instruccion.nuevoElseIf($3, [], [], this.$.first_line, this.$.first_column+1) }
;

CSwitch: TK_SWITCH PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre ListCase Default LlaveCierra { $$ = new Instruccion.nuevoSwitch($3, $6, $7, this.$.first_line, this.$.first_column+1)  }
		| TK_SWITCH PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre ListCase LlaveCierra { $$ = new Instruccion.nuevoSwitch($3, $6, null, this.$.first_line, this.$.first_column+1) }
		| TK_SWITCH PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre Default LlaveCierra { $$ = new Instruccion.nuevoSwitch($3, null, $6, this.$.first_line, this.$.first_column+1) }
                | TK_SWITCH error LlaveCierra { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de Switch no válida.", linea: this.$.first_line, columna: this.$.first_column+1 }); }
;

ListCase: ListCase TK_CASE Expresiones TK_DOSPUNTS Instructions { $1.push(new Instruccion.nuevoCaso($3, $5, this.$.first_line, this.$.first_column+1)); $$=$1; }
		| ListCase TK_CASE Expresiones TK_DOSPUNTS { $1.push(new Instruccion.nuevoCaso($3, [], this.$.first_line, this.$.first_column+1)); $$=$1; }
		| TK_CASE Expresiones TK_DOSPUNTS Instructions { $$ = [new Instruccion.nuevoCaso($2, $4, this.$.first_line, this.$.first_column+1)]; }
		| TK_CASE Expresiones TK_DOSPUNTS { $ = [new Instruccion.nuevoCaso($2, [], this.$.first_line, this.$.first_column+1)]; }
                | TK_CASE error TK_DOSPUNTS { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de caso no válida.", linea: this.$.first_line, columna: this.$.first_column+1 }); }
;

Default: TK_DEFAULT TK_DOSPUNTS Instructions { $$ = new Instruccion.nuevoCaso(null, $3, this.$.first_line, this.$.first_column+1); }
		| TK_DEFAULT TK_DOSPUNTS { $$ = new Instruccion.nuevoCaso(null, [], this.$.first_line, this.$.first_column+1); }
;

//--------------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------------- Sentencias Ciclicas ---------------------------------------------------------

SentenciasCiclicas: While { $$=$1 }
                   | For { $$=$1 }
                   | DoWhile { $$=$1 }
;

While: TK_WHILE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra { $$ = new Instruccion.nuevoWhile($3, $6, this.$.first_line,this.$.first_column+1) }
        | TK_WHILE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre LlaveCierra { $$ = new Instruccion.nuevoWhile($3, [], this.$.first_line,this.$.first_column+1) }
        | TK_WHILE error LlaveCierra { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de ciclo While no válida.", linea: this.$.first_line, columna: this.$.first_column+1 }); }
;

DoWhile: TK_DO LlaveAbre Instructions LlaveCierra TK_WHILE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA TK_PYC { $$ = new Instruccion.nuevoDoWhile($7, $3, this.$.first_line,this.$.first_column+1) }
        | TK_DO LlaveAbre LlaveCierra TK_WHILE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA TK_PYC { $$ = new Instruccion.nuevoDoWhile($7, [], this.$.first_line,this.$.first_column+1) } 
        | TK_DO error TK_PYC { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de sentencia Do-While no válida.", linea: this.$.first_line, columna: this.$.first_column+1 }); }
;

For: TK_FOR PARENTESIS_ABRE Dec_Var Expresiones TK_PYC Actualizacion PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra { $9.push($6); $$ = new Instruccion.nuevoFor($3, $4, $9, this.$.first_line,this.$.first_column+1) }
	| TK_FOR PARENTESIS_ABRE Dec_Var Expresiones TK_PYC Actualizacion PARENTESIS_CIERRA LlaveAbre LlaveCierra { $$ = new Instruccion.nuevoFor($3, $4, [$6], this.$.first_line,this.$.first_column+1) }
        | TK_FOR IDENTIFICADOR IN Expresiones LlaveAbre Instructions LlaveCierra {$$ = new Instruccion.nuevoFor($2, $4, $6, this.$.first_line,this.$.first_column+1)} 
        | TK_FOR error LlaveCierra { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de ciclo For no válida.", linea: this.$.first_line, columna: this.$.first_column+1 }); }
;

Actualizacion: IDENTIFICADOR IGUAL Expresiones { $$ = Instruccion.nuevaAsignacion($1, $3, this.$.first_line,this.$.first_column+1) }
 		| IDENTIFICADOR INCREMENTO { $$ = Instruccion.nuevaAsignacion($1,
			{ opIzq: { tipo: 'VAL_IDENTIFICADOR', valor: $1, linea: this.$.first_line, columna: this.$.first_column+1 },
  			opDer: { tipo: 'VAL_ENTERO', valor: 1, linea: this.$.first_line, columna: this.$.first_column+1 },
  			tipo: 'SUMA',
  			linea: this._$.first_line,
  			columna: this.$.first_column+1 }, this.$.first_line,this._$.first_column+1) }
		| IDENTIFICADOR DECREMENTO { $$ = Instruccion.nuevaAsignacion($1,
			{ opIzq: { tipo: 'VAL_IDENTIFICADOR', valor: $1, linea: this.$.first_line, columna: this.$.first_column+1 },
  			opDer: { tipo: 'VAL_ENTERO', valor: 1, linea: this.$.first_line, columna: this.$.first_column+1 },
  			tipo: 'RESTA',
  			linea: this._$.first_line,
  			columna: this.$.first_column+1 }, this.$.first_line,this._$.first_column+1) }
;

//--------------------------------------------------------------------------------------------------------------------------------------

//--------------------------------------------------------- Sentencias de Transferencia ------------------------------------------------

SentenciasTransferencias: TK_BREAK TK_PYC { $$ = new Instruccion.nuevoBreak(this.$.first_line, this.$.first_column+1) }
                        | TK_RETURN TK_PYC { $$ = new Instruccion.nuevoReturn(null, this.$.first_line, this.$.first_column+1) }
                        | TK_CONTINUE TK_PYC { $$ = new Instruccion.nuevoContinue(this.$.first_line, this.$.first_column+1) }
                        | TK_RETURN Expresiones TK_PYC { $$ = new Instruccion.nuevoReturn($2, this.$.first_line, this.$.first_column+1) }
;

//--------------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------------------- Impresion -------------------------------------------------------------

 Imprimir: TK_PRINT PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA TK_PYC { $$ = new Instruccion.nuevoImprimir($3, this.$.first_line,this.$.first_column+1); }
        | TK_PRINTLN PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA TK_PYC { $$ = new Instruccion.nuevoImprimir($3, this.$.first_line,this.$.first_column+1); }
        | TK_PRINT PARENTESIS_ABRE Dec_Vect PARENTESIS_CIERRA TK_PYC { $$ = new Instruccion.nuevoImprimir($3, this.$.first_line,this.$.first_column+1); }
        | TK_PRINTLN PARENTESIS_ABRE Dec_Vect PARENTESIS_CIERRA TK_PYC { $$ = new Instruccion.nuevoImprimir($3, this.$.first_line,this.$.first_column+1); }
        | TK_PRINT PARENTESIS_ABRE operString PARENTESIS_CIERRA TK_PYC { $$ = new Instruccion.nuevoImprimir($3, this.$.first_line,this.$.first_column+1); }
        | TK_PRINTLN PARENTESIS_ABRE operString PARENTESIS_CIERRA TK_PYC { $$ = new Instruccion.nuevoImprimir($3, this.$.first_line,this.$.first_column+1); }
        | TK_PRINT error TK_PYC {  $$ = ""; errores.push({ tipo: "Sintáctico", error: "Llamada a función imprimir no válida.", linea: this.$.first_line, columna: this.$.first_column+1 }); }
        | TK_PRINTLN error TK_PYC {  $$ = ""; errores.push({ tipo: "Sintáctico", error: "Llamada a función imprimir no válida.", linea: this.$.first_line, columna: this.$.first_column+1 }); }
 ;
 //---------------------------------------------------------------------------------------------------------------------------------------

//------------------------------------------------------------- Declaraciones -----------------------------------------------------------

 Dec_Var: Tipos IDENTIFICADOR IGUAL Expresiones TK_PYC { $$ = Instruccion.nuevaDeclaracion($2, $4, $1, this.$.first_line,this.$.first_column+1) }
        //| Tipos IDENTIFICADOR IGUAL LLamada TK_PYC { $$ = Instruccion.nuevaDeclaracion($2, [$4], $1, this.$.first_line,this.$.first_column+1) }
        | Tipos IDENTIFICADOR TK_PYC { $$ = Instruccion.nuevaDeclaracion($2, null, $1, this.$.first_line,this.$.first_column+1) }
        | IDENTIFICADOR IGUAL Expresiones TK_PYC { $$ = Instruccion.nuevaAsignacion($1, $3, this.$.first_line,this.$.first_column+1) }
        | IDENTIFICADOR INCREMENTO TK_PYC { $$ = Instruccion.nuevaAsignacion($1,
			{ opIzq: { tipo: 'VAL_IDENTIFICADOR', valor: $1, linea: this.$.first_line, columna: this.$.first_column+1 },
  			opDer: { tipo: 'VAL_ENTERO', valor: 1, linea: this.$.first_line, columna: this.$.first_column+1 },
  			tipo: 'SUMA',
  			linea: this._$.first_line,
  			columna: this.$.first_column+1 }, this.$.first_line,this._$.first_column+1) }
        | IDENTIFICADOR DECREMENTO TK_PYC { $$ = Instruccion.nuevaAsignacion($1,
			{ opIzq: { tipo: 'VAL_IDENTIFICADOR', valor: $1, linea: this.$.first_line, columna: this.$.first_column+1 },
  			opDer: { tipo: 'VAL_ENTERO', valor: 1, linea: this.$.first_line, columna: this.$.first_column+1 },
  			tipo: 'RESTA',
  			linea: this._$.first_line,
  			columna: this.$.first_column+1 }, this.$.first_line,this._$.first_column+1) }
        | Tipos IDENTIFICADOR { $$ = Instruccion.nuevaDeclaracion($2, null, $1, this.$.first_line,this.$.first_column+1) }

        | IDENTIFICADOR COR_ABRE Expresiones COR_CIERRA IGUAL Expresiones TK_PYC { $$ = Instruccion.modificacionVector($1, $3, $6, this.$.first_line, this.$.first_column+1) }

        | Tipos IDENTIFICADOR IGUAL operString TK_PYC { $$ = Instruccion.nuevaDeclaracion($2, $4, $1, this.$.first_line,this.$.first_column+1) }
        | Tipos error TK_PYC { $$ = ""; errores.push({ tipo: "Sintactico", error: "Declaracion de variable incorrecta", linea: this.$.first_line, columna: this.$.first_column+1 }); console.log(errores) }
;

Dec_Vect: Tipos COR_ABRE COR_CIERRA IDENTIFICADOR IGUAL COR_ABRE Params COR_CIERRA TK_PYC { $$ = Instruccion.nuevoVector($1, null, $4, null, $7, null, this.$.first_line, this.$.first_column+1) }
        | Tipos COR_ABRE COR_CIERRA IDENTIFICADOR IGUAL COR_ABRE COR_CIERRA TK_PYC { $$ = Instruccion.nuevoVector($1, null, $4, null, null, null, this.$.first_line, this.$.first_column+1) }
        | Tipos COR_ABRE COR_CIERRA IDENTIFICADOR IGUAL OP_VECOTRES IDENTIFICADOR TK_PYC {  }
        
        | IDENTIFICADOR TK_PUNTO TK_PUSH PARENTESIS_ABRE Params PARENTESIS_CIERRA TK_PYC {$$ = Instruccion.modificacionLista($1, null, $5, this._$.first_line, this._$.first_column+1)}
        | IDENTIFICADOR TK_PUNTO TK_POP PARENTESIS_ABRE PARENTESIS_CIERRA TK_PYC {$$ = Instruccion.modificacionVector($1, null, null, this._$.first_line, this._$.first_column+1)}

        | IDENTIFICADOR TK_PUNTO TK_LENGTH PARENTESIS_ABRE PARENTESIS_CIERRA TK_PYC {$$ = new Instruccion.nuevoLength($3, this.$.first_line,this.$.first_column+1)}
        
        | Tipos COR_ABRE COR_CIERRA IDENTIFICADOR IGUAL IDENTIFICADOR opVector TK_PYC {}
        | Tipos COR_ABRE COR_CIERRA IDENTIFICADOR IGUAL opVector TK_PYC {}
        | IDENTIFICADOR opVector {}
        | Tipos COR_ABRE COR_CIERRA error TK_PYC { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de vector no válida.", linea: this.$.first_line, columna: this.$.first_column+1 }); }
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
operString: Expresiones CONCATENADOCADENA Expresiones {$$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.SUMA,this.$.first_line,this.$.first_column+1); }
        | operString CONCATENADOCADENA Expresiones {$$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.SUMA,this.$.first_line,this.$.first_column+1); }
        | CADENA OP_EXPONENTE ENTERO {$$= Instruccion.nuevaOperacionBinaria(Instruccion.nuevoValor($1, TIPO_VALOR.CADENA, this.$.first_line,this.$.first_column+1),Instruccion.nuevoValor($3, TIPO_VALOR.ENTERO, this.$.first_line,this.$.first_column+1), TIPO_OPERACION.POTENCIA,this.$.first_line,this.$.first_column+1); }
        | operString OP_EXPONENTE ENTERO {$$= Instruccion.nuevaOperacionBinaria($1,Instruccion.nuevoValor($3, TIPO_VALOR.ENTERO, this.$.first_line,this.$.first_column+1), TIPO_OPERACION.POTENCIA,this.$.first_line,this.$.first_column+1); }
        | Expresiones TK_COMA Expresiones { $$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.SUMA,this.$.first_line,this.$.first_column+1); }
;
//--------------------------------------------------------------------------------------------------------------------------------------

//------------------------------------------------- LLamada a metodos / funciones -------------------------------------------------------

LLamada: IDENTIFICADOR PARENTESIS_ABRE Params PARENTESIS_CIERRA { $$ = Instruccion.nuevaLlamada($1, $3, this._$.first_line, this._$.first_column+1) }
        | IDENTIFICADOR PARENTESIS_ABRE PARENTESIS_CIERRA { $$ = Instruccion.nuevaLlamada($1, [], this._$.first_line, this._$.first_column+1) }
;
//--------------------------------------------------------------------------------------------------------------------------------------


simbolos: OP_SUMA { $$=$1 }
        | OP_MENOS { $$=$1 }
        | OP_DIVISION { $$=$1 }
        | OP_MULTIPLICACION { $$=$1 }
        | OP_MODULO { $$=$1 }
;

Expresiones: CADENA {$$ = Instruccion.nuevoValor($1, TIPO_VALOR.CADENA, this.$.first_line,this.$.first_column+1)}
            | CARACTER {$$ = Instruccion.nuevoValor($1.trim().substring(1, $1.length - 1), TIPO_VALOR.CARACTER, this.$.first_line,this.$.first_column+1)}
            | TRUE {$$ = Instruccion.nuevoValor($1.trim(), TIPO_VALOR.BOOLEAN, this.$.first_line,this.$.first_column+1)}
            | FALSE {$$ = Instruccion.nuevoValor($1.trim(), TIPO_VALOR.BOOLEAN, this.$.first_line,this.$.first_column+1)}
            | ENTERO {$$ = Instruccion.nuevoValor(Number($1.trim()), TIPO_VALOR.ENTERO, this.$.first_line,this.$.first_column+1)}
            | DECI {$$ = Instruccion.nuevoValor(Number($1.trim()), TIPO_VALOR.DOBLE, this.$.first_line,this.$.first_column+1)}
            | NULL {$$ = Instruccion.nuevoValor($1, TIPO_VALOR.NULL, this.$.first_line,this.$.first_column+1)}
            | IDENTIFICADOR {$$ = Instruccion.nuevoValor($1.trim(), TIPO_VALOR.IDENTIFICADOR, this.$.first_line,this.$.first_column+1)}

            | PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA {$$=$2;}

            | Expresiones OP_SUMA Expresiones {$$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.SUMA,this.$.first_line,this.$.first_column+1); }
            | Expresiones OP_MENOS Expresiones {$$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.RESTA,this.$.first_line,this.$.first_column+1);}
            | Expresiones OP_DIVISION Expresiones {$$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.DIVISION,this.$.first_line,this.$.first_column+1);}
            | Expresiones OP_MULTIPLICACION Expresiones {$$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.MULTIPLICACION,this.$.first_line,this.$.first_column+1);}
            | Expresiones OP_MODULO Expresiones {$$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.MODULO,this.$.first_line,this.$.first_column+1);}

            | TK_POW PARENTESIS_ABRE Expresiones TK_COMA Expresiones PARENTESIS_CIERRA {$$= Instruccion.nuevaOperacionBinaria($3,$5, TIPO_OPERACION.POTENCIA,this.$.first_line,this.$.first_column+1); }
            | TK_SQRT PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$= Instruccion.nuevaOperacionBinaria(null,$3, TIPO_OPERACION.RAIZ,this.$.first_line,this.$.first_column+1);}
            | TK_SENO PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$= Instruccion.nuevaOperacionBinaria(null,$3, TIPO_OPERACION.SENO,this.$.first_line,this.$.first_column+1);}
            | TK_COSENO PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$= Instruccion.nuevaOperacionBinaria(null,$3, TIPO_OPERACION.COSENO,this.$.first_line,this.$.first_column+1);}
            | TK_TANGENTE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$= Instruccion.nuevaOperacionBinaria(null,$3, TIPO_OPERACION.TANGETE,this.$.first_line,this.$.first_column+1);}
            | TK_LOGARITMOB10 PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$= Instruccion.nuevaOperacionBinaria(null,$3, TIPO_OPERACION.LOGARITMO,this.$.first_line,this.$.first_column+1);}

            | Expresiones IGUALIGUAL Expresiones { $$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.IGUALIGUAL,this.$.first_line,this.$.first_column+1); }
            | Expresiones MENOR Expresiones { $$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.MENOR,this.$.first_line,this.$.first_column+1); }
            | Expresiones MENORIGUAL Expresiones { $$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.MENORIGUAL,this.$.first_line,this.$.first_column+1); }
            | Expresiones MAYOR Expresiones { $$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.MAYOR,this.$.first_line,this.$.first_column+1); }
            | Expresiones MAYORIGUAL Expresiones { $$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.MAYORIGUAL,this.$.first_line,this.$.first_column+1) }

            | Expresiones OR Expresiones { $$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.OR,this.$.first_line,this.$.first_column+1); }
            | Expresiones AND Expresiones { $$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.AND,this.$.first_line,this.$.first_column+1); }
            | Expresiones DIFERENTEA Expresiones { $$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.DIFERENTE,this.$.first_line,this.$.first_column+1);  }
            | NOT Expresiones { $$= Instruccion.nuevaOperacionBinaria($2, null, TIPO_OPERACION.NOT,this.$.first_line,this.$.first_column+1); }

            | IDENTIFICADOR COR_ABRE Expresiones COR_CIERRA {}
            | COR_ABRE Expresiones COR_CIERRA {}
            | FuncioesReservadas { $$=$1; }
            | Casteos { $$=$1; }
            | Ternario {$$=$1;}
            | LLamada {$$=$1; }
            | IDENTIFICADOR COR_ABRE ENTERO TK_DOSPUNTS	ENTERO COR_CIERRA { }
            | IDENTIFICADOR COR_ABRE TK_BEGIN TK_DOSPUNTS ENTERO COR_CIERRA { }
            | IDENTIFICADOR COR_ABRE ENTERO TK_DOSPUNTS	TK_END COR_CIERRA { }
            | OP_MENOS Expresiones %prec umenos { $$= Instruccion.nuevaOperacionBinaria($2, null, TIPO_OPERACION.NEGACION,this.$.first_line,this.$.first_column+1); }
;

Ternario: Expresiones OP_TERNARIO Expresiones TK_DOSPUNTS Expresiones { $$ = new Instruccion.nuevoTernario($1, $3, $5, this._$.first_line, this._$.first_column+1) }
;

//------------------------------------------------------ Reservadas --------------------------------------------------------------------

FuncioesReservadas: FCaracterOfPosition { $$=$1 }
                   | FSubString { $$=$1 }
                   | Flength {$$=$1}
                   | FToLower { $$=$1 }
                   | FToUpper { $$=$1 }
                   | FTypeof { $$=$1 }
;

FCaracterOfPosition: IDENTIFICADOR TK_PUNTO TK_CARACTEROFPOSITION PARENTESIS_ABRE ENTERO PARENTESIS_CIERRA {}
;

FSubString: IDENTIFICADOR TK_PUNTO TK_SUBSTRING PARENTESIS_ABRE ENTERO TK_COMA ENTERO PARENTESIS_CIERRA {}
;

Flength: IDENTIFICADOR TK_PUNTO TK_LENGTH PARENTESIS_ABRE PARENTESIS_CIERRA { $$ = new Instruccion.nuevoLength(Instruccion.nuevoValor($1.trim(), TIPO_VALOR.IDENTIFICADOR, this.$.first_line,this.$.first_column+1), this._$.first_line,this._$.first_column+1) }
;

FToLower: IDENTIFICADOR TK_PUNTO TK_TOLOWER PARENTESIS_ABRE PARENTESIS_CIERRA { $$ = new Instruccion.toLower(Instruccion.nuevoValor($1.trim(), TIPO_VALOR.IDENTIFICADOR, this.$.first_line,this.$.first_column+1), this._$.first_line,this._$.first_column+1) }
;

FToUpper: IDENTIFICADOR TK_PUNTO TK_TOUPPER PARENTESIS_ABRE PARENTESIS_CIERRA { $$ = new Instruccion.toUpper(Instruccion.nuevoValor($1.trim(), TIPO_VALOR.IDENTIFICADOR, this.$.first_line,this.$.first_column+1), this._$.first_line,this._$.first_column+1) }
;

FTypeof: TK_TYPEOF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$ = new Instruccion.nuevoTypeOf($3, this._$.first_line,this._$.first_column+1) }
;

//--------------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------------------- Casteos ---------------------------------------------------------------
Casteos: parseo { $$ = $1 }
        | toTipo { $$ = $1 }
        | TK_STRINGPARSE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$ = new Instruccion.nuevoToString($3, this._$.first_line,this._$.first_column+1) }
;

parseo: Tipos TK_PUNTO TK_PARSE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$ = new Instruccion.nuevoCasteo($1, $5, this._$.first_line, this._$.first_column+1) }
;

toTipo: TK_TOINT PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$ = new Instruccion.nuevoCasteo("ENTERO", $3, this._$.first_line, this._$.first_column+1) }
        | TK_TODOUBLE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$ = new Instruccion.nuevoCasteo("DOBLE", $3, this._$.first_line, this._$.first_column+1) }
;


//--------------------------------------------------------------------------------------------------------------------------------------


Tipos: STRING { $$ = TIPO_DATO.CADENA; }
    | INT { $$ = TIPO_DATO.ENTERO; }
    | DOUBLE { $$ = TIPO_DATO.DOBLE; }
    | CHAR { $$ = TIPO_DATO.CARACTER; }
    | FLOAT { $$ = TIPO_DATO.DOBLE; }
    | BOOLEAN { $$ = TIPO_DATO.BOOLEAN; }
;