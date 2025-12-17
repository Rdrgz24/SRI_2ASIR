# Instalación de Wordpress en instancia Debian(o Ubuntu) EC2 con soporte de base de datos RDS y EFS

La idea de esta actividad es configurar un servidor web Apache montado en una instancia EC2 Debian (o Ubuntu) con un sistema de almacenamiento en EFS y la base de datos gestionada por RDS en una subred privada.
Para ello necesitaremos primeramente un VPC que tenga dos subredes públicas y dos privadas.
Creamos dos subredes públicas con intención de construir al final del ejercicio un balanceador de carga que permita servir contenidos en función de la carga de los servidores.

## 1. Introducción

### Creando VPC

Antes de crear la instancia, debemos crear una VPC, para ello, dentro de la Consola de Administración, nos dirigimos hacia "VPC" - "Crear VPC". Dentro, seleccionamos "Solo la VPC", la etiquetamos como "VPC-WordPress" y asignamos la red 10.0.0.0/16 con la que posteriormente crearemos las subredes.

<img width="1217" height="809" alt="image" src="https://github.com/user-attachments/assets/faf04214-7c59-4b89-a2f8-dcde7f8988c4" />

Tras crear la VPC, la seleccionamos, damos sobre "Actions" - "Edit VPC Settings".

<img width="1673" height="377" alt="image" src="https://github.com/user-attachments/assets/2d01d1dd-90b4-4e32-a680-c02e4e5f394f" />

Habilitamos en las opciones DNS las casillas "Enable DNS resolution" y "Enable DNS hostnames".

<img width="1654" height="626" alt="image" src="https://github.com/user-attachments/assets/41981222-fa11-41d3-be2f-e4165e9091a9" />

### Creando subredes

Dentro de la Consola de Administración, vamos a "Crear subred" y teniendo seleccionada "VPC-WordPress" asignamos el nombre a la subred, ya sea pública o privada y asignamos la subred correspondiente con máscara 255.255.255.0.

<img width="1110" height="774" alt="image" src="https://github.com/user-attachments/assets/bbbfcc3d-e732-4931-8cdc-32cf9994f86d" />

Esta configuración solo se aplica a las subredes públicas; Dentro de "Edit subnet settings" marcamos la casilla "Enable auto-assign public IPv4 address".

<img width="1728" height="401" alt="image" src="https://github.com/user-attachments/assets/bbd0851a-ee67-40a7-a90f-55716a1074f6" />

Creamos todas las subredes, tanto públicas como privadas (todas asignadas a VPC-WordPress) quedando como resultado:

<img width="1752" height="397" alt="image" src="https://github.com/user-attachments/assets/4221add9-3b3d-467e-8353-0c8005e2f797" />

### Creando la puerta de enlace (subredes públicas)

Debemos crear un gateway (puerta de enlace) para las subredes públicas, esto crea un router virtual que conecta una VPC determinada a la red pública. Asignamos un nombre significativo.

<img width="965" height="334" alt="image" src="https://github.com/user-attachments/assets/635f9f8a-6144-42da-8338-81f4f54fc8ec" />

Una vez creada, la seleccionamos y pulsamos sobre "Acciones" - "Conectar a la VPC".

<img width="1752" height="156" alt="image" src="https://github.com/user-attachments/assets/a2a06b57-2fbe-4995-ad11-4ba5a7970059" />

Seleccionamos la VPC creada y pulsamos sobre "Conectar gateway de Internet".

<img width="963" height="207" alt="image" src="https://github.com/user-attachments/assets/5f5930db-ba4d-4b81-bdb6-6686c40591ea" />

### Creando gateway NAT

Este servicio crea un "puente" entre las instancias de subredes privadas e Internet haciendo uso de una "IP elástica".
Asignamos un nombre significativo, seleccionamos "Zonal" en el modo de disponibilidad. Usaremos NAT con la subred "Public-1", esta realizará las traducciones y creamos un ID de asignación de IP elástica. Por último pulsamos sobre "Crear gateway NAT".

<img width="1102" height="622" alt="image" src="https://github.com/user-attachments/assets/cf085196-c495-4b07-8143-f397ce42205c" />

### Creando tabla de enrutamiento

La tabla de enrutamiento permitirá indicar la ruta de salida hacia Internet, subredes u otros servicios de red. En este caso nos servirá para enlazar:

· Subredes públicas - Tabla de enrutamiento pública - Acceso con Puerta de enlace de Internet (ruta) 

· Subredes privadas - Tabla de enrutamiento privada - Acceso con Puerta de enlace NAT (ruta)

#### Tabla de enrutamiento para Internet Gateway <--> Public Subnet

Creamos una tabla de enrutamiento llamada "Public-RT-WordPress" seleccionando la VPC creada anteriormente.

<img width="1111" height="377" alt="image" src="https://github.com/user-attachments/assets/a5ab92e1-6385-46ee-9f8c-02c631338d90" />

Asignamos las rutas, en este caso todo acceso (0.0.0.0/0) saldrá a Internet mediante la puerta de enlace igw anteriormente creada.

<img width="1100" height="242" alt="image" src="https://github.com/user-attachments/assets/289b3beb-1b58-4d5c-9fec-e39b3686137e" />

Una vez creada la tabla de enrutamiento, la asignamos a las dos subredes públicas; Esto permite a las subredes públicas saber que deben seguir la ruta hacia la IGW para salir a Internet.

<img width="1120" height="339" alt="image" src="https://github.com/user-attachments/assets/88ab6978-4853-4d51-859d-e91b51685c2c" />

#### Tabla de enrutamiento para NAT Gateway <--> Private Subnet

Creamos una tabla de enrutamiento llamada "Private-RT-WordPress" seleccionando la VPC creada anteriormente.

<img width="1106" height="376" alt="image" src="https://github.com/user-attachments/assets/521b15c2-0fb1-4fdf-933b-423aa4854613" />

Asignamos las rutas, en este caso todo acceso (0.0.0.0/0) saldrá a Internet mediante la puerta de enlace NAT anteriormente creada.

<img width="1111" height="243" alt="image" src="https://github.com/user-attachments/assets/5462abc6-daff-4869-b264-dc6f4691f244" />

Por último, asignamos las dos subredes privadas a esta tabla de enrutamiento; Esto permite a las subredes privadas saber que deben hacer uso de la ruta hacia NAT.

<img width="1108" height="339" alt="image" src="https://github.com/user-attachments/assets/4e078d00-3740-449e-8374-3e8b7a3eec39" />

## 2. Creación de Instancias

Creamos una instancia llamada "servidorwordpress" por ejemplo con el sistema operativo "Debian", con una "t2.nano" y 15GB de almacenamiento será suficiente para WordPress.

<img width="1252" height="700" alt="image" src="https://github.com/user-attachments/assets/c88d846d-f425-4603-9344-8cd97c804a44" />

Aplicamos las siguientes reglas del grupo de seguridad (SSH y HTTP abierto), creando nosotros un nuevo grupo y asignando todo desde cero.

<img width="1099" height="839" alt="image" src="https://github.com/user-attachments/assets/aab15c46-8ba8-42ef-89d2-d1af198bf943" />

Instancia iniciada y direcciones asignadas correctamente.

<img width="1758" height="428" alt="image" src="https://github.com/user-attachments/assets/a4b51463-3d1c-4426-9bd9-70c98546610f" />

Establecemos conexión por SSH desde el símbolo del sistema de Windows con el comando:

<img width="945" height="313" alt="image" src="https://github.com/user-attachments/assets/205f81e3-67fd-411e-87ee-65565dfd0ad7" />

## 3. Apache y PHP

### Apache

Actualizamos los repositorios con ```sudo apt update``` e instalamos apache con el comando ```sudo apt install apache2```.

<img width="787" height="333" alt="image" src="https://github.com/user-attachments/assets/23f068eb-1902-479c-9d8b-3e5476aff6de" />

Arrancamos el servicio con ```sudo systemctl start apache2```, habilitamos su arranque al iniciar la instancia con ```sudo systemctl enable apache2``` y comprobamos el estado con ```sudo systemctl status apache2```.

<img width="961" height="381" alt="image" src="https://github.com/user-attachments/assets/cf428979-72e6-46f5-8176-c19c0ec4c78d" />

Luego, comprobamos que Apache se ha instalado correctamente en nuestro servidor buscando la IP (o DNS) en nuestro navegador.

<img width="1200" height="720" alt="image" src="https://github.com/user-attachments/assets/9d35f164-8648-4e0b-8d00-9f9292ee5e8d" />

### PHP

Aunque ya previamente actualizamos los repositorios, volvemos a ejecutar ```sudo apt -y update && sudo apt upgrade```. Luego, instalamos PHP con el comando ```sudo apt install php libapache2-mod-php php-cli```.

<img width="935" height="280" alt="image" src="https://github.com/user-attachments/assets/da82e707-23a7-4840-a7dc-45f3b5526023" />

PHP correctamente instalado.

<img width="533" height="99" alt="image" src="https://github.com/user-attachments/assets/77e73a75-c6c0-490c-ae0d-176cf8bded38" />

### MySQL

Instalamos MySQL como módulo de PHP con el comando ```sudo apt install php-mysql```

<img width="484" height="223" alt="image" src="https://github.com/user-attachments/assets/0ab48088-ea6a-49a6-bd18-c0fc7de52028" />

Tras instalar PHP y MySQL, reiniciamos el servicio de Apache ```sudo systemctl start apache2```, comprobamos el estado ```sudo systemctl status apache2```, y por último verificamos que los módulos de MySQL se añadieron a PHP ```php --modules | grep mysql```.

<img width="958" height="435" alt="image" src="https://github.com/user-attachments/assets/07145275-fd53-4ef9-b4d2-9daa982275a9" />

## 4. Creación de la base de datos

Dentro del servicio RDS, pulsamos sobre "Configuración completa" y seleccionamos "MySQL" como tipo de base de datos. Para el tipo de plantilla usaremos "Sandbox".

<img width="1115" height="793" alt="image" src="https://github.com/user-attachments/assets/74826731-3e56-46de-a6ac-38adda090bc3" />

Seleccionamos que solo tenga una instancia para disponibilidad, identificamos la base de datos con "DBwordpress" usuario "admin", contraseña "adminadmin" (debemos pulsar sobre self-managed).

<img width="1099" height="837" alt="image" src="https://github.com/user-attachments/assets/d1c034b8-df9e-4c64-ac41-1ede5f54575c" />

Como tipo de base de datos, podemos elegir, entre otras la db.t3.micro. Disco ssd principal de 20GB (suficiente). Paso importante, debemos seleccionar la VPC de WordPress y crear una nueva subred para la DB (denegamos acceso público).

<img width="1124" height="856" alt="image" src="https://github.com/user-attachments/assets/c781cade-f1ed-4512-ad1c-ba76fc7dba7b" />

Además, asignaremos un nuevo grupo de seguridad a la RDS llamado "WordpressDBseguridad".

<img width="1089" height="375" alt="image" src="https://github.com/user-attachments/assets/b232ad09-342c-4f38-a649-4909e063813e" />

Como configuración adicional, es muy importante indicar el nombre inicial de la base de datos, la llamaremos "DBwordpress". 

<img width="733" height="238" alt="image" src="https://github.com/user-attachments/assets/592f85d3-d9b6-45a9-969a-f72a069b82df" />

Base de datos correctamente creada, luego la asignamos a la instancia EC2 "servidorwordpress" pulsando sobre "Acciones" - "Configurar conexión EC2". En la captura se ve como está correctamente asignada a la instancia.

<img width="1730" height="764" alt="image" src="https://github.com/user-attachments/assets/90ea8050-8bdf-496b-9c1f-3699b3214fa8" />

## 5. Elastic File System (EFS)

Dentro de servicios, pulsamos sobre "EFS", "Create File System", asignamos el nombre "almacenwordpress" y seleccionamos nuestra VPC-WordPress, el resto de configuración se dejará de manera predeterminada.

<img width="540" height="545" alt="image" src="https://github.com/user-attachments/assets/0ec40f91-c386-47fb-88f1-fcb9613f7835" />

Comprobamos que está creado (salen 4 mount targets porque tenemos 4 zonas de disponibilidad distintas por las subredes creadas manualmente y las de RDS, creadas automáticamente).

<img width="1114" height="333" alt="image" src="https://github.com/user-attachments/assets/15b2dcbd-d0f0-4f94-acc0-7b0d2eb877b4" />

Editamos el grupo de seguridad de la instancia EC2 "seguridad WordPress" y permitimos acceso de la instancia al EFS.

<img width="1397" height="366" alt="image" src="https://github.com/user-attachments/assets/5e0d1a4c-e81f-474e-ab2a-6b6b73350e1c" />

Nos conectamos vía IP.

<img width="1832" height="391" alt="image" src="https://github.com/user-attachments/assets/b1b7b263-5d50-4877-bb3a-5a4ecb6c5bf4" />

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Tras probar me dió "Error connection time out", esto me llevó a investigar y verificar la configuración de la instancia EC2 y de EFS, finalmente, encontré el error. Las zonas de disponibilidad eran distintas, y al intentar montar por IP no encontraba, EC2 estaba en "us-east-1e" y EFS estaba en todas menos en esa. ¿Qué hice? Sencillo, añadir en las "mount targets" la zona de disponibilidad "us-east-1e".

<img width="1079" height="51" alt="image" src="https://github.com/user-attachments/assets/62ff5901-9257-4a41-a532-e14e1f0ff577" />

Además de añadir en las reglas de entrada de la EFS -> Permitir vía NFS el security group de la EC2.

<img width="1076" height="58" alt="image" src="https://github.com/user-attachments/assets/ebb8c312-93f0-42ba-b89f-219552046fb5" />

Ahora conectamos vía IP con zona de disponibilidad "us-east-1e":

<img width="661" height="144" alt="image" src="https://github.com/user-attachments/assets/142754cf-2ad0-46b7-b76d-4029065407ab" />

Ahora sí, creamos la carpeta, insertamos el comando correspondiente y verificamos con ```sudo mount | grep nfs```.

<img width="1457" height="116" alt="image" src="https://github.com/user-attachments/assets/a5570150-9e3f-443b-b09b-293e15ffe49b" />

Conexión con EFS completada.

## 6. Descarga de WordPress



## 7. Comprobación final
