# Actividad 1.1 - Instalación de Apache (Pila LAMP)

## Preguntas

### 1. La arquitectura Web es un modelo compuesto de tres capas, ¿cuáles son y cuál es  la función de cada una de ellas?
---------------------------
Esta arquitectura predomina en las aplicaciones cliente-servidor tradicionales, está compuesta por:

· Nivel de presentación
---------------------------
Es la interfaz donde el usuario final se comunica e interactua con la aplicación. Su objetivo es mostrar la información al usuario y recopilar datos de este.

Este nivel se puede ejecutar en un navegador web, una aplicación de escritorio o una interfaz gráfica (GUI). Esta capa se suele desarrollar en HTML, CSS y JavaScript.

· Nivel de aplicación
---------------------------
Conocido nivel lógico o medio, es el núcleo de la aplicación; procesa la información recopilada en el nivel de presentación y utilizando la "lógica empresarial" y un conjunto de reglas comerciales se manda información al nivel de datos. 

Esta capa se suele desarrollar en Python, Perl, Java, PHP o Ruby; se comunica con el nivel de datos mediante las API.  

· Nivel de datos
---------------------------
Conocido como nivel de acceso a datos o backend, es donde se almacena y gestiona la información procesada por la aplicación. 

Puede integrar un sistema relacional de administración de bases de datos como MySQL, PostgreSQL, MariaDB, Oracle, DB2 o Microsoft SQL Server; O un servidor NoSQL de bases de datos como Cassandra,CouchDB o MongoDB.


### 2. Una plataforma web es el entorno de desarrollo de software empleado para  diseñar y ejecutar un sitio web; destacan dos plataformas web, LAMP y WISA. Explica en qué consiste cada una de ellas.

**LAMP (Linux, Apache, MySQL, PHP/Python/Perl)**

Plataforma web de código abierto ampliamente utilizada para desarrollar y ejecutar sitios web dinámicos.

· **L**inux como sistema operativo.

· **A**pache como servidor web para procesar solicitudes HTTP/HTTPS.

· **M**ySQL como sistema gestor de bases de datos.

· **P**HP/Python/Perl para programar la lógica de la aplicación.

**WISA (Windows, IIS, SQL Server, ASP.NET)**

Plataforma web basada en tecnologías propietarias de Microsoft, diseñada para entornos corporativos o sistemas preferentes de esta compañía.

· **W**indows como sistema operativo.

· **I**IS (Internet Information Services) como servidor web de Microsoft.

· **S**QL Server para la gestión de bases de datos de Microsoft.

· **A**SP.NET como Framework para crear aplicaciones web dinámicas en .NET.


## Instalación de pila LAMP en Ubuntu 24.04
La pila “LAMP” se refiere al conjunto de aplicaciones software que se instalan juntas para que un servidor permita alojar aplicaciones y sitios web dinámicos escritos en PHP. 
El término en realidad se refiere al Sistema Operativo "Linux" junto al servidor web "Apache", almacenando los datos en una base de datos "MySQL" y procesando el contenido dinámico mediante "PHP".

## Pasos de Instalación
**1. Instalar Apache y actualizar el firewall**  
-----------------------------------------------
Actualizamos la lista de paquetes disponibles con el comando:
```
sudo apt update
```
Instalamos apache2:
```
sudo apt install apache2 -y
```
Listamos las aplicaciones conocidas por el cortafuegos UFW:
```
sudo ufw app list
```
Permitimos el tráfico hacia Apache usando la regla:
```
sudo ufw allow in "Apache"
```
Habilitamos el cortafuegos y comprobamos su estado:
```
sudo ufw enable
```
```
sudo ufw status
```
Muestra de comandos realizados en la máquina virtual:

<img width="800" height="800" alt="image" src="https://github.com/user-attachments/assets/54673a86-3947-409a-9da4-88194262e4ea" />


Comprobamos el estado de nuestro servidor web Apache ingresando a localhost:

<img width="700" height="600" alt="image" src="https://github.com/user-attachments/assets/3d68be54-22fe-4f31-9dcf-e85a20be3280" />

Servidor apache funcionando correctamente.

**2. Instalar MySQL**  
-----------------------------------------------
Instalamos mysql-server con el comando:
```
sudo apt install mysql-server -y
```
Tras instalar el servidor de mysql, aseguramos la instalación con el comando:
```
sudo mysql_secure_installation
```
Asignamos password al usuario root, borramos usuarios anónimos y bases de datos de prueba.

Probamos que el servidor funcione correctamente:
```
sudo mysql
```
Muestra de comandos realizados en la máquina virtual:

<img width="947" height="770" alt="image" src="https://github.com/user-attachments/assets/03723df7-5363-40d6-b259-ad2d2a174db9" />

**3. Instalar PHP**  
-----------------------------------------------
Instalamos php y las integraciones con apache y MySQL con el comando:
```
sudo apt install php libapache2-mod-php php-mysql
```
Comprobamos que php esté correctamente instalado con:
```
php -v
```
Así comprobamos la versión instalada.

Muestra de comandos realizados en la máquina virtual:

<img width="1145" height="236" alt="image" src="https://github.com/user-attachments/assets/863aebfb-c349-4ae7-af95-d76d37c16d22" />

Editamos el archivo dir.conf de apache para dar preferencia a index.php frente al resto:
```
sudo nano /etc/apache2/mods-enabled/dir.conf
```
<img width="807" height="102" alt="image" src="https://github.com/user-attachments/assets/99fbdcb3-440a-4708-a644-2598ace6d0e7" />

Restablecemos el servicio de apache con:
```
sudo systemctl restart apache2
```
**4. Crear host virtual para nuestro sitio web**
   ---------------------------------------
Primero, creamos una carpeta dentro de /var/www/
```
sudo mkdir /var/www/myweb
```
Asignamos permisos al usuario correspondiente ($USER = usuario del sistema) tras crear la carpeta:
```
sudo chown -R $USER:$USER /var/www/myweb
```
Creamos un archivo de configuración para nuestro sitio web:
```
sudo nano /eyc/apache2/sites-avaliable/myweb.conf
```
Configuración aplicada en mi caso:

<img width="711" height="214" alt="image" src="https://github.com/user-attachments/assets/81a792cd-91c9-4394-bcdb-8253b5b0e69e" />

Habilitamos nuestro sitio web y deshabilitamos el sitio web por defecto:
```
sudo a2ensite myweb
```
```
sudo a2dissite 000-default
```
```
sudo systemctl reload apache2
```
Muestra de comandos en la máquina virtual:

<img width="1782" height="733" alt="image" src="https://github.com/user-attachments/assets/67d7473f-ad6b-41c0-ae18-ccbfeab967e8" />

Creamos un index.html para nuestro sitio web:
```
sudo nano /var/www/myweb/index.html
```
<img width="649" height="255" alt="image" src="https://github.com/user-attachments/assets/87369003-90aa-4c95-b93f-6235174312fe" />

Accedemos al localhost desde el navegador:

<img width="395" height="159" alt="image" src="https://github.com/user-attachments/assets/316518ae-abcc-46f5-b335-d2a8d2017076" />

Nuestro sitio web funciona correctamente!!!

**5. Probar procesamiento PHP en el servidor web**
   -------------------------------
Creamos un archivo php dentro del directorio de nuestro sitio web:
```
sudo nano /var/www/myweb/info.php
```
Agregamos el contenido:
<img width="523" height="116" alt="image" src="https://github.com/user-attachments/assets/de18fa69-1c28-455f-891b-288c20a417ed" />

Tras agregar el contenido ingresamos al navegador, accedemos al localhost/info.php
<img width="1004" height="600" alt="image" src="https://github.com/user-attachments/assets/64d3432c-9340-44e7-9482-cd1cea802135" />

PHP mantiene un correcto funcionamiento dentro del servidor web, lo que signfica que está bien integrado.

Borramos el archivo info.php
```
sudo rm /var/www/myweb/info.php
```
