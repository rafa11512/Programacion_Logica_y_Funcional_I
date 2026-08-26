public class iterativo {
    public static void main(String[] args) {
        
        int numero = 456;
        int[] cantidades = {100,50,20,10,5,2,1};//6

        for (int i = 0; i<cantidades.length; i++){ //6
            int contador = numero/cantidades[i];
            numero %= cantidades[i];
            
            System.out.println(cantidades[i]+ " : " + contador);
            
        }
    }
}