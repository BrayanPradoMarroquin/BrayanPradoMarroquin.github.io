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

ini: ENTRADA EOF { typeof console !== 'undefined' ? alert($1) : print($1); return $1; }
    |error EOF   {}
;

ENTRADA: ENTRADA instrucciones {}
        | instrucciones {}
;

instrucciones: MFBody {}
		| MainBody {}
		| Dec_Var {}
		| Dec_Vect {}
                | Dec_Struct {}
                | LLamada TK_PYC{}
;
//--------------------------------------------------------------- MAIN ------------------------------------------------------------
MainBody: TK_VOID TK_MAIN PARENTESIS_ABRE PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra {}
;

//-----------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------- METODO FUNCION STRUCT ----------------------------------------------------------
MFBody: Tipos IDENTIFICADOR PARENTESIS_ABRE PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra {}
        | Tipos IDENTIFICADOR PARENTESIS_ABRE Params PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra {}
        | TK_VOID IDENTIFICADOR PARENTESIS_ABRE PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra {}
	| TK_VOID IDENTIFICADOR PARENTESIS_ABRE Params PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra {}
;

Dec_Struct: TK_STRUCT IDENTIFICADOR LlaveAbre BodyStruct LlaveCierra TK_PYC {}
        | IDENTIFICADOR IDENTIFICADOR IGUAL IDENTIFICADOR PARENTESIS_ABRE Params PARENTESIS_CIERRA TK_PYC {}
        | IDENTIFICADOR IDENTIFICADOR IGUAL IDENTIFICADOR PARENTESIS_ABRE PARENTESIS_CIERRA TK_PYC {}
        | IDENTIFICADOR TK_PUNTO IDENTIFICADOR IGUAL Expresiones TK_PYC {}
;

BodyStruct: s {}
        | s TK_COMA BodyStruct {}
;

s: Dec_Var {}
        | IDENTIFICADOR IDENTIFICADOR {}
;
//------------------------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------------- PARAMETROS -------------------------------------------------------------
Params: parametros{}
        | parametros TK_COMA Params {}
;

parametros: Tipos COR_ABRE COR_CIERRA IDENTIFICADOR {}
	| Tipos IDENTIFICADOR {}
        | IDENTIFICADOR IDENTIFICADOR {}
        | Expresiones {}
;
//--------------------------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------------- Instrucciones ------------------------------------------------------------
Instructions: Instructions cuerpo {}
			| cuerpo {}
;

cuerpo: Dec_Var {}
        | Imprimir {}
        | SentenciasControl {}
        | SentenciasCiclicas {}
        | SentenciasTransferencias {}
        | Dec_Struct {}
        | Dec_Vect {}
        | LLamada TK_PYC {}
;
//--------------------------------------------------------------------------------------------------------------------------------------

//--------------------------------------------------- Sentencias de Control If y Switch ------------------------------------------------

SentenciasControl: ControlIF {}
		| CSwitch {}
;

ControlIF: If {}
	| IfElse {}
	| ElseIf {}
;

If: TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra {}
   | TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre LlaveCierra {}
;

IfElse: TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra TK_ELSE LlaveAbre Instructions LlaveCierra {}
        | TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre LlaveCierra TK_ELSE LlaveAbre Instructions LlaveCierra {}
        | TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra TK_ELSE LlaveAbre LlaveCierra {}
        | TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre LlaveCierra TK_ELSE LlaveAbre LlaveCierra {}
;

ElseIf: TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra TK_ELSE ControlIF {}
	| TK_IF PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre LlaveCierra TK_ELSE ControlIF {}
;

CSwitch: TK_SWITCH PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre ListCase Default LlaveCierra {}
		| TK_SWITCH PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre ListCase LlaveCierra {}
		| TK_SWITCH PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre Default LlaveCierra {}
;

ListCase: ListCase TK_CASE Expresiones TK_DOSPUNTS Instructions {}
		| ListCase TK_CASE Expresiones TK_DOSPUNTS {}
		| TK_CASE Expresiones TK_DOSPUNTS Instructions {}
		| TK_CASE Expresiones TK_DOSPUNTS {}
;

Default: TK_DEFAULT TK_DOSPUNTS Instructions {}
		| TK_DEFAULT TK_DOSPUNTS {}
;

//--------------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------------- Sentencias Ciclicas ---------------------------------------------------------

SentenciasCiclicas: While {}
                   | For {}
                   | DoWhile {}
;

While: TK_WHILE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra {}
        | TK_WHILE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA LlaveAbre LlaveCierra {}
;

DoWhile: TK_DO LlaveAbre Instructions LlaveCierra TK_WHILE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA TK_PYC {}
        | TK_DO LlaveAbre LlaveCierra TK_WHILE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA TK_PYC {} 
;

For: TK_FOR PARENTESIS_ABRE Dec_Var Expresiones TK_PYC Actualizacion PARENTESIS_CIERRA LlaveAbre Instructions LlaveCierra {}
	| TK_FOR PARENTESIS_ABRE Dec_Var Expresiones TK_PYC Actualizacion PARENTESIS_CIERRA LlaveAbre LlaveCierra {}
;

Actualizacion: IDENTIFICADOR IGUAL Expresiones {}
 		| IDENTIFICADOR INCREMENTO {}
		| IDENTIFICADOR DECREMENTO {}
;

//--------------------------------------------------------------------------------------------------------------------------------------

//--------------------------------------------------------- Sentencias de Transferencia ------------------------------------------------

SentenciasTransferencias: TK_BREAK TK_PYC {}
                        | TK_RETURN TK_PYC {}
                        | TK_CONTINUE TK_PYC {}
                        | TK_RETURN Expresiones TK_PYC {}
;

//--------------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------------------- Impresion -------------------------------------------------------------

 Imprimir: TK_PRINT PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA TK_PYC {}
        | TK_PRINTLN PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA TK_PYC {}
        | TK_PRINT PARENTESIS_ABRE Dec_Vect PARENTESIS_CIERRA TK_PYC {}
        | TK_PRINTLN PARENTESIS_ABRE Dec_Vect PARENTESIS_CIERRA TK_PYC {}
        | TK_PRINT PARENTESIS_ABRE operString PARENTESIS_CIERRA TK_PYC {}
        | TK_PRINTLN PARENTESIS_ABRE operString PARENTESIS_CIERRA TK_PYC {}
 ;
 //---------------------------------------------------------------------------------------------------------------------------------------

//------------------------------------------------------------- Declaraciones -----------------------------------------------------------

 Dec_Var: Tipos IDENTIFICADOR IGUAL Expresiones TK_PYC {}
        | Tipos IDENTIFICADOR TK_PYC {}
        | IDENTIFICADOR IGUAL Expresiones TK_PYC {}
        | IDENTIFICADOR INCREMENTO TK_PYC {}
        | IDENTIFICADOR DECREMENTO TK_PYC {}
        | Tipos IDENTIFICADOR {}
        | IDENTIFICADOR COR_ABRE Expresiones COR_CIERRA IGUAL Expresiones TK_PYC {}
        | Tipos IDENTIFICADOR IGUAL operString TK_PYC {}
;

Dec_Vect: Tipos COR_ABRE COR_CIERRA IDENTIFICADOR IGUAL COR_ABRE Params COR_CIERRA TK_PYC {}
        | Tipos COR_ABRE COR_CIERRA IDENTIFICADOR IGUAL COR_ABRE COR_CIERRA TK_PYC {}
        | Tipos COR_ABRE COR_CIERRA IDENTIFICADOR IGUAL OP_VECOTRES IDENTIFICADOR TK_PYC {}
        | IDENTIFICADOR TK_PUNTO TK_PUSH PARENTESIS_ABRE Params PARENTESIS_CIERRA TK_PYC {}
        | IDENTIFICADOR TK_PUNTO TK_POP PARENTESIS_ABRE PARENTESIS_CIERRA TK_PYC {}
        | IDENTIFICADOR TK_PUNTO TK_LENGTH PARENTESIS_ABRE PARENTESIS_CIERRA TK_PYC {}
        | Tipos COR_ABRE COR_CIERRA IDENTIFICADOR IGUAL IDENTIFICADOR opVector TK_PYC {}
        | Tipos COR_ABRE COR_CIERRA IDENTIFICADOR IGUAL opVector TK_PYC {}
        | IDENTIFICADOR opVector {}
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

Expresiones: CADENA {}
            | CARACTER {}
            | TRUE {}
            | FALSE {}
            | ENTERO {}
            | DECI {}
            | NULL {}
            | IDENTIFICADOR {}
            | PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA {}
            | Expresiones OP_SUMA Expresiones {}
            | Expresiones OP_MENOS Expresiones {}
            | Expresiones OP_DIVISION Expresiones {}
            | Expresiones OP_MULTIPLICACION Expresiones {}
            | Expresiones OP_MODULO Expresiones {}
            | TK_POW PARENTESIS_ABRE Expresiones TK_COMA Expresiones PARENTESIS_CIERRA {}
            | TK_SQRT PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA {}
            | TK_SENO PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA {}
            | TK_COSENO PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA {}
            | TK_TANGENTE PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA {}
            | TK_LOGARITMOB10 PARENTESIS_ABRE Expresiones PARENTESIS_CIERRA {}
            | Expresiones IGUALIGUAL Expresiones {}
            | Expresiones MENOR Expresiones {}
            | Expresiones MENORIGUAL Expresiones {}
            | Expresiones MAYOR Expresiones {}
            | Expresiones MAYORIGUAL Expresiones {}
            | Expresiones OR Expresiones {}
            | Expresiones AND Expresiones {}
            | Expresiones DIFERENTEA Expresiones {}
            | NOT Expresiones {}
            | IDENTIFICADOR COR_ABRE Expresiones COR_CIERRA {}
            | FuncioesReservadas {}
            | Casteos {}
            | Ternario {}
            | IDENTIFICADOR COR_ABRE ENTERO TK_DOSPUNTS	ENTERO COR_CIERRA {}
            | IDENTIFICADOR COR_ABRE TK_BEGIN TK_DOSPUNTS ENTERO COR_CIERRA {}
            | IDENTIFICADOR COR_ABRE ENTERO TK_DOSPUNTS	TK_END COR_CIERRA {}
            | OP_MENOS Expresiones %prec umenos {}
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


Tipos: STRING {}
    | INT {}
    | DOUBLE {}
    | CHAR {}
    | FLOAT {}
    | BOOLEAN {}
;