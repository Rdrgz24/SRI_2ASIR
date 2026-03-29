#!/bin/bash

echo "Iniciando despliegue de Infraestructura Docker..."

docker-compose up -d

echo "Creando página de prueba para la web"

echo "<h1>Servidor Web en Docker (Vía puerto 8080)</h1>" > ./web_data/index.html

echo "Esperando servicio de MySQL"
sleep 15
docker exec mysql_docker_extra mariadb -u root -p'PWD5QL5€CURe' -e "CREATE DATABASE IF NOT EXISTS db_docker_extra;"
docker exec mysql_docker_extra mariadb -u root -p'PWD5QL5€CURe' -e "CREATE TABLE db_docker_extra.prueba (id INT, valor VARCHAR(25));"
docker exec mysql_docker_extra mariadb -u root -p'PWD5QL5€CURe' -e "INSERT INTO db_docker_extra.prueba VALUES(1, 'DOCKER FUNCIONANDO!');"

echo "Mostrando contenedores desplegados:"
docker ps

echo "Infra desplegada con éxito"
echo "Web: http://192.168.195.5:8080"
echo "DNS: Puerto 5353 en Server"
echo "MySQL: Puerto 3307 en Server"
