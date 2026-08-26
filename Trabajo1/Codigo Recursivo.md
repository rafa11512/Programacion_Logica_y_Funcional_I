public class recursivo {
public static void main(String[] args) {
        int numero = 456;
        int[] cantidades = {100, 50, 20, 10, 5, 2, 1}; //0-6

        contadorDenominaciones(numero, cantidades, 0);
    }

    public static void contadorDenominaciones(int numero, int[] cantidades, int i) {
        //se termina cuando se recorre todas las cantidades
        if (i >= cantidades.length) {//0-6 y 7 se acaba el array
            return;
        }

        int contador = numero / cantidades[i];
        numero = numero % cantidades[i]; // residuo
        System.out.println(cantidades[i] + " : " + contador);

        //se llama asi misma
        contadorDenominaciones(numero, cantidades, i + 1);
    }
}