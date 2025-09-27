# Actividad 0.2 - UDP and TCP: Comparison of Transport Protocols

Visualizar vídeo -> https://www.youtube.com/watch?v=Vdc8TCESIg8

## Diferencias entre udp y tcp

TCP (Transmission Control Protocol) es un protocolo orientado a la conexión, proporciona fiabilidad y orden en la transmisión de datos. Establece una conexión antes de transmitir los datos y garantiza que los paquetes se entreguen con mecanismos de comprobación de errores y control del flujo. Se suele usar en entornos donde la entrega de paquetes es crucial.

UDP (User Datagram Protocol) a diferencia de TCP es un protocolo sin conexión, rápido y con menos sobrecarga. No garantiza la entrega ni el orden de datos. Se usa en entornos donde se toleran pérdidas de datos y se da preferencia a la velocidad de entrega de datos.

## ¿Qué aplicaciones usan tcp?

TCP es usado en aplicaciones que requieren de una transmisión fiable y ordenada de datos, por ejemplo:

· HTTP/HTTPS: Para la navegación web.

· SMTP: Envío de correos electrónicos.

· POP3/IMAP: Recepción de correos electrónicos.

· FTP/SFTP: Transferencia de archivos.

· SSH: Acceso remoto seguro a sistemas.

## ¿Qué aplicaciones usan udp?

UDP es usado en aplicaciones donde la velocidad es crucial y puede tolerar cierta pérdida de datos, por ejemplo:

· DNS: Para la resolución de nombres de dominio.

· VoIP: Llamadas de voz por Internet.

· Streaming de video y audio: Servicios como IPTV (Televisión por IP).

· Juegos en línea: Aplicaciones que requieren baja latencia.

· TFTP: Transferencia de archivos sencilla.

## ¿Qué capa almacena el puerto?

Teniendo en cuenta el Modelo OSI, la Capa de Transporte (4) es la encargada de las conexiones de extremo a extremo y el direccionamiento de puertos.

## ¿Qué capa almacena la dirección IP?

La Capa de Red (3) es la encargada del enrutamiento de paquetes en diferentes redes

## ¿Qué es three-way handshake?

Es un proceso de conexión que realiza el protocolo TCP para asegurar la comunicación antes de enviar los paquetes de extremo a extremo (cliente/servidor).

Está compuesto por los segmentos: SYN (Sincronizar) y ACK (Acuse de recibo)

Tres pasos para realizar la conexión:

· SYN: El cliente envía un segmento con el flag SYN activado para proponer el inicio la conexión.

· SYN-ACK: El servidor responde con un segmento que tiene los flags SYN y ACK activados, indicando que ha recibido la solicitud y está dispuesto a establecer la conexión.

· ACK: El cliente envía un segmento con el flag ACK activado, confirmando la recepción del mensaje del servidor.

