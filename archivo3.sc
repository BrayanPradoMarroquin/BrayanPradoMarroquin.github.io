/*
    DECLARAMOS UN VECTOR DE 15 POSICIONES
    SE IMPRIMRÁ Y POSTERIORMENTE SE ORDENARÁ
*/
int vectorNumeros[] = new int[15];
vectorNumeros[0] = 200;
vectorNumeros[1] = 26;
vectorNumeros[2] = 1;
vectorNumeros[3] = 15;
vectorNumeros[4] = 167;
vectorNumeros[5] = 0;
vectorNumeros[6] = 76;
vectorNumeros[7] = 94;
vectorNumeros[8] = 25;
vectorNumeros[9] = 44;
vectorNumeros[10] = 5;
vectorNumeros[11] = 59;
vectorNumeros[12] = 95;
vectorNumeros[13] = 10;
vectorNumeros[14] = 23;

/*
    DECLARAMOS UNA LISTA
*/
dynamiclist<string> frase = new dynamiclist<string>;

void Hanoi(int discos, int origen, int auxiliar, int destino) {
    if (discos == 1) {
        writeline("Mover disco de " + origen + " a " + destino);
    } else {
        Hanoi(discos - 1, origen, destino, auxiliar);
        writeline("Mover disco de " + origen + " a " + destino);
        Hanoi(discos - 1, auxiliar, origen, destino);
    }
}

void imprimirVector(int[] miVector){
    for (int i = 0; i < length(miVector); i++) {
        writeline("vectorNumeros[" + i + "] = " + miVector[i]);
    }
}

void BubbleSort(int[] miVector){
    for (int i = 0; i < length(miVector); i++)
    {
        for (int j = 0; j < length(miVector) - i - 1; j++)
        {
            if (miVector[j] > miVector[j + 1]) {
                int temp;
                temp = miVector[j];
                miVector[j] = miVector[j + 1];
                miVector[j + 1] = temp;
            }
        }
    }
}

void agregarValorLista(string letra){
    append(frase,letra);
}

void imprimirLista(dynamiclist<string> miLista){
    for (int i = 0; i < length(miLista); i++) {
        writeline("frase[[" + i + "]] = " + getValue(miLista,i));
    }
}

string mensajeVolteado(dynamiclist<string> miLista){
    string mensaje="";
    for(int i=length(miLista)-1;i>=0;i--){
        mensaje=mensaje+getValue(miLista,i);
    }
    return mensaje;
}

start with Archivo3();

void ParoImpar(int a) {
    if (par(a) == 1) { // El número es Par
        writeline("El numero '" + a + "'" + " es Par");
    } else { // El número es impar
        writeline("El numero '" + a + "'" + " es Impar");
    }
}

int par(int nump) {
    if (nump == 0) {
        return 1;
    }
    return impar(nump - 1);
}

int impar(int numi) {
    if (numi == 0) {
        return 0;
    }
    return par(numi - 1);
}

int ackermanPuntosMenos(int m, int n)
{
    if (m == 0) {
        return n + 1;
    } else if (m > 0 && n == 0) {
        return ackermanPuntosMenos(m - 1, 1);
    } else {
        return ackermanPuntosMenos(m - 1, ackermanPuntosMenos(m, n - 1));
    }
}

int ackerman(int m, int n)
{
    return (m == 0 ? n + 1 : (m > 0 && n == 0 ? ackerman(m - 1, 1) : ackerman(m - 1, ackerman(m, n - 1))));
}

void Archivo3(){
    writeline("====================ARCHIVO 3====================");
    writeline("**************SECCION DE VECTORES****************");
    writeline("---Vector Desordenado---");
    imprimirVector(vectorNumeros);
    BubbleSort(vectorNumeros);
    writeline("-----Vector Ordenado----");
    imprimirVector(vectorNumeros);
    writeline("************FIN DE SECCION VECTORES***************");
    writeline("****************SECCION DE LISTAS****************");
    //agregamos valores a la lista
    agregarValorLista(")");
    agregarValorLista(":");
    agregarValorLista(" ");
    agregarValorLista("1");
    agregarValorLista("I");
    agregarValorLista("P");
    agregarValorLista("M");
    agregarValorLista("O");
    agregarValorLista("C");
    agregarValorLista(" ");
    agregarValorLista("E");
    agregarValorLista("L");
    agregarValorLista("A");
    agregarValorLista("S");
    agregarValorLista(" ");
    agregarValorLista("I");
    agregarValorLista("S");
    imprimirLista(frase);
    writeline("El mensaje es:");
    writeline(mensajeVolteado(frase));
    writeline("************FIN DE SECCION DE LISTAS**************");
    writeline("**************SECCION DE CASTEOS***************");
    Casteos();
    writeline("************FIN DE SECCION DE CASTEOS*************");
    writeline("**************SECCION DE NATIVAS***************");
    FuncionesEspecialesNativas();
    writeline("************FIN DE SECCION DE NATIVAS*************");
    writeline("***********SECCION DE RECURSIVIDAD***************");
    writeline("---------------FUNCION FIBONACCI-----------------");
    imprimir_fibonacci(20);
    writeline("-------------------------------------------------");
    writeline("---------------FUNCION PAR-IMPAR-----------------");
    ParoImpar(71);
    writeline("-------------------------------------------------");
    writeline("----------------TORRES DE HANOI------------------");
    int discos = 3;
    int origen = 1;
    int auxiliar = 2;
    int destino = 3;
    Hanoi(discos, origen, auxiliar, destino);
    writeline("-------------------------------------------------");
    writeline("---------------FUNCION ACKERMANN-----------------");
    int m = 3;
    int n = 4;
    writeline("Funcion de Ackerman (" + m + ", " + n + ") = " + ackerman(m, n));
    //writeline("Funcion de Ackerman Puntos Menos (" + m + ", " + n + ") = " + ackermanPuntosMenos(m, n));
    writeline("-------------------------------------------------");
    writeline("*************FIN DE RECURSIVIDAD*****************");
    writeline("=================================================");
}

void Casteos(){
    writeline("int a "+typeof((double) 1789));
    writeline("double a "+ typeof((int) 258.2));
    writeline("char  a "+ typeof((double) 'F'));
    writeline("int a "+typeof((char) 98));
    writeline("double a "+typeof(toString(2589.97)));
}

void FuncionesEspecialesNativas(){
    writeline("------------------LENGTH-------------------");
    writeline("vectorNumero es de "+length(vectorNumeros)+" elementos");
    writeline("La lista frase tiene "+length(frase)+" elementos");
    int a = 15;
    writeline("------------------TOLOWER-------------------");
    writeline("SIN TOLOWER");
    writeline(toLower("CON TOLOWER"));
    writeline("------------------TOUPPER-------------------");
    writeline("sin toupper");
    writeline(toUpper("con toupper"));
    writeline("------------------TRUNCATE------------------");
    double b=17.8;
    writeline("sin truncate: "+b);
    b=truncate(b);
    writeline("con truncate "+b);
    writeline("------------------ROUND-------------------");
    double c=26.5;
    writeline("sin round: "+c);
    c=round(c);
    writeline("con round "+c);
    double cc=26.4;
    writeline("sin round: "+cc);
    cc=round(cc);
    writeline("con round "+cc);
    writeline("-----------------TYPEOF--------------------");
    string x="soy una cadena";
    int y = 50;
    double z = 78.5;
    char xx = 'a';
    boolean yy = true;
    writeline("tipo: "+typeof(x));
    writeline("tipo: "+typeof(y));
    writeline("tipo: "+typeof(z));
    writeline("tipo: "+typeof(xx));
    writeline("tipo: "+typeof(yy));
    writeline("------------------LENGTH-------------------");
    string cadena="soy una cadena";
    writeline("tamaño: "+length(cadena));
    writeline("------------------TOSTRING-------------------");
    int numero=105;
    writeline("tipo: "+typeof(numero));
    writeline("tipo: "+typeof(toString(numero)));
    writeline("----------------TOCHARARRAY------------------");
    dynamiclist<char> listaChar = toCharArray("SOY UNA LISTA");
    writeline("########imprimiendo lista de caracteres#######");
    imprimirListaChar(listaChar);
}

void imprimirListaChar(dynamiclist<char> miLista){
    for (int i = 0; i < length(miLista); i++) {
        writeline("listaChar[[" + i + "]] = " + getValue(miLista,i));
    }
}

void imprimir_fibonacci(int valor) {
    writeline("Resultado de fibonacci(" + valor + ") = " + fibonacci(valor));
}

int fibonacci(int n) {
    if (n > 1) {
        return fibonacci(n - 1) + fibonacci(n - 2);
    } else if (n == 1) {
        return 1;
    } else if (n == 0) {
        return 0;
    } else {
        writeline("error");
        return 0;
    }
}
