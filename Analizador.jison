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

"pow"                   return 'TK_POW'
"sqrt"                  return 'TK_SQRT'
"sin"                   return 'TK_SENO'
"cos"                   return 'TK_COSENO'
"tan"                   return 'TK_TANGENTE'
"log10"                 return 'TK_LOGARITMOB10'

"||"                   	return 'OR'
"&&"                   	return 'AND'
"!"                   	return 'NOT'
"true"                	return 'TRUE'
"false"               	return 'FALSE'

"=="                   	return 'IGUALIGUAL'
"!="                   	return 'DIFERENTEA'
">"                   	return 'MAYOR'
"<"                   	return 'MENOR'
"<="                   	return 'MENORIGUAL'
">="					return 'MAYORIGUAL'
"="						return 'IGUAL'
"&"                     return 'CONCATENADOCADENA'
"$"                     return "OPERACIONESALIMPRIMIR"
"#"                     return "OP_VECOTRES"

","                   	return 'TK_COMA'
";"                   	return 'TK_PYC'
"."						return 'TK_PUNTO'
":"						return 'TK_DOSPUNTS'

"*"                   	return 'OP_MULTIPLICACION'
"/"                   	return 'OP_DIVISION'
"-"                   	return 'OP_MENOS'
"+"                   	return 'OP_SUMA'
"^"                   	return 'OP_EXPONENTE'
"%"                   	return 'OP_MODULO'
"?"						return 'OP_TERNARIO'

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
"typeof"				return 'TK_TYPEOF'
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

ini: ENTRADA EOF { typeof console !== 'undefined' ? console.log($1) : print($1); return $1; }
    |error TK_PYC   {errores.push({ tipo: "Sintactico", error: "Token no Válido", linea: this._$.first_line, columna: this._$.first_column+1 }); return 'INVALID';}
;

ENTRADA: ENTRADA instrucciones {}
        | instrucciones {}
;

instrucciones: Mainbody {}
            | Funciones {}
            | Metodos {}
            | Variables {}
            | Vectores {}
            | Structs {}
;

//---------------------------------------------------------------------------------------------------------
Mainbody: TK_VOID TK_MAIN PARENTESIS_ABRE PARENTESIS_CIERRA LlaveAbre cuerpomain LlaveCierra {}
;

cuerpomain: imprimir cuerpomain {}
        | TK_RETURN TK_PYC {}
;
//----------------------------------------------------------------------------------------------------------

//------------------------------------------------------------------------------------------------------------------------------------------
Funciones: tipos TK_FUNCTION IDENTIFICADOR PARENTESIS_ABRE PARENTESIS_CIERRA LlaveAbre cuerpoPrograma LlaveCierra {}
        | tipos TK_FUNCTION IDENTIFICADOR PARENTESIS_ABRE listaparametros PARENTESIS_CIERRA LlaveAbre cuerpoPrograma LlaveCierra {}
;

cuerpoPrograma: imprimir {} 
            | cuerpoPrograma TK_RETURN IDENTIFICADOR PARENTESIS_ABRE listaparametros PARENTESIS_CIERRA TK_PYC {}
            | cuerpoPrograma TK_RETURN IDENTIFICADOR PARENTESIS_ABRE listaparametros PARENTESIS_CIERRA {}
            | cuerpoPrograma TK_RETURN IDENTIFICADOR {}
            | cuerpoPrograma TK_RETURN IDENTIFICADOR TK_PYC {}
;

listaparametros: tipos IDENTIFICADOR {}
                | tipos IDENTIFICADOR TK_COMA listaparametros {}
                | IDENTIFICADOR {}
                | IDENTIFICADOR TK_COMA listaparametros {}
;
//------------------------------------------------------------------------------------------------------------------------------------------

imprimir: TK_PRINT PARENTESIS_ABRE impresion PARENTESIS_CIERRA TK_PYC {}
        | TK_PRINT PARENTESIS_ABRE impresion PARENTESIS_CIERRA {}
        | TK_PRINTLN PARENTESIS_ABRE impresion PARENTESIS_CIERRA TK_PYC {}
        | TK_PRINTLN PARENTESIS_ABRE impresion PARENTESIS_CIERRA {}
;

impresion: CADENA {}
        | IDENTIFICADOR {}
        | ENTERO {}
        | DECI {}
        | IDENTIFICADOR OP_SUMA impresion {}
;

Variables: tipos IDENTIFICADOR IGUAL CADENA {}
;


tipos: STRING {}
    | INT {}
    | DOUBLE {}
    | CHAR {}
    | FLOAT {}
    | BOOLEAN {}
    | TK_VOID {}
;