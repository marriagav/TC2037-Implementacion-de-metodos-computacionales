## Reporte: Actividad Integradora 3.4 Resaltador de sintáxis

### Miguel Arriaga - A01028570

### Pablo Rocha - A01028638

## Instrucciones para correr el programa

Correr `mix test` en el directorio raíz del proyecto para parsear todos los archivos json. Los resultados en html se crearán en el directorio `./lib/html_output_files`

## Reflexión

Se puede concluir que la solución planteada es concisa y optima. El equipo eligió parsear el lenguaje JSON, esto debido a dos factores, el primero su simplicidad y bajo número número de tokens, el segundo siendo su amplio uso en el mundo de la programación. JSON es el lenguaje universal para pasar información en métodos GET,PUT PUSH, etc. Los tolkens que identifico el equipo fueron:

<ul>
    <li>LLaves: estas se componen de strings, en su interior pueden contener cualquier character</li>
    <li>Strings: Son caracteres delimitados por comillas
    </li>
    <li>Números
    </li>
    <li>Palabras Reservadas: Estas son especificas del lenguaje palabras como true,false, null.
    </li>
    <li>Puntuación: Son símbolos de puntuación específicos de JSON, estos incluyen: []{}.,
    </li>
</ul>

Sobre complejidad la solución plantada tiene una gran implementación ya que tiene complejidad de O(n) donde n es el número de tolkens que se encuentran en el documento.

## Análisis de complejidad

En el ámbito de la complejidad temporal, primero debemos de considerar cuánto tarda en ejecutarse una búsqueda con una expresión regular. En este caso consideraremos que la complejidad de cada expresión regular es constante, ya que unicamente estamos buscando cada "token" al inicio de cada línea.

Teniendo esto en mente, analicemos el algoritmo `json_praser`.
Esta función esta encargada de leer el archivo json y aplicar la función `eachline` para cada línea del archivo. La lectura se realiza en tiempo constante, por lo que la verdadera complejidad temporal de este programa viene en la función `goThroughLine`. La cual toma como argumento cada línea y busca la expresión regular al principio. Esta función se llama recursivamente hasta que la línea se encuentre vacía. Es por esto que la complejidad temporal del algoritmo es `O(n)` en donde `n` es el número de tokens en el json.

## Implicaciones éticas

Agrega además una breve reflexión sobre las implicaciones éticas que el tipo de tecnología que desarrollaste pudiera tener en la sociedad