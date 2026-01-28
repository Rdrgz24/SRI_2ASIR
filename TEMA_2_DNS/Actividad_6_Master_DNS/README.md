# Actividad 6 - Master DNS - Servidor autoritativo

Partimos del siguiente punto -> Servidor DNS con dirección IP 192.168.195.27/24 junto a un cliente con Dirección IP 192.168.195.22/24, que ambos en la [Práctica 5](../../TEMA_2_DNS/Actividad_5_Cache_Forwarding) fueron configurados.

## 1. Configurar BIND

Para la configuración de BIND, primero debemos editar el archivo de configuración local, donde definimos la zona directa (marisma.intranet) y su archivo, junto a la zona inversa (195.168.192.in-addr.arpa) y su archivo.

<img width="978" height="378" alt="image" src="https://github.com/user-attachments/assets/34a30dd1-efa3-4aea-b0e4-727bd1fc4e50" />

### 1.1 Configurando zona DNS directa

Para esta zona, se definirán los siguientes FQDN:

Servidor DNS: ns1

Servidor fpt: ftp1

Servidores de correo: mail1, mail2

Servidores web: www, departamentos

 - Creamos el archivo de zona directa con ```sudo nano /etc/bind/db.marisma.intranet``` y asignamos un registro de autoridad con SOA a los nombres de dominio "ns1.marisma.intranet" y "admin.marisma.intranet", registros A para asignar IPv4 a nombre de dominio y MX para asignar un servidor mal a un nombre específico (va en orden, es decir, a menor número = más prioritario, por lo que prevalecería mail1).

<img width="1026" height="416" alt="image" src="https://github.com/user-attachments/assets/103b953b-2aed-4965-8bbb-e0bebac51b2e" />

### 1.2 Configurando zona DNS inversa

 - Creamos el archivo de zona inversa con el comando ```sudo nano /etc/bind/db.192.168.195```, y al igual que hicimos en la zona directa, usaremos el registro de autoridad SOA con los nombres de dominio "ns1.marisma.intranet" y "admin.marisma.intranet". Posteriormente usaremos los registros PTR, que permite resolver direcciones IP a nombres de dominio.

<img width="1026" height="416" alt="image" src="https://github.com/user-attachments/assets/fd4a966f-9604-40a6-976d-d12a822c5966" />

## 2. Aplicar y comprobar BIND

Comprobamos la sintaxis con el comando ```sudo named-checkconf``` y ```sudo named-checkzone``` tanto para la zona directa como para la zona inversa. Si todo está correcto, reiniciamos el servicio con el comando ```sudo systemctl restart bind9``` y comprobamos el estado con ```sudo systemctl restart bind9```.

<img width="1038" height="647" alt="image" src="https://github.com/user-attachments/assets/55573cbc-3dbc-47b4-8a23-2e5078af7fcc" />

## 3. Configuración del cliente

Editamos el archivo de configuración con ```sudo nano /etc/resolv.conf``` y añadimos la línea "search marisma.intranet", ya que la línea "nameserver 192.168.195.27" ya estaba añadida desde la práctica anterior.

<img width="1038" height="128" alt="image" src="https://github.com/user-attachments/assets/1af47fee-9815-4b54-b73e-7a6a9239fd00" />

## 4. Comprobaciones

Haremos uso del comando ```dig``` para comprobar las resoluciones de cada uno de los registros de las zonas, además usaremos ```ping``` y ```nslookup```.

Primero, comprobamos los registros SOA (autoritativos) vemos que lo resuelve correctamente y devuelve tanto ns1.marisma.intranet. como admin.marisma.intranet.

<img width="1248" height="558" alt="image" src="https://github.com/user-attachments/assets/5a29a2e8-f7c5-40b5-ab4c-e517f132e38b" />

Pasamos a comprobar los registros A y tenemos a marisma.intranet. apuntado a ns1.marisma.intranet junto a ns1.marisma.intranet apuntando a la dirección IP 192.168.195.27.

<img width="973" height="628" alt="image" src="https://github.com/user-attachments/assets/e967f3fe-7793-421f-8e47-8021bc488a04" />

Los registros A, que también los resuelve, recordemos que son los asociados a una IP.

<img width="1241" height="557" alt="image" src="https://github.com/user-attachments/assets/7a8d2c1e-325f-4e6c-bd48-629b2b26992f" />

Registros MX, nos devuelve tanto mail1.marisma.intranet. como mail2.marisma.intranet. a su vez apuntando a la IP del servidor DNS.

<img width="1241" height="668" alt="image" src="https://github.com/user-attachments/assets/d3552d08-21ef-4e8f-a921-02d44cea0c24" />

Comprobamos la resolución inversa con ```-x``` y nos resuelve todos los registros PTR.

<img width="1241" height="668" alt="image" src="https://github.com/user-attachments/assets/af8527d0-a4ab-4fe1-ba03-843c66c3bcc3" />

Por último hacemos ```ping -c2``` a varios de los registros y ```nslookup```, como podemos ver se resuelven todos correctamente.

<img width="1241" height="736" alt="image" src="https://github.com/user-attachments/assets/17330511-257e-476c-b97d-0264965cca6d" />
