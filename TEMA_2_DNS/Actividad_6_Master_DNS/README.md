# Actividad 6 - Master DNS - Servidor autoritativo

## 1. Crea un fichero de zona para "marisma.intranet", además de la zona de resolución inversa.

Partimos del siguiente punto -> Servidor DNS con dirección IP 192.168.195.27/24 junto a un cliente con Dirección IP 192.168.195.22/24, que ambos en la [Práctica 5](../../TEMA_2_DNS/Actividad_5_Cache_Forwarding) fueron configurados.

Para esta zona, se definirán los siguientes FQDN:
Servidor DNS: ns1
Servidor fpt: ftp1
Servidores de correo: mail1, mail2
Servidores web: www, departamentos

## 2. Completar los ejercicios que se piden

### Configura el servidor DNS con los registros necesarios


### Cambia la configuración del cliente para que emplee el nuevo servidor DNS: /etc/resolv.conf (ver nota a pie de página)

Haz la consultas necesarias para comprobar el correcto funcionamiento del servidor DNS:
(SOA, MX, A, NS). Comprueba además de la resolución inversa.
