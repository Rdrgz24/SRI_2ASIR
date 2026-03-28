# Práctica Segundo Trimestre - Servidor de alojamiento web

## 0. Pasos previos

Para realizar esta práctica usaremos una máquina virtual con Ubuntu Server 24.04.3, donhde hemos asignado los siguientes recursos en el Proxmox del centro.

<img width="600" height="450" alt="image" src="https://github.com/user-attachments/assets/c57f9e4b-1f31-40a3-8be5-b897f5f7ae3e" />

Tras crear la máquina virtual, la iniciamos. Nos paramos en el paso de configuración de red, donde pulsamos sobre la interfaz de red - "Edit IPv4".

<img width="1043" height="208" alt="image" src="https://github.com/user-attachments/assets/fdb762aa-13b7-48cd-b558-6e0b4d3c5506" />

Marcamos como método "Manual" e insertamos una dirección IP estática, en este caso mi servidor dispondrá de la dirección 192.168.195.5/24 y su enrutador será 192.168.195.101, un servidor de alojamiento siempre debe tener dirección IP estática.

<img width="1271" height="577" alt="image" src="https://github.com/user-attachments/assets/6d30e056-7b53-4dfb-80af-f41afa5621cb" />

Asignamos un nombre identificativo al usuario y al servidor. Luego, insertamos unas credenciales seguras para el usuario.

<img width="1104" height="315" alt="image" src="https://github.com/user-attachments/assets/8d8dfedf-2d87-4ef1-9938-32f03095723e" />

Ubuntu ya nos da la opción de instalar el servicio OpenSSH (servicio SSH) por defecto, marcamos la casilla y pulsamos Intro sobre "Done" para después solo tener que habilitar el servicio, nos ahorramos instalarlo.

<img width="1042" height="262" alt="image" src="https://github.com/user-attachments/assets/b54650c9-198d-44f6-a323-84147bdea0b2" />

Una vez el sistema está instalado, reiniciamos la máquina e iniciamos sesión con nuestro usuario. Usamos el comando ```uname -a``` para ver el nombre del equipo, ```ip a``` para comprobar que la dirección IP es la correcta, y por último ```ping -c2 8.8.8.8``` para verificar que la máquina tiene conexión a Internet.

<img width="1027" height="390" alt="image" src="https://github.com/user-attachments/assets/74582953-6527-4e8b-bbde-e05528474f44" />

Ejecutamos el comando ```sudo apt update && sudo apt upgrade -y``` para actualizar la lista de repositorios junto a las aplicaciones del sistema.

<img width="1278" height="373" alt="image" src="https://github.com/user-attachments/assets/38a2c9c8-dab9-4d19-9459-ca84e86bab4f" />

Por último, instalamos los paquetes básicos de los que tiene que disponer el sistema para un correcto funcionamiento y gestión de certificados, web y paquetes.

<img width="933" height="246" alt="image" src="https://github.com/user-attachments/assets/e76abc4e-ef1e-4089-b561-f1a550899665" />

## 1. Instalación de servicios

### 1.1 Pila LAMP

Para esta práctica haré uso de LAMP (Linux, Apache, MariaDB/MySQL, PHP/Perl) ya que es un stack tecnológico muy conocido y apoyado por la comunidad. Para ello usamos el comando ```sudo apt install apache2 mariadb-server php libapache2-mod-php php-mysql -y```. Esta pila o conjunto de paquetes ya incluye PHP y los módulos necesarios para la correcta integración con los servicios web de Apache.

<img width="1265" height="425" alt="image" src="https://github.com/user-attachments/assets/0089414b-d3a1-41aa-b00f-4c856408a169" />

### 1.2 Módulos PHP

No obstamte, aunque la integración con Apache ya estaría, debemos instalar otro módulos necesarios para la integración con phpMyAdmin y más funcionalidades web, para ello usamos el comando ```sudo apt install php-cli php-curl php-gd php-mbstring php-xml php-zip -y```.

<img width="1010" height="200" alt="image" src="https://github.com/user-attachments/assets/da03776e-c465-4674-bab0-bc4c8fea30ef" />

Tras completar la instalación de PHP y todos sus módulos, usamos el comando ```php -v``` para comprobar la versión y ```php -m``` para comprobar las extensiones o módulos instalados.

<img width="1164" height="224" alt="image" src="https://github.com/user-attachments/assets/6b5dafe6-b809-4250-85ae-debe10737f53" />

### 1.3 phpMyAdmin

Insertamos el comando ```sudo apt install phpmyadmin```, introducimos la tecla "Y" para aceptar y damos Intro para confirmar la instalación del programa.

<img width="1283" height="441" alt="image" src="https://github.com/user-attachments/assets/fccf11a2-49d1-4779-bd66-0ba7fb53df83" />

En el proceso de instalación, nos pregunta que motor o servidor web va a ejecutar phpMyAdmin, marcamos "apache2" y damos Intro sobre "Ok". 

<img width="771" height="246" alt="image" src="https://github.com/user-attachments/assets/55a382a5-c3c1-4aad-992e-caae48e9b6da" />

Creamos la base de datos de manera automática con "dbconfig-common", para ello, marcamos la casilla "Yes" y damos Intro.

<img width="1262" height="270" alt="image" src="https://github.com/user-attachments/assets/526919e3-205d-4f76-9a92-373d83610b6c" />

Insertamos una contraseña segura en la base de datos del servidor para el acceso a phpMyAdmin.

<img width="1105" height="248" alt="image" src="https://github.com/user-attachments/assets/4685a767-fda7-4a63-a158-1723c72fb680" />
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### Habilitando servicios LAMP

Tras instalar la pila LAMP, es conveniente habilitar los servicios para que se inicien al arrancar el servidor ```sudo systemctl enable ...```, iniciarlos en la propia sesión con ```sudo systemctl start ...```y comprobar su estado con ```sudo systemctl status ...```, en este caso he habilitado e iniciado tanto apache2 como mariadb.

<img width="1284" height="487" alt="image" src="https://github.com/user-attachments/assets/6a161ac4-9e0a-4231-9915-69e0468b3e6b" />
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### 1.4 Instalación de FTP

Para hacer uso del servicio FTP, instalaré el paquete "vsftpd" con el comando ```sudo apt install vsftpd```.

<img width="502" height="117" alt="image" src="https://github.com/user-attachments/assets/502f3e2e-d1ee-4b69-80a4-f8d363202043" />

Tras instalarlo, habilitamos el servicio con ```sudo systemctl enable vsftpd```, lo iniciamos con ```sudo systemctl start vsftpd``` y comprobamos su estado con ```sudo systemctl status vsftpd```.

<img width="994" height="279" alt="image" src="https://github.com/user-attachments/assets/0f6eea25-2db2-4958-a354-1590a766777f" />

Posteriormente habilitaremos la seguridad en el servicio.

### 1.5 Habilitando servicio SSH

Tal y como marcamos en la instalación, el servicio SSH se instaló, no obstante, por defecto no viene habilitado, por lo que usaremos el comando ```sudo systemctl enable ssh```, luego ```sudo systemctl start ssh``` y por último ```sudo systemctl status ssh``` para comprobar su estado.

<img width="1019" height="356" alt="image" src="https://github.com/user-attachments/assets/4043009a-bc0f-48ee-9206-5cb1726b97f3" />

Probaremos desde un cliente la conexión SSH con el comando ```ssh rafael@192.168.195.5```, aceptamos con "yes" indicando que es un host conocido e introducimos la contraseña. Como podemos ver, ha conectado por SSH exitosamente, hemos verificado la conexión con ```uname -a``` dentro del servidor.

<img width="1072" height="513" alt="image" src="https://github.com/user-attachments/assets/0079fd40-4fb6-4e6d-890a-5a1bde45366c" />

### 1.6 Instalación del servidor DNS BIND9

En esta práctica, haremos uso del servidor DNS BIND9 para crear una zona maestra (hosting2asir.intranet) donde posteriormente se añadirán subdominios por cada uno de los usuarios que automatice el script. Para instalarlo, usamos el comando ```sudo apt install bind9 bind9utils bind9-doc```, insertamos "Y" y pulsamos Intro.

<img width="598" height="233" alt="image" src="https://github.com/user-attachments/assets/bd0b8a98-a291-44aa-a7b0-d92907d27207" />

### 1.7 Instalación de soporte Python con Apache

Para poder usar Python en la práctica, debemos instalar los módulos compatibles con Apache y su correspondiente integración. Para ello, usamos el comando ```sudo apt install libapache2-mod-wsgi-py3 python3```, insertamos "Y" y pulsamos Intro.

<img width="602" height="209" alt="image" src="https://github.com/user-attachments/assets/62b6e618-d3d1-4da6-a4a8-d395d52836b3" />

## 2. Configuración de servicios

Tras instalar todos los servicios, toca configurar uno a uno todo lo necesario para que al usar y ejecutar el script todo funcione correctamente.

### 2.1 Apache

Como hemos instalado módulos relacionados con Apache, este no los trata hasta que se habilite, por lo que usamos el comando ```sudo a2enmod ...``` para activar ```rewrite```, ```wsgi``` y ```ssl```, tras activar todos, usamos el comando ```sudo systemctl restart apache2``` para reiniciar o recargar apache y aplicar la configuración.

<img width="839" height="260" alt="image" src="https://github.com/user-attachments/assets/c84c03ac-21c5-40ab-967a-8b2743b24062" />

### 2.2 PHP

Editamos el archivo php.ini para integrarlo correctamente con Apache, para ello usamos el comando ```sudo nano /etc/php/8.3/apache2/php.ini```, donde descomentaremos la línea "display_errors" y la dejaremos tal que así ```display_errores = On```.

<img width="799" height="106" alt="image" src="https://github.com/user-attachments/assets/7ff4b5de-cc6b-47b8-b8ef-3aca39ab2d89" />

Posteriormente, aplicamos ```upload_max_filesize = 20M``` que para esta práctica no tiene mucha utilidad, pero vamos a trabajar siempre intentando simular entornos reales.

<img width="797" height="91" alt="image" src="https://github.com/user-attachments/assets/184c183a-d8c3-475e-b5ac-19a584444d65" />

Lo mismo pasa con este, aplicamos ```upload_max_size = 20M``` que aunque no lo vayamos a usar para nada, es útil.

<img width="771" height="119" alt="image" src="https://github.com/user-attachments/assets/6fb95203-839a-4f05-b289-37b84ff00b2a" />

### 2.3 MariaDB

Este paso es muy importante de cumplir, ya que es una medida de seguridad bastante importante. Vamos a acceder a la configuración de la base de datos con ```sudo mariadb``` como root. Dentro vamos a crear un usuario llamado "rafael" apuntando a la instancia local (localhost) con una contraseña segura ```CREATE USER 'rafael'@'localhost' IDENTIFIED BY '........';```. Posteriormente le concedemos privilegios sobre toda la instancia y todas las bases de datos (administrador) con ```GRANT ALL PRIVILEGES ON *.* TO 'rafael'@'localhost' WITH GRANT OPTION;```, por último aplicamos / refrescamos los privilegios con ```FLUSH PRIVILEGES;```. 

<img width="723" height="285" alt="image" src="https://github.com/user-attachments/assets/437098a7-1b84-4796-b0c8-5645f90dce93" />

### 2.4 PHPMyadmin

La configuración de phpMyAdmin no es compleja, solo debemos acceder al archivo de configuración con ```sudo nano /etc/apache2/conf-avaliable/phpmyadmin.conf``` y deshabilitar el acceso a directorios que los usuarios no tienen porque tener, básicamente aplicando la directiva ```Require all denied``` en los directorios /usr/share/phpmyadmin/templates y /usr/share/phpmyadmin/libraries.

<img width="1281" height="493" alt="image" src="https://github.com/user-attachments/assets/08c4281b-98ab-4691-aa66-dd6f2a6f036e" />

Ya que estamos, vamos a probar si phpMyAdmin está operativo en el servidor web, para ello, desde una máquina cliente que tengo de la [Práctica 8 - Subdominios](../TEMA_2_DNS/Actividad_8_Subdominios), donde tengo ya previamente un nameserver del servidor que estuve configurando, no obstante, voy a poner como servidor DNS primario la IP del de esta práctica (192.168.195.5) dentro de ```/etc/resolv.conf``` para que resuelva las peticiones del dominio local hosting2asir.intranet.

<img width="1067" height="116" alt="image" src="https://github.com/user-attachments/assets/b67ea7c4-f574-4a92-9b9b-ee54319b5db0" />

Tras aplicar la configuración para la resolución DNS podemos acceder al navegador e introducir la URL http://hosting2asir.intranet/phpmyadmin, donde he introducido las credenciales de acceso del usuario "rafael", justo creado anteriormente en la configuración de MariaDB. Vemos el Dashboard o página de inicio de phpMyAdmin correctamente.

<img width="1070" height="676" alt="image" src="https://github.com/user-attachments/assets/88ecffce-4775-4ddb-a4b9-dbffa114f83d" />

### 2.5 FTP + TLS

Antes de realizar modificaciones sobre el fichero de configuración principal, debemos hacer una copia de este con el comando ```sudo cp /etc/vsftpd.conf /etc/vsftpd_copy.conf```, por si realizamos alguna configuración errónea que no podamos solventar, restablecer dicho archivo y dejar el servicio nuevamente funcional, pero haremos que eso no pase.

<img width="552" height="24" alt="image" src="https://github.com/user-attachments/assets/b2c45bce-b8e2-4317-b5b6-702d88d54c1d" />

Una vez que hemos hecho la copia, podemos trabajar sobre el archivo original, voy a empezar elimintando todas las líneas que empiecen por "#", es decir, todos los comentarios del archivo, para trabajar con texto plano y no tener que estar buscando configuraciones en tantas líneas. Para ello usé el comando ```sudo sed -i /^#/d /etc/vsftpd.conf```, ¿Cómo funciona internamente el comando? Con ```sed -i``` indicamos que reemplace, con ```/^#/d``` indicamos que todo lo que empiece por "#" sea ```d (eliminado)```.

<img width="454" height="21" alt="image" src="https://github.com/user-attachments/assets/2c551fbe-c2f4-4614-bae5-2b0bed594620" />

Posteriormente, edité las variables del archivo de configuración, de tal manera que el servicio usara TLS con los pre firmados que asigna Ubuntu, quitamos el acceso anónimo, permitimos el acceso local, la estrictura e indicamos el tipo de certificado TLS a usar.

<img width="1209" height="505" alt="image" src="https://github.com/user-attachments/assets/07cd1f75-098d-4713-a3e1-417c5f58dc32" />

Creamos la ruta para los chroot como técnica de seguridad, donde cambiamos el directorio raíz (/) para un usuario específico. Garantizando que cada usuario no pueda modificar archivos de otros.

<img width="1216" height="104" alt="image" src="https://github.com/user-attachments/assets/56ba287c-6923-4303-bbb0-b029e8755e6c" />

Tras editar el archivo de configuración, debemos reiniciar el servicio con ```sudo systemctl restart vsftpd.service``` y comprobar el estado con ```sudo systemctl status vsftpd.service```.

<img width="791" height="247" alt="image" src="https://github.com/user-attachments/assets/506d64e6-bfcf-4bd9-9fd4-472eb4477f00" />

### 2.6 SSH y SFTP

Para habilitar el acceso a SSH y SFTP, debemos editar el archivo de configuración con el comando ```sudo nano /etc/ssh/sshd_config```, donde descomentamos la línea ```PasswordAuthentication yes``` para que permita y pida la contraseña como credencial de acceso.

<img width="760" height="86" alt="image" src="https://github.com/user-attachments/assets/5c46168f-a39f-4d0e-ad41-4b884e3271bf" />

Luego, bajamos dentro del documento y comprobamos que como ```Subsystem``` esté insertado ```sftp /usr/lib/openssh/sftp-server```. Guardamos y cerramos.

<img width="1278" height="388" alt="image" src="https://github.com/user-attachments/assets/b35f471c-c434-4390-8b24-d77a74a57a31" />

Tras aplicar la configuración, reiniciamos el servicio con ```sudo systemctl restart ssh``` y comprobamos su estado con ```sudo systemctl status ssh```.

<img width="947" height="326" alt="image" src="https://github.com/user-attachments/assets/0ff51ea1-f012-4c50-9a60-2305acdbdb75" />

### 2.7 Configuración del DNS BIND9

#### Zona directa

Esta configuración es importante y crítica, ya que el servicio DNS se encargará de alojar el sitio web principal (hosting2asir.intranet) y los subdominios (usuario1.hosting2asir.intranet, usuario2.hosting2asir.intranet, etc...). Empezamos editando el archivo de configuración local con ```sudo nano /etc/bind/named.conf.local``` donde añadiremos las líneas ```zone "hosting2asir.intranet"``` como tipo de zona maestra e indicamos el archivo de configuración de esta zona ```file /etc/bind/db.hosting2asir.intranet```.

<img width="779" height="226" alt="image" src="https://github.com/user-attachments/assets/8e19ed03-dbd1-412f-8e10-a1d6b31fccf0" />

En base al archivo original "db.local", haremos una copia para solo modificarlo con la zona que queremos y así evitar tener que escribir todo el texto, para ello usamos el comando ```sudo cp /etc/bind/db.local /etc/bind/db.hosting2asir.intranet```.

<img width="683" height="31" alt="image" src="https://github.com/user-attachments/assets/8809f0a7-4184-48cf-a50b-c73029a76131" />

Luego, tras añadirlo como zona, creamos el nuevo archivo de configuración con ```sudo nano /etc/bind/db.hosting2asir.intranet```, aquí indicaremos los registros SOA (autoritativos) ```ns.host.intranet. admin.hosting2asir.intranet.``` con su serial y tiempos de llegada correspondientes. En las cuatro últimas líneas indicamos NameServer principal ```ns.hosting2asir.intranet.```, asociamos tres registros tipo A, el primero ```ns IN A 192.168.195.5``` donde asociamos el NameServer a esa IP, luego ```@ IN A 192.168.195.5``` que asigna la dirección IP como principal del servidor, por último ```www IN A 192.168.195.5``` para hacerlo un poco más interesante y poder acceder al dominio vía http://www.hosting2asir.intranet.

<img width="808" height="221" alt="image" src="https://github.com/user-attachments/assets/7c768f40-8807-4a4d-8b00-b9b1ac6cdc2a" />

Tras aplicar la configuración del DNS, debemos comprobar si la sintaxis es correcta, y si no hay problemas con los archivos de configuración y zona recién creados. Para ello usamos el comando ```sudo named-checkconf``` para comprobar la sintaxis del archivo de configuración, luego ```sudo named-checkzone hosting2asir.intranet /etc/bind/db.hosting2asir.intranet``` para comprobar la sintaxis del archivo de zona recién creado, si todo está correcto (el primero no muestra nada y el segundo OK), reiniciamos el servicio DNS con ```sudo systemctl restart bind9``` y comprobamos el correcto estado con ```sudo systemctl status bind9```.

<img width="994" height="457" alt="image" src="https://github.com/user-attachments/assets/0c2a0aad-eebf-45d3-92e8-24912df231fd" />

Para comprobar y verificar que el servidor DNS funciona, vamos a usar múltiples comandos de utilidad. Primero, hemos comprobado con ```nslookup hosting2asir.intranet``` que devuelve el contenido 192.168.195.5, lo que verifica que la resolución es correcta. Luego comprobamos con ```ping -c2 hosting2asir.intranet``` que hay comunicación y en realidad estamos llamando a la dirección IP, por último ```dig hosting2asir.intranet``` ha contestado con un registro DNS ```IN A 192.168.195.5``` justo el que se esperaba, ya que es el que tiene asociado el NameServer y la IP principal del servidor.

<img width="760" height="589" alt="image" src="https://github.com/user-attachments/assets/1a9cc1a2-4ff2-4462-826c-afd18489404e" />

#### Zona inversa

Editamos el archivo de configuración local con ```sudo nano /etc/bind/named.conf.local``` donde añadiremos las líneas ```zone "195.168.192.in-addr.arpa"``` como tipo de zona maestra e indicamos el archivo de configuración de esta zona ```file /etc/bind/db.192.168.195```.

<img width="1271" height="307" alt="image" src="https://github.com/user-attachments/assets/9435d123-8e1a-4978-9cf3-70eabd59d5ff" />

Creamos el archivo de configuración de zona inversa con el comando ```sudo nano /etc/bind/db.192.168.195``` y añadimos el contenido correspondiente, en este caso registros de tipo NS y PTR, con SOA indicamos la autoridad.

<img width="1277" height="231" alt="image" src="https://github.com/user-attachments/assets/6cc2302a-41ba-477c-b542-5d1144b5a868" />

Comprobamos la sintaxis del archivo de zona principal con ```sudo named-checkconf```, el archivo de la zona inversa con ```sudo named-checkzone 192.168.195 /etc/bind/db.192.168.195``` nos da OK y restablecemos el servicio BIND9 con el comando ```sudo systemctl restart bind9```. Cuando comprobamos el estado, todo está correcto, servicio ejecutándose.

<img width="1280" height="479" alt="image" src="https://github.com/user-attachments/assets/de1fda66-58b2-4ed5-aef2-428a6b12ba36" />

## 3. Creación, configuración y uso del script

### 3.1 Creación del script

Creamos una carpeta llamada "script" con el comando ```mkdir script```, accedemos a esta con ```cd``` y comprobamos el directorio en el que estamos con ```pwd```. Una vez dentro, usamos el comando ```echo "" > crear_hosting.sh``` para crear el script sin contenido dentro y asignamos permisos de ejecución con ```sudo chmod +x crear_hosting.sh```, comprobamos con ```ls -l``` los permisos actuales.

<img width="1278" height="231" alt="image" src="https://github.com/user-attachments/assets/80912d7a-9ddd-4c6e-a918-a65bb0932196" />

Editamos el script con ```nano crear_hosting.sh``` sin "sudo", porque lo hemos creado como usuario "rafael", por lo que no son necesarios permisos de super usuario. Dentro, añadimos la línea ```#!/bin/bash``` con la que indicamos al sistema operativo que intérprete debe usar para ejecutar el resto del archivo (comandos).

<img width="1280" height="61" alt="image" src="https://github.com/user-attachments/assets/47f903ac-9296-418a-a736-0e69b41719c9" />

##### ACCESO AL SCRIPT YA CREADO Y EXPLICADO CON COMENTARIOS-> [CLICK AQUÍ](./crear_hosting.sh)

A partir de aquí cambié de máquina y me conecté con el cliente por ssh al servidor con el comando ```ssh rafael@192.168.195.5```, ya que me resultaba más sencillo para escribir el script.

Primera parte del script, donde comprobamos la sintaxis, definimos variables dinámicas y fijas, creamos el usuario para el hosting con su directorio home, asignamos contraseña y creamos las carpetas pública y de logs.

<img width="1207" height="684" alt="image" src="https://github.com/user-attachments/assets/1a1d6f98-a6a0-44a0-ac34-5bfe8fbe43a4" />

Segunda parte del script, donde creamos los tres ficheros (HTML, PHP y Python) para el usuario, asignamos propietario y permisos, configuramos el DNS y creamos el VirtualHost para el puerto 80 (solo para redirigir al 443). 

<img width="1206" height="689" alt="image" src="https://github.com/user-attachments/assets/8af688cd-3824-42d1-963e-e1d3f80f6199" />

Tercera parte del script, donde creamos el VirtualHost para el puerto 443, asignando los certificados SSL predeterminados (snakeoil) con clave pública y privada, añadimos el WSGI Script de Python y habilitamos la sobreescritura y acceso predeterminado. Luego, se habilita el módulo rewrite, el sitio del usuario recientemente configurado y se reinicia el servicio de Apache. Por último creamos la base de datos, el usuario y brindamos permisos totales sobre dicha base de datos (esto dará acceso a PHPMyAdmin). Tras terminar, lo indicamos por pantalla. (Se muestra la password de acceso a la DB porque es local en la VM dentro del servidor de Proxmox).

<img width="1205" height="628" alt="image" src="https://github.com/user-attachments/assets/19f24c0a-a9a9-4aee-9546-64b1d57c814f" />

### 3.2 Comprobaciones de funcionamiento del script

#### Ejecutando

Ejecutamos el script con el comando ```sudo bash crear_hosting.sh probando probando```, donde ejecutamos el script y pasamos como primer parámetro el usuario y segundo parámetro la contraseña. Vemos que todos los "echo" que hemos insertado en el comando se muestran y además muestra la URL del subdominio para acceder directamente desde el terminal hacia el navegador.

<img width="1211" height="195" alt="image" src="https://github.com/user-attachments/assets/537cd9dd-b885-4be0-83fa-2284f58de016" />

#### DNS

Una vez ejecutado el script y creado el subdominio, probamos que la resolución DNS funcione correctamente con el comando ```dig probando.hosting2asir.intranet```, vemos que resuelve correctamente con registros IN A.

<img width="1210" height="332" alt="image" src="https://github.com/user-attachments/assets/a97fddf6-f614-4c6a-9a78-2e9e3c64f865" />

#### Web y TLS

Accedemos a la URL del subdominio creado desde el navegador, en este caso "https://probando.hosting2asir.intranet" y vemos el encabezado que crea el script automáticamente.

<img width="1213" height="268" alt="image" src="https://github.com/user-attachments/assets/8ac17492-bf24-4aa9-99df-d0026dfd98b0" />

Además, comprobamos el certificado SSL, que tal y como podemos ver, aún así muestra que no es seguro porque no está validad por agencias certificadoras, está directamente certificado por el servidor. Pero vemos que muestra que es una conexión encriptada con TLS_AES_128_GCM (TLS 1.3).

<img width="715" height="583" alt="image" src="https://github.com/user-attachments/assets/318c7e55-4533-40e0-847b-dffe026d19bf" />

#### Python WSGI

Accedemos a la aplicación de Python, que tal y como acordamos en el script sería la dirección del subdominio /py, que aloja el contenido de la aplicación app.wsgi, dentro del directorio del usuario.

<img width="1213" height="766" alt="image" src="https://github.com/user-attachments/assets/4439a84a-2fab-47fc-b32c-2a524a26af0e" />

#### PHP

Si accedemos a la dirección del subdominio al recurso /info.php nos muestra toda la información del servidor PHP que está alojando el servidor tras ejecutar el script del subdominio en el hosting.

<img width="1213" height="767" alt="image" src="https://github.com/user-attachments/assets/c185b27a-819e-4eb2-96a0-17898c2883c1" />

#### MySQL

Accedemos con nuestro usuario "rafael" y su correspondiente contraseña con ```mysql -u rafael -p```, comprobamos las bases de datos creadas hasta la fecha con el comando ```SHOW DATABASES;```, en este caso "probando_db" es la actual. Comprobamos con el comando ```SELECT user, host FROM mysql.user WHERE user='probando';``` que el usuario esté creado. Y por último, usando ```SHOW GRANTS FOR 'probando'@'localhost';``` vemos que los permisos corresponden a los asignados en el script.

<img width="1213" height="671" alt="image" src="https://github.com/user-attachments/assets/22b5777f-64cf-48e5-93e8-9b90a0757f85" />

#### PHPMyAdmin

Evidentemente, el usuario tendrá acceso para modificar la base de datos que se ha creado, para ello, tendrá acceso a PHPMyAdmin vía web. Accedemos a la URL "https://probando.hosting2asir.intranet/phpmyadmin" e insertamos las credenciales del script, tales como son usuario: "probando", contraseña "probando" y pulsamos sobre "Log in". 

<img width="1216" height="586" alt="image" src="https://github.com/user-attachments/assets/c50465cf-b331-4e55-8726-0f31c7e95277" />

Tras iniciar sesión, vemos que el usuario "probando" tiene solo acceso a su BD "probando_db", tal y como debe ser, aquí, tendría acceso a operaciones DML, DDL y DCL: 

<img width="1213" height="769" alt="image" src="https://github.com/user-attachments/assets/0a16e9d3-224a-49ab-aac5-cbfebb5c40a1" />

Creamos la tabla "clientes" para verificar que podemos hacer operaciones de inserción, con 3 columnas, por ejemplo.

<img width="1211" height="368" alt="image" src="https://github.com/user-attachments/assets/49526bb9-738c-474c-9e85-5c73f4dcf78c" />

Creamos la primera columna "id" INT, segunda "Nombre" VARCHAR 45, tercera "Apellidos" VARCHAR 45, pulsamos sobre "Save".

<img width="1210" height="746" alt="image" src="https://github.com/user-attachments/assets/61afcbc0-debe-4f03-8734-0653ba6edd10" />

Tabla con sus campos correspondientes creada, podemos realizar operaciones de inserción, todo OK.

<img width="1211" height="383" alt="image" src="https://github.com/user-attachments/assets/28ef6acc-6abc-4214-bacc-aa2b633ba7b2" />

#### SSH

Nos conectamos por SSH desde el equipo cliente con el comando ```ssh probando@hosting2asir.intranet```, también valdría con ```ssh probando@probando.hosting2asir.intranet```, insertamos la contraseña y vemos el contenido con ```ls -l``` de nuestro directorio "home", que pertenece en el servidor a "/var/www/html/probando/". Comprobamos con ```whoami``` el usuario con el que estamos conectados.

<img width="1201" height="703" alt="image" src="https://github.com/user-attachments/assets/6c897a37-a390-4004-b99b-2e43aa278089" />

Vemos que dentro de nuestro directorio "home" tenemos todos los directorios y archivos creados por el script, para ello hicimos uso del comando ```ls -l``` y ```cd```. 

<img width="1203" height="280" alt="image" src="https://github.com/user-attachments/assets/6ce516bc-5172-4ad4-a53f-e1597e57278e" />

#### SFTP

Vamos a hacer una dinámica para probar lo que sería un entorno real, vamos a Internet y nos descargamos cualquier imagen:

<img width="564" height="196" alt="image" src="https://github.com/user-attachments/assets/32837b86-6408-4f19-9546-3a8f541db0c3" />

Nos conectamos por sftp hacia el hosting desde el cliente con el comando ```sftp probando@probando.hosting2asir.intranet```, insertamos la contraseña correcta (por favor) y dentro, podemos ver que tenemos los mismo directorios que en "home", creamos la carpeta "recursos" con ```mkdir recursos```, accedemos a esta con ```cd``` y subimos la imagen con "put", utilidad de ftp, ```put /home/rafael/Downloads/imagen_prueba.webp```, comprobamos que se ha subido correctamente con ```ls -l```.

<img width="1213" height="401" alt="image" src="https://github.com/user-attachments/assets/366173bf-8067-4073-9a2e-564694ceda01" />

Una forma de ver todo esto más gráfico, sería desde el explorador "Files" de Ubuntu, donde dentro de "Other Locations" podemos añadir ubicaciones por FTP, SFTP, SMB, NFS, etc... Para ello insertamos la línea "sftp://probando@probando.hosting2asir.intranet".  

<img width="1101" height="546" alt="image" src="https://github.com/user-attachments/assets/570af61e-79da-420c-aa0a-ba4350428a73" />

Insertamos las credenciales de acceso, mismas que anteriormente: usuario: probando, contraseña: probando y pulsamos sobre "Unlock".

<img width="412" height="299" alt="image" src="https://github.com/user-attachments/assets/c9409a1f-6169-40fe-8f39-53fdd5ff53e9" />

Dentro, podemos ver toda la estructura de directorios que hemos visualizado anteriormente con ssh y sftp por consola, pero de manera gráfica. Accedemos a "recursos" para comprobar que está aquí la foto descargada en local.

<img width="1150" height="541" alt="image" src="https://github.com/user-attachments/assets/b12b9363-8e6c-45a7-b0fa-18a399ff27d5" />

Vemos como, la foto que descargamos en nuestra máquina cliente, se ha mandado exitosamente con sftp por terminal usando "put" hacia nuestro servidor de alojamiento.

<img width="1098" height="552" alt="image" src="https://github.com/user-attachments/assets/6c94d1bc-58f8-4e29-9121-605b44c34972" />

ACCESO AL APARTADO OPCIONAL -> DOCKER
