%{
    var cadena = '';
    var errores = [];
    var producciones = [];
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

ini: ENTRADA EOF { retorno = { parse: $1, errores: errores }; errores = []; return retorno; producciones.push({Sintactico: "inicio -> entrada EOF", Semantico: "inicio.val := entrada.val EOF"}); }
    |error EOF   { retorno = { parse: null, errores: errores }; errores = []; return retorno; }
;

ENTRADA: ENTRADA instrucciones { if($2 !=="") $1.push($2); $$ = $1; producciones.push({Sintactico: "entrada -> entrada instrucciones", Semantico: "entrada.val := entrada.val instrucciones.val"});}
        | instrucciones { if($1 !== "") $$ = [$1]; else $$ = []; producciones.push({Sintactico: "entrada -> instrucciones ", Semantico: "entrada.val := instrucciones.val"});}
;

instrucciones: MFBody { $$ = $1; producciones.push({Sintactico: "instrucciones -> Metodo/Funcion", Semantico: "instrucciones.val -> Metodo.val/Funcion.val"});}
		| MainBody { $$= $1; producciones.push({Sintactico: "instrucciones -> Main", Semantico: "instrucciones.val -> Main.val"}); }
		| Dec_Var { $$= $1; producciones.push({Sintactico: "instrucciones -> Declaracion_Variable", Semantico: "instrucciones.val -> Declaracion_Variable.val"}); }
		| Dec_Vect { $$= $1; producciones.push({Sintactico: "instrucciones -> Declaracion_Vector", Semantico: "instrucciones.val -> Declaracion_Vector.val"}); }
                | Dec_Struct { $$= $1; producciones.push({Sintactico: "instrucciones -> Declaracion_Struct", Semantico: "instrucciones.val -> Declaracion_Struct.val"}); }
                | LLamada TK_PYC{ $$= $1; producciones.push({Sintactico: "instrucciones -> Llamadas", Semantico: "instrucciones.val -> Llamadas.val"}); }
;
//--------------------------------------------------------------- MAIN ------------------------------------------------------------
MainBody: TK_VOID TK_MAIN PARENTESIS_ABRE PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra { $$ = Instruccion.nuevoStart("main", [], $6, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "Main -> VOID MAIN () { instructions }", Semantico: "Main.val -> VOID MAIN () { instructions.val }"}); }
        | TK_VOID TK_MAIN error LlaveCierra { $$= ""; errores.push({ tipo: "Sintactico", error: "Declaracion de main invalido", linea: this._$.first_line, columna: this._$.first_column+1 }); console.log(errores) }
;

//-----------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------- METODO FUNCION STRUCT ----------------------------------------------------------
MFBody: Tipos IDENTIFICADOR PARENTESIS_ABRE PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra { $$ = Instruccion.nuevaFuncion($2, null, $6, $1, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "Funcion -> TIPO ID () { instructions }", Semantico: "Funcion.val -> TIPO.val ID () { instructions.val }"}); }
        | Tipos IDENTIFICADOR PARENTESIS_ABRE Params PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra { $$= Instruccion.nuevaFuncion($2, $4, $7, $1, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "Funcion -> TIPO ID ( Params ) { instructions }", Semantico: "Funcion.val -> TIPO.val ID ( Params.val ) { instructions.val }"}); }
        | Tipos IDENTIFICADOR PARENTESIS_ABRE Params PARENTESIS_CIERRA LlaveAbre LlaveCierra { $$= Instruccion.nuevaFuncion($2, $4, [], $1, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "Funcion -> TIPO ID ( Params ) {}", Semantico: "Funcion.val -> TIPO.val ID ( Params.val ) {}"}); }
        | Tipos IDENTIFICADOR PARENTESIS_ABRE PARENTESIS_CIERRA LlaveAbre LlaveCierra { $$= Instruccion.nuevaFuncion($2, null, [], $1, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "Funcion -> TIPO ID () {}", Semantico: "Funcion.val -> TIPO.val ID () {}"}); }
        | Tipos error LlaveCierra { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de función no válida.", linea: this._$.first_line, columna: this._$.first_column+1 }); }
        | Tipos COR_ABRE COR_CIERRA error LlaveCierra { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de función no válida.", linea: this._$.first_line, columna: this._$.first_column+1 }); }

        | TK_VOID IDENTIFICADOR PARENTESIS_ABRE PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra { $$ = Instruccion.nuevoMetodo($2, null, $6, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "Metodo -> VOID ID () { instructions }", Semantico: "Metodo.val -> VOID ID () { instructions.val }"}); }
	| TK_VOID IDENTIFICADOR PARENTESIS_ABRE Params PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra { $$ = Instruccion.nuevoMetodo($2, $4, $7, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "Metodo -> VOID ID ( Params ) { instructions }", Semantico: "Metodo.val -> VOID ID ( Params.val ) { instructions.val }"}); } 
	| TK_VOID IDENTIFICADOR PARENTESIS_ABRE Params PARENTESIS_CIERRA LlaveAbre LlaveCierra { $$ = Instruccion.nuevoMetodo($2, $4, [], this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "Metodo -> VOID ID ( Params ) {}", Semantico: "Metodo.val -> VOID ID ( Params.val ) {}"}); } 
	| TK_VOID IDENTIFICADOR PARENTESIS_ABRE PARENTESIS_CIERRA LlaveAbre LlaveCierra { $$ = Instruccion.nuevoMetodo($2, [], [], this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "Metodo -> VOID ID () {}", Semantico: "Metodo.val -> VOID ID () {}"}); }
        | TK_VOID error LlaveCierra { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de método no válida.", linea: this._$.first_line, columna: this._$.first_column+1 }); }
;

Dec_Struct: TK_STRUCT IDENTIFICADOR LlaveAbre BodyStruct LlaveCierra TK_PYC { alert("Struct: "+$1+", Nombre: "+$2); return $4; producciones.push({Sintactico: "Declaracion_Struct -> STRUCT ID { dec_variables };", Semantico: "Declaracion_Struct.val -> STRUCT ID { dec_variables.val };" }); }
        | IDENTIFICADOR IDENTIFICADOR IGUAL IDENTIFICADOR PARENTESIS_ABRE Params PARENTESIS_CIERRA TK_PYC { alert("Nombre Struct: "+$1+", Identificador1: "+$2+", Identificador2: "+$4); return $5; producciones.push({Sintactico: "Declaracion_Struct -> ID ID = ID( Params );", Semantico: "Declaracion_Struct.val -> ID ID.val = ID( Params.val );" }); }
        | IDENTIFICADOR IDENTIFICADOR IGUAL IDENTIFICADOR PARENTESIS_ABRE PARENTESIS_CIERRA TK_PYC { alert("Nombre Struct: "+$1+", Identificador1: "+$2+", Identificador2: "+$4); return $1; producciones.push({Sintactico: "Declaracion_Struct -> ID ID = ID();", Semantico: "Declaracion_Struct.val -> ID ID.val = ID();" }); }
        | IDENTIFICADOR TK_PUNTO IDENTIFICADOR IGUAL Expresiones TK_PYC { alert("Nombre Struct: "+$1+" Identificador: "+$3); return $5; producciones.push({Sintactico: "Declaracion_Struct -> ID.ID = Espresiones", Semantico: "Declaracion_Struct.val -> ID.ID.val = Espresiones.val"}); }
        | TK_STRUCT error LlaveCierra TK_PYC { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de Struct no válida.", linea: this._$.first_line, columna: this._$.first_column+1 }); }
;

BodyStruct: s { $$ = $1; producciones.push({Sintactico: "dec_variables -> var ", Semantico: "dec_variables.val -> var.val;" }); }
        | s TK_COMA BodyStruct { $1.push($3); $$=1; return $1; producciones.push({Sintactico: "dec_variables -> var , dec_variables ", Semantico: "dec_variables.val -> var.val, dec_variables.val;"});}
;

s: Dec_Var {$$=$1; producciones.push({Sintactico: "var -> Declaracion_Variable", Semantico: "var.val -> Declaracion_Variable.val"}); }
        | IDENTIFICADOR IDENTIFICADOR { alert("Nombre: "+$1+", identificador: "+$2); return $2; producciones.push({Sintactico: "var -> ID ID", Semantico: "var.val -> ID ID.val"}); }
;
//------------------------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------------- PARAMETROS -------------------------------------------------------------
Params: parametros { $$ = [$1]; producciones.push({Sintactico: "Params -> parametros", Semantico: "Params.val -> parametros.val"}); }
        | Params TK_COMA parametros { $1.push($3); $$=$1; producciones.push({Sintactico: "Params -> Params , parametros", Semantico: "Params.val -> Params.val , parametros.val"}); } 
;

parametros: Tipos COR_ABRE COR_CIERRA IDENTIFICADOR { $$ = Instruccion.nuevoParametro($4, ["LISTA", $1], this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "parametros -> TIPO [] ID ", Semantico: "parametros.val -> TIPO.val [] ID.val"}); }
	| Tipos IDENTIFICADOR { $$=Instruccion.nuevoParametro($2, $1, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "parametros -> TIPO ID ", Semantico: "parametros.val -> TIPO.val ID.val"}); }
        | IDENTIFICADOR IDENTIFICADOR { $$=Instruccion.nuevoParametro($2, {struct: $1}, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "parametros -> ID ID ", Semantico: "parametros.val -> ID ID.val"});}
        | Expresiones { $$ = $1; producciones.push({Sintactico: "parametros -> Expresiones ", Semantico: "parametros.val -> Expresiones.val"});}
;
//--------------------------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------------- Instrucciones ------------------------------------------------------------
Instructions: Instructions cuerpo { if($2 !== "") $1.push($2); $$=$1; producciones.push({Sintactico: "instructions -> instructions cuerpo ", Semantico: "instructions.val -> instructions.val cuerpo.val"}); }
			| cuerpo { if($1 !== "") $$ = [$1]; else $$ = []; producciones.push({Sintactico: "instructions -> cuerpo", Semantico: "instructions.val -> cuerpo.val"})}
;

cuerpo: Dec_Var { $$=$1; producciones.push({Sintactico: "cuerpo -> Declaracion_Variable", Semantico:"cuerpo.var -> Declaracion_Variable.var" });}
        | Imprimir {$$=$1; producciones.push({Sintactico: "cuerpo -> imprimir", Semantico:"cuerpo.var -> imprimir.var" });}
        | SentenciasControl {$$=$1; producciones.push({Sintactico: "cuerpo -> Sentencia_De_Control", Semantico:"cuerpo.var -> Sentencia_De_Control.var" })}
        | SentenciasCiclicas {$$=$1; producciones.push({Sintactico: "cuerpo -> Sentencias_Ciclicas", Semantico:"cuerpo.var -> Sentencias_Ciclicas.var" })}
        | SentenciasTransferencias {$$=$1; producciones.push({Sintactico: "cuerpo -> Sentencias_De_Escape", Semantico:"cuerpo.var -> Sentencias_De_Escape.var" })}
        | Dec_Struct {$$=$1; producciones.push({Sintactico: "cuerpo -> Declaracion_Struct", Semantico:"cuerpo.var -> Declaracion_Struct.var" })}
        | Dec_Vect {$$=$1; producciones.push({Sintactico: "cuerpo -> Declaracion_Vector", Semantico:"cuerpo.var -> Declaracion_Vector.var" })}
        | LLamada TK_PYC {$$=$1; producciones.push({Sintactico: "cuerpo -> Llamada", Semantico:"cuerpo.var -> Llamada.var" })}
        | error TK_PYC { $$=""; errores.push({ tipo: "Sintactico", error: "Declaracion de instruccion no valida", linea: this._$.first_line, columna: this._$.first_column+1}); }
        | error LlaveCierra { $$=""; errores.push({ tipo: "Sintactico", error: "Declaracion de instruccion no valida", linea: this._$.first_line, columna: this._$.first_column+1}); }
;
//--------------------------------------------------------------------------------------------------------------------------------------

//--------------------------------------------------- Sentencias de Control If y Switch ------------------------------------------------

SentenciasControl: ControlIF { $$ = $1; producciones.push({Sintactico: "Sentencia_De_Control -> ControlIF", Semantico: "Sentencia_De_Control.val -> ControlIF.val"});}
		| CSwitch { $$ = $1; producciones.push({Sintactico: "Sentencia_De_Control -> CSwitch", Semantico: "Sentencia_De_Control.val -> CSwitch.val"}); }
;

ControlIF: If { $$=$1; producciones.push({Sintactico: "ControlIf -> If", Semantico: "ControlIf.val -> If.val"});}
	| IfElse { $$ = $1; producciones.push({Sintactico: "ControlIf -> IfElse", Semantico: "ControlIf.val -> IfElse.val"});}
	| ElseIf { $$ = $1; producciones.push({Sintactico: "ControlIf -> ElseIf", Semantico: "ControlIf.val -> ElseIf.val"});}
        | TK_IF error LlaveCierra { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de sentencia If no válida.", linea: this._$.first_line, columna: this._$.first_column+1 }); }
;

If: TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra { $$ = new Instruccion.nuevoIf($3, $6, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "If -> IF (Expresiones) {instructions}", Semantico: "If.val -> IF (Expresiones.val) {instructions.val}"});}
   | TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre LlaveCierra { $$ = new Instruccion.nuevoIf($3, [], this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "If -> IF () {}", Semantico: "If -> IF () {}"});}
;

IfElse: TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra TK_ELSE LlaveAbre Instructions LlaveCierra { $$ = new Instruccion.nuevoIfElse($3, $6, $10, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "IfElse -> IF (Expresiones) {instructions} ELSE {instructions}", Semantico: "IfElse.val -> IF (Expresiones.val) {instructions.val} ELSE {instructions.val}"});}
        | TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre LlaveCierra TK_ELSE LlaveAbre Instructions LlaveCierra { $$ = new Instruccion.nuevoIfElse($3, [], $9, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "IfElse -> IF (Expresiones) {} ELSE {instructions}", Semantico: "IfElse.val -> IF (Expresiones.val) {} ELSE {instructions.val}"}); }
        | TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra TK_ELSE LlaveAbre LlaveCierra { $$ = new Instruccion.nuevoIfElse($3, $6, [], this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "IfElse -> IF (Expresiones) {instructions} ELSE {}", Semantico: "IfElse.val -> IF (Expresiones.val) {instructions.val} ELSE {}"}); }
        | TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre LlaveCierra TK_ELSE LlaveAbre LlaveCierra { $$ = new Instruccion.nuevoIfElse($3, [], [], this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "IfElse -> IF () {} ELSE {}", Semantico: "IfElse.val -> IF () {} ELSE {}"}); }
;

ElseIf: TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra TK_ELSE ControlIF { $$ = new Instruccion.nuevoElseIf($3, $6, $9, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "ElseIF -> IF (Expresiones) {instructions} ELSE ControlIf", Semantico: "ElseIF.val -> IF (Expresiones.val) {instructions.val} ELSE ControlIf.val"}); }
	| TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre LlaveCierra TK_ELSE ControlIF { $$ = new Instruccion.nuevoElseIf($3, [], [], this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "ElseIF -> IF (Expresiones) {} ELSE ControlIf", Semantico: "ElseIF.val -> IF (Expresiones.val) {} ELSE ControlIf.val"}); }
;

CSwitch: TK_SWITCH PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre ListCase Default LlaveCierra { $$ = new Instruccion.nuevoSwitch($3, $6, $7, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "CSwitch -> SWITCH (Expresiones) { listCase Default }", Semantico: "SWITCH (Expresiones.val) { listCase.val Default.val }"});}
		| TK_SWITCH PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre ListCase LlaveCierra { $$ = new Instruccion.nuevoSwitch($3, $6, null, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "CSwitch -> SWITCH (Expresiones) { listCase }", Semantico: "SWITCH (Expresiones.val) { listCase.val }"});}
		| TK_SWITCH PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre Default LlaveCierra { $$ = new Instruccion.nuevoSwitch($3, null, $6, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "CSwitch -> SWITCH (Expresiones) { Default }", Semantico: "SWITCH (Expresiones.val) { Default.val }"}); }
                | TK_SWITCH error LlaveCierra { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de Switch no válida.", linea: this._$.first_line, columna: this._$.first_column+1 }); }
;

ListCase: ListCase TK_CASE Expresiones TK_DOSPUNTS Instructions { $1.push(new Instruccion.nuevoCaso($3, $5, this._$.first_line, this._$.first_column+1)); $$=$1; producciones.push({Sintactico: "listCase -> listCase CASE Expresiones : instructions", Semantico: "listCase.val -> listCase.val CASE Expresiones.val : instructions.val"});}
		| ListCase TK_CASE Expresiones TK_DOSPUNTS { $1.push(new Instruccion.nuevoCaso($3, [], this._$.first_line, this._$.first_column+1)); $$=$1; producciones.push({Sintactico: "listCase -> listCase CASE Expresiones :", Semantico: "listCase.val -> listCase.val CASE Expresiones.val :"}); }
		| TK_CASE Expresiones TK_DOSPUNTS Instructions { $$ = [new Instruccion.nuevoCaso($2, $4, this._$.first_line, this._$.first_column+1)]; producciones.push({Sintactico: "listCase -> CASE Expresiones : instructions", Semantico: "listCase.val -> CASE Expresiones.val : instructions.val"}); }
		| TK_CASE Expresiones TK_DOSPUNTS { $ = [new Instruccion.nuevoCaso($2, [], this._$.first_line, this._$.first_column+1)]; producciones.push({Sintactico: "listCase -> CASE Expresiones :", Semantico: "listCase.val -> CASE Expresiones.val :"}); }
                | TK_CASE error TK_DOSPUNTS { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de caso no válida.", linea: this._$.first_line, columna: this._$.first_column+1 }); }
;

Default: TK_DEFAULT TK_DOSPUNTS Instructions { $$ = new Instruccion.nuevoCaso(null, $3, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "Default -> DEFAULT : instructions", Semantico: "Default.val -> DEFAULT : instructions.val"});}
		| TK_DEFAULT TK_DOSPUNTS { $$ = new Instruccion.nuevoCaso(null, [], this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "Default -> DEFAULT :", Semantico: "Default.val -> DEFAULT :"});}
;

//--------------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------------- Sentencias Ciclicas ---------------------------------------------------------

SentenciasCiclicas: While { $$=$1; producciones.push({Sintactico: "Sentencias_Ciclicas -> While", Semantico: "Sentencias_Ciclicas.val -> While.val"});}
                   | For { $$=$1; producciones.push({Sintactico: "Sentencias_Ciclicas -> For", Semantico: "Sentencias_Ciclicas.val -> For.val"});}
                   | DoWhile { $$=$1; producciones.push({Sintactico: "Sentencias_Ciclicas -> DoWhile", Semantico: "Sentencias_Ciclicas.val -> DoWhile.val"});}
;

While: TK_WHILE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra { $$ = new Instruccion.nuevoWhile($3, $6, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "While -> WHILE (Expresiones) {instructions}", Semantico: "While.val -> WHILE (Expresiones.val) {instructions.val}"});; }
        | TK_WHILE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre LlaveCierra { $$ = new Instruccion.nuevoWhile($3, [], this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "While -> WHILE (Expresiones) {}", Semantico: "While.val -> WHILE (Expresiones.val) {}"});}
        | TK_WHILE error LlaveCierra { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de ciclo While no válida.", linea: this._$.first_line, columna: this._$.first_column+1 }); }
;

DoWhile: TK_DO LlaveAbre Instructions LlaveCierra TK_WHILE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA TK_PYC { $$ = new Instruccion.nuevoDoWhile($7, $3, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "DoWhile -> DO {instructions} WHILE (Expresiones);", Semantico: "DoWhile.val -> DO {instructions.val} WHILE (Expresiones.val);"});}
        | TK_DO LlaveAbre LlaveCierra TK_WHILE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA TK_PYC { $$ = new Instruccion.nuevoDoWhile($7, [], this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "DoWhile -> DO {} WHILE (Expresiones);", Semantico: "DoWhile.val -> DO {} WHILE (Expresiones.val);"});} 
        | TK_DO error TK_PYC { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de sentencia Do-While no válida.", linea: this._$.first_line, columna: this._$.first_column+1 }); }
;

For: TK_FOR PARENTESIS_ABRE Dec_Var Expresiones TK_PYC Actualizacion PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra { $9.push($6); $$ = new Instruccion.nuevoFor($3, $4, $9, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "For -> FOR (Declaracion_Variable Expresiones; actualizacion) {instructions}", Semantico: "For.val -> FOR (Declaracion_Variable.val Expresiones.val; actualizacion.val) {instructions.val}"});}
	| TK_FOR PARENTESIS_ABRE Dec_Var Expresiones TK_PYC Actualizacion PARENTESIS_CIERRA LlaveAbre LlaveCierra { $$ = new Instruccion.nuevoFor($3, $4, [$6], this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "For -> FOR (Declaracion_Variable Expresiones; actualizacion) {}", Semantico: "For -> FOR (Declaracion_Variable.val Expresiones.val; actualizacion.val) {}"}); }
        | TK_FOR IDENTIFICADOR IN Expresiones LlaveAbre Instructions LlaveCierra {$$ = new Instruccion.nuevoFor($2, $4, $6, this._$.first_line,this._$.first_column+1); producciones.pus({Sintactico: "For -> FOR ID IN Expresiones {instructions}", Semantico: "For.val -> FOR ID.val IN Expresiones.val {instructions.val}"});} 
        | TK_FOR error LlaveCierra { $$ = ""; errores.push({ tipo: "Sintáctico", error: "Declaración de ciclo For no válida.", linea: this._$.first_line, columna: this._$.first_column+1 }); }
;

Actualizacion: IDENTIFICADOR IGUAL Expresiones { $$ = Instruccion.nuevaAsignacion($1, $3, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Acutualizacion -> ID = Expresiones", Semantico: "Acutualizacion.val -> ID = Expresiones.val"}); }
 		| IDENTIFICADOR INCREMENTO { $$ = Instruccion.nuevaAsignacion($1,
			{ opIzq: { tipo: 'VAL_IDENTIFICADOR', valor: $1, linea: this._$.first_line, columna: this._$.first_column+1 },
  			opDer: { tipo: 'VAL_ENTERO', valor: 1, linea: this._$.first_line, columna: this._$.first_column+1 },
  			tipo: 'SUMA',
  			linea: this._$.first_line,
  			columna: this._$.first_column+1 }, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Actualizacion -> ID ++", Semantico: "Actualizacion.val -> ID ++"});}
		| IDENTIFICADOR DECREMENTO { $$ = Instruccion.nuevaAsignacion($1,
			{ opIzq: { tipo: 'VAL_IDENTIFICADOR', valor: $1, linea: this._$.first_line, columna: this._$.first_column+1 },
  			opDer: { tipo: 'VAL_ENTERO', valor: 1, linea: this._$.first_line, columna: this._$.first_column+1 },
  			tipo: 'RESTA',
  			linea: this._$.first_line,
  			columna: this._$.first_column+1 }, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Actualizacion -> ID --", Semantico: "Actualizacion.val -> ID --"}); }
;

//--------------------------------------------------------------------------------------------------------------------------------------

//--------------------------------------------------------- Sentencias de Transferencia ------------------------------------------------

SentenciasTransferencias: TK_BREAK TK_PYC { $$ = new Instruccion.nuevoBreak(this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "Sentencias_De_Transferencia -> BREAK ;", Semantico: "Sentencias_De_Transferencia.val -> BREAK ;"});}
                        | TK_RETURN TK_PYC { $$ = new Instruccion.nuevoReturn(null, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "Sentencias_De_Transferencia -> RETURN ;", Semantico: "Sentencias_De_Transferencia.val -> RETURN ;"}) }
                        | TK_CONTINUE TK_PYC { $$ = new Instruccion.nuevoContinue(this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "Sentencias_De_Transferencia -> CONTINUE ;", Semantico: "Sentencias_De_Transferencia.val -> CONTINUE ;"}) }
                        | TK_RETURN Expresiones TK_PYC { $$ = new Instruccion.nuevoReturn($2, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "Sentencias_De_Transferencia -> RETURN Expresiones ;", Semantico: "Sentencias_De_Transferencia.val -> RETURN Expresiones.val ;"}) }
;

//--------------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------------------- Impresion -------------------------------------------------------------

 Imprimir: TK_PRINT PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA TK_PYC { $$ = new Instruccion.nuevoImprimir($3, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "imprimir - > PRINT (Expresiones) ; ", Semantico: "imprimir.val - > PRINT (Expresiones.val); "});}
        | TK_PRINTLN PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA TK_PYC { $$ = new Instruccion.nuevoImprimir($3, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "imprimir - > PRINTLN (Expresiones) ; ", Semantico: "imprimir.val - > PRINTLN (Expresiones.val); "});}

        | TK_PRINT PARENTESIS_ABRE Dec_Vect PARENTESIS_CIERRA TK_PYC { $$ = new Instruccion.nuevoImprimir($3, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "imprimir - > PRINT (Expresiones) ; ", Semantico: "imprimir.val - > PRINT (Expresiones.val); "});}
        | TK_PRINTLN PARENTESIS_ABRE Dec_Vect PARENTESIS_CIERRA TK_PYC { $$ = new Instruccion.nuevoImprimir($3, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "imprimir - > PRINTLN (Expresiones) ; ", Semantico: "imprimir.val - > PRINTLN (Expresiones.val); "});}

        | TK_PRINT PARENTESIS_ABRE operString PARENTESIS_CIERRA TK_PYC { $$ = new Instruccion.nuevoImprimir($3, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "imprimir - > PRINT (Expresiones) ; ", Semantico: "imprimir.val - > PRINT (Expresiones.val); "});}
        | TK_PRINTLN PARENTESIS_ABRE operString PARENTESIS_CIERRA TK_PYC { $$ = new Instruccion.nuevoImprimir($3, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "imprimir - > PRINTLN (Expresiones) ; ", Semantico: "imprimir.val - > PRINTLN (Expresiones.val); "});}

        | TK_PRINT error TK_PYC {  $$ = ""; errores.push({ tipo: "Sintáctico", error: "Llamada a función imprimir no válida.", linea: this._$.first_line, columna: this._$.first_column+1 }); }
        | TK_PRINTLN error TK_PYC {  $$ = ""; errores.push({ tipo: "Sintáctico", error: "Llamada a función imprimir no válida.", linea: this._$.first_line, columna: this._$.first_column+1 }); }
 ;
//---------------------------------------------------------------------------------------------------------------------------------------

//------------------------------------------------------------- Declaraciones -----------------------------------------------------------

 Dec_Var: Tipos IDENTIFICADOR IGUAL Expresiones TK_PYC { $$ = Instruccion.nuevaDeclaracion($2, $4, $1, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Declaracion_Variable -> TIPO ID = Expresiones", Semantico: "Declaracion_Variable.val -> TIPO.val ID = Expresiones.val"});}
        //| Tipos IDENTIFICADOR IGUAL LLamada TK_PYC { $$ = Instruccion.nuevaDeclaracion($2, [$4], $1, this._$.first_line,this._$.first_column+1) }
        | Tipos IDENTIFICADOR TK_PYC { $$ = Instruccion.nuevaDeclaracion($2, null, $1, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Declaracion_Variable -> TIPO ID;", Semantico: "Declaracion_Variable.val -> TIPO.val ID;"});}
        | IDENTIFICADOR IGUAL Expresiones TK_PYC { $$ = Instruccion.nuevaAsignacion($1, $3, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Declaracion_Variable -> ID = Expresiones", Semantico: "Declaracion_Variable.val -> ID = Expresiones.val"});}
        | IDENTIFICADOR INCREMENTO TK_PYC { $$ = Instruccion.nuevaAsignacion($1,
			{ opIzq: { tipo: 'VAL_IDENTIFICADOR', valor: $1, linea: this._$.first_line, columna: this._$.first_column+1 },
  			opDer: { tipo: 'VAL_ENTERO', valor: 1, linea: this._$.first_line, columna: this._$.first_column+1 },
  			tipo: 'SUMA',
  			linea: this._$.first_line,
  			columna: this._$.first_column+1 }, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Declaracion_Variable -> ID ++", Semantico: "Declaracion_Variable.val -> ID ++;"});}
        | IDENTIFICADOR DECREMENTO TK_PYC { $$ = Instruccion.nuevaAsignacion($1,
			{ opIzq: { tipo: 'VAL_IDENTIFICADOR', valor: $1, linea: this._$.first_line, columna: this._$.first_column+1 },
  			opDer: { tipo: 'VAL_ENTERO', valor: 1, linea: this._$.first_line, columna: this._$.first_column+1 },
  			tipo: 'RESTA',
  			linea: this._$.first_line,
  			columna: this._$.first_column+1 }, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Declaracion_Variable -> ID --;", Semantico: "Declaracion_Variable.val -> ID --;"});}
        | Tipos IDENTIFICADOR { $$ = Instruccion.nuevaDeclaracion($2, null, $1, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Declaracion_Variable -> TIPO ID ", Semantico: "Declaracion_Variable.val -> TIPO.val ID "}); }

        | IDENTIFICADOR COR_ABRE Expresiones COR_CIERRA IGUAL Expresiones TK_PYC { $$ = Instruccion.modificacionVector($1, $3, $6, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "Declaracion_Variable ->ID[Expresiones] = Expresiones;", Semantico: "Declaracion_Variable.val -> ID[Expresiones.val] = Expresiones.val;"}); }

        | Tipos IDENTIFICADOR IGUAL operString TK_PYC { $$ = Instruccion.nuevaDeclaracion($2, $4, $1, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Declaracion_Variable -> TIPO ID = Expresiones", Semantico: "Declaracion_Variable.val -> TIPO.val ID = Expresiones.val;"}); }
        | Tipos error TK_PYC { $$ = ""; errores.push({ tipo: "Sintactico", error: "Declaracion de variable incorrecta", linea: this._$.first_line, columna: this._$.first_column+1 }); console.log(errores) }
;

Dec_Vect: Tipos COR_ABRE COR_CIERRA IDENTIFICADOR IGUAL COR_ABRE Params COR_CIERRA TK_PYC { $$ = Instruccion.nuevoVector($1, null, $4, null, $7, null, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "Declaracion_Vector -> TIPO[] ID = [Params];", Semantico: "Declaracion_Vector.val -> TIPO[] ID.val = [Params.val];"}); }
        | Tipos COR_ABRE COR_CIERRA IDENTIFICADOR IGUAL COR_ABRE COR_CIERRA TK_PYC { $$ = Instruccion.nuevoVector($1, null, $4, null, null, null, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "Declaracion_Vector -> TIPO[] ID = []", Semantico: "Declaracion_Vector.val -> TIPO[] ID.val = []"});}
        | Tipos COR_ABRE COR_CIERRA IDENTIFICADOR IGUAL OP_VECOTRES IDENTIFICADOR TK_PYC {  }
        
        | IDENTIFICADOR TK_PUNTO TK_PUSH PARENTESIS_ABRE Params PARENTESIS_CIERRA TK_PYC {$$ = Instruccion.modificacionLista($1, null, $5, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "Declaracion_Vector -> ID.PUSH(Expresiones);", Semantico: "Declaracion_Vector.val -> ID.PUSH(Expresiones.val);"});}
        | IDENTIFICADOR TK_PUNTO TK_POP PARENTESIS_ABRE PARENTESIS_CIERRA TK_PYC {$$ = Instruccion.modificacionVector($1, null, null, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "Declaracion_Vector -> ID.POP();", Semantico: "Declaracion_Vector.val -> ID.POP();"});}

        | IDENTIFICADOR TK_PUNTO TK_LENGTH PARENTESIS_ABRE PARENTESIS_CIERRA TK_PYC {$$ = new Instruccion.nuevoLength($3, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Declaracion_Vector -> ID.LENGTH();", Semantico: "Declaracion_Vector.val -> ID.LENGTH();"});}
        
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
operString: Expresiones CONCATENADOCADENA Expresiones {$$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.SUMA,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> Expresiones & Expresiones", Semantico: "Expresiones.val -> Expresiones.val & Expresiones.val"});}
        | operString CONCATENADOCADENA Expresiones {$$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.SUMA,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> Expresiones & Expresiones", Semantico: "Expresiones.val -> Expresiones.val & Expresiones.val"});}
        | CADENA OP_EXPONENTE ENTERO {$$= Instruccion.nuevaOperacionBinaria(Instruccion.nuevoValor($1, TIPO_VALOR.CADENA, this._$.first_line,this._$.first_column+1),Instruccion.nuevoValor($3, TIPO_VALOR.ENTERO, this._$.first_line,this._$.first_column+1), TIPO_OPERACION.POTENCIA,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> CADENA ^ ENTERO", Semantico: "CADENA.val -> Expresiones.val ^ ENTERO.val"});}
        | operString OP_EXPONENTE ENTERO {$$= Instruccion.nuevaOperacionBinaria($1,Instruccion.nuevoValor($3, TIPO_VALOR.ENTERO, this._$.first_line,this._$.first_column+1), TIPO_OPERACION.POTENCIA,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> Expresiones ^ ENTERO", Semantico: "Expresiones.val -> Expresiones.val ^ ENTERO.val"});}
        | Expresiones TK_COMA Expresiones {$$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.SUMA,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> Expresiones , Expresiones", Semantico: "Expresiones.val -> Expresiones.val , Expresiones.val"}); }
;
//--------------------------------------------------------------------------------------------------------------------------------------

//------------------------------------------------- LLamada a metodos / funciones -------------------------------------------------------

LLamada: IDENTIFICADOR PARENTESIS_ABRE Params PARENTESIS_CIERRA { $$ = Instruccion.nuevaLlamada($1, $3, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "Llamada -> ID (Params)", Semantico: "Llamada.val -> ID.val (Params.val)"});}
        | IDENTIFICADOR PARENTESIS_ABRE PARENTESIS_CIERRA { $$ = Instruccion.nuevaLlamada($1, [], this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "Llamada -> ID ()", Semantico: "Llamada.val -> ID.val ()"});}
;
//--------------------------------------------------------------------------------------------------------------------------------------


simbolos: OP_SUMA { $$=$1 }
        | OP_MENOS { $$=$1 }
        | OP_DIVISION { $$=$1 }
        | OP_MULTIPLICACION { $$=$1 }
        | OP_MODULO { $$=$1 }
;

Expresiones: CADENA {$$ = Instruccion.nuevoValor($1, TIPO_VALOR.CADENA, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> CADENA", Semantico: "Expresiones.val -> CADENA.val"});}
            | CARACTER {$$ = Instruccion.nuevoValor($1.trim().substring(1, $1.length - 1), TIPO_VALOR.CARACTER, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> CARACTER", Semantico: "Expresiones.val -> CARACTER.val"});}
            | TRUE {$$ = Instruccion.nuevoValor($1.trim(), TIPO_VALOR.BOOLEANO, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> TRUE", Semantico: "Expresiones.val -> TRUE.val"});}
            | FALSE {$$ = Instruccion.nuevoValor($1.trim(), TIPO_VALOR.BOOLEANO, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> FALSE", Semantico: "Expresiones.val -> FALSE.val"});}
            | ENTERO {$$ = Instruccion.nuevoValor(Number($1.trim()), TIPO_VALOR.ENTERO, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> ENTERO", Semantico: "Expresiones.val -> ENTERO.val"});}
            | DECI {$$ = Instruccion.nuevoValor(Number($1.trim()), TIPO_VALOR.DOBLE, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> DECI", Semantico: "Expresiones.val -> DECI.val"});}
            | NULL {$$ = Instruccion.nuevoValor($1, TIPO_VALOR.NULL, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> NULL", Semantico: "Expresiones.val -> NULL.val"});}
            | IDENTIFICADOR {$$ = Instruccion.nuevoValor($1.trim(), TIPO_VALOR.IDENTIFICADOR, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> ID", Semantico: "Expresiones.val -> ID.val"});}

            | PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA {$$=$2; producciones.push({Sintactico: "Expresiones -> (Expresiones)", Semantico: "Expresiones.val -> (Expresiones.val)"});}

            | Expresiones OP_SUMA Expresiones {$$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.SUMA,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> Expresiones SUMA Expresiones", Semantico: "Expresiones.val -> Expresiones.val SUMA Expresiones.val"});}
            | Expresiones OP_MENOS Expresiones {$$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.RESTA,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> Expresiones RESTA Expresiones", Semantico: "Expresiones.val -> Expresiones.val RESTA Expresiones.val"});}
            | Expresiones OP_DIVISION Expresiones {$$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.DIVISION,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> Expresiones DIVISION Expresiones", Semantico: "Expresiones.val -> Expresiones.val DIVISION Expresiones.val"});}
            | Expresiones OP_MULTIPLICACION Expresiones {$$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.MULTIPLICACION,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> Expresiones MULTIPLICAION Expresiones", Semantico: "Expresiones.val -> Expresiones.val MULTIPLICAION Expresiones.val"});}
            | Expresiones OP_MODULO Expresiones {$$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.MODULO,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> Expresiones MODULO Expresiones", Semantico: "Expresiones.val -> Expresiones.val MODULO Expresiones.val"});}

            | TK_POW PARENTESIS_ABRE Expresiones TK_COMA Expresiones PARENTESIS_CIERRA {$$= Instruccion.nuevaOperacionBinaria($3,$5, TIPO_OPERACION.POTENCIA,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> POW(Expresiones, Expresiones)", Semantico: "Expresiones.val -> POW(Expresiones.val, Expresiones.val)"});}
            | TK_SQRT PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$= Instruccion.nuevaOperacionBinaria(null,$3, TIPO_OPERACION.RAIZ,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> SQRT(Expresiones)", Semantico: "Expresiones.val -> SQRT(Expresiones.val)"});}
            | TK_SENO PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$= Instruccion.nuevaOperacionBinaria(null,$3, TIPO_OPERACION.SENO,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> SEN(Expresiones)", Semantico: "Expresiones.val -> SEN(Expresiones.val)"});}
            | TK_COSENO PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$= Instruccion.nuevaOperacionBinaria(null,$3, TIPO_OPERACION.COSENO,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> COS(Expresiones)", Semantico: "Expresiones.val -> COS(Expresiones.val)"});}
            | TK_TANGENTE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$= Instruccion.nuevaOperacionBinaria(null,$3, TIPO_OPERACION.TANGETE,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> TAN(Expresiones)", Semantico: "Expresiones.val -> TAN(Expresiones.val)"});}
            | TK_LOGARITMOB10 PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$= Instruccion.nuevaOperacionBinaria(null,$3, TIPO_OPERACION.LOGARITMO,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> LOG10(Expresiones)"}, Semantico: "Expresiones.val -> LOG10(Expresiones.val)");}

            | Expresiones IGUALIGUAL Expresiones { $$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.IGUALIGUAL,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> Expresiones == Expresiones", Semantico: "Expresiones.val -> Expresiones.val == Expresiones.val"}); }
            | Expresiones MENOR Expresiones { $$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.MENOR,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> Expresiones < Expresiones", Semantico: "Expresiones.val -> Expresiones.val < Expresiones.val"});}
            | Expresiones MENORIGUAL Expresiones { $$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.MENORIGUAL,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> Expresiones <= Expresiones", Semantico: "Expresiones.val -> Expresiones.val <= Expresiones.val"});}
            | Expresiones MAYOR Expresiones { $$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.MAYOR,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> Expresiones > Expresiones", Semantico: "Expresiones.val -> Expresiones.val > Expresiones.val"});}
            | Expresiones MAYORIGUAL Expresiones { $$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.MAYORIGUAL,this._$.first_line,this._$.first_column+1) producciones.push({Sintactico: "Expresiones -> Expresiones >= Expresiones", Semantico: "Expresiones.val -> Expresiones.val >= Expresiones.val"});}

            | Expresiones OR Expresiones { $$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.OR,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> Expresiones || Expresiones", Semantico: "Expresiones.val -> Expresiones.val || Expresiones.val"});}
            | Expresiones AND Expresiones { $$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.AND,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> Expresiones && Expresiones", Semantico: "Expresiones.val -> Expresiones.val && Expresiones.val"});}
            | Expresiones DIFERENTEA Expresiones { $$= Instruccion.nuevaOperacionBinaria($1,$3, TIPO_OPERACION.DIFERENTE,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> Expresiones != Expresiones", Semantico: "Expresiones.val -> Expresiones.val != Expresiones.val"}); }
            | NOT Expresiones { $$= Instruccion.nuevaOperacionBinaria($2, null, TIPO_OPERACION.NOT,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones ->  !Expresiones", Semantico: "Expresiones.val -> !Expresiones.val"});}

            | IDENTIFICADOR COR_ABRE Expresiones COR_CIERRA {$$ = Instruccion.accesoLista($1, $3, this._$.first_line, this._$.first_column); producciones.push({Sintactico: "Expresiones -> ID [Expresiones]", Semantico: "Expresiones.val -> ID [Expresiones.val]"});}
            | COR_ABRE Expresiones COR_CIERRA {}
            | FuncioesReservadas { $$=$1; producciones.push({Sintactico: "Expresiones -> Funciones_Reservadas", Semantico: "Expresiones.val -> Funciones_Reservadas.val"});}
            | Casteos { $$=$1; producciones.push({Sintactico: "Expresiones -> Casteos", Semantico: "Expresiones.val -> Casteos.val"});}
            | Ternario {$$=$1; producciones.push({Sintactico: "Expresiones -> Ternario", Semantico: "Expresiones.val -> Ternario.val"});}
            | LLamada {$$=$1; producciones.push({Sintactico: "Expresiones -> Llamada", Semantico: "Expresiones.val -> Llamada.val"});}
            | COR_ABRE COR_CIERRA {$$=($1+$2); producciones.push({Sintactico: "Expresiones -> []", Semantico: "Expresiones.val -> []"});}
            | IDENTIFICADOR COR_ABRE ENTERO TK_DOSPUNTS	ENTERO COR_CIERRA { }
            | IDENTIFICADOR COR_ABRE TK_BEGIN TK_DOSPUNTS ENTERO COR_CIERRA { }
            | IDENTIFICADOR COR_ABRE ENTERO TK_DOSPUNTS	TK_END COR_CIERRA { }
            | OP_MENOS Expresiones %prec umenos { $$= Instruccion.nuevaOperacionBinaria($2, null, TIPO_OPERACION.NEGACION,this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Expresiones -> RESTA Expresiones", Semantico: "Expresiones.val -> RESTA Expresiones.val"});}
;

Ternario: Expresiones OP_TERNARIO Expresiones TK_DOSPUNTS Expresiones { $$ = new Instruccion.nuevoTernario($1, $3, $5, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "Ternario -> Expresiones ? Expresiones : Expresiones", Semantico: "Ternario -> Expresiones.val ? Expresiones.val : Expresiones.val"});}
;

//------------------------------------------------------ Reservadas --------------------------------------------------------------------

FuncioesReservadas: FCaracterOfPosition { $$=$1; producciones.push({Sintactico: "Funciones_Reservadas -> CaracterOfPosition", Semantico: "Funciones_Reservadas.val -> CaracterOfPosition.val"});}
                   | FSubString { $$=$1; producciones.push({Sintactico: "Funciones_Reservadas -> SubString", Semantico: "Funciones_Reservadas.val -> SubString.val"});}
                   | Flength {$$=$1; producciones.push({Sintactico: "Funciones_Reservadas -> Length", Semantico: "Funciones_Reservadas.val -> Length.val"});}
                   | FToLower { $$=$1; producciones.push({Sintactico: "Funciones_Reservadas -> ToLower", Semantico: "Funciones_Reservadas.val -> ToLower.val"});}
                   | FToUpper { $$=$1; producciones.push({Sintactico: "Funciones_Reservadas -> ToUpper", Semantico: "Funciones_Reservadas.val -> ToUpper.val"});}
                   | FTypeof { $$=$1; producciones.push({Sintactico: "Funciones_Reservadas -> Typeof", Semantico: "Funciones_Reservadas.val -> Typeof.val"});}
;

FCaracterOfPosition: IDENTIFICADOR TK_PUNTO TK_CARACTEROFPOSITION PARENTESIS_ABRE ENTERO PARENTESIS_CIERRA { $$ = new Instruccion.nuevoPosition(Instruccion.nuevoValor($1.trim(), TIPO_VALOR.IDENTIFICADOR, this.$.first_line,this.$.first_column+1), $5, this.$.first_line,this.$.first_column+1); producciones.push({Sintactico: "CaracterOfPosition -> ID.CARACTEROFPOSITION(ENTERO)", Semantico: "CaracterOfPosition.val -> ID.CARACTEROFPOSITION(ENTERO.val)"});}
;

FSubString: IDENTIFICADOR TK_PUNTO TK_SUBSTRING PARENTESIS_ABRE ENTERO TK_COMA ENTERO PARENTESIS_CIERRA { $$ = new Instruccion.nuevoSub(Instruccion.nuevoValor($1.trim(), TIPO_VALOR.IDENTIFICADOR, this.$.first_line,this.$.first_column+1), $5, $7, this.$.first_line,this.$.first_column+1); producciones.push({Sintactico: "SubString -> ID.SUBSTRING(ENTERO, ENTERO)", Semantico: "SubString.val -> ID.SUBSTRING(ENTERO.val, ENTERO.val)"});}
;

Flength: IDENTIFICADOR TK_PUNTO TK_LENGTH PARENTESIS_ABRE PARENTESIS_CIERRA { $$ = new Instruccion.nuevoLength(Instruccion.nuevoValor($1.trim(), TIPO_VALOR.IDENTIFICADOR, this._$.first_line,this._$.first_column+1), this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Length -> ID.LENGTH()", Semantico: "Length.val -> ID.LENGTH()"});}
;

FToLower: IDENTIFICADOR TK_PUNTO TK_TOLOWER PARENTESIS_ABRE PARENTESIS_CIERRA { $$ = new Instruccion.toLower(Instruccion.nuevoValor($1.trim(), TIPO_VALOR.IDENTIFICADOR, this._$.first_line,this._$.first_column+1), this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "ToLower -> ID.TOLOWERCASE()", Semantico: "ToLower.val -> ID.TOLOWERCASE()"});}
;

FToUpper: IDENTIFICADOR TK_PUNTO TK_TOUPPER PARENTESIS_ABRE PARENTESIS_CIERRA { $$ = new Instruccion.toUpper(Instruccion.nuevoValor($1.trim(), TIPO_VALOR.IDENTIFICADOR, this._$.first_line,this._$.first_column+1), this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "ToUpper -> ID.TOUPPERCASE()", Semantico: "ToUpper.val -> ID.TOUPPERCASE()"});}
;

FTypeof: TK_TYPEOF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$ = new Instruccion.nuevoTypeOf($3, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Typeof -> TYPEOF(Expresiones)", Semantico: "Typeof.val -> TYPEOF(Expresiones.val)"});}
;

//--------------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------------------- Casteos ---------------------------------------------------------------
Casteos: parseo { $$ = $1; producciones.push(Sintactico: "Casteos -> parseo", Semantico: "Casteos.val -> parseo.val");}
        | toTipo { $$ = $1; producciones.push({Sintactico: "Casteos -> toTipo", Semantico: "Casteos.val -> toTipo.val"});}
        | TK_STRINGPARSE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$ = new Instruccion.nuevoToString($3, this._$.first_line,this._$.first_column+1); producciones.push({Sintactico: "Casteos -> String(Expresiones)", Semantico: "Casteos.val -> String(Expresiones.val)"});}
;

parseo: Tipos TK_PUNTO TK_PARSE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$ = new Instruccion.nuevoCasteo($1, $5, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "parseo -> TIPO.PARSE(Expresiones)", Semantico: "parseo.val -> TIPO.val.PARSE(Expresiones.val)"});}
;

toTipo: TK_TOINT PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$ = new Instruccion.nuevoTruncate($3, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "toTipo -> toInt(Expresiones)", Semantico: "toTipo.val: toInt(Expresiones.val)"});}
        | TK_TODOUBLE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA { $$ = new Instruccion.nuevoCasteo("DOBLE", $3, this._$.first_line, this._$.first_column+1); producciones.push({Sintactico: "toTipo: toDouble(Expresiones)", Semantico: "toTipo.val: toDouble(Expresiones.val)"});}
;

//--------------------------------------------------------------------------------------------------------------------------------------

Tipos: STRING { $$ = TIPO_DATO.CADENA; producciones.push({Sintactico: "Tipos -> String", Semantico: "Tipos.val -> String.val"});}
    | INT { $$ = TIPO_DATO.ENTERO; producciones.push({Sintactico: "Tipos -> Entero", Semantico: "Tipos.val -> Entero.val"});}
    | DOUBLE { $$ = TIPO_DATO.DOBLE; producciones.push({Sintactico: "Tipos -> Double", Semantico: "Tipos.val -> Double.val"});}
    | CHAR { $$ = TIPO_DATO.CARACTER; producciones.push({Sintactico: "Tipos -> Caracter", Semantico: "Tipos.val -> Caracter.val"});}
    | FLOAT { $$ = TIPO_DATO.DOBLE; producciones.push({Sintactico: "Tipos -> Double", Semantico: "Tipos.val -> Double.val"});}
    | BOOLEAN { $$ = TIPO_DATO.BOOLEANO; producciones.push({Sintactico: "Tipos -> Boolean", Semantico: "Tipos.val -> Boolean.val"});}
;