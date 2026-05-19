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



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### Ejemplo 4: Despliegue de tomcat + nginx

#### Desplegando tomcat

#### Desplegando nginx como proxy inverso
