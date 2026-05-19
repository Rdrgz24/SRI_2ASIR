# 4. Almacenamiento y redes

## Objetivos a realizar

 · Llevar a cabo al menos tres de los ejemplos mostrados en el módulo.

Dentro del Curso de Docker hay cuatro ejemplos. Yo voy a completar los que me parecen en realidad más útiles, ya sea por el stack que se despliega o lo que se realiza con Docker.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### Ejemplo 2: Despliegue de la aplicación Temperaturas

Esta aplicación permite consultar la temperatura mínima y máxima en todos los municipios de España. Y se forma de dos "microservicios":

 · Un FrontEnd donde Python ofrece una web que permite realizar las búsquedas y mostrar los resultados. Para completar esto, realiza peticiones HTTP al segundo microservicio donde obtiene la información. Utiliza el puerto 3000/TCP.

  · Un BackEnd donde una API Restful hace consultas sobre los municipios y sus temperaturas. Utiliza el puerto 5000/TCP.

Estos microservicios van interconectados a través de la misma red e indicaciones por nombre, donde el contenedor del frontend, se conecta el contenedor del backend vía nombre identificativo.

#### Creando la red

Creamos la red con el comando ```docker network create red_temperaturas``` y comprobamos que se ha creado correctamente con ```docker network ls```.

<img width="1634" height="289" alt="image" src="https://github.com/user-attachments/assets/57aa5038-930a-49e5-bc9e-4581306c8bdf" />

#### Ejecutando los contenedores

Primero, ejecutamos el contenedor del backend, para este no debemos indicar puerto, ya que este será interno, no hará uso de puertos en el anfitrión. Lo que sí, debemos indicar la red a usar (la creada anteriormente) y la imagen iesgn/temperaturas_backend.

<img width="1645" height="415" alt="image" src="https://github.com/user-attachments/assets/6e738e01-b4cd-4d2e-af3b-dce1e73bb587" />

Luego, levantamos el contenedor del frontend, en este caso si indicamos el puerto, usará el 80 para el anfitrión y el 3000 para el contenedor (80:3000). Nuevamente, indicamos la red que se creó antes y la imagen iesgn/temperaturas_frontend.

<img width="1637" height="490" alt="image" src="https://github.com/user-attachments/assets/3b23f658-0f41-47e0-9a7e-cce6f1e94462" />

Ya de por sí, si entramos en el localhost:3000 la aplicación va a funcionar. De hecho, podemos ver la temperatura de Huelva, la aplicación es funcional y capaz de consultar el BackEnd.

<img width="1626" height="828" alt="image" src="https://github.com/user-attachments/assets/03fae67e-c67b-4408-9b51-48fe899e5571" />

Tal y como podemos ver se muestra la temperatura de la ciudad que hemos indicado.

#### Configuración de la aplicación Temperaturas

En la documentación de la práctica, se indica que se puede crear un contenedor de Backend con un nombre distinto al predeterminado (temperaturas-backend) y se puede crear un container con nombre personalizado, para luego indicar al frontend que recoja las temperaturas desde "TEMP_SERVER" con el nombre del nuevo container del backend.

En este caso, he creado un container llamado temp-api para el backend y temp-fe para el frontend, todo incluido dentro de la variable "TEMP_SERVER" para que apunte al que indico.

<img width="1214" height="634" alt="image" src="https://github.com/user-attachments/assets/ad4368f7-cd28-4ee3-91a1-6c002e21fcc9" />

Todo funcionando OK.

<img width="1211" height="601" alt="image" src="https://github.com/user-attachments/assets/48264cdb-8162-48b0-815a-e9d6570fa181" />

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### Ejemplo 3: Despliegue de WordPress + MariaDB

Este despliegue es bastante simple, permite conectar una base de datos a un contenedor Wordpress dentro de una misma red y con resolución DNS.

#### Creando la red

Creamos la red con el comando ```docker network create red-wp-sri``` y verifico su creación con ```docker network ls```.

<img width="1213" height="214" alt="image" src="https://github.com/user-attachments/assets/b0fdfb58-7118-45b1-8c55-ced16b57312c" />

#### Ejecutando contenedores

Tras crear la red, creo el primer contenedor con un comando multilínea donde abarco, el nombre del contenedor, red a la que va conectada, volumen de datos (para que se queden persistentes), nombre de la DB, usuario, contraseña del usuario y contraseña root de mariaDB, por último, se indica la imagen "mariadb", que, evidentemente se baja la versión latest. Por último, paro los contenedores del ejemplo anterior para que no los tenga consumiendo recursos a lo tonto.

<img width="1218" height="456" alt="image" src="https://github.com/user-attachments/assets/c98a5bf4-2f0e-4165-afb5-714406a23868" />

Levantamos contenedor de WordPress usando los datos de la DB creada anteirormente, y, además indicamos su volumen (/var/www/html o /var/www/html/wp-content), cualquiera es válida. Luego, indico que use el puerto 80 para el anfitrión y el contenedor. Como se puede ver, descarga la imagen porque no la tiene localmente, esto baja la latest.

<img width="1207" height="768" alt="image" src="https://github.com/user-attachments/assets/bae9a7fc-68a4-4c41-a764-8e30bb759da5" />

Resultado tras levantar containers, dentro de la web localhost vía puerto 80, tengo la instalación de WP disponible.

<img width="1211" height="764" alt="image" src="https://github.com/user-attachments/assets/e0f9a8b1-9f77-4158-9dcd-481476ae99fb" />

Hago la config de instalación en 2 minutos y listo, contenedor de WP conectado a base de datos MariaDB y website llamado "WP-SRI-DOCKER" operativo.

<img width="1210" height="597" alt="image" src="https://github.com/user-attachments/assets/d2b30e2b-a347-4aa1-b70e-49d1769b3f62" />

Volúmenes de los containers creados, por lo que se puede verificar que todo está funcionando correctamente.

<img width="1214" height="439" alt="image" src="https://github.com/user-attachments/assets/5c446d10-90c4-45cf-81db-54ffeea30033" />

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### Ejemplo 4: Despliegue de tomcat + nginx

#### Creando la red

Creamos red con elc omando ```docker network create``` y visualizo con ```docker network ls```, simple, ya lo hemos visto anteriormente.

<img width="1213" height="230" alt="image" src="https://github.com/user-attachments/assets/186c140f-c7fe-4374-abad-c7d9d1953016" />

#### Desplegando tomcat

Completo un git clone para clonarme el repo que estamos usando para las actividades, y así, poder calcar los archivos de configuración para el programa Java de Tomcat y la configuración de la página de Nginx, que usaremos posteriormente. Para ello, lo clono, accedo a la carpeta exacta y me copio los dos documentos a mi carpeta de /home/, directamente.

<img width="1217" height="544" alt="image" src="https://github.com/user-attachments/assets/bf50e306-243b-44f2-a7ea-ad408d792654" />

Tras bajar los archivos, creo el contenedor de tomcat, al que he llamado "appjava" y je indicado que utilice la red creada junto a un volumen de almacenamiento que use el archivo "sample.war" de mi equipo local como archivo dentro del propio container. Esto hace una serie de hyperlink.

<img width="1214" height="406" alt="image" src="https://github.com/user-attachments/assets/22360347-68bd-405f-9442-cce3215ab988" />

#### Desplegando nginx como proxy inverso

Edito el default.conf, ya que el que viene por defecto en el repo usa como proxy_pass "aplicacionjava" en lugar de appjava, y tengo que modificar esta opción al nombre de mi container y entorno.

<img width="1208" height="373" alt="image" src="https://github.com/user-attachments/assets/112d73ce-8fe4-4993-8a6b-0484e8503d2f" />

Posteriormente, despliego nginx por el puerto 80 anfitrión y container, con la red creada anteriormente y vinculando un volumen que utilice el archivo default.conf para servir el website de tomcat.

<img width="1219" height="178" alt="image" src="https://github.com/user-attachments/assets/2085ce2b-a258-4cf1-b411-5b6f1eb8cf76" />

El gatito felino dentro de nuestra máquina anfitrión, donde me conecto por IP:

<img width="1215" height="323" alt="image" src="https://github.com/user-attachments/assets/a929e852-a144-48a9-9d43-0df63c8d2343" />

Para poder conectarme con el proxy_pass, hay que iniciar sesión dentro del contenedor de Nginx y aquí si que resuelve bien el nombre de la app http://appjava:8080/sample/ ya que es una dirección local y solo la resuleve el container. También muestra el tomcat con curl.

<img width="1212" height="509" alt="image" src="https://github.com/user-attachments/assets/f57cf7e0-cc0a-42cf-85a5-93f4ad0070ff" />

Ejercicios bastante entretenidos.
