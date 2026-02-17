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

### 1.1 Instalación de pila LAMP

Para esta práctica haré uso de LAMP (Linux, Apache, MariaDB/MySQL, PHP/Perl) ya que es un stack tecnológico muy conocido y apoyado por la comunidad. Para ello usamos el comando ```sudo apt install apache2 mariadb-server php libapache2-mod-php php-mysql -y```. Esta pila o conjunto de paquetes ya incluye PHP y los módulos necesarios para la correcta integración con los servicios web de Apache.

<img width="1265" height="425" alt="image" src="https://github.com/user-attachments/assets/0089414b-d3a1-41aa-b00f-4c856408a169" />

### 1.2 Instalación más módulos PHP

No obstamte, aunque la integración con Apache ya estaría, debemos instalar otro módulos necesarios para la integración con phpMyAdmin y más funcionalidades web, para ello usamos el comando ```sudo apt install php-cli php-curl php-gd php-mbstring php-xml php-zip -y```.

<img width="1010" height="200" alt="image" src="https://github.com/user-attachments/assets/da03776e-c465-4674-bab0-bc4c8fea30ef" />

Tras completar la instalación de PHP y todos sus módulos, usamos el comando ```php -v``` para comprobar la versión y ```php -m``` para comprobar las extensiones o módulos instalados.

<img width="1164" height="224" alt="image" src="https://github.com/user-attachments/assets/6b5dafe6-b809-4250-85ae-debe10737f53" />

### 1.3 Instalación de PHPMyAdmin

Insertamos el comando ```sudo apt install phpmyadmin```, introducimos la tecla "Y" para aceptar y damos Intro para confirmar la instalación del programa.

<img width="1283" height="441" alt="image" src="https://github.com/user-attachments/assets/fccf11a2-49d1-4779-bd66-0ba7fb53df83" />

En el proceso de instalación, nos pregunta que motor o servidor web va a ejecutar phpMyAdmin, marcamos "apache2" y damos Intro sobre "Ok". 

<img width="771" height="246" alt="image" src="https://github.com/user-attachments/assets/55a382a5-c3c1-4aad-992e-caae48e9b6da" />

Creamos la base de datos de manera automática con "dbconfig-common", para ello, marcamos la casilla "Yes" y damos Intro.

<img width="1262" height="270" alt="image" src="https://github.com/user-attachments/assets/526919e3-205d-4f76-9a92-373d83610b6c" />

Insertamos una contraseña segura en la base de datos del servidor para el acceso a phpMyAdmin.

<img width="1105" height="248" alt="image" src="https://github.com/user-attachments/assets/4685a767-fda7-4a63-a158-1723c72fb680" />

### Habilitando los servicios LAMP

Tras instalar la pila LAMP, es conveniente habilitar los servicios para que se inicien al arrancar el servidor ```sudo systemctl enable ...```, iniciarlos en la propia sesión con ```sudo systemctl start ...```y comprobar su estado con ```sudo systemctl status ...```, en este caso he habilitado e iniciado tanto apache2 como mariadb.

<img width="1284" height="487" alt="image" src="https://github.com/user-attachments/assets/6a161ac4-9e0a-4231-9915-69e0468b3e6b" />

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

Este paso es muy importante de cumplir, ya que es una medida de seguridad bastante potente. Vamos a acceder a la configuración de la base de datos con ```sudo mariadb``` como root. Dentro vamos a crear un usuario llamado "rafael" apuntando a la instancia local (localhost) con una contraseña segura ```CREATE USER 'rafael'@'localhost' IDENTIFIED BY '........';```. Posteriormente le concedemos privilegios sobre toda la instancia y todas las bases de datos (administrador) con ```GRANT ALL PRIVILEGES ON *.* TO 'rafael'@'localhost' WITH GRANT OPTION;```, por último aplicamos / refrescamos los privilegios con ```FLUSH PRIVILEGES;```. 

<img width="723" height="285" alt="image" src="https://github.com/user-attachments/assets/437098a7-1b84-4796-b0c8-5645f90dce93" />

### 2.4 PHPMyadmin

wasd

<img width="1281" height="493" alt="image" src="https://github.com/user-attachments/assets/08c4281b-98ab-4691-aa66-dd6f2a6f036e" />

wasd

<img width="1067" height="116" alt="image" src="https://github.com/user-attachments/assets/b67ea7c4-f574-4a92-9b9b-ee54319b5db0" />

wasd

<img width="1070" height="676" alt="image" src="https://github.com/user-attachments/assets/88ecffce-4775-4ddb-a4b9-dbffa114f83d" />


### 2.5 FTP + TLS

wasd

<img width="552" height="24" alt="image" src="https://github.com/user-attachments/assets/b2c45bce-b8e2-4317-b5b6-702d88d54c1d" />

wasd

<img width="454" height="21" alt="image" src="https://github.com/user-attachments/assets/2c551fbe-c2f4-4614-bae5-2b0bed594620" />

wasd

<img width="744" height="306" alt="image" src="https://github.com/user-attachments/assets/90458bab-af59-4bca-bfea-fb8dd4f6b199" />

wasd

<img width="791" height="247" alt="image" src="https://github.com/user-attachments/assets/506d64e6-bfcf-4bd9-9fd4-472eb4477f00" />

### 2.6 SSH y SFTP

wasd

<img width="760" height="86" alt="image" src="https://github.com/user-attachments/assets/5c46168f-a39f-4d0e-ad41-4b884e3271bf" />

wasd

<img width="1278" height="388" alt="image" src="https://github.com/user-attachments/assets/b35f471c-c434-4390-8b24-d77a74a57a31" />

wasd

<img width="947" height="326" alt="image" src="https://github.com/user-attachments/assets/0ff51ea1-f012-4c50-9a60-2305acdbdb75" />

### 2.7 Configuración del DNS BIND9

wasd

<img width="779" height="226" alt="image" src="https://github.com/user-attachments/assets/8e19ed03-dbd1-412f-8e10-a1d6b31fccf0" />

wasd

<img width="681" height="25" alt="image" src="https://github.com/user-attachments/assets/2671b5d7-bb67-45bf-af1e-fd91086d5644" />

wasd

<img width="808" height="221" alt="image" src="https://github.com/user-attachments/assets/7c768f40-8807-4a4d-8b00-b9b1ac6cdc2a" />


wasd

<img width="994" height="457" alt="image" src="https://github.com/user-attachments/assets/0c2a0aad-eebf-45d3-92e8-24912df231fd" />

wasd

<img width="760" height="589" alt="image" src="https://github.com/user-attachments/assets/1a9cc1a2-4ff2-4462-826c-afd18489404e" />

wasd

### 2.8 Configuración de soporte Python (WSGI)

wasd

<img width="549" height="23" alt="image" src="https://github.com/user-attachments/assets/5635768c-5f0a-4c76-9eb9-414b70cf00dd" />

wasd

<img width="810" height="157" alt="image" src="https://github.com/user-attachments/assets/57a8e486-51ac-4ba3-8c63-95e41e8abb5b" />


wasd

<img width="870" height="376" alt="image" src="https://github.com/user-attachments/assets/0f564fa9-974e-463f-bd3e-d35811b8dde0" />
