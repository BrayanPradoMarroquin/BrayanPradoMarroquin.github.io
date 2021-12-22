var edit = CodeMirror.fromTextArea(document.getElementById('txtEdditor'), {
    mode: "text/x-java",
    theme: "lesser-dark",
    lineNumbers: true,
    autoCloseTags: true
});
edit.setSize("600", "590");

var oup = CodeMirror.fromTextArea(document.getElementById('txtConsole'), {
    mode: "text/x-java",
    theme: "lesser-dark",
    lineNumbers: true,
    autoCloseTags: true
});
oup.setSize("600", "590");

var traductor = CodeMirror.fromTextArea(document.getElementById('trad'), {
    mode: "text/x-java",
    theme: "lesser-dark",
    lineNumbers: true,
    autoCloseTags: true
});
traductor.setSize("600", "680");

txtEdditor = edit;
txtConsole = oup;
trad = traductor;
let errores = null;
let simbolos = null;
let gramatica = null;

function compiler(){
    Lista_Traducciones = []
    temporales=0
    Stack=0
    Enc_Temp=""
    opera=""
    etiquetas=0
    Heap=0
    var informacion = txtEdditor.getValue();
    try {
        gramatica = Analizador.parse(informacion);
        errores = gramatica.errores;
        var global = new Ambito(null, "global", "");
        var cadena = Global(gramatica.parse, global);
        simbolos = global.getArraySimbols()
        for(let i = 0; i < cadena.errores.length; i++){
            const err = cadena.errores[i];
            errores.push(err)
        }
        var salida = txtConsole.setValue(cadena.cadena);
    } catch (error) {
        alert(error);
    }
}

function Traductor(){
    var respuesta = Llamado_Traductor();
    var re = trad.setValue(respuesta);
}

function TablaSimbolos(){
    var base = `<!DOCTYPE html>
                    <html lang=\"en\">
                        <head>
                            <meta charset=\"UTF-8\">
                            <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">
                            <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
                            <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css\" rel=\"stylesheet\" integrity=\"sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3\" crossorigin=\"anonymous\">
                            <link rel=\"stylesheet\" href=\"Style.css\">
                            <link rel=\"icon\" type=\"image/x-icon\" href=\"quetzal.ico\">
                            <title>Quetzalito 502</title>
                        </head>
                        <body>
                            <header>
                                <div class="padre">
                                    <div class="titlep">
                                        <h1>Interprete Quetzalito</h1>
                                    </div>
                                </div>
                            </header>
                            <div class="row my-5">
                                <div class="col-12">
                                <p class="mt-2 mb-1 text-white subtitulo" style="text-align: center; font-size: 36px;">Tabla de símbolos</p>
                                <table class="table table-striped table-dark text-center">
                                    <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Nombre</th>
                                        <th scope="col">Tipo símbolo</th>
                                        <th scope="col">Tipo dato</th>
                                        <th scope="col">Ámbito</th>
                                        <th scope="col">Valor</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    `
    var contcantenar = "";
    for(let i = 0; i < simbolos.length; i++){
        contcantenar = contcantenar + `
                                    <tr>
                                        <td>`+(i+1).toString()+`</td>
                                        <td>`+simbolos[i].id+`</td>
                                        <td>`+simbolos[i].tipo+`</td>
                                        <td>`+simbolos[i].objeto+`</td>
                                        <td>`+simbolos[i].entorno+`</td>`
                                        if(simbolos[i].valor!=undefined){
                                            if(simbolos[i].valor != undefined){
                                                contcantenar= contcantenar+   `<td>`+simbolos[i].valor+`</td>`
                                            }
                                        }else{
                                            contcantenar= contcantenar+   `<td></td>`
                                        }
                                        contcantenar= contcantenar+`
                                                                    </tr>
                                                                    `
    }
    var final = `
        </tbody>
        </table>
        </div>
        </div>
        <footer class="text-center text-lg-start">
        <div class="text-center p-3" style="background-color: #EDEDED;">
          <p class="foot my-0">
            © 2021 QUETZALITO - Organización de Lenguajes y Compiladores 2 - Proyecto 1
          </p>
        </div>
      </footer>
      </body>
</html>                   
    `  
    var resul = base + contcantenar + final;       
    var doc = document.open("text/html");
    doc.write(resul);
    doc.close();  
}

function Generar_AST(){
    var root_AST = new Graph(gramatica.parse);
    var dot = root_AST.getDot();
    d3.graphviz("#graph")
    .addImage("images/first.png", "400px", "300px")
    .addImage("images/second.png", "400px", "300px")
    .renderDot(dot);   
}

function TablaErrores(){
    var base = `<!DOCTYPE html>
                    <html lang=\"en\">
                        <head>
                            <meta charset=\"UTF-8\">
                            <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">
                            <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
                            <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css\" rel=\"stylesheet\" integrity=\"sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3\" crossorigin=\"anonymous\">
                            <link rel=\"stylesheet\" href=\"Style.css\">
                            <link rel=\"icon\" type=\"image/x-icon\" href=\"quetzal.ico\">
                            <title>Quetzalito 502</title>
                        </head>
                        <body>
                            <header>
                                <div class="padre">
                                    <div class="titlep">
                                        <h1>Interprete Quetzalito</h1>
                                    </div>
                                </div>
                            </header>
                            <div class="row my-5">
                                <div class="col-12">
                                <p class="mt-2 mb-1 text-white subtitulo" style="text-align: center; font-size: 36px;">Tabla de Errores</p>
                                <table class="table table-striped table-dark text-center">
                                    <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Tipo de Error</th>
                                        <th scope="col">Descripcion</th>
                                        <th scope="col">Linea</th>
                                        <th scope="col">columna</th>
                                    </tr>
                                    </thead>
                                    <tbody>
          
                              `
    var contcantenar = "";
    for(let i = 0; i < errores.length; i++){
        contcantenar = contcantenar + `
                                        <tr>
                                            <td>`+(i+1).toString()+`</td>
                                            <td>`+errores[i].tipo+`</td>
                                            <td>`+errores[i].error+`</td>
                                            <td>`+simbolos[i].linea+`</td>
                                            <td>`+simbolos[i].columna+`</td>
                                        </tr>`      
                              }

    var final = `
        </tbody>
            </table>
                </div>
                    </div>
                        <footer class="text-center text-lg-start">
                            <div class="text-center p-3" style="background-color: #EDEDED;">
                                <p class="foot my-0">
                                  © 2021 QUETZALITO - Organización de Lenguajes y Compiladores 2 - Proyecto 1
                                </p>
                            </div>
                        </footer>
                    </body>
                  </html>                   
                `  
    var resul = base + contcantenar + final;       
    var doc = document.open("text/html","replace");
    doc.write(resul);
    doc.close();  
}

function limpiar(){
    var ed = txtEdditor.setValue(" ");
    var sa = txtConsole.setValue(" ");
    var t = trad.setValue(" ");
}