# Actividad 5 - Trabajando con la directiva "Directory"

## Ejercicios

### 1. Crea un directorio llamado "dir1" y otro llamado "dir2".
-----------------------------------------------
Creamos el directorio con el comando ```mkdir nombredirectorio``` y lo comprobamos con ```ls -l```.

<img width="500" height="200" alt="image" src="https://github.com/user-attachments/assets/b1ac7950-6137-4d3a-b241-ecfff420f6db" />


### 2. Explica qué diferencia existe entre ambos y muestra su equivalencia con la directiva Require:
-----------------------------------------------
```
<Directory /var/www/example1>
Order Deny,Allow
Deny from All
Allow from 192.168.1.100
</Directory>

<Directory /var/www/example1>
Order Allow,Deny
Deny from All
Allow from 192.168.1.100
</Directory>
```
La diferencia se basa en el orden de preferencia en el que Apache denegará o permitirá el acceso. En el primer caso (Deny, Allow), por defecto, denegará todo el acceso, pero permitirá conexiones de la dirección 192.168.1.100. En el segundo caso (Allow, Deny), por defecto, permitirá todo el acceso, luego bloquea toda las conexiones, excepto la dirección 192.168.1.100.

Como en los dos casos anteriores, se bloquean todas las conexiones excepto una dirección, la equivalencia a esta configuración con ```require``` sería:
```
<Directory /var/www/example1>
    Require ip 192.168.1.100
</Directory>
```

### 3. Para dir1
-----------------------------------------------
 · Todas estas configuraciones se harán desde ```/etc/apache2/apache2.conf``` para aplicar reglas globales. Aunque también podrían crearse nuevos archivos de configuración en ```/etc/apache2/sites-avaliable```.

#### a. Permite el acceso de las peticiones provenientes de 10.3.0.100.

Hacemos uso de la directiva "Require ip".

<img width="302" height="95" alt="image" src="https://github.com/user-attachments/assets/dde71700-8209-4526-9760-aa3f6c82d565" />

#### b. Permite el acceso desde "marisma.intranet".

Hacemos uso de la directiva "Require host".

<img width="385" height="88" alt="image" src="https://github.com/user-attachments/assets/3f2d8644-4cd9-480b-8847-dec7c59948c7" />

#### c. Permite el acceso desde cualquier subdominio de "marisma.intranet".

Hacemos uso de la directiva "Require host" y añadimos un "." al principio del dominio.

<img width="392" height="96" alt="image" src="https://github.com/user-attachments/assets/e3caca9f-ba68-422a-b2e4-10dbe7338110" />

#### d. Permite el acceso de las peticiones provenientes de "10.3.0.100" con máscara "255.255.0.0".

Hacemos uso de la directiva "Require ip" con máscara en formato CIDR.

<img width="337" height="97" alt="image" src="https://github.com/user-attachments/assets/bb733931-8f5e-4eb8-a175-95592ccab34c" />

### 4. Modifica la configuración de forma que el acceso a dir1:
-----------------------------------------------
#### a. Se permita a "marisma.intranet" y no se permita desde 10.3.0.101"

```RequireAll``` significa que todas las condiciones deben cumplirse para permitir el acceso. Las conexiones se bloquean con "not".

<img width="462" height="168" alt="image" src="https://github.com/user-attachments/assets/65b937b7-6ce4-4c62-aac8-151baa1c6362" />

### 5. Modifica la configuración de forma que el acceso a dir2:
-----------------------------------------------
#### Se permita a "10.3.0.100/8" y no a "marisma.intranet".

De igual manera, hacemos uso de ```RequireAll``` con notación CIDR para la IP.

<img width="519" height="157" alt="image" src="https://github.com/user-attachments/assets/f54bf5f0-31fd-484e-bb55-97fcedfe6c2b" />
