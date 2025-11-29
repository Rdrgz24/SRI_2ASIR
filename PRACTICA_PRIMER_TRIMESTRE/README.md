# PRÁCTICA PRIMER TRIMESTRE 2025 - SERVIDORES WEB

En esta práctica se simulará el servidor web interno para un instituto, donde se alojará un sitio con WordPress usando Apache, un pequeño programa en Python y phpmyadmin usando Nginx.

## 1. Instalación del servidor web apache. Usaremos dos dominios mediante el archivo hosts: centro.intranet y departamentos.centro.intranet. El primero servirá el contenido mediante wordpress y el segundo una aplicación en python.

Primero instalaremos y habilitaremos Apache2 en nuestro servidor con el comando ```sudo apt update``` (recargar repositorio) y ```sudo apt install apache2``` (instalar Apache).

<img width="1229" height="284" alt="image" src="https://github.com/user-attachments/assets/75c8bf2e-c1e1-4d59-b48a-485bc5ed355f" />

Tras finalizar la instalación, habilitamos e iniciamos el servicio con ```sudo systemctl enable apache2``` y ```sudo systemctl start apache2```.

<img width="800" height="550" alt="image" src="https://github.com/user-attachments/assets/b48062d0-0f24-41d3-9b11-c7e4410914c8" />

Luego, editamos el archivo hosts con el comando ```sudo nano /etc/hosts``` y añadimos la dirección IP local con los dominios "centro.intranet" para WP, "departamentos.centro.intranet" para el programa de Python y "servidor2.centro.intranet" para nginx con phpmyadmin.

<img width="820" height="92" alt="image" src="https://github.com/user-attachments/assets/349c533d-cd61-4076-9f58-67e3b7081eb2" />

Antes de saltar al siguiente paso, comprobamos que los dominios han sido añadidos correctamente y están funcionales enviando paquetes ICMP (ping).

<img width="600" height="420" alt="image" src="https://github.com/user-attachments/assets/7fc2783d-b7b6-4530-8f43-5dba828267f5" />

## 2. Activar los módulos necesarios para ejecutar php y acceder a mysql.

### Instalando PHP

Primero instalamos PHP y los módulos necesarios con el comando ```sudo apt install php libapache2-mod-php php-mysql php-cli php-gd php-xml php-mbstring```.

<img width="1026" height="373" alt="image" src="https://github.com/user-attachments/assets/459b2696-ff5c-4747-a7a3-72ec5fb8a1c7" />

### Instalando y configurando MySQL (MariaDB)

Posteriormente, instalamos mysql con el comando ```sudo apt install mariadb-server mariadb-client``` y configuramos con ```sudo mysql_secure_installation```.

<img width="996" height="534" alt="image" src="https://github.com/user-attachments/assets/f459338d-6cc8-4e51-ace8-3be291f10212" />

Realizamos la configuración inicial de MySQL:

<img width="545" height="729" alt="image" src="https://github.com/user-attachments/assets/d0b8d2ad-5f27-4b2c-b68b-3569fc706c39" />

Tras realizar todos estos cambios reiniciamos el servicio de apache con el comando ```sudo systemctl restart apache2```.

<img width="838" height="34" alt="image" src="https://github.com/user-attachments/assets/5f333e69-9c3e-4c77-a154-67e9f1f0ee6e" />

## 3. Instala y configura wordPress.

### Creando el VirtualHost para centro.intranet (WordPress)

Creamos el directorio con los comandos ```sudo mkdir -p /var/www/centro.intranet``` y cambiamos de propietario a nuestro usuario con ```sudo chown -R $USER:$USER /var/www/centro.intranet```.

<img width="1025" height="54" alt="image" src="https://github.com/user-attachments/assets/4c9a20e1-596b-475e-8c04-ba0d958e9f00" />

Creamos el VirtualHost con ```sudo nano /etc/apache2/sites-available/centro.intranet.conf``` e insertamos la siguiente información.

<img width="792" height="303" alt="image" src="https://github.com/user-attachments/assets/64b6a3c7-5b9a-4094-941b-c5fbb00747ff" />

Tras crear el VirtualHost, toca habilitarlo y recargar el servicio de Apache usando ```sudo a2ensite centro.intranet.conf``` junto a ```sudo a2enmod rewrite``` y por último ```sudo systemctl reload apache2```.

<img width="867" height="222" alt="image" src="https://github.com/user-attachments/assets/070e3bb0-9cd1-45e8-887c-b9abf60010e9" />

### Descargar WordPress y asignar ubicación

Para descargar e instalar WordPress debemos descargarlo de la página oficial dentro de /tmp (carpeta temporal), usamos el comando ```cd /tmp``` y ```wget https://wordpress.org/latest.tar.gz```:

<img width="988" height="338" alt="image" src="https://github.com/user-attachments/assets/28e5325d-d26e-435d-8e59-344afb8e21a9" />

Descomprimimos el archivo  y lo movemos hacia la ubicación del VirtualHost con los comandos ```tar -xf latest.tar.gz``` y ```sudo mv wordpress/* /var/www/centro.intranet/```:

<img width="1014" height="182" alt="image" src="https://github.com/user-attachments/assets/89436b21-1da3-4b8c-a182-eab2009aa072" />

Cambiamos el propietario y asignamos los permisos necesarios con los comandos ```sudo chown -R www-data:www-data /var/www/centro.intranet``` y ```sudo chmod -R 755 /var/www/centro.intranet```.

<img width="1089" height="49" alt="image" src="https://github.com/user-attachments/assets/5ddeede4-7502-486f-8a1a-295b0325ec9e" />

### Crear la base de datos

Accedemos a MySQL con el comando ```sudo mysql -u root -p``` e insertamos las siguientes líneas de comando:

<img width="967" height="534" alt="image" src="https://github.com/user-attachments/assets/ccc744ee-d4ba-4c7a-93be-430019756447" />

### Configurando WordPress

Accedemos a la URL http://centro.intranet y realizamos la configuración de WordPress:

Elegimos el idioma:

<img width="700" height="500" alt="image" src="https://github.com/user-attachments/assets/0cc457a0-80be-4c96-ad4b-fda6992fca7a" />

Insertamos la información correspondiente a la base de datos creada anteriormente:

<img width="700" height="505" alt="image" src="https://github.com/user-attachments/assets/0f8c4fd3-f696-43d3-a54b-72199739b34c" />

Nos informa de una correcta conexión con la base de datos:

<img width="700" height="300" alt="image" src="https://github.com/user-attachments/assets/b6717ac9-9b76-488c-93ef-4e851c1ccb52" />

Rellenamos la información pertinente para la instalación de WordPress:

<img width="700" height="500" alt="image" src="https://github.com/user-attachments/assets/b9b4213f-6e65-4f73-9b19-47fd9fa010de" />

Instalación y configuración de WordPress completada:

<img width="700" height="303" alt="image" src="https://github.com/user-attachments/assets/737099b4-ddf1-4fa1-a325-06597246b8d6" />

Página de inicio:

<img width="700" height="500" alt="image" src="https://github.com/user-attachments/assets/959ded8b-5b47-465e-af33-5d7f78854222" />

## 4. Activar el módulo “wsgi” para permitir la ejecución de aplicaciones Python.

Instalamos el módulo desde los repositorios APT con el comando ```sudo apt install libapache2-mod-wsgi-py3```, habilitamos el módulo con ```sudo a2enmod wsgi``` y reiniciamos el servicio de Apache ```sudo systemctl restart apache2```.

<img width="800" height="430" alt="image" src="https://github.com/user-attachments/assets/6ac91cfc-079b-4f8c-8fbd-6ba70534e57f" />

## 5. Crea y despliega una pequeña aplicación python para comprobar que funciona correctamente.

Primero creamos la carpeta y el archivo de python:

<img width="700" height="50" alt="image" src="https://github.com/user-attachments/assets/094c18df-c258-46c1-bd63-b672b6c57510" />

### Creando pequeña aplicación python

En esta "aplicación" se muestra un mensaje de bienvenida (es con python pero tiene extensión wsgi).

<img width="747" height="212" alt="image" src="https://github.com/user-attachments/assets/b26a1d57-30b1-4f7e-9f5c-1513d30dd1ef" />

def application(environ, start_response):
    status = '200 OK'
    output = b"Hola desde la aplicación Python con WSGI"

    headers = [('Content-type', 'text/plain')]
    start_response(status, headers)

    return [output]

### Creando VirtualHost

Creamos el archivo de configuración con el comando ```sudo nano /etc/apache2/sites-available/departamentos.conf``` e introducimos:

<img width="811" height="261" alt="image" src="https://github.com/user-attachments/assets/b724dd8f-78c5-4a04-801b-fe54594d3d6f" />

Habilitamos el sitio y recargamos el servicio de apache con ```sudo a2ensite departamentos.conf``` y ```sudo systemctl reload apache2```.

<img width="846" height="114" alt="image" src="https://github.com/user-attachments/assets/194878f3-b458-46bc-be39-6785c8596538" />

## Adicionalmente protegeremos el acceso a la aplicación python mediante autenticación.

wasd 

## Instala y configura awstat.

wasd 

## Instala un segundo servidor de tu elección (nginx, lighttpd) bajo el dominio “servidor2.centro.intranet”. Debes configurarlo para que sirva en el puerto 8080 y haz los cambios necesarios para ejecutar php. Instala phpmyadmin.
