# Práctica 2 - Introducción en contenedores

## Objetivos de la actividad

En general, una primera toma de contacto con docker y como funcionan los contenedores de distintas maneras.

Para ello, seguiremos una guía interactiva facilitado por el profe. Donde tendremos que llevar a cabo los ejemplos mostrados en el primer módulo "Introducción a los contenedores Docker".

### Instalación de docker

De aquí, podemos obviar gran parte porque ya lo hicimos en la Actividad 1, no obstante, faltó comprobar la versión de docker y facilitar una captura. Usamos el comando ```docker --version```.

<img width="1637" height="124" alt="image" src="https://github.com/user-attachments/assets/8013b660-2a88-49be-b272-f467937e430c" />

### El "Hola Mundo" de docker

Gran parte del contenido, también ha sido realizado en el la Actividad 1 de Instalación, ya que se lanzó este contenedor como prueba. 

No obstante, dentro del contenido de este módulo hay un dato interesante que conviene recalcar -> "Hello-world" es un contenedor que se ejecuta automáticamente y se baja, es decir, no está en continua ejecución. Por lo que si usamos el comando ```docker ps```, evidentemente no va a salir, porque no está en ejecución. En cambio, podemos usar ```docker ps -a``` para que muestre contenedores tanto en ejecución como no.

Tal y como se puede ver en la siguiente captura, se pueden ver los contenedores con ```docker ps -a``` y se pueden eliminar los contenedores por ID o por nombre con ```docker rm ID``` o ```docker rm nombre```.

<img width="1635" height="962" alt="image" src="https://github.com/user-attachments/assets/d719b5b7-bc1a-445a-9da7-6b8cc2a10831" />

### Ejecución simple de contenedores

Según indica la guia, podemos crear un contenedor para que ejecute un comando temporalmente y automáticamente se pare. Por ejemplo, podemos bajar la imagen de Ubuntu (al ser la primera vez lo descarga de Docker Hub), ejecutar un comando, y luego que el contenedor se pare.

Tal y como se puede ver en la captura, bajamos la imagen de Ubuntu para que muestre por pantalla un "Hello World" y una vez ejecutado el comando, deja de estar en ejecución. Podemos ver la imagen que se ha descargado con ```docker image ls``` o con ```docker images```.

<img width="1644" height="660" alt="image" src="https://github.com/user-attachments/assets/53840bef-debb-4c49-8d49-3cc4bb197918" />

### Ejecutando un contenedor interactivo

Para ejecutar un contenedor interactivo, debemos usar -i -> Indicamos sesión interactiva y -t -> Para ejecutar un terminal e interaccionar con el contenedor. Posteriormente, debemos indicar la imagen (Ubuntu) y asignar un nombre al contenedor, por ejemplo, lo llamaré ubuntu_interactivo, y por último la terminal a ejecutar, que usaré bash. 

Comprobamos dentro del terminal de contenedor con ```uname -a``` que nos muestra info del sistema

<img width="1214" height="133" alt="image" src="https://github.com/user-attachments/assets/450b01dd-2a2a-43da-899e-572c4156de7a" />

Una vez hemos finalizado la conexión con el contenedor, podemos volver a conectarnos usando el comando ```docker start ubuntu_interactivo``` para iniciarlo y ```docker attach ubuntu_interactivo``` para conectarnos a la terminal.

<img width="1217" height="290" alt="image" src="https://github.com/user-attachments/assets/7d67364f-a01b-4178-98be-6d3607dcd5a0" />

