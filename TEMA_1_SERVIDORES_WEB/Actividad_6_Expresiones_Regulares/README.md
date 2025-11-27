# Actividad Expresiones Regulares

## Realizar los ejercicios propuestos.

### Directorios en /www/ cuyo nombre consista en tres dígitos

Podríamos utilizar -> ```/www/\d{3}``` -> Dentro de la carpeta /www/ busca con d (dígitos) {3} totales.

### Ficheros: *.gif, *.jpeg, *.jpg, *.png

```.+.(gif | jpe?g |png )``` -> Cualquier nombre acabado en .gif o .jpg / jpeg indicando con ? que la letra "e" es opcional o png.

### Escribe una directiva para redireccionar todos los GIF a ficheros JPEG en otro servidor

RedirectMatch ```"(.*)\.gif$" "$1.jpeg"``` -> Cualquier caracter en cualquier ruta con (.*) convertido al nombre recogido con $1.

### Números enteros y decimales

```\d*(\.\d+)?``` -> Cualquier dígito del 0 al 9, seguido de un "." con ? indicando que puede ser opcional cualquier digito decimal posterior al punto. 

### Números de teléfono en el formato Americano: 123-123-1234

```\d{3}-\d{3}-\d{4}``` -> Pedir tres dígitos en el primer bloque, otros tres en el segundo y cuatro en el tercero separado por guiones.

### Palabras

```\b[a-zA-Z]+\b``` -> Obligamos que empiece o termine con \b e indicamos letras de la a-z minúscula o A-Z mayúscula.

### Códigos hexadecimales de color de 24 o 32 bits

```^#(?:[A-Fa-f0-9]{6}|[A-Fa-f0-9]{8})$``` -> Más complejo. En este caso indicamos que empiece por # seguido de dos puntos opcionales y el formato A-Fa-f0-9 con 6 dígitos (24 bits).
Posteriormente indicamos que también puede tener el mismo formato pero de 8 dígitos (32 bits). Con | indicamos "OR".

### Palabras de 4 letras

```\b[A-Za-z]{4}\b``` -> Cualquier palabara (sin números) que empiece y acabe por A-Za-z y además contenga 4 letras indicamos con {4}. 

### Número entero sin signo

```^\d+``` -> Obligamos que empiece por el dígito, lo que evita que tenga signo, luego indicamos uno o más dígitos.

### Número entero con signo

```^[+-]?\d+``` -> Obligamos que empiece por + o - (signos) e inidcamos uno o más dígitos.

¿Debería ponerse $ al final para indicar fin de cadena? -> A mi me funciona sin el.

### Números reales

```[-+]?\d*(\.\d+)?``` -> Interpreta por números reales números con -+ con cualquier dígito seguido de decimales o no.

### Número reales con exponente

```[-+]?\d*(\.\d+)?([eE]\d+)?``` -> Igual expresiones que números reales pero añadiendo "e o E" seguido de un dígito o más.

### Email

```\b[\w\.-]+@[\w\.-]+\.\w\b``` -> \w indica cualquier letra, dígito o guión bajo. Indicamos que empiece por cualquiera de estos, seguido de un @ y más letras (concatenamos con +).
Por último se indica con .\w\b que debe terminar en .com, .es, .net, o cualquier dominio.

### Números del 0 a 255

```^(25[0-5]|2[0-4]0\d|1\d\d|[1-9]?\d)$``` -> Indicamos con 25[0-5] de 250 a 255, con 2[0-4]0 de 200 a 240, con | ingresamos un OR, indicamos 1\d\d de 100 a 199 y [1-9]?\ indicamos del 1 al 9 seguido de un dígito
indicando realmente del 0 al 99 con ^ indicamos que empiece por... y con $ que termine la cadena ahí (no puede haber nada después).
