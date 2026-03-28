# Parte opcional de la Práctica Servidor Alojamiento Web

La actividad propone crear con Docker un contenedor DNS y al menos un contenedor que actuará como servidor (web, mysql, ssh,...) con su correspondiente red, volúmenes y scripts necesarios para ponerlos en marcha.

## 1. Plantenamiento

En base a lo que pide la actividad, he pensado que podría montar la siguiente infraestructura dentro de Docker:

 · DNS con puerto 5353 en Host y 53 en Contenedor Docker.
 
 · MySQL con puerto 3307 en Host y 3306 en Contenedor Docker.
 
 · Server Web con puerto 8080 en Host y 80 en Contenedor Docker.

Así no "pisamos" los puertos que usa nuestro script en bash con los que usará el script que ejecute el compose de docker.

Tendremos toda la infra guardada dentro del directorio /home/rafael del servidor, en una carpeta llamada "parte_docker", donde dentro contendrá:

 · Directorio: bind_config
 
 · Directorio: bind_zones
 
 · Directorio: web_data
 
 · Archivo: docker-compose.yml

# 2. Implementación

