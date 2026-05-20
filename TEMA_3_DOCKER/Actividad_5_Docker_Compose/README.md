# 5. Creando contenedores con Docker Compose

## Objetivos a realizar

 · Para esta actividad, se llevará a cabo el despliegue de contenedores con Docker Compose, completando un mínimo de tres ejemplos del curso. 

En el módulo anterior de almacenamiento y redes, escogí la app de temperaturas, WordPress + MariaDB y Tomcat + Nginx. Para esta, voy a dejar de lado el despliegue de tomcat y nginx porque me parece algo demasiado sencillo. Por ello, voy a probar con el despliegue de Guestbook, que no lo hice en la act anterior y así me informo de la utilidad que brinda esta app.

### 1. Ejemplo 1: Despliegue de la aplicación guestbook

Para cada uno de los ejemplos voy a crear una carpeta que guarde cada compose. Empiezo creando la primera con el comando ```mkdir compose1``` y posteriormente creo el archivo totalmente vacío haciendo una redirección de un echo sin contenido. El archivo tiene que llamarse "docker-compose.yaml", y aquí dentro es donde se define el escenario a ejecutar.

<img width="1217" height="164" alt="image" src="https://github.com/user-attachments/assets/2cb22d6c-244f-4999-bdb4-65359b33fdfc" />

Tras crearlo vacío, lo edito con ```nano docker-compose.yaml```. Añado el siguiente contenido:

<img width="1208" height="421" alt="image" src="https://github.com/user-attachments/assets/94d68fde-0363-427a-a712-9221d9120a06" />

Primero se define la estructura de los contenedores a crear, indicando el nombre del ct, imagen a usar, estado, comando a ejecutar...

Como se puede ver en la imagen, indicamos con una variable de entorno que el servidor REDIS a usar es el del nombre del container, en este caso redis-sri. El ct de guestbook servirá en el puerto 8080, interno 5000. Y redis usará el volumen de datos "/data", indicando con --append-only yes que debe usar el volumen indicando para guardar la información.


