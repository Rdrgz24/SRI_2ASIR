# Instalación de Wordpress en instancia Debian(o Ubuntu) EC2 con soporte de base de datos RDS y EFS

La idea de esta actividad es configurar un servidor web Apache montado en una instancia EC2 Debian (o Ubuntu) con un sistema de almacenamiento en EFS y la base de datos gestionada por RDS en una subred privada.
Para ello necesitaremos primeramente un VPC que tenga dos subredes públicas y dos privadas.
Creamos dos subredes públicas con intención de construir al final del ejercicio un balanceador de carga que permita servir contenidos en función de la carga de los servidores.

## 1. Introducción


### Creando VPC

Antes de crear la instancia, debemos crear una VPC, para ello, dentro de la Consola de Administración, nos dirigimos hacia "VPC" - "Crear VPC". Dentro, seleccionamos "Solo la VPC", la etiquetamos como "VPC-WordPress" y asignamos la red 10.0.0.0/16 con la que posteriormente crearemos las subredes.

<img width="1217" height="809" alt="image" src="https://github.com/user-attachments/assets/faf04214-7c59-4b89-a2f8-dcde7f8988c4" />

### Creando subredes

Dentro de la Consola de Administración, vamos a "Crear subred" y teniendo seleccionada "VPC-WordPress" asignamos el nombre a la subred, ya sea pública o privada y asignamos la subred correspondiente con máscara 255.255.255.0.

<img width="1110" height="774" alt="image" src="https://github.com/user-attachments/assets/bbbfcc3d-e732-4931-8cdc-32cf9994f86d" />

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

#### Tabla de enrutamiento para Internet Gateway <--> Public Subnet

#### Tabla de enrutamiento para NAT Gateway <--> Private Subnet

## 2. Creación de Instancias



## 3. Apache y PHP

## 4. Creación de la base de datos

## 5. Elastic File System (EFS)

## 6. Descarga de WordPress

## 7. Comprobación final
