# Parte opcional de la Práctica Servidor Alojamiento Web

La actividad propone crear con Docker un contenedor DNS y al menos un contenedor que actuará como servidor (web, mysql, ssh,...) con su correspondiente red, volúmenes y scripts necesarios para ponerlos en marcha.

## 1. Plantenamiento

En base a lo que pide la actividad, he pensado que podría montar la siguiente infraestructura dentro de Docker:

 · DNS con puerto 5353 en Host y 53 en Contenedor Docker.
 
 · MySQL con puerto 3307 en Host y 3306 en Contenedor Docker.
 
 · Server Web con puerto 8080 en Host y 80 en Contenedor Docker.

Así no "pisamos" los puertos que usa nuestro script en bash, con respecto a los que usará el script que ejecute el compose de docker.

Tendré toda la infra guardada dentro del directorio /home/rafael del servidor, en una carpeta llamada "parte_docker", donde dentro contendrá:

 · Directorio: bind_config
 
 · Directorio: bind_zones
 
 · Directorio: web_data
 
 · Archivo: docker-compose.yml

 · Archivo: setup_docker.sh

# 2. Implementación

Actualizamos los repositorios apt e isntalamos docker junto a docker-compose con el comando ```sudo apt update && sudo apt install docker.io docker-compose -y```

<img width="1212" height="385" alt="image" src="https://github.com/user-attachments/assets/5920c5c0-5400-45fa-b252-ebf879633f6f" />

Habilitamos el servicio de Docker con ```sudo systemctl enable docker``` para que se inicie con el arranque del servidor, lo iniciamos con ```sudo systemctl start docker``` y comprobamos su estado actual con ```sudo systemctl status docker```.

<img width="1208" height="401" alt="image" src="https://github.com/user-attachments/assets/215a7512-99b3-4a12-bfb9-206694c79da9" />

Añadimos nuestro usuario al grupo docker con ```sudo usermod -aG docker rafael```, creamos las carpetas dentro de "/home/rafael" con el comando ```mkdir parte_docker``` y ```mkdir bind_config bind_zones web_data```, por último creamos el archivo "docker-compose.yml" vacío con el comando ```echo "" > docker-compose.yml```.

<img width="1207" height="320" alt="image" src="https://github.com/user-attachments/assets/51425b8d-7b53-403b-840b-ae5dc888e094" />

Creamos el archivo "setup_docker.sh" con el comando ```echo "" > setup_docker.sh``` y asignamos permisos de ejecución con ```chmod +x setup_docker.sh```.

<img width="1213" height="149" alt="image" src="https://github.com/user-attachments/assets/0e197f90-fe27-4383-b2ec-8441881060f8" />

## docker-compose.yml

Dentro del archivo [docker-compose.yml](./docker-compose.yml) desplegamos los servicios DNS Bind9, MySQL con MariaDB y Apache2 con módulo PHP 8.2. Dentro encontramos:

 · DNS Bind9 usando imagen latest. Puerto 5353 en host y 53 en contenedor por TCP y UDP. Volúmenes de configuración y zonas dentro de ./bind_config y ./bind_zones, dentro de red_docker.
 
 · MariaDB usando imagen latest. Puerto 3307 en host y 3306 en contenedor. Volumen nombrado dentro de db_data_extra: (gestionado internamente por Docker, los ":" indica los valores por defecto), dentro de red_docker.
 
 · Apache2 con mod PHP8.2. Puerto 8080 en host y 80 en contenedor. Volúmenes de datos web dentro de ./web_data y perteneciente a red_docker.
 
 · Declaramos la red_docker de tipo bridge (los container se ven entre ellos).
 
 · Declaramos el volumen nombrado para las DB con valores por defecto.

<img width="1201" height="629" alt="image" src="https://github.com/user-attachments/assets/94d7ba4a-753e-4265-a803-6ed2a3efd212" />

##### ACCESO AL ARCHIVO DOCKER-COMPOSE EN FORMATO YAML-> [CLICK AQUÍ](./docker-compose.yml)

## setup_docker.sh

Dentro del archivo [setup_docker.sh](./setup_docker.sh) ejecutamos el docker-compose en modo "detached" y mostramos varios mensajes informativos por pantalla. Dentro de este se ejecutan varias pruebas:

 · Tras desplegar los contenedores, se crea dentro del volumen de la web (./web_data) un index.html con un encabezado h1 que servirá de prueba para ver que el servidor web funcione.

 · Esperamos 15 segundos a que la DB cargue toda la configuración y tenga los servicios iniciados, luego creamos una DB, dentro de esta una tabla, y dentro de la tabla, un valor con un mensaje. Para ello usamos la siguiente estructura: ```docker exec mysql_docker_extra mariadb -u root -p'PASSWORD' -e "SENTENCIA A EJECUTAR DENTRO DE MARIADB"```.

 · Por último, ejecutamos un ```docker ps``` para comprobar el estado de los contenedores e informamos con varios mensajes del acceso a estos contenedores y servicios.

<img width="1207" height="331" alt="image" src="https://github.com/user-attachments/assets/4f5acea4-9eda-43cd-8512-2120cb28b985" />

##### ACCESO AL ARCHIVO QUE DESPLIEGA DOCKER Y HACE PRUEBAS EN FORMATO BASH-> [CLICK AQUÍ](./setup_docker.sh)

# 3. Ejecución

Para ejecutar el script en bash, que como ya sabemos, desplegará todo los contenedores llamado al docker-compose, y además realizará varias pruebas, ejecutamos el comando ```sudo bash setup_docker.sh```. Tal y como podemos ver, primero crea la red_docekr, luego hace un "pull" de todas las imágenes de los contenedores, los despliega y crea los volúmenes. Tras finalizar el despliegue, crea la página de prueba para la web (index.html), muestra los contenedores desplegados ejecutando internamente ```docker ps``` y muestra la configuración del despliegue.

<img width="1214" height="666" alt="image" src="https://github.com/user-attachments/assets/f6fa2e52-c9c4-4022-9f1e-4f77c3061aa8" />

# 4. Comprobación

#### Red docker y puertos host

En el servidor, tal y como hemos ejecutado en el compose, deberíamos tener: Puertos 5353, 8080 y 3007 abiertos dentro del host, es decir, el servidor hosting de la práctica.

Para comprobar esto, usamos el comando ```sudo docker network ls```, donde podemos ver que "red_docker" está correctamente creada. Luego vemos los puertos con el comando ```sudo ss -tulnp | grep puerto``` y vemos que tanto el 5353, como el 8080 y el 3007 están escuchando por el proceso "docker-proxy". Todo OK.

<img width="1209" height="426" alt="image" src="https://github.com/user-attachments/assets/e1c77b01-997a-47a8-8d28-978aba58876c" />

#### Resolución DNS

Para realizar estas pruebas DNS usamos el comando ```dig @127.0.0.1 -p 5353 google.com``` y ```dig @127.0.0.1 -p 5353 8.8.8.8``` donde estaríamos diciendo -> Resuelve la dirección DNS indicada, de manera local por el 127.0.0.1 con el puerto 5353 y dame la respuesta que te brinda este. Vemos que en cada uno de los casos resuelve los registros IN A e IN SOA. Todo OK.

<img width="1207" height="680" alt="image" src="https://github.com/user-attachments/assets/6376077d-2311-4f6f-93c0-b0199490bb6a" />

#### Contenedor Web

Esta pruebas es simple, accedemos al servidor web por el navegador con la dirección IP por el puerto 8080, en este caso "192.168.195.5:8080", vemos que nos responde el servidor web con el contenido del index.html, status 200 OK desde el servidor Apache2/2.4.66. Todo OK.

<img width="1213" height="769" alt="image" src="https://github.com/user-attachments/assets/1025dedb-e7e1-4dd8-b9a2-c80357363b01" />

#### Contenedor MySQL

Usamos el comando ```sudo docker exec -it mysql_docker_extra mariadb -u root -p```, introducimos la contraseña y verificamos:

 · ```SHOW DATABASES;``` -> Vemos DB "db_docker_extra" creada.

 · ```USE db_docker_extra;``` -> Seleccionamos la base de datos para hacer operaciones o consultas sobre esta.

 · ```SHOW TABLES;``` -> Vemos todas las tablas creadas dentro de la DB, está la tabla "prueba".

 · ```SELECT * FROM prueba;``` -> Visualizar todo el contenido dentro de la tabla "prueba", vemos que el campo 1 con valor "DOCKER FUNCIONANDO!" está añadido.

<img width="1208" height="714" alt="image" src="https://github.com/user-attachments/assets/0a3262a5-915d-49a6-883f-1bdf3ffe3fa3" />

Con esto podemos verificar que se han creado todos los contenedores y nuestro script en bash ha realizado todas las pruebas correctamente.
