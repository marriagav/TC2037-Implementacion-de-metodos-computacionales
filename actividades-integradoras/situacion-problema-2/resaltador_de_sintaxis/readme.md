## Reporte: Actividad Integradora 5.3 Resaltador de sintaxis paralelo 

### Miguel Arriaga - A01028570

### Pablo Rocha - A01028638

## Instrucciones para correr el programa
### Para correr los tests:
Correr `mix test` en el directorio raíz del proyecto para parsear todos los archivos json. Los resultados en html se crearán en el directorio `./lib/html_output_files`
Este test va a correr el programa, primero con la función que utiliza concurrencia, y posteriormente con la función que no utiliza concurrencia. Además, imprimirá el tiempo de ejecución de cada una de estas funciones.
### Para llamar la función:
La función para parsear archivos JSON utilizando concurrencia se llama `multi_parser`, esta función se encuentra en el módulo `ResaltadorDeSintaxis` en el archivo `resaltador_de_sintaxis.ex` en el directorio `lib` y contiene 2 argumentos:
<ul>
    <li>dir: El path/nombre del directorio en donde se encuentran todos los archivos json que quieres parsear</li>
    <li>template: El path/nombre de el documento del html que se usa como template</li>
</ul>

Por lo tanto, un ejemplo para llamar la función sería:
`ResaltadorDeSintaxis.multi_parser("./lib/test_json_files/*.json","./lib/template_page.html") end)`

En donde:
<ul>
    <li>dir: "./lib/test_json_files/*.json"</li>
    <li>template: "./lib/template_page.html"</li>
</ul>

## Reflexión
La concurrencia es una herramienta muy poderosa que nos permite resolver problemas muy complejos que no se podrían resolver de forma secuencial. Esto se debe a que al programar de esta manera se aprovechan más recursos de la computadora para dividir el programa en diferentes "cores" o "hilos".

## Análisis de complejidad
Al igual que en la situación problema anterior, la complejidad temporal del algoritmo es `O(n)` en donde `n` es el número de tokens en el json, ya que en realidad se utilizó el mismo algoritmo. Sin embargo, en este caso es ejecutado de manera concurrente, lanzando diferentes threads, uno para cada archivo. Es por esto que el algoritmo corre mucho más rápido en esta ocasión.

Después de correr el programa 5 veces de forma concurrente y 5 veces de forma secuencial en una laptop personal (Procesador Intel CORE i5 vPro de octava generación), se midieron y compararon los tiempos de ejecución promedio para cada caso, estos fueron los resultados obtenidos:

<ul>
    <li>Con concurrencia: 0.0828596 segundos en promedio</li>
    <li>Sin concurrencia: 0.2310508 segundos en promedio</li>
</ul>

Como se puede observar, el programa se ejecuto 0.1481912 segundos más rápido (en promedio) cuando se ejecuto con concurrencia en comparación con su ejecución sin concurrencia. Esto representa una diferencia de velocidad del 35%. Adicionalmente, esta es una diferencia que solo se hace mayor conforme mayor sea el número de archivos que se vayan a parsear.

## Implicaciones éticas
A pesar de que esta sea una técnica de programación que puede acelerar muchísimo el tiempo de ejecución de un programa, también requiere de más recursos computacionales. Nos impulsa a cada vez utilizar más energía y procesadores más veloces. Es un hecho que estamos viviendo en una época de crisis ambiental y calentamiento global. 

Estos chips de procesamiento cada vez contaminan más y utilizan más energía. Es por esto que a pesar de que exista y utilicemos a la programación concurrente, como programadores debemos de pensar e implementar las soluciones más eficientes posibles.
