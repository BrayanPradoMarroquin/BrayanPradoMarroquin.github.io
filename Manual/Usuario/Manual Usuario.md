# MANUAL DE USUARIO

# QUETZAL – PROYECTO 1

![](Aspose.Words.ec71b1e2-de3a-4315-b993-e6009371efee.004.png)

# Contenido

[Requerimientos del Equipo. 2](#_Toc91108805)

[Flujo de Aplicación. 3](#_Toc91108806)

[Interfaz de la Aplicación. 5](#_Toc91108807)

[Sintaxis del Lenguaje. 6](#_Toc91108808)

[Tipos. 6](#_Toc91108809)

[Arreglos. 6](#_Toc91108810)

[Structs. 6](#_Toc91108811)

[Expresiones. 7](#_Toc91108812)

[Cadenas. 8](#_Toc91108813)

[Operador Ternario 9](#_Toc91108814)

[Instrucciones. 9](#_Toc91108815)

[Impresión. 9](#_Toc91108816)

[Declaración y Asignación. 9](#_Toc91108817)

[Llamada de Funciones. 10](#_Toc91108818)

[Funciones Nativas 10](#_Toc91108819)

[Funciones. 11](#_Toc91108820)

[Métodos. 11](#_Toc91108821)

[Condicionales. 12](#_Toc91108822)

[Loops. 13](#_Toc91108823)

# Requerimientos del Equipo.

- Sistema Operativo requerido: Windows 8 o superiores.
- Memoria RAM: 4GB o superior.
- Procesador: Intel Celeron o superiores ( Recomendados Core i5 de 8gen en adelante).
- Tipo de Sistema: 64 bits (recomendado).
- Lenguaje de Programación: JavaScript.

![DiagramaDescripción generada automáticamente](Aspose.Words.ec71b1e2-de3a-4315-b993-e6009371efee.005.png)

# Flujo de Aplicación.

A continuación, se explica el flujo de la aplicación. La aplicación es sencilla por lo que su funcionalidad se basa en interpretar, generar código intermedio y desplegar reportes.

Interpreta: Esta opción nos va a permitir interpretar una entrada. El programa recibe un archivo de entrada de código de alto nivel y ejecuta las instrucciones.

Traducir: Esta opción nos va a permitir traducir una entrada. El programa recibe un archivo de entrada de código de alto nivel y traduce a código intermedio en la sintaxis de tres direcciones.

Reportes: Esta opción nos va a permitir visualizar los reportes generados después de traducir una entrada.

# Interfaz de la Aplicación.

![Interfaz de usuario gráfica, AplicaciónDescripción generada automáticamente](Aspose.Words.ec71b1e2-de3a-4315-b993-e6009371efee.007.png)
![Interfaz de usuario gráficaDescripción generada automáticamente con confianza baja](Aspose.Words.ec71b1e2-de3a-4315-b993-e6009371efee.006.png)

1. **Editor**: Es el área en donde se puede colocar el lenguaje.
1. **Consola**: Mostrara el resultado de las instrucciones colocadas en el editor.
1. **Compilar**: Tomara toda la sintaxis del lenguaje colocado en el editor y lo analizara de manera que se la respuesta se mostrara en las tablas y consola.
1. **Traducir**: Itera la cadena de traducciones que se generan en el código intermedio.
1. **Tabla** **de Símbolos**: Mostrara la tabla de todos los tokens y lexemas analizados
1. **Tabla** **de Errores**: Mostrara si se encuentra algún error en la sintaxis analizada.
1. **Descargar** **AST**: Se obtendrá la estructura del AST que se podrá ver en un editor en línea.

# Sintaxis del Lenguaje.

## Tipos.

Quetzal aceptará distintos tipos de datos con los que cuenta Java y C. Entre ellos se aceptarán:

**_Nulo_**:

Se representa con la palabra reservada null, la cual indica que no existe ningún valor.

**_Int_**

Valores numéricos enteros. Por ejemplo: 3, 2, -1, -100.

**_Double_**

Valores numéricos con punto flotante. Por ejemplo: 3.1415, 2.7182, 0.5.

**_Boolean_**

Los valores booleanos únicamente pueden ser true o false.

**_Char_**

Estos son literales de caracteres, se definen con comillas simples. Por ejemplo: 'a', 'b'.

**_String_**

Estos representan cadenas de texto, se definen con comillas dobles. Por ejemplo: "Hola", "Mundo". Los Strings también cuentan con operaciones especiales que se pueden realizar con estos. Se detalla más adelante en la sección de Expresiones.

## Arreglos.

Estos son un conjunto de valores indexados entre 1 hasta n, que pueden ser de diferentes tipos. Por ejemplo:

[10, 20, 30, 40]

["Hola", "Mundo"]

[1, 2, 5, [1, 2]]

## Structs.

Estos pueden contener cualquier tipo de dato en su interior, incluso otros struct, arreglos o arreglos de structs.:

struct NOMBRE_STRUCT{

` `LISTA_ATRIBUTOS

};

Y para crear una variable con nuestro Struct, se escribe:

NOMBRE_STRUCT ID = NOMBRE_STRUCT(VALORES);

Un ejemplo de creación de struct podría ser:

struct Rectangulo {

` `int base,

` `int altura

};

## Expresiones.

Quetzal acepta operaciones aritméticas, relacionales y lógicas de la siguiente forma:

**Aritméticas**

Entre las operaciones aritméticas disponibles vamos a encontrar las siguientes:

Suma: La suma de dos expresiones se define por el símbolo +

Resta: La resta de dos expresiones y la negación de una expresión aritmética se define por el símbolo -

Multiplicación: La multiplicación de dos expresiones se define por el símbolo \*

División: La división de dos expresiones se define por el símbolo /

Modulo: El módulo entre dos expresiones se define por el símbolo %

Nativas: Quetzal posee 6 funciones nativas para la resolución de expresiones, entre ellas se encuentran:

pow: Recibe como primer parámetro la base y como segundo parametro la potencia a elevar. Ejemplo: pow(2,4)

sqrt: Cálcula la raíz cuadrara de un número Ejemplo: sqrt(4)

sin: Resuelve la función seno del número que se ingrese

cos: Resuelve la función coseno del número que se ingrese

tan: Resuelve la función tangente del número que se ingrese

**Relacionales**

Entre las operaciones relacionales disponibles vamos a encontrar las siguientes:

Igualdad: Esta se define por el símbolo: ==

Diferenciación: Esta se define por el símbolo: !=

Mayor que: Esta se define por el símbolo: >

Menor que: Esta se define por el símbolo: <

Mayor o igual que: Esta se define por el símbolo: >=

Menor o igual que: Esta se define por el símbolo: <=

**Lógicas**

Entre las operaciones lógicas disponibles vamos a encontrar las siguientes:

AND: Esta se define por el símbolo: &&

OR: Esta se define por el símbolo: ||

NOT: Esta se define por el símbolo: !

## Cadenas.

Entre las operaciones con cadenas (Strings) vamos a encontrar las siguientes:

Concatenación: La unión de dos cadenas de texto se define por el símbolo &

"para" & "caidismo" = "paracaidismo"

Repetición: Permite que una cadena de texto se repita cierto número de veces, esta se define por el símbolo ^

"Cadena"^3 = "CadenaCadenaCadena"

Acceso a una pocisión: El acceso a un elemento de una cadena se define de la siguiente manera: string.caracterOfPosition(posición), el cual devolverá el carácter correspondiente a esa posición

animal = "Tigre";

println(animal.caracterOfPosition(2)); //g

Acceso a una porción: El acceso a una porción de una cadena se define de la siguiente manera: string.subString(inicial,final), el cual devolverá la cadena correspondiente al intervalo definido.

animal = "Tigre";

println(animal.subString(2,4)); //gre

Tamaño de una cadena: La obtención del número de elementos de una cadena se define por la función cadena.length()

animal = "Tigre";

println(animal.length());

Cadena en mayúsculas: Una cadena puede ser convertida a mayúsculas con la utilización de la función cadena.toUppercase())

animal = "Tigre";

println(animal.toUppercase()); //TIGRE

Cadena en minúsculas: Una cadena puede ser convertida a mayúsculas con la utilización de la función cadena.toLowercase())

animal = "Tigre";

println(animal.toLowercase()); //tigre

## Operador Ternario

El operador ternario es utilizado cuando se necesita entre diferentes expresiones a travez de una condición

(EXPRESIÓN RELACIONAL O LOGICA) ? RESULTADO SI ES VERDADERO : RESULTADO SI ES FALSO

## Instrucciones.

Quetzal contará con varias instrucciones para su ejecución, cada instrucción deber terminar con un punto y coma (;) siempre. Las instrucciones que Quetzal acepta son:

## Impresión.

Quetzal cuenta con 2 distintas instrucciones de imprimir.

print(expresión); Esta imprime sin realizar un salto de línea

println(expresión); Esta imprime realizando un salto de línea

Para imprimir más de un valor por línea, se puede imprimir una secuencia de valores separados por comas. También dentro de las cadenas se pueden colocar cualquier expresión utilizando el operador $. Por ejemplo:

println("+", "-"); // Imprime + -

print("El resultado de 2 + 2 es $(2 + 2)"); Imprime El resultado de 2 + 2 es 4

println("$a $(b[1])"); // Imprime el valor de a y el valor de b[1]

Quetzal también tiene la opción de imprimir arreglos y struct. Por ejemplo:

` `a = [0, 1, 2];

` `println(a); // Imprime [0, 1, 2]

` `s = Hora(10, 30);

` `print(s); // Imprime Hora(10, 30)

## Declaración y Asignación.

Quetzal permite la declaración y asignación de variables, las NO variables pueden cambiar su tipo de dato en cualquier momento

Declaración: Quetzal permite declarar variables de dos maneras:

` `tipo ID = Expresión;

` `// ó

` `tipo LISTA_ID;

Ejemplo:

` `int x = (3\*5);

` `double y = (10/4);

` `String str = "Saludo";

Asignación: Quetzal permite asignar valores a variables existentes de la siguiente manera:

` `ID = Expresión;

Ejemplo:

` `var1 = "Adios";

` `v = 89 - 9;

## Llamada de Funciones.

Una llamada a función es como un desvío en el flujo de la ejecución. En lugar de pasar a la siguiente sentencia, el flujo salta al cuerpo de la función, ejecuta esta y regresa para continuar después de la llamada a la función.

Para llamar a una función se realiza de la siguiente manera:

NOMBRE_FUNCION(LISTA_PARAMETROS);

Si la función cuenta con más de un parámetro estos se separan por medio de ,. Además, es importante tener en cuenta que cuando se pasa un arreglo o struct como argumento de una función, en realidad se pasa una referencia de este. Por lo que cualquier cambio que se realice al parámetro, se podrá observar después de salir de la función.

Las llamadas a funciones también se pueden utilizar en expresiones, debido a que existen funciones que retornan un valor.

## Funciones Nativas

Quetzal utiliza diversas funciones nativas para sus expresiones, estas son:

tipo.Parse(string): Toma una cadena y la convierte al tipo de numero que se le indice si es posible.

` `int.parse("8200")

` `ó

` `double.parse("3.13159")

` `ó

` `boolean.parse("1")

toInt: Convierte un número flotante a un número entero sin redondearlo

` `toInt(3.99999) retorna 3

toDouble: Convierte un número entero a un número flotante

` `toDouble(34) retorna 34.0

String: Convierte el argumento en una cadena, puede usarse en cualquier tipo de dato excepto null

` `string(45.87) // retorna "45.87"

` `string([1,2,3]) // retorna "[1,2,3]"

typeof: Muestra el tipo del argumento

` `typeof(5 \* 5) // Int

## Funciones.

Las funcioens son secuencias de sentencias que ejecuta una operación que nosotros deseamos. Cuando se crea una función se especifica su nombre y secuencia de sentencias. Luego, ya se puede llamar a estas usando su nombre y los parámetros solicitados. Se definen las funciones en Quetzal así:

TIPO NOMBRE_FUNCION(LISTA_PARAMETROS){

` `LISTA_INSTRUCCIONES

}

## Métodos.

Estos son bloques de código a los cuales se accede únicamente con una llamada al método. Al finalizar su ejecución se retorna el control al punto donde fue llamado para continuar con las siguientes instrucciones.

VOID NOMBRE_METODO(LISTA_PARAMETROS){

` `LISTA_INSTRUCCIONES

}

## Condicionales.

Quetzal cuenta con sentencias condicionales, lo que permite que un bloque de codigo pueda ser o no ejecutado. Estas se definen por if,if...else y if...else if y adicional con la sentencia switch case. Su estructura es la siguiente:

if (CONDICION){

` `LISTA_INTRUCCIONES

}

if (CONDICION)

` `INSTRUCCION

if(CONDICION1){

` `LISTA_INTRUCCIONES

}

else if(CONDICION1){

` `LISTA_INTRUCCIONES

}

else{

` `LISTA_INTRUCCIONES

}

switch(expression) {

` `case x:

` `LISTA_INTRUCCIONES

` `break;

` `case y:

` `LISTA_INTRUCCIONES

` `break;

` `default:

` `LISTA_INTRUCCIONES

}

## Loops.

Quetzal cuenta con sentencias iterativas, lo que permite ejecutar repetidamente un bloque de sentencias. Existen 2 de estas, el ciclo while, el ciclo do while y el ciclo for.

**While**

La sentencia while sigue la siguiente estructura:

while (CONDITION) {

` `LISTA_INTRUCCIONES

}

Y se ejecutará hasta que la condición del while se vuelva false. De manera más formal, el flujo de un while es el siguiente:

Se determina si la condición es true o false.

Si es false, se sale de la sentencia while y continúa la ejecución con la siguiente sentencia.

Si es true, ejecuta cada una de las sentencias en la lista de instrucciones.

**Do While**

La sentencia do while sigue la siguiente estructura:

do {

` `LISTA_INSTRUCCIONES

}

while (CONDICION);

Se ejecutará el código la primera vez y se seguira ejecutando hasta que la condición del while se vuelva false. De manera más formal, el flujo de un do while es el siguiente:

Se ejecuta el bloque del codigo

Se determina si la condición es true o false.

Si es false, se sale de la sentencia do while y continúa la ejecución con la siguiente sentencia.

Si es true, ejecuta cada una de las sentencias en la lista de instrucciones.

**For**

La sentencia for en Quetzal tiene la siguiente estructura:

for (declaracion ó asignacion; condicion; instruccion) {

` `LISTA_INSTRUCCIONES

}

Dentro de los ciclos también existen las sentencias de control break y continue. Las cuales, una termina el bucle y la otra regresa al inicio del bucle ignorando las sentencias faltantes.

## Arreglos.

Como se a mencionado Quetzal cuenta con arreglos, los cuales pueden ser definidos mediante una sintaxis. Los valores de los arreglos solo pueden ser del tipo definido en la variable o arreglos del mismo tipo.

[8,2,3,[1,2,3]]

Para acceder a una posición en específico del arreglo, se debe definir una expresión que de como resultado un numero entero dentro de corchetes. los indices en Quetzal inician desde el numero 0 en adelante.

String[] arr = ["H","O","L","A"];

print(arr[1]) //O

Se debe de validar que el valor mínimo sea 0 y el máximo no debe de exceder del tamaño del arreglo, caso contrario se deberá de reportar un error.

Quetzal también permite que se acceda a una porción de un arreglo, esto se define mediante la sintaxis begin:end, el cual debe ir dentro de corchetes y devolverá un arreglo con los limites establecidos. Se debe tomar en cuenta que las palabras begin y end pueden ser utilizadas para indicar el inicio y el final del arreglo respectivamente

int[] arr = [1,2,3,4,5,6];

print(arr[2:4]); //[2,3,4]

print(arr[begin:4]) //[1,2,3,4]

print(arr[4:end]) //[4,5,6]

Se debe de validar que el valor minimo sea 0 y el máximo no debe de exceder del tamaño del arreglo, caso contrario se deberá de reportar un error.

Copiar un arreglo:

Quetzal permite crear una copia de un arreglo utilizando el símbolo #, es útil hacer una copia antes de realizar operaciones que las modifiquen.

int[] arr = [1,2,3,4,5,6];

int[] arr2 = #arr;

arr[2] = 0;

print(arr) //[1,0,3,4,5,6]

print(arr2) //[1,2,3,4,5,6]

Funciones nativas con arreglos:

Quetzal cuenta con 2 funciones nativas con arreglos, en los que podemos encontrar:

Push: inserta un nuevo valor al final del arreglo, se define como:

` `nombre_arreglo.push(expresion);

Ejemplo:

int[] arr = [1,2,3,4,5,6];

arr.push(7); // arr = [1,2,3,4,5,6,7]

Pop: elimina y devuelve el ultimo valor de un arreglo, se define como:

nombre_arreglo.pop();

Ejemplo:

int[] arr = [1,2,3,4,5,6];

arr.pop(); // retorna 6, arr = [1,2,3,4,5]

Length: La obtención del tamaño de un arreglo, se define como:

arreglo.length();

Ejemplo:

int[] arr = [1,2,3,4,5,6];

arr.length(); // 6

Operador punto con arreglos:

Quetzal permite la utilización del operador numeral (#) para realizar diferentes operaciones aritméticas, trigonométricas, relaciones o cualquier otro tipo de función sobre cada valor en un arreglo.

int[] arr = [1,2,3];

print(arr#\*2) //[2,4,6]

double[] arr2 = sin#(arr) //[0.8415, 0.9093, 0.1411]
