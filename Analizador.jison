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
"public"                return 'TK_PUBLIC'

"pow"                   return 'POW'
"sqrt"                  return 'SQRT'
"sin"                   return 'SENO'
"cos"                   return 'COSENO'
"tan"                   return 'TANGENTE'
"log10"                 return 'LOGARITMOB10'

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

","                   	return 'COMA'
";"                   	return 'TK_PYC'
"."						return 'PUNTO'
":"						return 'DOSPUNTS'

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

"caracterOfPosition"    return 'CARACTEROFPOSITION'
"subString"             return 'SUBSTRING'
"toLowercase"			return 'TK_TOLOWER'
"toUppercase"			return 'TK_TOUPPER'
"length"				return 'TK_LENGTH'
"print"                 return 'PRINT'
"println"               return 'PRINTLN'
"parse"                 return 'PARSE'
"toInt"                 return 'TOINT'
"toDouble"              return 'TODOUBLE'
"string"                return 'STRINGPARSE'
"typeof"				return 'TK_TYPEOF'
"struct"                return 'TK_STRUCT'





