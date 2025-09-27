# Actividad 0.5 - Práctica Servidor Web 

## Ejemplo de servidores web en python



Este repositorio contiene varios ejemplos de servidores web simples en Python.
Se usa el mismo [index](index.html) para todos los casos.

## Contenido del Repositorio

### 1. Simple Web Server (http.server)

· Con python instalado en nuestra máquina, ejecutamos el servidor web predeterminado de python usando el siguiente código:
```
python -m http.server 8000
```
Este código hay que ejecutarlo en la misma carpeta donde se ubique el index.html

<img width="700" height="500" alt="image" src="https://github.com/user-attachments/assets/bbc799d9-3a6b-46cd-9eac-af60e7e27cfd" />


### 2. Servidor web simple con código en archivo .py

· En nuestra máquina, ahora debemos crear una archivo [simple_web_server.py](simple_web_server.py) con código que permite iniciar un servidor web a través de códigp python.

<img width="648" height="305" alt="image" src="https://github.com/user-attachments/assets/7e80ee89-e471-4b09-b07d-c2a3ed51e11e" />

Este archivo de ser ejecutado en la misma carpeta donde se ubique el index.html


### 3. Servidor web usando dummy con código en archivo .py

En nuestra máquina, creamos un archivo [dummy_server.py](dummy_server.py) que es mucho más corto que el servidor web anterior, ya que usa el módulo estándar http.server y permite modificar la configración fácilmente.

<img width="636" height="311" alt="image" src="https://github.com/user-attachments/assets/3e5a863f-18e3-4d94-943f-cf47ae61aafc" />

Debemos ejecutar el servidor en la misma carpeta donde se ubique index.html

## Conclusiones

Realizar esta actividad ha permitido comprobar cómo Python puede montar servidores web de forma rápida y eficiente, sin necesidad de configuraciones complejas ni herramientas externas. 
Utilizarlo, resulta útil sobre todo en entornos de prueba, compartir archivos de manera sencilla o incluso para levantar servicios temporales.
