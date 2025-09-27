# Actividad 0.1 - Introducción a HTTP

## Visualiza los siguientes videos y responde a las cuestiones planteadas a continuación
https://www.youtube.com/watch?v=eesqK59rhGA

https://www.youtube.com/watch?v=DuSURHrZG6I

## ¿Quién, dónde y cuándo se crea el primer servidor web?

Tim Berners-Lee fue quien creó en primer servidor web, montado en un ordenador NeXT en el CERN a finales de 1990 (primer servidor web, llamado "httpd")
Con la ayuda de Robert Cailliau creó la World Wide Web desarrollado con NEXTSTEP.

## ¿Qué es pila de protocolos usados por http?

HTTP trabaja en la capa de aplicación, está basada en la pila TCP/IP.

TCP -> Garantiza la entrega confiable de los datos (cliente/servidor).

IP -> Encamina los paquetes entre redes.

## ¿Componentes de una URL?

Una URL se compone de:
· Protocolo o esquema -> Usa http:// o https://

· Nombre de dominio -> Como (www.ejemplo1.com) o (www.ejemplo2.es)

· Puerto -> 80 para HTTP, 443 para HTTPS o se puede usar otros como el 8080.

· Ruta  o recurso -> Camino hacia el archivo o recurso dentro del servidor (/compras/index.html).

· Parámetros de consulta (opcional) -> Distingue la consulta en el sitio web (/compras/index.html?id=5&orden=desc).

· ID de fragmento (opcional) -> Distingue la sección en el sitio web (/compras/index.html#seccion3).

<img width="1707" height="185" alt="image" src="https://github.com/user-attachments/assets/496793ca-e5c8-4c69-8df7-a2755a5d9b1a" />

## ¿Pasos en la recuperación de una página web mediante HTTP?

Conexión cliente/servidor en HTTP:

· El cliente resuelve de nombre de dominio a dirección IP (DNS).

· El cliente inicia una conexión TCP hacia el servidor (:80 HTTP o :443 HTTPS).

· El cliente envía una "Request" (petición HTTP) con un método "GET" y la ruta del recurso.

· El servidor, recibe la solicitud y procesa la petición.

· El servidor envía una "Response" (respuesta HTTP) que incluye: código de estado, cabeceras (headers), y el contenido.

· El cliente recibe la respuesta y la interpreta: analiza cabeceras, tipo de contenido, muestra el contenido, solicita recursos adicionales (imágenes, CSS, JS) si es necesario.

· La conexión se cierra o se mantiene para futuras peticiones.

## Diferencia entre páginas dinámicas y estáticas

En las páginas estáticas, el contenido de la web es fijo, por ejemplo un html; cada cliente que la solicita recibe el mismo contenido.
En cambios, las páginas dinámicas el contenido es manejado por el servidor, por ejemplo Python, PHP, Java... en función de las peticiones de cada usuario, por lo que cada cliente puede recibir un contenido distinto.

## ¿Cómo usar telnet para acceder a un servidor web?

Telnet es una herramienta antigua para conexiones remotas y está prácticamente en desuso, ya que no cifra la comunicación, a diferencia de SSH que sí ofrece seguridad y cifrado.
No obstante, para una conexión telnet se usa el comando:
```
telnet IP puerto (80)
```
Una vez conectados podemos hacer un GET del recurso que queramos.
Ejemplo conectándonos a página de configuración de PC en PcComponentes: 
```
telnet 104.16.27.13 80
```
```
GET /configurador/index.html/1.1
```

## Request. Métodos principales
	
Los métodos más usados en HTTP incluyen:
· GET: solicitar la lectura de un recurso.

· POST: enviar datos al servidor (como formularios) para crear o procesar datos.

· PUT: reemplazar el recurso existente con los datos enviados.

· DELETE: eliminar un recurso.

· HEAD: igual que GET pero solo pide la cabecera, sin el cuerpo del contenido.

· OPTIONS: pregunta al servidor qué métodos admite para ese recurso.

## Response. Códigos

Los códigos de Respuesta HTTP se componen de tres dígitos e indican el resultado de la petición, se dividen en:

· 100–199 -> Informativo, para mensajes provisionales.

· 200-299 -> Petición procesada correctamente (200 OK).

· 300-399 -> Redirección (301 Moved Permanently).

· 400-499 -> Error del cliente / problema con la petición (404 Not Found).

· 500-599 -> Fallo del servidor / problema al procesar peticion (500 Internal Server Error).

## Content type. Tipos principales

Indica el tipo de datos que se envían en el cuerpo de la respuesta. Entre los más comunes:

· text/html → Contenido HTML

· image/png o image/jpeg → Imágenes

· application/javascript → Scripts JS

· text/css → Hojas de estilo CSS

· application/xml o text/xml → XML
