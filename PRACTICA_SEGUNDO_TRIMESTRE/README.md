# Práctica Segundo Trimestre - Servidor de alojamiento web

## 0. Pasos previos

Para realizar esta práctica usaremos una máquina virtual con Ubuntu Server 24.04.3, donhde hemos asignados los siguientes recursos en el Proxmox del centro.

<img width="600" height="450" alt="image" src="https://github.com/user-attachments/assets/c57f9e4b-1f31-40a3-8be5-b897f5f7ae3e" />

Una vez hemos creado la máquina virtual, la iniciamos. En el paso de configuración de red pulsamos sobre la interfaz de red - "Edit IPv4".

<img width="1043" height="208" alt="image" src="https://github.com/user-attachments/assets/fdb762aa-13b7-48cd-b558-6e0b4d3c5506" />

Marcamos como método "Manual" e insertamos una dirección IP estática, en este caso mi servidor dispondrá de la dirección 192.168.195.5/24 y su enrutador será 192.168.195.101

<img width="1271" height="577" alt="image" src="https://github.com/user-attachments/assets/6d30e056-7b53-4dfb-80af-f41afa5621cb" />

Creamos un usuario y asignamos un nombre identificativo a nuestro servidor. Insertamos unas credenciales seguras para el usuario.

<img width="1104" height="315" alt="image" src="https://github.com/user-attachments/assets/8d8dfedf-2d87-4ef1-9938-32f03095723e" />

Ubuntu Server nos da la opción de instalar el servicio OpenSSH (servicio SSH) por defecto, marcamos la casilla y pulsamos Intro sobre "Done".

<img width="1042" height="262" alt="image" src="https://github.com/user-attachments/assets/b54650c9-198d-44f6-a323-84147bdea0b2" />

Usamos el comando ```uname -a```, ```ip a```, ```ping -c2 8.8.8.8```

<img width="1027" height="390" alt="image" src="https://github.com/user-attachments/assets/74582953-6527-4e8b-bbde-e05528474f44" />

Ejecutamos el comando ```sudo apt update && sudo apt upgrade -y``` para actualizar la lista de repositorios junto a las aplicaciones del sistema.

<img width="1278" height="373" alt="image" src="https://github.com/user-attachments/assets/38a2c9c8-dab9-4d19-9459-ca84e86bab4f" />

Por último, para la sección de pasos previos, instalamos los paquetes básicos de los que tiene que disponer el sistema.

<img width="933" height="246" alt="image" src="https://github.com/user-attachments/assets/e76abc4e-ef1e-4089-b561-f1a550899665" />

## 1. Instalación de servicios

### 1.1 Instalación de pila LAMP

La pila LAMP está formada por:

 · Linux

 · Apache

 · MySQL/MariaDB

 · PHP

 <img width="1265" height="425" alt="image" src="https://github.com/user-attachments/assets/0089414b-d3a1-41aa-b00f-4c856408a169" />

### 1.2 Instalación de PHP y sus módulos

 <img width="1010" height="200" alt="image" src="https://github.com/user-attachments/assets/da03776e-c465-4674-bab0-bc4c8fea30ef" />

### 1.3 Instalación de PHPMyAdmin

<img width="1283" height="441" alt="image" src="https://github.com/user-attachments/assets/fccf11a2-49d1-4779-bd66-0ba7fb53df83" />

wasd

<img width="771" height="246" alt="image" src="https://github.com/user-attachments/assets/55a382a5-c3c1-4aad-992e-caae48e9b6da" />

wasd

<img width="1262" height="270" alt="image" src="https://github.com/user-attachments/assets/526919e3-205d-4f76-9a92-373d83610b6c" />

wasd

<img width="1105" height="248" alt="image" src="https://github.com/user-attachments/assets/4685a767-fda7-4a63-a158-1723c72fb680" />

wasd

<img width="1284" height="487" alt="image" src="https://github.com/user-attachments/assets/6a161ac4-9e0a-4231-9915-69e0468b3e6b" />

### 1.4 Instalación de FTP

wasd

<img width="502" height="117" alt="image" src="https://github.com/user-attachments/assets/502f3e2e-d1ee-4b69-80a4-f8d363202043" />

Habilitamos

<img width="994" height="279" alt="image" src="https://github.com/user-attachments/assets/0f6eea25-2db2-4958-a354-1590a766777f" />

wasd

### 1.5 Habilitando servicio SSH

wasd

<img width="1019" height="356" alt="image" src="https://github.com/user-attachments/assets/4043009a-bc0f-48ee-9206-5cb1726b97f3" />

### 1.6 Instalación del servidor DNS BIND9

wasd

<img width="598" height="233" alt="image" src="https://github.com/user-attachments/assets/bd0b8a98-a291-44aa-a7b0-d92907d27207" />

### 1.7 Instalación de soporte Python con Apache

wasd

<img width="602" height="209" alt="image" src="https://github.com/user-attachments/assets/62b6e618-d3d1-4da6-a4a8-d395d52836b3" />
