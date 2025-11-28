# Actividad 7 - Directivas de Reescritura

Consultar ejemplos de redirecciones útiles -> https://www.elarraydejota.com/ejemplos-de-redirecciones-utiles-y-comunes-con-mod_rewrite-para-apache/

## Lleva a cabo los ejercicios propuestos en el siguiente enlace

http://www.josedomingo.org/pledin/2011/10/ejemplos-del-modulo-rewrite-en-apache-2-2/

Todas las configuraciones se realizarán sobre el archivo de configuración global de apache (/etc/apache2.conf), lo recomendable es un .htaccess dentro del directorio determinado, pero son configuraciones para comprobar el funcionamiento de las directivas, por lo que obviamos las buenas prácticas (teniendo conocimiento de ellas).

Antes de empezar a realizar configuraciones de directivas, debemos habilitar el módulo rewrite:

<img width="747" height="94" alt="image" src="https://github.com/user-attachments/assets/9e698349-2199-453c-b9eb-3de3a1fc7017" />


### 1. Reescribir URL

Usamos los módulos RewriteEngine (reescribe y redirige), RewriteBase (desde donde accedemos a la RewriteRule) y RewriteRule (en este caso de operacion.html a operacion.php).

<img width="765" height="210" alt="image" src="https://github.com/user-attachments/assets/d49de85e-ef32-409d-b07f-67bbe0fb765b" />


### 2: Cambiar la extensión de los ficheros

Cambia extensión de ficheros (redirección) hacia el html, no .do.

<img width="771" height="224" alt="image" src="https://github.com/user-attachments/assets/3a602be9-4f23-437b-8cde-bbbba7dad734" />


### 3: Crear URL amigables

En vez de poner la URL de operacion.php tan larga, hacemos una URL amigable con /operador/num1/num2.

<img width="636" height="125" alt="image" src="https://github.com/user-attachments/assets/c9b976a4-4564-4ce5-926d-bfbea3fbfde2" />

Ejemplo:

<img width="609" height="151" alt="image" src="https://github.com/user-attachments/assets/b7ac4cd6-44dc-4cd7-a7e4-6b6c0e64f82f" />


### 4: Acortar URL

Cuando un usuario accede a una URL misitio.com/buscar lo redirige hacia misitio.com/busqueda/buscar.php.

<img width="720" height="152" alt="image" src="https://github.com/user-attachments/assets/e39e7d0b-a6a0-4a66-a4ed-ca59d8784974" />


### 5: Uso del RewriteCond

Solo permite URL provenientes de http://domrrc.local o http://www.domrrc.local, peticiones desde otra dirección no están permitidas para evitar el hotlinking.

<img width="720" height="146" alt="image" src="https://github.com/user-attachments/assets/cb776e0e-1fe7-4454-89fd-b7cdfb826844" />

Comprobamos sintaxis de los cambios, reiniciamos servicio y chequeamos el estado.

<img width="750" height="420" alt="image" src="https://github.com/user-attachments/assets/5bf5c19c-ec6f-4fb3-b775-1ff723d25775" />

