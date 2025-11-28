# Actividad 8 - Configurando VirtualHost

## Lee el artículo siguiente y lleva a cabo la práctica propuesta:

https://www.digitalocean.com/community/tutorials/como-configurar-virtual-host-de-apache-en-ubuntu-14-04-lts-es

### Paso Uno - Crear la Estructura del Directorio

Creamos la estructura de directorios que contendrán la información de nuestro sitio, para ello usamos los comandos ```sudo mkdir -p /var/www/ejemplo.com/public_html``` y ```sudo mkdir -p /var/www/pruebas.com/public_html```:

<img width="894" height="237" alt="image" src="https://github.com/user-attachments/assets/0ca4dfdf-8a63-4fa1-8987-36c04efc951b" />

### Paso Dos - Otorgar Permisos

Tras crear estos directorios, root es el propietario, por lo que vamos a modificar los permisos para que nuestro usuario regular pueda hacer modificaciones sobre ellos, insertamos los siguientes comandos: ```sudo chown -R $USER:$USER /var/www/ejemplo.com/public_html``` y ```sudo chown -R $USER:$USER /var/www/pruebas.com/public_html```, por último ```sudo chmod -R 755 /var/www``` para asignar los permisos adecuados.

<img width="1014" height="183" alt="image" src="https://github.com/user-attachments/assets/e93a92e2-704f-42f6-bc09-cd8a48859f8b" />

### Paso Tres — Crear una Página de Prueba para cada Virtual Host

Creamos un archivo en HTML para comprobar que el sitio funciona correctamente con ```sudo nano /var/www/ejemplo.com/public_html/index.html``` y ```sudo nano /var/www/pruebas.com/public_html/index.html```:

<img width="741" height="201" alt="image" src="https://github.com/user-attachments/assets/fb9c485d-158d-4674-9bda-a8810fef4963" />

<img width="740" height="207" alt="image" src="https://github.com/user-attachments/assets/91a692b9-d25b-4c71-9759-38ace3df670a" />

### Paso Cuatro — Crear Nuevos Archivos Virtual Host

Apache incluye un archivo para VirtualHost por defecto llamado 000-default.conf, vamos a copiarlo para el VirtualHost ejemplo.com y lo editaremos:

<img width="1094" height="88" alt="image" src="https://github.com/user-attachments/assets/22f651c3-60ae-43e8-bfb8-da129a88b023" />

Resultado final de las modificaciones en ejemplo.com.conf:

<img width="790" height="415" alt="image" src="https://github.com/user-attachments/assets/81d30c66-a234-4243-a0e4-defc243642f7" />

Copiamos el archivo de VirtualHost ejemplo.com.conf para pruebas.com.conf:

<img width="1090" height="91" alt="image" src="https://github.com/user-attachments/assets/59f25da8-419c-4fc0-8b71-fd037c9527ac" />

<img width="777" height="431" alt="image" src="https://github.com/user-attachments/assets/c166b428-ead0-4826-a9b6-ef40f6372a4e" />

### Paso Cinco — Habilita los nuevos Archivos Virtual Host

Habilitamos los nuevos archivos VirtualHost con el comando ```sudo a2ensite nombremodulo.conf``` y reiniciamos el servicio con ```sudo systemctl restart apache2```.

<img width="862" height="549" alt="image" src="https://github.com/user-attachments/assets/7d2c8d43-6e43-47ff-b579-7c8decb64be2" />

### Paso Seis — Configurar Archivos Locales

Añadimos en el fichero /etc/hosts los nombres "servidor.com" y "pruebas.com" simulando un nombre DNS con el que nos podremos conectar en local a nuestros VirtualHost.

<img width="631" height="84" alt="image" src="https://github.com/user-attachments/assets/f9190d72-8d82-4e20-b105-d20fa9b78869" />

### Paso Siete - Probar resultados

Accedemos al navegador e ingresamos la dirección http://servidor.com -> Se conecta al VirtualHost servidor.com.conf.

<img width="900" height="164" alt="image" src="https://github.com/user-attachments/assets/fbc4b4ef-68c3-43a4-85fb-973d11334214" />

Accedemos al navegador e ingresamos la dirección http://pruebas.com -> Se conecta al VirtualHost pruebas.com.conf.

<img width="908" height="167" alt="image" src="https://github.com/user-attachments/assets/6946fcce-80bd-4579-adfb-952beccd0fe5" />
