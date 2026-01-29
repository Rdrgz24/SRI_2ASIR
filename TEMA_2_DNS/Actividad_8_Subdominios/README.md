# Actividad 8 - Subdominios

Para esta actividad, usaré el mismo dominio de la práctica 6, ya que las zonas directas e inversas, registros y configuraciones ya están realizadas y funcionales, por lo que para esta práctica solo indicaremos como hacer el subdominio.

El subdominio a crear se llama "informática.marisma.intranet", estará alojado en el dominio padre "marisma.intranet" y resolverá las direcciones vía IP del servidor (192.168.195.27/24).

Nombre de hosts en el subdominio: www, ftp, smtp

La práctica permite elegir entre dos métodos:
Creando un subdominio virtual.
Delegando el subdominio.

#### Yo, elegiré delegando un sobdominio, ya que me parece más óptimo para un entorno real. Ya que... el subdominio virtual trabaja sobre una sola zona DNS (tanto dominio como subdominios) y un subdominio delegadotrabaja o tiene una autoridad propia sobre su DNS, lo que permite separar su gestión del dominio principal.

## 1. Configuración sobre el dominio padre

Comenzamos modificando la configuración del dominio padre (marisma.intranet) con el comando ```sudo nano /etc/bind/db.marisma.intranet``` y cambiamos el número del serial al día de hoy. Además, al final del documento, añadimos la línea que apunta al name server (NS) junto al registro o dirección que resolverá ese NS, es decir, la dirección 192.168.195.27.

<img width="1081" height="513" alt="image" src="https://github.com/user-attachments/assets/2aa190b1-8620-4c59-b1f9-17666e98939b" />

## 2. Configuración de la nueva zona (subdominio)

Editamos la configuración de bind local con el comando ```sudo nano /etc/bind/named.conf.local``` y añadimos la nueva zona, de tipo "master" e indicamos su archivo de configuración con la sentencia "file".

<img width="1064" height="514" alt="image" src="https://github.com/user-attachments/assets/cf7c4e6c-d678-4d95-a67f-0cf4baa71652" />

Lo siguiente, por supuesto, será crear el archivo de configuración de la zona "informatica.marisma.intranet". Para ello usamos el comando ```sudo nano /etc/bind/db.informatica.marisma.intranet``` donde delegaremos como SOA al subdominio ns1.informatica.marisma.intranet con admin.marisma.intranet. Luego indicamos su NS y sus registros con tipo A, los cuales son "ns1", "www", "ftp" y "smtp". 

<img width="1150" height="342" alt="image" src="https://github.com/user-attachments/assets/6d076b46-398b-496f-b3d6-74119cd343c6" />

Por último realizamos las correspondientes comprobaciones, las cuales son ```sudo named-checkconf``` para comprobar la sintaxis general, ```sudo named-checkzone marisma.intranet /etc/bind/db.marisma.intranet``` para comprobar la sintaxis específica del archivo de zona del dominio padre y por último ```sudo named-checkzone informatica.marisma.intranet /etc/bind/db.informatica.marisma.intranet```, reinciamos el servicio DNS con ```sudo systemctl restart bind9``` y comprobamos su estado con ```sudo systemctl status bind9```.

Si nos fijamos, al comprobar el dominio padre, indica "ns1.informatica.marisma.intranet has no addresses records", esto aparece porque el servidor NS del subdominio está fuera de la zona padre y su registro A es un glue record. Y claro, named-checkzone no considera los glue records como registros de dirección propios, aunque sean necesarios y correctos. Todo funciona.

<img width="1583" height="731" alt="image" src="https://github.com/user-attachments/assets/9cb915bf-ed42-4c06-9a30-6879da302014" />

## 3. Comprobación del cliente

Primero, insertamos el comando ```cat /etc/resolv.conf``` y podemos ver la configuración que está aplicada desde la práctica pasada (6.Master_DNS), luego he comprobado que el NS se resuelva correctamente con el comando ```dig informatica.marisma.intranet NS``` - lo resuleve correctamente.

<img width="1347" height="781" alt="image" src="https://github.com/user-attachments/assets/ef1185aa-7f52-456f-9a08-ad51c2178da7" />

Seguimos probando con el resto de hosts (registros A añadidos anteriormente), en este caso ```dig www.informatica.marisma.intranet``` - se resuelve correctamente.

<img width="1347" height="633" alt="image" src="https://github.com/user-attachments/assets/dc50f70f-c8fb-416e-ad22-56de6d471bbb" />

Siguente comprobación sobre el host "ftp" este caso ```dig ftp.informatica.marisma.intranet``` - se resuelve correctamente.

<img width="1347" height="633" alt="image" src="https://github.com/user-attachments/assets/8d401b3d-0262-4332-8cf1-7ab68f398e5d" />

Como último registro, comprobamos sobre el host "smtp" con el comando ```dig smtp.informatica.marisma.intranet``` y verificamos que todos los hosts se resuelve correctamente.

<img width="1347" height="633" alt="image" src="https://github.com/user-attachments/assets/4d333814-47fd-47e6-8049-c9dd706857b6" />

Como hemos podido comprobar, todos los host (registros A) han sido resueltos correctamente en el subdominio delegado.
