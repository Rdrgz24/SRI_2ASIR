# 5. Creando contenedores con Docker Compose

## Objetivos a realizar

 · Para esta actividad, se llevará a cabo el despliegue de contenedores con Docker Compose, completando un mínimo de tres ejemplos del curso. 

En el módulo anterior de almacenamiento y redes, escogí la app de temperaturas, WordPress + MariaDB y Tomcat + Nginx. Para esta, voy a dejar de lado el despliegue de tomcat y nginx porque me parece algo demasiado sencillo. Por ello, voy a probar con el despliegue de Guestbook, que no lo hice en la act anterior y así me informo de la utilidad que brinda esta app.

### Ejemplo 1: Despliegue de la aplicación guestbook

Para cada uno de los ejemplos voy a crear una carpeta que guarde cada compose. Empiezo creando la primera con el comando ```mkdir compose1``` y posteriormente creo el archivo totalmente vacío haciendo una redirección de un echo sin contenido. El archivo tiene que llamarse "docker-compose.yaml", y aquí dentro es donde se define el escenario a ejecutar.

<img width="1217" height="164" alt="image" src="https://github.com/user-attachments/assets/2cb22d6c-244f-4999-bdb4-65359b33fdfc" />

Tras crearlo vacío, lo edito con ```nano docker-compose.yaml```. Añado el siguiente contenido:

<img width="1208" height="421" alt="image" src="https://github.com/user-attachments/assets/94d68fde-0363-427a-a712-9221d9120a06" />

Primero se define la estructura de los contenedores a crear, indicando el nombre del ct, imagen a usar, estado, comando a ejecutar...

Como se puede ver en la imagen, indicamos con una variable de entorno que el servidor REDIS a usar es el del nombre del container, en este caso redis-sri. El ct de guestbook servirá en el puerto 8080, interno 5000. Y redis usará el volumen de datos "/data", indicando con --append-only yes que debe usar el volumen indicando para guardar la información.

Levantamos el escenario con el comando ```docker compose up -d``` y verificamos con ```docker ps```. Nos salta un warning porque dentro del compose he declarado "version" tal cuál se hace en el curso, pero indica que es una clausula obsoleta, por lo que la obviaré para el siguiente compose.

<img width="1216" height="331" alt="image" src="https://github.com/user-attachments/assets/9e321dd5-6889-4a06-a487-0686c57bc545" />

Pruebo guestbook, aparentemente solo es una lista? Pensaba que tendría algo más de utilidad :(

<img width="1213" height="543" alt="image" src="https://github.com/user-attachments/assets/c8482406-f525-440a-9de7-51a32282d3fd" />

Paro los container recientemente creados con ```docker compose stop```, que literalmente para lo que está en ejecución relacionado con el escenario levantado. Y luego, elimino el escenario al completo con ```docker compose down```, que borra absolutamente todo, incluyendo contenedores y redes.

<img width="1215" height="354" alt="image" src="https://github.com/user-attachments/assets/67740434-0db7-4922-aa82-a1a78f47d9bf" />

### Ejemplo 2: Despliegue de la aplicación Temperaturas

En este caso, se va a desplegar lo mismo que en la actividad anterior (almacenamiento y redes) pero con un entorno. En lugar de desplegar contenedores individualmente, se despliega en conjunto con compose. Util, verdad :) ?

Creo estructura y archivo, luego lo edito con ```nano```.

<img width="1216" height="147" alt="image" src="https://github.com/user-attachments/assets/16768563-a041-4ba5-ade2-bece0327ee0d" />

Creo el compose indicando el escenario. Un frontend exponiendo puerto 8081 del host anfitrión, conectado internamente con un backend que gestiona las temperaturas.

<img width="1209" height="365" alt="image" src="https://github.com/user-attachments/assets/13de57e0-b5e4-40ac-964f-c79fd75dc13b" />

Levanto el escenario con el comando ```docker compose up -d``` y compruebo con ```docker ps```

<img width="1215" height="283" alt="image" src="https://github.com/user-attachments/assets/9c15c1b6-66ad-472f-a36e-07d5abb7345f" />

Revisamos temperaturas en Huelva y ya va subiendo la calor...

<img width="1210" height="573" alt="image" src="https://github.com/user-attachments/assets/a3a02c7e-fd26-4793-9923-720440cc6954" />

Paramos el escenario con ```docker compose stop```, si quieres borrarlo usa ```down```, yo lo voy a dejar para la próxima chequear temperaturas :)

### Ejemplo 3: Despliegue de WordPress + MariaDB

Este despliegue es más completito, además de que es un clásico. Aquí vamos a usar volúmenes de datos asociados a cada container. Lo mismo que desplegamos antes manualmente por cada container en la Act 4, pero todo en un solo archivo y desplegando al instante. Después dudan de porque usar Docker...

Empiezo creando estructura, archivo y lo edito.

<img width="1216" height="129" alt="image" src="https://github.com/user-attachments/assets/cf48d458-fc3d-4b6f-9bbe-759378ce6977" />

Relleno todo el compose y lo explico debajo de la imagen.

<img width="1207" height="578" alt="image" src="https://github.com/user-attachments/assets/efa29ecd-d2e5-4dd7-bdb1-7c230bc16919" />

Muy sencillo, se levantan dos container docker, uno para wp y otro para mariadb, cada uno de estos tiene un "Named Volume" gestionado por docker. Están conectados entre sí y wp usa la DB indicada en el compose. No tiene más historia. 

Levantamos entorno y se observan volúmenes creados.

<img width="1213" height="526" alt="image" src="https://github.com/user-attachments/assets/e57145f0-2ba7-49d8-b590-d3661aabe9fa" />

Sitio de WP desplegado!

<img width="1211" height="496" alt="image" src="https://github.com/user-attachments/assets/3f8b8f2e-af1c-46dd-8f23-126c01dcbd72" />

#### Usando bind-mount

Existe una diferencia entre el código del compose anterior, que simplemente indicamos wordpress_data y docker elige donde guardarlo. Y, si usamos el nuevo código, donde se indica donde se guardará el volumen.

Es decir, en uno, YO indico donde se guarda, en otro decide DOCKER donde guardarlo. Más control / menos control.

Para este ejemplo no voy a hacer cambios sobre la guía del tutorial, solo me interesa que se vea la diferencia. Simplemente he cambiado puerto del 80 al 81, renombrado el ct de mysql y quitado la clausula "version".

<img width="1198" height="529" alt="image" src="https://github.com/user-attachments/assets/7b78efc7-8486-49d2-adb1-1d9f036e2cea" />

Despliego entorno.

<img width="1216" height="406" alt="image" src="https://github.com/user-attachments/assets/5e32faad-069a-4292-9bea-901f7075ffc4" />

Se pueden observar los contenedores correctamente creados. Además, los volúmenes están creados dentro de la carpeta del entorno, tal cuál se ha indicado en el compose.

Instalador de WP Disponible en puerto 81 :)

<img width="1210" height="722" alt="image" src="https://github.com/user-attachments/assets/581ae97e-d76b-463e-a3d5-8e4ab19ee808" />

Para borrar todo el entorno, en este caso hay algo muy peculiar. Y es que, para borrar los volúmenes hay que usar el comando ```docker compose down -v```, donde, -v indica que también se borren volúmenes.

<img width="1208" height="666" alt="image" src="https://github.com/user-attachments/assets/e6c51922-f44e-421c-ad35-6db244b2498d" />

Pero... me acabo de dar cuenta de una cosa. Y es que, se borran volúmenes creados por docker (named volumes), en cambio, el volumen creado con bind-mount, no. Esto es extremadamante útil, ya que podemos mantener un entorno desplegado durante un tiempo, borrarlo y luego volverlo a desplegar usando estos mismos volúmenes con montaje vinculado (bind).

<img width="1215" height="490" alt="image" src="https://github.com/user-attachments/assets/c628ad20-b38c-4d6f-b026-4ada5769cd38" />

OJO -> Si quieres borrar solo containers usa ```docker compose rm```, pero... si quieres borrar todo, incluido volúmenes y redes, lo dicho antes -> ```docker compose down -v```.
