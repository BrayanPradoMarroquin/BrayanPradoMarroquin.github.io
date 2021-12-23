7

# MANUAL TÉCNICO

# QUETZAL – PROYECTO 1

![](Aspose.Words.5967a895-45af-44fb-96ff-c706ad2029a2.004.png)

# Contenido

[Requerimientos del Equipo. 2](#_Toc90861758)

[Estructura del Proyecto. 3](#_Toc90861759)

[Editor y Conexión del Analizador. 3](#_Toc90861760)

[Clases Utilizadas. 4](#_Toc90861761)

[Controladores. 4](#_Toc90861762)

[Modelos. 6](#_Toc90861763)

[Analizador.jison 6](#_Toc90861764)

# Requerimientos del Equipo.

- Sistema Operativo requerido: Windows 8 o superiores.
- Memoria RAM: 4GB o superior.
- Procesador: Intel Celeron o superiores ( Recomendados Core i5 de 8gen en adelante).
- Tipo de Sistema: 64 bits (recomendado).
- Lenguaje de Programación: JavaScript.
- Librería de Análisis Léxico y Sintáctico: Jison.
- Librerías Extras: Bootstrap, Codemirror.
- Lenguaje Para Traducir: C

# Estructura del Proyecto.

![AplicaciónDescripción generada automáticamente con confianza baja](Aspose.Words.5967a895-45af-44fb-96ff-c706ad2029a2.006.png)

_Se descargo la carpeta de origen de Codemirror desde su sitio oficial <https://codemirror.net/> para poder implementar las herramientas de JavaScript, posterior a eso se creó el archivo Analizador.jison el cual contiene las palabras reservadas (tokens, analizador léxico) así como también las producciones que tendrán a cargo el análisis sintáctico. Al ser un proyecto montado en GitHub Pages se nos solicitó que fuese full HTML y JavaScript por lo tanto en el archivo Editores.js se hace la configuración del editor y así mismo la conexión con el Analizador, los archivos HTML y CSS son directos de la página_

![Captura de pantalla de computadoraDescripción generada automáticamente](Aspose.Words.5967a895-45af-44fb-96ff-c706ad2029a2.008.png)

_En esta clase se tiene la configuración de los editores (Entrada, salida y traductor) y también la función de compilar la cual llama al analizador para parsearlo y empezar con los analizadores así mismo se inicia los entornos y las direcciones para la tabla de símbolos y errores y también se inicializa el AST._

# Clases Utilizadas.

![Imagen que contiene Interfaz de usuario gráficaDescripción generada automáticamente](Aspose.Words.5967a895-45af-44fb-96ff-c706ad2029a2.011.png)

_Estas se encuentran separadas por dos carpetas las cuales son Controladores y Modelos, esto para tener un mayor orden en las clases y saber en donde se especifica cada una de las instrucciones._

## Controladores.

- **Árbol.**

_Se encuentra el archivo donde iremos generando el árbol nodo por nodo, dentro de encontraremos los métodos para cada una de las instrucciones del lenguaje._

![TextoDescripción generada automáticamente](Aspose.Words.5967a895-45af-44fb-96ff-c706ad2029a2.014.png)

- **Instrucción.**

_Dentro de esta carpeta se encuentran las acciones que se deben de realizar, así mismo las carpetas de Arranque, Sentencias Cíclicas y de Control._

![TextoDescripción generada automáticamente con confianza baja](Aspose.Words.5967a895-45af-44fb-96ff-c706ad2029a2.016.png)

- Arranque: Tiene la sentencia de main, que esta instrucción tiene la función de inicializar la aplicación, ya que sin esta da error.
- Cíclicas: Tiene todas las sentencias que general un bucle y se iteran n veces (While, Do While, For).
- De control: Tiene todas las sentencias que controlan un flujo determinado de código (If, If-Else, If-Else-If, Switch-Case).

- **Principales**

En esta carpeta se encuentran las clases enumeradas las cuales se heredarán en la mayoría de los archivos ya que estos tendrán los tipos de operaciones, de valores, de datos y los tipos primitivos.

![Pantalla de computadora con letrasDescripción generada automáticamente con confianza baja](Aspose.Words.5967a895-45af-44fb-96ff-c706ad2029a2.018.png)

![TextoDescripción generada automáticamente](Aspose.Words.5967a895-45af-44fb-96ff-c706ad2029a2.020.png)

![TextoDescripción generada automáticamente](Aspose.Words.5967a895-45af-44fb-96ff-c706ad2029a2.022.png)

## Modelos.

![Interfaz de usuario gráfica, AplicaciónDescripción generada automáticamente](Aspose.Words.5967a895-45af-44fb-96ff-c706ad2029a2.026.png)

_En los modelos veremos la carpeta de las palabras reservadas, los ámbitos y las operaciones que se realizan durante el flujo del programa._

## Analizador.jison

_Si hablamos de Jison veremos que es un lenguaje que facilita la creación de un intérprete en JavaScript, ya que en este se verá una sintaxis a un léxico y sintáctico ya que Jison traduce nuestros tokens, expresiones y producciones a js, el comando para compilar es Jison analizador.jison esto por si se hacen modificaciones en las producciones o tokens_

![Una captura de pantalla de un celular con texto e imagenDescripción generada automáticamente con confianza baja](Aspose.Words.5967a895-45af-44fb-96ff-c706ad2029a2.028.png)
