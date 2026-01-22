# Actividad 5 - Caching & Fordwarding - DNS Bind9

## 0. Detalles de configuración y red

wasd

<img width="1326" height="607" alt="image" src="https://github.com/user-attachments/assets/a543cd53-8761-4047-9d95-771900468ea5" />

wasd

## 1. Instalar bind en el servidor

Dentro del servidor (Ubuntu Server 24.04) ejecutamos el comando ```sudo apt-get update && sudo apt-get upgrade -y``` para actualizar la lista de paquetes y que las aplicaciones se mantengan en su estado más reciente.

<img width="1666" height="539" alt="image" src="https://github.com/user-attachments/assets/f6f6991b-62d8-459e-ac4b-26ed0492e952" />

Posteriormente, instalaremos el servidor DNS bind9 con el comando ```sudo apt-get install bind9 bind9utils bind9-doc```, confirmamos con la letra "S" y pulsamos Intro.

<img width="861" height="318" alt="image" src="https://github.com/user-attachments/assets/8ac5f6bc-31a9-4a8c-9c82-1a7db683ba50" />

## 2. Configurar servidor DNS para almacenamiento en caché

Accedemos a la carpeta de DNS bind con el comando ```cd etc/bind```, dentro de la carpeta, editamos el archivo de configuraciónm con ```sudo nano named.conf.options```.

<img width="726" height="365" alt="image" src="https://github.com/user-attachments/assets/e2777d23-16a6-48bb-8963-0b98a6a74939" />

Añadimos un ACL por encima de ```options{}``` llamada "autchclients" que contenga la red a la que pertenece el servidor (192.168.195.0/24) y las direcciones "localhost" junto a "localnets".

<img width="1004" height="206" alt="image" src="https://github.com/user-attachments/assets/1269bd4d-d75c-4e14-8bab-05c9da834f3f" />

Tras crear la ACL con los clientes permitidos, habilitaremos ```recursion``` ("x" clientes continuos, primero los de allow-query-caché, luego los localhost, por último los localnets) e indicamos con ```allow-query``` la ACL "authclients".

<img width="991" height="278" alt="image" src="https://github.com/user-attachments/assets/47852006-2802-443c-94cc-c2c69c7d2541" />

Comprobamos la sintaxis del archivo con el comando ```sudo named-checkconf```, si en el resultado no sale alguna alerta tipo "Missing ; on line ..." o similar, estará todo correcto. Posteriormente, reiniciamos el servicio para aplicar la configuración con el comando ```sudo systemctl restart bind9```.

<img width="644" height="78" alt="image" src="https://github.com/user-attachments/assets/1f79d31c-30ff-432a-afab-9a60a24cbcee" />

Comprobamos que el puerto 53 esté escuchando tras aplicar la configuración. En este caso usé el comando ```sudo ss -tulpn | grep :53```. Para entender este comando, voy a desglosarlo un poco -> ```sudo ss``` (referente a Socket Statistics como super usuario) -tulpn (t -> tcp, u -> udp, l -> listen, p -> mostrar proceso que lo usa, n -> mostrar numéricamente), luego hacemos un "grep" para encontrar dentro de la salida, todo lo que contenga ":53".

<img width="1160" height="286" alt="image" src="https://github.com/user-attachments/assets/9a5a2cab-0429-475a-bf84-86cc5e097b3f" />

## 3. Configurar como servidor DNS de reenvío (Forwarding)

Tras configurar nuestro servidor DNS como almacenamiento caché, toca configurarlo como servidor DNS de reenvío. Esta configuración, permitirá al servicio DNS que los peticiones / solicitudes que no se puedan resolver localmente  se envíen a servidores DNS externos que nosotros indiquemos. 

Para ello, volvemos a editar el archivo de configuración con ```sudo nano named.conf.options``` y dentro de ```options{}```, descomentamos la sección ```forwarders{}``` con IP del DNS de oogle (8.8.8.8) y de cloudflare DNS (1.1.1.1).

<img width="800" height="550" alt="image" src="https://github.com/user-attachments/assets/2e81b47c-a3b7-409c-afbe-1799c1907828" />

## 4. Probar configuración y reiniciar bind

Tras guardar el archivo ```named.conf.options```, comprobamos la sintaxis con el comando ```sudo named-checkconf```, como podemos ver da error con la línea "dnssec-enable", esto es debido a que es una directiva obsoleta, ya dnssec viene activado internamente por defecto, solo está pendiente de si se valida o no.

<img width="875" height="79" alt="image" src="https://github.com/user-attachments/assets/c0643003-f789-4c43-8c14-d7511e5abe52" />

Por lo que esta línea quedará totalmente borrada de nuestro archivo de configuración. Para ello editamos con ```sudo nano named.conf.options``` y guardamos los cambios.

<img width="800" height="550" alt="image" src="https://github.com/user-attachments/assets/3d94665a-a364-418a-adcd-6ef6272d5f32" />

Comprobamos la sintaxis nuevamente con ```sudo named-checkconf```, habilitamos el DNS en el firewall ufw con ```sudo ufw allow Bind9``` y por último reiniciamos el servicio con ```sudo systemctl restart bind9```.

<img width="648" height="140" alt="image" src="https://github.com/user-attachments/assets/e3e77fa4-c6ba-470e-bc95-ca0bd207504c" />

Antes de hacer

<img width="1284" height="228" alt="image" src="https://github.com/user-attachments/assets/770ec35f-1916-447f-b82f-1139be1b7a5c" />


