class Traductor_id{
    constructor(_id,  _opIzq ,_valor, _opDer, _tipo){
        this.id = _id
        this.opIzq = _opIzq
        this.valor = _valor
        this.opDer = _opDer
        this.tipo = _tipo
        if((this.tipo=="DECLARACION") && ((_valor==true) || (_valor==false))){
            let a = T_V_boolean(this.valor)
            this.traduccion = a.traduccion
            this.ubicacion = a.ubicacion
            console.log("hola")
        }else if(this.tipo=="DECLARACION"){
            let a = T_Declaracion(this.opIzq, this.valor, this.opDer)
            this.traduccion = a.traduccion
            this.ubicacion = a.ubicacion
            console.log("hola")
        }
    }
}

Lista_Traducciones = []

encabezado = `
/* ------ HEADERS ------ */
#include <stdio.h>
#include <math.h>

double heap[30101999];
double stack[30101999];
double xheap[30101999];
double xstack[30101999];
double resultados[3010199];
double P;
double H;
            `
inicio = ` 
int main(){
        
    //el stack pointer inicia en 2 porque en la posicion 0 guardamos el encoding
    //y la posicion 1 indicara donde termina el xml en el heap
    //El heap pointer inicia en cero.
    P = 0;
    H = 0;

    //guardamos el encoding en el stack en la posicion 0 (definida por default)
    // -1 : utf8
    // -2 : iso
    // -3 : ascii
    
        `

final=`
return 0;

}
        `
//------------------------- PARA LOS TEMPORALES Y OPERACIONES --------------------------------
temporales = 0;
Enc_Temp = "";
Stack = 0;
opera = ""

//---------------------------------------------------------------------------------------------
etiquetas = 0;
Heap = 0;  
P = 0;

//------------------------------ PARA EL VOID DE LAS POTENCIAS -------------------------------
var OP_Potencia = "";

//------------------------------- FUNCIONES ---------------------------------------------------
function T_Declaracion(opIzq, valor, opDer){
    if((opIzq==null) & (opDer==null)){
        let data = {traduccion: "stack[(int)"+(Stack).toString()+"] = "+valor.toString()+";\n",
                    ubicacion: "stack[(int)"+(Stack).toString()+"];"};
        Stack = Stack +1
        return data
    }
}

function T_Aritmetica(opIzq, tipoA, signo, opDer, tipoB){
    porIzq = ""
    tA = ""
    porDer = ""
    tB = ""
    let Op__potencia=""
    var data= ""
    if(tipoA=="VAL_IDENTIFICADOR"){
        t = BuscarPosicion(opIzq);
        tA = "t"+temporales.toString()+" = "+t+"\n"
        porIzq = "t"+temporales.toString()
        temporales = temporales +1
    }else{
        porIzq = opIzq.toString()
    }

    if(tipoB=="VAL_IDENTIFICADOR"){
        t = BuscarPosicion(opDer);
        tB = "t"+temporales.toString()+" = "+t+"\n"
        porDer = "t"+temporales.toString()
        temporales = temporales +1
    }else{
        porDer = opDer.toString()
    }

    if(signo=="POTENCIA"){
        T_Potencia();
        temporales = temporales +1;
        //t5 = P+0;
        Op__potencia = Op__potencia + "t"+temporales.toString()+"= P+0;\n"
        //t5 = t5+1;
        Op__potencia = Op__potencia + "t"+temporales.toString()+" = t"+temporales.toString()+"+1;\n"
        //stack[(int)t5] = 5;
        Op__potencia = Op__potencia + "stack[(int)t"+temporales.toString()+"] = "+porIzq+";\n"
        //t5 = t5+1;
        Op__potencia = Op__potencia + "t"+temporales.toString()+" = t"+temporales.toString()+"+1;\n"
        //stack[(int)t5] = 3;
        Op__potencia = Op__potencia + "stack[(int)t"+temporales.toString()+"] = "+porDer+";\n"
        //P = P + 0;
        Op__potencia = Op__potencia + "P = P + 0;\n"
        //potencia();
        Op__potencia = Op__potencia + "potencia();\n"
        //t0 = stack[(int)P];
        Op__potencia = Op__potencia + "t"+(temporales-4).toString()+" = stack[(int)P];\n"
        //P = P - 0;
        Op__potencia = Op__potencia + "P = P - 0;\n"
        data = {traducciones: tA+tB+Op__potencia, ubicacion: "t"+(temporales-4).toString()}
    }else if(signo=="RAIZ"){
        data = {traducciones:tA+"t"+temporales.toString()+"= sqrt( "+porIzq.toString()+");\n",
                ubicacion: "t"+temporales.toString()}
        temporales = temporales +1;
    }else if(signo=="SENO"){
        data = {traducciones:tA+"t"+temporales.toString()+"= sin( "+porIzq.toString()+");\n",
                ubicacion: "t"+temporales.toString()}
        temporales = temporales +1;
    }else if(signo=="COSENO"){
        data = {traducciones:tA+"t"+temporales.toString()+"= cos( "+porIzq.toString()+");\n",
                ubicacion: "t"+temporales.toString()}
        temporales = temporales +1;
    }else if(signo=="TAN"){
        data = {traducciones:tA+"t"+temporales.toString()+"= tan( "+porIzq.toString()+");\n",
                ubicacion: "t"+temporales.toString()}
        temporales = temporales +1;
    }else if(signo=="LOG"){
        data = {traducciones:tA+"t"+temporales.toString()+"= log10("+porIzq.toString()+");\n",
                ubicacion: "t"+temporales.toString()}
        temporales = temporales +1;
    }
    else{
        data = {traducciones:tA+tB+"t"+temporales.toString()+" ="+(porIzq)+signo+(porDer)+";\n",
                ubicacion: "t"+temporales.toString()}
        temporales = temporales +1;
    }
    return data
}

function T_V_boolean(valor){
    data = ""
    /**
    goto L0;
    L0:
    stack[(int)0] = 1;
    goto L2;
    L1:
    stack[(int)0] = 0;
    L2:
     */
    if(valor == true){
        return data =  {traduccion: "goto L0;\n L0:\n stack[(int)"+Stack.toString()+"] = 1;\n goto L2;\n L1:\n stack[(int)"+Stack.toString()+"] = 0;\n L2:",
                        ubicacion: "stack[(int)"+(Stack).toString()+"];"}
    }else if(valor == false){
        return data =  {traduccion: "goto L1;\n L0:\n stack[(int)"+Stack.toString()+"] = 1;\n goto L2;\n L1:\n stack[(int)"+Stack.toString()+"] = 0;\n L2:",
                        ubicacion: "stack[(int)"+(Stack).toString()+"];"}
    }

}

//FUNCIONES PARA IMPRIMIR VALORES

function T_imprimir(dato){
    da = BuscarPosicion(dato)
    data =  "t"+temporales.toString()+" = "+da+"\n";
    data = data + "printf(\"%f\", (double)t"+temporales.toString()+");\n"
    data = data + "printf(\"%c\", (char)10);\n"
    temporales = temporales +1;
    return data
}

function T_imprimir2(dato){
    let data = "";
    data = data + "printf(\"%f\", (double)"+dato+");\n"
    data = data + "printf(\"%c\", (char)10);\n"
    temporales = temporales +1;
    return data
}

//FUNCION INTERNA DE LA POTENCIA
function T_Potencia(){
    let inicio = `/*------NATIVES------*/
                void potencia() {\n`
    temporales = temporales+1;
    //t3 = P+1;
    var traducciones = "t"+temporales.toString() +"= P+1; \n"
    temporales = temporales -1;
    //t2 = stack[(int)t3];
    traducciones = traducciones + "t"+temporales.toString() +"= "+"stack[(int)t"+(temporales+1).toString()+"];\n"
    temporales = temporales+2;
    //t4 = t2;
    traducciones = traducciones + "t"+temporales.toString()+" = t"+(temporales-2).toString()+";\n"
    //t5 = t2;
    temporales = temporales +1;
    traducciones = traducciones + "t"+temporales.toString()+" = t"+(temporales-3).toString()+";\n"
    //t3 = P+2;
    traducciones = traducciones + "t"+(temporales-2)+" = P+2;\n"
    //t2 = stack[(int)t3];
    traducciones = traducciones + "t"+(temporales-3)+"= stack[(int)t"+(temporales-2).toString()+"];\n"
    //if(t2 == 0) goto L1;
    etiquetas = etiquetas+1;
    traducciones = traducciones +"if(t"+(temporales-3).toString()+" == 0) goto L"+(etiquetas).toString()+";\n"
    etiquetas = etiquetas +1;
    //L2:
    traducciones = traducciones + "L"+(etiquetas).toString()+":\n"
    //if(t2 <= 1) goto L0;
    traducciones = traducciones +"if(t"+(temporales-3).toString()+" <= 1) goto L"+(etiquetas-2).toString()+";\n"
    //t4 = t4*t5;
    traducciones = traducciones + "t"+(temporales-1).toString()+" = t"+(temporales-1).toString()+"*t"+temporales.toString()+";\n";
    //t2 = t2-1;
    traducciones = traducciones + "t"+(temporales-3).toString()+" = t"+(temporales-3).toString()+"-1;\n"
    //goto L2;
    traducciones = traducciones + "goto L"+etiquetas.toString()+";\n"
    //L0:
    traducciones = traducciones + "L"+(etiquetas-2).toString()+":\n"
    //stack[(int)P] = t4;
    traducciones = traducciones + "stack[(int)P] = t"+(temporales-1).toString()+";\n"
    //goto L3;
    etiquetas = etiquetas + 1;
    traducciones = traducciones + "goto L"+etiquetas.toString()+";"
    //L1:
    traducciones = traducciones + "L"+(etiquetas-2).toString()+":\n"
    //stack[(int)P] = 1;
    traducciones = traducciones + "stack[(int)P] = 1;\n"
    //L3:
    traducciones = traducciones + "L"+etiquetas.toString()+":\n"
    //return;
    traducciones = traducciones + "return;\n}"
    OP_Potencia =  inicio+traducciones;
}

//FUNCIONES INTERMEDIRARIAS

function Llamado_Traductor(){
    var tem = ""
    var contenido = ""
    Enc_Temp = cantidadTemporales(temporales);
    contenido = concatenar(Lista_Traducciones)
    if(Enc_Temp!=""){
        tem = " double "+Enc_Temp+";";
    }
    var re = encabezado+tem+OP_Potencia+inicio+contenido+final;
    return re;
}

function concatenar(Lista){
    concate = ""
    for(i=0; i<Lista.length; i++){
        if(Lista[i].tipo=="DECLARACION"){
            concate = concate + Lista[i].traduccion;
        }else if(Lista[i].tipo=="ARITMETICA"){
            concate = concate + Lista[i].valor;
        }else if(Lista[i].tipo=="IMPRIMIR"){
            concate = concate + Lista[i].valor;
        }
    }
    return concate
}

function cantidadTemporales(cantidad){
    total = ""
    for(let i = 0; i<cantidad; i++){
        if(i==(cantidad-1)){
            total = total+"t"+i.toString()
        }else{
            total = total+"t"+i.toString()+","
        }
    }
    return total
}

function BuscarPosicion(dato){
    for (let i = 0; i < Lista_Traducciones.length; i++){
        if(Lista_Traducciones[i].id === dato){
            return Lista_Traducciones[i].ubicacion
        }
    }
}