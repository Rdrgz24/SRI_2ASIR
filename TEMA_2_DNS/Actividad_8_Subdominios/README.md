# Actividad 8 - Subdominios

Para esta actividad, usaré el mismo dominio de la práctica 6 (marisma.intranet), ya que las zonas directas e inversas, registros y configuraciones ya están realizadas y funcionales, por lo que para esta práctica solo indicaremos como hacer el subdominio, tanto de forma manual como con un script en bash.

El subdominio a crear se llama "informática.marisma.intranet" y dispone de varios hosts.

Nombre de dominio principal: iesmarisma.intranet

Nombre de hosts en el dominio principal: www, ftp, smtp

Nombre del subdominio: informatica.iesmarisma.intranet

Nombre de hosts en el subdominio: www, ftp, smtp

La práctica permite elegir entre dos métodos, o bien creamos
Creando un subdominio virtual.
Delegando el subdominio.

## 1. Configuración sobre el dominio padre

Comenzamos modificando la configuración del dominio padre (marisma.intranet) con el comando ```sudo nano /etc/bind/db.marisma.intranet``` y cambiamos el número del serial al día de hoy. Además, al final del documento, añadimos la línea que apunta al name server (NS) junto al registro o dirección que resolverá ese NS, es decir, la dirección 192.168.195.27.

<img width="1081" height="513" alt="image" src="https://github.com/user-attachments/assets/2aa190b1-8620-4c59-b1f9-17666e98939b" />

## 2. Configuración de la nueva zona (subdominio)

Editamos la configuración de bind local con el comando ```sudo nano /etc/bind/named.conf.local``` y añadimos la nueva zona, de tipo "master" e indicamos su archivo de configuración con la sentencia "file".

<img width="1064" height="514" alt="image" src="https://github.com/user-attachments/assets/cf7c4e6c-d678-4d95-a67f-0cf4baa71652" />

Lo siguiente, por supuesto, será crear el archivo de configuración de la zona "informatica.marisma.intranet". Para ello usamos el comando ```sudo nano /etc/bind/db.informatica.marisma.intranet``` donde delegaremos como SOA al subdominio ns1.informatica.marisma.intranet con admin.marisma.intranet. Luego indicamos su NS y sus registros con tipo A, los cuales son "ns1", "www", "ftp" y "smtp". 

<img width="1150" height="342" alt="image" src="https://github.com/user-attachments/assets/6d076b46-398b-496f-b3d6-74119cd343c6" />

Por último realizamos las correspondientes comprobaciones, las cuales son ```sudo named-checkconf``` para comprobar la sintaxis general, ```sudo named-checkzone marisma.intranet /etc/bind/db.marisma.intranet``` para comprobar la sintaxis específica del archivo de zona del dominio padre y por último ```sudo named-checkzone informatica.marisma.intranet /etc/bind/db.informatica.marisma.intranet```, reinciamos el servicio DNS con ```sudo systemctl restart bind9``` y comprobamos su estado con ```sudo systemctl status bind9```.

<img width="1583" height="731" alt="image" src="https://github.com/user-attachments/assets/9cb915bf-ed42-4c06-9a30-6879da302014" />

## 3. Comprobación del cliente

wasd

<img width="1347" height="781" alt="image" src="https://github.com/user-attachments/assets/ef1185aa-7f52-456f-9a08-ad51c2178da7" />

wasd

<img width="1347" height="633" alt="image" src="https://github.com/user-attachments/assets/dc50f70f-c8fb-416e-ad22-56de6d471bbb" />

wasd

<img width="1347" height="633" alt="image" src="https://github.com/user-attachments/assets/8d401b3d-0262-4332-8cf1-7ab68f398e5d" />

wasd

<img width="1347" height="633" alt="image" src="https://github.com/user-attachments/assets/4d333814-47fd-47e6-8049-c9dd706857b6" />

wasd

<img width="1634" height="878" alt="image" src="https://github.com/user-attachments/assets/8e3c989d-038e-4fd8-be87-4670cceb067b" />



