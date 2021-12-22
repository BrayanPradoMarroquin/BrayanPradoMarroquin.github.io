def Hanoi(discos, origen, auxiliar, destino):
    if (discos == 1):
        print("Mover disco de " + str(origen) + " a " + str(destino))
    else:
        Hanoi(discos - 1, origen, destino, auxiliar)
        print("Mover disco de " + str(origen) + " a " + str(destino))
        Hanoi(discos - 1, auxiliar, origen, destino)

Hanoi(3, 1, 2, 3)