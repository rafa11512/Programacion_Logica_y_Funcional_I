# Actividad. 3 funciones

- Fibonacci
- factorial
- división con restas sucesivas

recursiva y prueba de escritorio.



```java
package prolog;

public class Actividad3Factorial {

    public static void main(String[] args) {

        /*factorial: n! = (n-0)*(n - 1)*(n - 2)... */
        /*fibonacci: */
        
        int n = 10;
        int i = 0;
        int n1 = 0, n2 = 1, suma= 0;
     
        fibonacci(n,i,n1,n2,suma);
        
    }
    
    
    public static void factorial(int n, int i){
        if( i>n){
            return;
        }
        
        n = n + n*(n+i);
        
        System.out.println("Factorial: " + n);
        
        factorial(n, i+1);
    }
    
    
    
    public static void fibonacci(int n, int i, int n1, int n2, int suma){
        
        if(i > n){
            return;
        }

        System.out.println(n1 + ", " + n2);
        
        suma = n1 + n2;
        
         
        
        fibonacci(n, i+1, n1+1, n2+1, suma);
    }
    
    
    
    
    
}
```