# PRÁCTICA PRIMER TRIMESTRE 2025 - SERVIDORES WEB

## Vamos a instalar un servidor web interno para un instituto. Se Pide:

### Instalación del servidor web apache. Usaremos dos dominios mediante el archivo hosts: centro.intranet y departamentos.centro.intranet. El primero servirá el contenido mediante wordpress y el segundo una aplicación en python.

Primero instalaremos y habilitaremos Apache2 en nuestro servidor con el comando ```sudo apt update``` (recargar repositorio) y ```sudo apt install apache2``` (instalar Apache).

<img width="1229" height="284" alt="image" src="https://github.com/user-attachments/assets/75c8bf2e-c1e1-4d59-b48a-485bc5ed355f" />

Tras finalizar la instalación, habilitamos e iniciamos el servicio con ```sudo systemctl enable apache2``` y ```sudo systemctl start apache2```.

<img width="800" height="550" alt="image" src="https://github.com/user-attachments/assets/b48062d0-0f24-41d3-9b11-c7e4410914c8" />

Luego, editamos el archivo hosts con el comando ```sudo nano /etc/hosts``` y añadimos la dirección IP local con los dominios "centro.intranet" para WP, "departamentos.centro.intranet" para el programa de Python y "servidor2.centro.intranet" para nginx con phpmyadmin.

<img width="820" height="92" alt="image" src="https://github.com/user-attachments/assets/349c533d-cd61-4076-9f58-67e3b7081eb2" />

Antes de saltar al siguiente paso, comprobamos que los dominios han sido añadidos correctamente y están funcionales enviando paquetes ICMP (ping).

<img width="600" height="420" alt="image" src="https://github.com/user-attachments/assets/7fc2783d-b7b6-4530-8f43-5dba828267f5" />

### Activar los módulos necesarios para ejecutar php y acceder a mysql.

Primero instalamos PHP y los módulos necesarios con el comando ```sudo apt install php libapache2-mod-php php-mysql php-cli php-gd php-xml php-mbstring``` y reiniciamos el servicio de apache con ```sudo systemctl restart apache2```:



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
