class Traductor_id{
    constructor(_id,  _opIzq ,_valor, _opDer, _tipo){
        this.id = _id
        this.opIzq = _opIzq
        this.valor = _valor
        this.opDer = _opDer
        this.tipo = _tipo
        if(this.tipo=="DECLARACION"){
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
double SP;
double HP;

;
            `
inicio = ` 
int main(){
        
    //el stack pointer inicia en 2 porque en la posicion 0 guardamos el encoding
    //y la posicion 1 indicara donde termina el xml en el heap
    //El heap pointer inicia en cero.
    SP = 0;
    HP = 0;

    //guardamos el encoding en el stack en la posicion 0 (definida por default)
    // -1 : utf8
    // -2 : iso
    // -3 : ascii
    
    stack[(int)0] = -1;
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

//------------------------------- FUNCIONES ---------------------------------------------------
function T_Declaracion(opIzq, valor, opDer){
    if((opIzq==null) & (opDer==null)){
        let data = {traduccion: "stack[(int)"+(Stack).toString()+"] = "+valor.toString()+";\n",
                    ubicacion: "stack[(int)"+(Stack).toString()+"];"};
        Stack = Stack +1
        return data
    }
}

function T_Aritmetica(opIzq, signo, opDer){
    porIzq = ""
    porDer = ""
    if(isLetter(opIzq)){
        t = BuscarPosicion(opIzq);
        t = "t"+temporales.toString()+" = "+t
        temporales = temporales +1
        porIzq = t
    }else{
        porIzq = opIzq.toString()
    }

    if(isLetter(opDer)){
        t = BuscarPosicion(opDer);
        t = "t"+temporales.toString()+" = "+t
        temporales = temporales +1
        porDer = t
    }else{
        porDer = opDer.toString()
    }

    let data = {traducciones: "t"+temporales.toString()+" ="+(porIzq)+signo+(porDer)+";",
                ubicacion: "t"+temporales.toString()}
    temporales = temporales +1;
    return data
}

function Llamado_Traductor(){
    var tem = ""
    if(Enc_Temp!=""){
        tem = " double "+Enc_Temp+";";
    }
    var re = encabezado+tem+inicio+final;
    return re;
}

function isLetter(char){
    return ( (char >= 'A' &&  char <= 'Z') ||
             (char >= 'a' &&  char <= 'z') );
}

function BuscarPosicion(dato){
    for (let i = 0; i < Lista_Traducciones.length(); i++){
        if(Lista_Traducciones[i].id === dato){
            return Lista_Traducciones[i].ubicacion
        }
    }
}