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

Docker-compose.yml

<img width="1202" height="626" alt="image" src="https://github.com/user-attachments/assets/238cc44f-d8cb-4f57-b001-08fcf990c480" />

