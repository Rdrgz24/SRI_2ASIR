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

## 4. Creación de la base de datos

## 5. Elastic File System (EFS)

## 6. Descarga de WordPress

## 7. Comprobación final
