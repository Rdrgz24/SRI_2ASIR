# Actividad 10 - Certificado SSL autofirmado 

Para el siguiente ejercicio se debe usar una instancia EC2 de AWS con una IP pública.

## 1. Crear un certificado ssl. Activar el módulo ssl, configura el VirtualHost SSL y comprobar que todo funciona correctamente.

### Creación del certificado autofirmado

Primero, creamos el certificado autofirmado en nuestra máquina de AWS.

<img width="1918" height="600" alt="image" src="https://github.com/user-attachments/assets/3233f7db-9ac8-40e1-802c-4ab83293a083" />

Comprobamos que se ha creado correctamente, y vemos su fecha de caducidad (365 días).

<img width="1355" height="88" alt="image" src="https://github.com/user-attachments/assets/a5b7a326-8ac0-4509-9833-b91c37f3a082" />

Editamos la configuración del archivo default-ssl.conf añadiendo el ServerName y los indices.

<img width="800" height="550" alt="image" src="https://github.com/user-attachments/assets/0def3dc7-de4d-4e41-a5f0-34e74ae192b7" />

Habilitamos el sitio default-ssl.conf y el módulo ssl para poder hacer uso de ellos.

<img width="800" height="223" alt="image" src="https://github.com/user-attachments/assets/a2515290-18a6-4442-9c66-c62b367034a1" />

Editamos la configuración del archivo 000-default.conf añadiendo el ServerName y la redirección de HTTP a HTTPS.

<img width="800" height="550" alt="image" src="https://github.com/user-attachments/assets/24e067a4-4e1b-46d1-8b00-da750bda0247" />

Habilitamos el módulo rewrite y restablecemos el servicio de Apache.

<img width="527" height="87" alt="image" src="https://github.com/user-attachments/assets/6aecce59-e40d-48c7-a10d-df8afbf79f26" />

Accediendo al DNS público que nos proporciona AWS vemos que ya tenemos el certificado HTTPS; recalcar que el mensaje "No seguro" sale porque el certificado no está validado por una entidad certificadora, aunque podemos ver que la información coincide con la rellenada. 

<img width="1240" height="731" alt="image" src="https://github.com/user-attachments/assets/59f1e711-f50e-4571-9e6b-979ca5e9269a" />

## 2. Registrate en no-ip y configura los DNS para que apunten a la dirección pública de la instancia. A continuación instala certbot y comprueba que todo funciona correctamente.

Tras registrarme en no-ip, dentro de "DNS Records" pulsamos sobre "Create Hostname" y añadimos un registro de tipo A, con hostname awspractica y extensión ddns.net -> apuntando a la IP pública de nuestra máquina EC2 de AWS.

<img width="1483" height="398" alt="image" src="https://github.com/user-attachments/assets/0c6dde68-3857-49d9-965b-b34bf56cf6af" />

Probamos la correcta resolución de la dirección DNS con el comando nslookup.

<img width="507" height="131" alt="image" src="https://github.com/user-attachments/assets/2a239c9e-faf0-4633-ae16-9fee170a4b2d" />

En este caso podemos instalar certbot con repositorios de apt.

<img width="1727" height="173" alt="image" src="https://github.com/user-attachments/assets/50be0be4-ffb9-4cf8-ad89-20a357e0e72f" />

Y... aquí empiezan los errores...

<img width="1394" height="716" alt="image" src="https://github.com/user-attachments/assets/8b56e5fe-63b3-4bb8-aaa1-12256bd67850" />

¿Qué ha pasado en este caso? Muy simple, estamos intentando generar un certificado para "awspractica.ddns.net" y tenemos en los archivos de configuración awspractica.marisma -> Esto provoca un error, ya que no tiene donde redirigir el registro DNS a una IP pública que está apuntando a un host virtual distinto. ¿Solución? cambiar el servername de "awspractica.marisma" a "awspractica.ddns.net" en 000-default.conf y default-ssl.conf.

Quedando de la siguente manera (solo muestro modificaciones):

<img width="1177" height="229" alt="image" src="https://github.com/user-attachments/assets/590203bf-6185-4e93-85c9-ed50c12d5e2c" />
<img width="1176" height="252" alt="image" src="https://github.com/user-attachments/assets/404f71e6-b7c9-4c7b-9d35-4cd5ddc0c3ad" />

Tras encontrar el error y solventarlo, el certificado se realiza con certbot perfectamente, apuntando al DNS que nos brindó no-ip. 

<img width="1148" height="392" alt="image" src="https://github.com/user-attachments/assets/8483f5cf-3c45-412d-8eb0-bb1d1ec490e1" />

Ahora, accedemos a la URL con el nombre de dominio proporcionado por no-ip (https://awspractica.ddns.net) y tenemos un certificado SSL válido.

<img width="1695" height="505" alt="image" src="https://github.com/user-attachments/assets/bde4f8f2-a6a7-4838-97d2-601dc001aefb" />

