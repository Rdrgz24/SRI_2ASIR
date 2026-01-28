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

<img width="1026" height="416" alt="image" src="https://github.com/user-attachments/assets/103b953b-2aed-4965-8bbb-e0bebac51b2e" />

### 1.2 Configurando zona DNS inversa

wasd

<img width="1026" height="416" alt="image" src="https://github.com/user-attachments/assets/fd4a966f-9604-40a6-976d-d12a822c5966" />


## Aplicar y comprobar BIND


## Configuración del cliente

## Comprobaciones
