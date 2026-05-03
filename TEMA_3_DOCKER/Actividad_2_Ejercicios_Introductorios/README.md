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

Una vez hemos finalizado la conexión con el contenedor, podemos volver a conectarnos usando el comando ```docker start ubuntu_interactivo``` para iniciarlo y ```docker attach ubuntu_interactivo``` para conectarnos a la terminal. Si hacemos un "exit" y ejecutamos un ```docker ps``` no se muestra, porque una vez terminamos la sesión deja de ejecutarse. No se borra, solo se para.

<img width="1217" height="290" alt="image" src="https://github.com/user-attachments/assets/7d67364f-a01b-4178-98be-6d3607dcd5a0" />

También existe la posibilidad de mandar comandos con la sentencia ```docker exec ubuntu_interactivo COMANDO```. Tal y como podemos ver, aquí el contenedor no se para, podemos mandar los comandos que queramos y el contenedor sigue activo hasta orden de apagado o conexión / desconexión desde terminal.

<img width="1636" height="802" alt="image" src="https://github.com/user-attachments/assets/c1b9e95a-340f-4a63-8205-233c6762ed01" />

Por otra parte, tenemos las sentencias:

```docker restart ubuntu_interactivo``` -> Nos permite reiniciar el contenedor, literalmente lo que hace es pararlo y volver a iniciarlo.

```docker inspect ubuntu_interactivo``` -> Nos permite visualizar toda la información del contenedor que se indica.

<img width="1639" height="1037" alt="image" src="https://github.com/user-attachments/assets/f26247af-a141-4cbf-9a02-3d00f17384db" />

Según muestra la guía, si levantamos un contenedor de ubuntu, no es necesario indicar la terminal a usar, ya que tienen de manera preestablecida / por defecto el proceso bash o terminal que usará. Vamos a probar creando otro contenedor sin indicar "bash". Uso ```docker run -it --name ubuntu2 ubuntu```.

<img width="1637" height="751" alt="image" src="https://github.com/user-attachments/assets/fbee2202-a69c-41c5-b00b-bb9934094bd1" />

Efectivamente, la teoría es cierta, en este caso la imagen de Ubuntu ya contiene el proceso bash, y no tenemos que indicarlo. Bastante interesante.

### Creando un contenedor demonio

Un contenedor demonio permite ejecutar comandos en segundo plano, en lugar de nosotros mandar un comando y que se ejecute una vez, al instante, podemos dejar un comando preestablecido y que se quede ejecutando el tiempo que indiquemos. Esto estaría bien, por ejemplo, para comprobar nuestra IP pública, si fuese dinámica, cada 2 o 5 minutos y si cambia, que lo actualice en "x" sitio que indiquemos.

Voy a realizar el ejemplo de la guía para que se pueda ver visualmente como funciona esto. Se usa -d para ejecutar el comando del contenedor en segundo plano.

<img width="1642" height="853" alt="image" src="https://github.com/user-attachments/assets/52543dad-b0f8-4834-9a13-65fbe2dbcad6" />

Tenemos dos formas de eliminar un contenedor:

· Paramos y borramos con ```docker stop ubuntu_demonio``` y ```docker rm ubuntu_demonio``` (es la recomendada).

· Pero si un contenedor se resiste (no es lo común), podemos borrarlo a la fuerza con ```docker rm -f ubuntu_demonio```.

### Creando un contenedor con un servidor web

Levantamos un contenedor con la imagen de apache versión 2.4, donde indicamos con la opción -p el puerto que usará el contenedor. aquí conviene detenernos un poco, ya que tiene su concepto: ```8080:80``` indica, usa el puerto de la izquierda dentro del host anfitrión ```8080``` y usa el puerto de la derecha internamente para el contenedor ```80```. Aunque aún no lo hayamos dado, pasa lo mismo con los volúmenes, parte izquierda host, parte derecha CT docker.

<img width="1635" height="666" alt="image" src="https://github.com/user-attachments/assets/9235da99-20e8-4597-8e7e-d6203bba83f7" />

Si comprobamos desde el navegador la dirección http://localhost:8080, encontramos Apache sirviendo una página de prueba predeterminada.

<img width="1635" height="883" alt="image" src="https://github.com/user-attachments/assets/13c927f2-4699-4bc3-b3ff-8c3de8607c9d" />

Con ```docker logs``` podemos visualizar los registros de acceso hacia el sitio web del contenedor, lo que aporta una información bastante útil. Si quiseramos ver los logs en tiempo real usaríamos ```docker logs -f ...```

<img width="1636" height="456" alt="image" src="https://github.com/user-attachments/assets/fa58d899-cc17-4b77-a500-8c92f4e17a15" />

Para cambiar el contenido de la página que se sirve, tenemos varias formas:

1. O bien, entramos dentro del contenedor con ```docker exec -it apache_ct bash``` y dentro modificamos el contenido del index.html con un echo y redirección total (machacamos el contenido).

<img width="1634" height="520" alt="image" src="https://github.com/user-attachments/assets/cc46275d-acfa-4fc2-bf9e-bb413d5bb439" />

Resultado:

<img width="740" height="243" alt="image" src="https://github.com/user-attachments/assets/14a8137d-379b-48ac-b77f-c0115e43ecc2" />

2. O bien, modificamos desde fuera del contenedor mandando un comando compuesto con bash -c, por ejemplo: ```$ docker exec apache_ct bash -c 'echo "<h1>Curso Docker. Hecho por Rafael 2.</h1>" > /usr/local/apache2/htdocs/index.html'```

<img width="1635" height="221" alt="image" src="https://github.com/user-attachments/assets/a44d9188-f8e3-4062-bd79-46d3aa9336ee" />

Resultado:

<img width="779" height="230" alt="image" src="https://github.com/user-attachments/assets/a0571c13-c038-4b65-8188-05c3eae0b97d" />

### Configuración de contenedores con variables de entorno

También existe la posibilidad de crear contenedores con variables de entorno, por ejemplo, podemos crear un contenedor con la imagen de Ubuntu que guarde una variable "USUARIO" cuyo valor sea "prueba". Para ello, usamos la sentencia ```-e o --env```.

<img width="1212" height="207" alt="image" src="https://github.com/user-attachments/assets/2d069161-e768-498a-8520-b10b0127013a" />

#### Configuración de un contenedor con la imagen mariadb

MariaDB es una imagen de Docker Hub que nos permite insertar variables de entorno durante su primera ejecución. Por ejemplo, podemos indicarle la contraseña de root para administrar las bases de datos. Esto, se haría con el comando ```docker run -d --name mariadb_ct -e MARIADB_ROOT_PASSWORD=root1234 mariadb```.

<img width="1214" height="753" alt="image" src="https://github.com/user-attachments/assets/dce85e4a-d194-42da-ac99-de60cca60bff" />

Para ejecutar la base de datos, podemos entrar al contenedor con el comando ```docker exec -it mariadb_ct bash``` y una vez estemos con su terminal, podemos ejecutar el comando ```mariadb -u root -p"$MARIADB_ROOT_PASSWORD"``` que literalmente sería lo mismo que si ponemos la contraseña. Como estamos pasando la variable que contiene el propio valor de la contraseña, pues todo funciona OK. 

<img width="1214" height="580" alt="image" src="https://github.com/user-attachments/assets/4076d5e8-a5e5-4c29-831d-4ff3d6108b10" />

#### Accediendo a servidor de base de datos desde el exterior

En el ejemplo anterior de configuración del contenedor, solo estaba abierto el puerto 3306 dentro del contenedor, pero no lo hacía desde el anfitrión.

Vamos a cambiar esto, para ello, borramos el contenedor anterior e indicamos con la sentencia ```-p 3306:3306``` que use el puerto 3306 del anfitrión para conectarnos sin tener que hacer uso de bash en el contenedor.

<img width="1213" height="362" alt="image" src="https://github.com/user-attachments/assets/8462bbac-bd3c-4c4a-a8b9-15ac05a0e799" />

Instalamos el cliente de MariaDB en nuestro equipo anfitrión para conectarnos a la base de datos del contenedor. Hacemos uso del comando ```sudo apt update && sudo apt install mariadb-client```, insertamos "Y" para confirmar.

<img width="1214" height="696" alt="image" src="https://github.com/user-attachments/assets/650aab1f-f484-40b0-b251-67cb1a295bcc" />

Una vez instalado el cliente de MariaDB, hacemos uso del comando ```mysql -u root -p -h 127.0.0.1```. 

Pero...¿Por qué estamos insertando el localhost como dirección si no tenemos un server de MariaDB instalado? Muy sencillo, no tenemos un server instalado, pero tenemos un contenedor docker alojando el server de MariaDB, y usa el puerto 3306 del equipo anfitrión, por lo que, al final de cuentas, está escuchando por el localhost.

<img width="1212" height="577" alt="image" src="https://github.com/user-attachments/assets/ed665637-6833-4758-a866-76b027fae15b" />
