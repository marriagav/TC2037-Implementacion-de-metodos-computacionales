## Reporte: Actividad Integradora 3.4 Resaltador de sintáxis

### Miguel Arriaga - A01028570

### Pablo Rocha - A01028638

## Instrucciones para correr el programa

Correr `mix test` en el directorio raíz del proyecto para parsear todos los archivos json. Los resultados en html se crearán en el directorio `./lib/html_output_files`

## Reflexión 

Reflexiona sobre la solución planteada, los algoritmos implementados y sobre el tiempo de ejecución de estos.

## Análisis de complejidad

Calcula la complejidad de tu algoritmo basada en el número de iteraciones y contrástala con el tiempo obtenido en el punto 7.

En el ámbito de la complejidad temporal, primero debemos de considerar cuánto tarda en ejecutarse una búsqueda con una expresión regular. En este caso consideraremos que la complejidad de cada expresión regular es constante, ya que unicamente estamos buscando cada "token" al inicio de cada línea. 

Teniendo esto en mente, analicemos el algoritmo `json_praser`.
Esta función esta encargada de leer el archivo json y aplicar la función `eachline` para cada línea del archivo. La lectura se realiza en tiempo constante, por lo que la verdadera complejidad temporal de este programa viene en la función `goThroughLine`. La cual toma como argumento cada línea y busca la expresión regular al principio. Esta función se llama recursivamente hasta que la línea se encuentre vacía. Es por esto que la complejidad temporal del algoritmo es `O(n)` en donde `n` es el número de tokens en el json.

## Implicaciones éticas

Agrega además una breve reflexión sobre las implicaciones éticas que el tipo de tecnología que desarrollaste pudiera tener en la sociedad