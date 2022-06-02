## Reporte: Actividad Integradora 

### Miguel Arriaga - A01028570

### Pablo Rocha - A01028638

## Instrucciones para correr el programa
### Para correr los tests:
Correr `mix test` en el directorio raíz del proyecto para parsear todos los archivos json. Los resultados en html se crearán en el directorio `./lib/html_output_files`
Este test va a correr el programa, primero con la función que utiliza concurrencia, y posteriormente con la función que no utiliza concurrencia. Además, imprimirá el tiempo de ejecución de cada una de estas funciones.
### Para llamar la función:
La función para parsear arhivos JSON utilizando concurrencia se llama `multi_parser`, esta función se encuentra en el módulo `ResaltadorDeSintaxis` en el archivo `resaltador_de_sintaxis.ex` en el directorio `lib` y contiene 2 argumentos:
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

## Análisis de complejidad

## Implicaciones éticas

