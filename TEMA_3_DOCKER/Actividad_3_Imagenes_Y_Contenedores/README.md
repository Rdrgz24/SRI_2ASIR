# Práctica 3 - Imágenes y contenedores

## Objetivos de la actividad

 · Descargar, gestionar y administrar las imágenes en Docker

### 1. Descarga la imagen de ubuntu

Descargaríamos la imagen con ```dokcer pull ubuntu```, pero ya la tenemos en el sistema.

<img width="799" height="139" alt="image" src="https://github.com/user-attachments/assets/337f330c-9154-45ba-aeb9-dd9c00a3c360" />

### 2. Descarga la imagen de hello-world

Descargaríamos la imagen con ```docker pull hello-world```, pero ya la tenemos en el sistema.

<img width="796" height="139" alt="image" src="https://github.com/user-attachments/assets/eb6eee0d-3c9f-46c8-a28e-c14036f0b43b" />

### 3. Descarga la imagen nginx

Descargamos la imagen de nginx con ```docker pull nginx```.

<img width="795" height="315" alt="image" src="https://github.com/user-attachments/assets/a174617f-bdee-4dc6-8bea-ded97dd7c5c5" />

Aunque hayamos descargado en todo momento las imágenes con la versión base (que por defecto descarga la última, latest), podemos indicar la versión, por ejemplo, con el comando ```docker pull nginx:1.24``` y bajaría la versión 1.24 en lugar de latestn.

### 4. Muestra un listado de todas la imágenes

Aquí tenemos dos formas de mirarlo, y hacen exactamente lo mismo: ```docker image ls``` o ```docker images```.

<img width="1214" height="427" alt="image" src="https://github.com/user-attachments/assets/796e7ba1-c7b2-42bf-a2d1-8e3b010bc3fb" />

### 5. Ejecuta un contenedor hello-world y dale nombre “myhello1”

Para ejecutar el contenedor con un nombre determinado usamos la sentencia ```docker run --name myhello1 hello-world```.

<img width="1210" height="540" alt="image" src="https://github.com/user-attachments/assets/b06b44b4-9c99-4a4e-9b1f-75c598cffd06" />

### 6. Ejecuta un contenedor hello-world y dale nombre “myhello2”

Repetimos con el mismo comando ```docker run --name myhello2 hello-world```.

<img width="1211" height="539" alt="image" src="https://github.com/user-attachments/assets/e8aae697-8009-411f-935b-6d39966f2840" />

### 7. Ejecuta un contenedor hello-world y dale nombre “myhello3”

Repetimos con el mismo comando ```docker run --name myhello3 hello-world```.

<img width="1214" height="542" alt="image" src="https://github.com/user-attachments/assets/ab66dec2-4e5a-4858-8d17-12d8a857ed16" />

### 8. Muestra los contenedores que se están ejecutando

Aquí hay que aclarar algo, los contenedores que usan la imagen "hello-world" ejecutan su acción (mostrar el mensaje de bienvenida) y se apagan automáticamente. Aunque intentemos hacer comandos como ```docker start``` están preparados para apagarse tras su ejecución. Por lo que, usar ```docker ps``` será nulo en todo momento.

En esta imagen se puede ver mejor lo que explico:

<img width="1214" height="586" alt="image" src="https://github.com/user-attachments/assets/587701f0-d932-40d8-bda3-cb7d610f564e" />

### 9. Para el contenedor "myhello1”

Aunque ya se para automáticamente, esto se haría con ```docker stop myhello1```.

<img width="1214" height="147" alt="image" src="https://github.com/user-attachments/assets/8f62689e-a89f-4598-8032-5ce805cffc6c" />

### 10. Para el contenedor "myhello2”

Aunque ya se para automáticamente, esto se haría con ```docker stop myhello2```.

<img width="1216" height="141" alt="image" src="https://github.com/user-attachments/assets/2c980dac-53d9-46f1-b641-c5328d670ae5" />

### 11. Borra el contenedor “myhello1”

Como ya está parado, podemos eliminarlo directamente con el comando ```docker rm myhello1``` sin necesidad de usar la sentencia ```-f``` y forzar el borrado. Comprobamos que se ha borrado con ```docker ps -a```.

<img width="1212" height="295" alt="image" src="https://github.com/user-attachments/assets/8b57485a-a5cb-4534-97ae-10eafcb4e9d9" />

### 12. Muestra los contenedores que se están ejecutando.

Volvemos a lo mismo que dije anteriormente, los hello-world no se mantienen en ejecución continua, por lo que obviamos este apartado y mostramos un ```docker ps -a```.

<img width="1211" height="291" alt="image" src="https://github.com/user-attachments/assets/3dee70d2-379c-4f43-bfe4-d00179881995" />

### 13. Borra todos los contenedores

Voy a suponer que la cuestión se refiere a borrar los creados en esta práctica. Por lo que queda borrar "myhello2" y "myhello3", lo borramos con ```docker rm myhello2 myhello3```, y sí, podemos borrar ambos juntos.

<img width="1215" height="273" alt="image" src="https://github.com/user-attachments/assets/ed01c0ea-e597-4714-b338-9aad2e3523b0" />
