# Actividad 5 - Caching & Fordwarding - DNS Bind9

## 1. Instalar bind en el servidor

Dentro del servidor (Ubuntu Server 24.04) ejecutamos el comando ```sudo apt-get update && sudo apt-get upgrade -y``` para actualizar la lista de paquetes y que las aplicaciones se mantengan en su estado más reciente.

<img width="1666" height="539" alt="image" src="https://github.com/user-attachments/assets/f6f6991b-62d8-459e-ac4b-26ed0492e952" />

Posteriormente, instalaremos el servidor DNS bind9 con el comando ```sudo apt-get install bind9 bind9utils bind9-doc```, confirmamos con la letra "S" y pulsamos Intro.

<img width="861" height="318" alt="image" src="https://github.com/user-attachments/assets/8ac5f6bc-31a9-4a8c-9c82-1a7db683ba50" />

## 2. Configurar servidor DNS para almacenamiento en caché

Accedemos a la carpeta de DNS bind con el comando ```cd etc/bind```, dentro de la carpeta, editamos el archivo de configuraciónm con ```sudo nano named.conf.options```.

<img width="726" height="365" alt="image" src="https://github.com/user-attachments/assets/e2777d23-16a6-48bb-8963-0b98a6a74939" />

Editamos el archivo, dentro de ```options{}```, añadimmos la sección ```forwarders{}``` con IP del router (que resolverá peticiones DNS) y un DNS público, por ejemplo la IP 1.1.1.1 correspondiente al DNS de cloudflare.

<img width="1013" height="604" alt="image" src="https://github.com/user-attachments/assets/2cf5e8c9-dc8a-4c55-ba33-052ce5dfa069" />

Añadimos un ACL por encima de ```options{}``` llamada "autchclients"que contenga la red a la que pertenece el servidor (192.168.195.0/24) y las direcciones "localhost" junto a "localnets".

<img width="1004" height="206" alt="image" src="https://github.com/user-attachments/assets/1269bd4d-d75c-4e14-8bab-05c9da834f3f" />

## 3. Configurar como servidor DNS de reenvío (Forwarding)

------

------

## 4. Probar configuración y reiniciar bind

sudo named-checkconf

sudo systemctl restart bind9

sudo ufw allow Bind9

sudo journalctl -u bind9 -f
