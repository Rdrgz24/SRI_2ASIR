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

## 2. Configuración de servicios

### 2.1 Apache

Activación de módulos:

<img width="839" height="260" alt="image" src="https://github.com/user-attachments/assets/c84c03ac-21c5-40ab-967a-8b2743b24062" />

### 2.2 PHP

wasd

<img width="799" height="106" alt="image" src="https://github.com/user-attachments/assets/7ff4b5de-cc6b-47b8-b8ef-3aca39ab2d89" />

wasd

<img width="797" height="91" alt="image" src="https://github.com/user-attachments/assets/184c183a-d8c3-475e-b5ac-19a584444d65" />

wasd

<img width="771" height="119" alt="image" src="https://github.com/user-attachments/assets/6fb95203-839a-4f05-b289-37b84ff00b2a" />

wasd

### 2.3 MariaDB

wasd

<img width="723" height="285" alt="image" src="https://github.com/user-attachments/assets/437098a7-1b84-4796-b0c8-5645f90dce93" />

### 2.4 PHPMyadmin

wasd

### 2.5 FTP + TLS

wasd

<img width="552" height="24" alt="image" src="https://github.com/user-attachments/assets/b2c45bce-b8e2-4317-b5b6-702d88d54c1d" />

wasd

<img width="454" height="21" alt="image" src="https://github.com/user-attachments/assets/2c551fbe-c2f4-4614-bae5-2b0bed594620" />

wasd

<img width="753" height="270" alt="image" src="https://github.com/user-attachments/assets/d6a29350-9c4e-4cbc-b41d-73d2eb0b1504" />

wasd

<img width="805" height="243" alt="image" src="https://github.com/user-attachments/assets/cf6ff9b8-5605-4b71-9c31-711e6b87b4fc" />

wasd

### 2.6 SSH y SFTP

wasd

<img width="760" height="86" alt="image" src="https://github.com/user-attachments/assets/5c46168f-a39f-4d0e-ad41-4b884e3271bf" />

wasd

<img width="1278" height="388" alt="image" src="https://github.com/user-attachments/assets/b35f471c-c434-4390-8b24-d77a74a57a31" />

wasd

<img width="947" height="326" alt="image" src="https://github.com/user-attachments/assets/0ff51ea1-f012-4c50-9a60-2305acdbdb75" />

### 2.7 Configuración del DNS BIND9

wasd

<img width="774" height="156" alt="image" src="https://github.com/user-attachments/assets/562551d0-2da2-4099-bc89-4d8ba1e1143e" />

wasd

<img width="733" height="262" alt="image" src="https://github.com/user-attachments/assets/31bd6387-2e30-4457-bb6f-0eb3fd594dc0" />

wasd

<img width="800" height="198" alt="image" src="https://github.com/user-attachments/assets/336cba40-4560-4dee-b1b4-c4ca641964a2" />


