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

## 4. Creación y configuración de scripts

### 4.1 Script en bash

#### Creación

Comenzamos creando una carpeta para los scripts con el comando ```mkdir scripts``` dentro de /home/rafael por ejemplo, creamos el fichero "crear_subdominio.sh" vacío y asignamos los permisos con el comando ```sudo chmod 755 crear_subdominio.sh```, y por último hacemos uso de ```nano crear_subdominio.sh``` para editar el archivo e insertar el contenido del script.

<img width="518" height="201" alt="image" src="https://github.com/user-attachments/assets/9377dfb7-f70f-42b8-844f-09cd38fe1ead" />

#### Explicación

Vamos a desglosar el script por partes:

Primero, validamos con -z, que comprueba si el parámetro $1 es nulo y devuelve un booleano. Una excepción simple, si es nulo, informar y parar scrip, de lo contrario, seguir ejecutando las siguientes líneas.

<img width="1628" height="304" alt="image" src="https://github.com/user-attachments/assets/5dc696ec-57b4-4b0e-b8b6-0d711de016ff" />

Definimos las variables fijas, tales como son el dominio, la ruta del servidor bind, la dirección IP de nuestro servidor que aloja los dominios y subdominios, y por último el archivo de la zona padre. Posteriormente añadimos las variables dinámicas, en este caso el subdominio que pasa el usuario y el archivo de configuración de este. La terminación "hosts" permite tener más claro si es un subdominio o no, por lo que el mantenimiento de múltiples archivos es más limpio.

<img width="1629" height="373" alt="image" src="https://github.com/user-attachments/assets/8560483d-23d5-4609-8f08-35c192073738" />

Tras definir todas las variables, creamos el archivo "include", llamado así en el script para identificarlo. Evkdentemente, asignamos el nombre definido en la ruta específica y asignamos los registros apuntando a una IP. Como dato curioso de esta configuración, hemos implementado ```cat <<EOF > ...... EOF``` para insertar contenido multilínea. ```$ORIGIN``` está indicando el origen del dominio base que contendrá dichos registros.

<img width="1628" height="421" alt="image" src="https://github.com/user-attachments/assets/799caa80-6b83-42ba-a15e-0ea4e4a503ea" />


Por último, y por supuesto, el paso más importante, hacemos una comprobación de que el nombre del subdominio junto a la directiva include no existe dentro del archivo de zona. Hacemos las excepciones, si existe, lo indicamos, de lo contrario, lo crea. La sentencia ```$INCLUDE``` permite asignar el contenido del archivo del subdominio dentro del archivo de la zona principal, hace una especie de enlace para que lo tenga en consideración.

<img width="1636" height="459" alt="image" src="https://github.com/user-attachments/assets/ebf89971-e446-4075-b620-8fce428bdae0" />

#### Comprobación

Vamos a probar el script para ver que tal funciona, para ello usamos el comando ```sudo bash crear_subdominio.sh nombresubdominio```, tras crearlo, comprobamos con ```cat /etc/bind/db.prueba2026.marisma.intranet.hosts``` y vemos el contenido de los registros correctamente añadido.

<img width="1639" height="454" alt="image" src="https://github.com/user-attachments/assets/3eef530b-6c24-432f-bfe2-e7f5d9439bdd" />

Si comprobamos 

<img width="1634" height="871" alt="image" src="https://github.com/user-attachments/assets/6775d66b-8175-40f0-b47a-57c22d99d010" />


wasd

<img width="1636" height="880" alt="image" src="https://github.com/user-attachments/assets/10223bed-506d-40d0-8ec0-0b504629797a" />

wasd

<img width="1635" height="873" alt="image" src="https://github.com/user-attachments/assets/7afffd0b-5fe3-48e6-94f5-589737fbbf1f" />
