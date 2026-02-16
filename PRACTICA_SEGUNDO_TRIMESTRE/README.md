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

wasd
