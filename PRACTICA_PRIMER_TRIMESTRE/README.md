# PRÁCTICA PRIMER TRIMESTRE 2025 - SERVIDORES WEB

## Vamos a instalar un servidor web interno para un instituto. Se Pide:

### Instalación del servidor web apache. Usaremos dos dominios mediante el archivo hosts: centro.intranet y departamentos.centro.intranet. El primero servirá el contenido mediante wordpress y el segundo una aplicación en python.

Primero instalaremos y habilitaremos Apache2 en nuestro servidor con el comando ```sudo apt update``` (recargar repositorio) y ```sudo apt install apache2``` (instalar Apache).

Tras finalizar la instalación, habilitamos e iniciamos el servicio con ```sudo systemctl enable apache2``` y ```sudo systemctl start apache2```.

### Activar los módulos necesarios para ejecutar php y acceder a mysql.

wasd 

### Instala y configura wordpress.

wasd 

### Activar el módulo “wsgi” para permitir la ejecución de aplicaciones Python.

wasd 

### Crea y despliega una pequeña aplicación python para comprobar que funciona correctamente.

wasd 

### Adicionalmente protegeremos el acceso a la aplicación python mediante autenticación.

wasd 

### Instala y configura awstat.

wasd 

### Instala un segundo servidor de tu elección (nginx, lighttpd) bajo el dominio “servidor2.centro.intranet”. Debes configurarlo para que sirva en el puerto 8080 y haz los cambios necesarios para ejecutar php. Instala phpmyadmin.
