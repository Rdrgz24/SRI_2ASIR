# 6. Creando imágenes en Docker

## Objetivos a realizar

 · Aprender a empaquetar y construir nuestras propias imágenes de Docker utilizando archivos Dockerfile. 
  · Hacer tres de los ejemplos explicados en el temario de GitHub proporcionado por el profe.

Toca aprender algo relativamante nuevo, ya que lo realizado hasta la actividad 5 ya lo había hecho antes todo, pero crear imágenes no había coincidido en ninguno de mis objetivos o proyectos realizados, por lo que... a aprender :)

### Ejemplo 1: Construcción de imágenes con una página estática

#### Versión 1: Desde una imagen base

Empiezo creando la estructura para tener todo organizado.

<img width="1212" height="142" alt="image" src="https://github.com/user-attachments/assets/84ba1233-eb66-4b7b-8db4-6372e3a74ec7" />

Utilizamos la imagen de Debian e instalamos con paquetes APT, limpiamos y guardamos contenido dentro la carpeta public_html, exponiendo por P80 y ejecutando el servicio.

<img width="1207" height="190" alt="image" src="https://github.com/user-attachments/assets/d311e62c-ed15-4259-9dd9-f50f8f9086a0" />

Ahora sí, creo la carpeta public_html.
<img width="1216" height="156" alt="image" src="https://github.com/user-attachments/assets/080e8ffa-7ed2-4d90-bb55-7813d9c7fd4b" />

Creamos o construimos la imagen con el comando ```docker build -t rdrgz24ejemplo1:v1 .``` donde con el . final indicamos que lo levante con el contenido existente dentro del directorio actual.

<img width="1215" height="535" alt="image" src="https://github.com/user-attachments/assets/0a058686-59ba-43ec-b9d9-35c3000c3ec8" />

Levantamos un ct con el comando ```$ docker run -d -p 80:80 --name nombrect dueño/imagen:version```.

<img width="1218" height="132" alt="image" src="https://github.com/user-attachments/assets/4e21b246-ec04-471c-ae40-f3cb96dfe286" />

Accedemos al localhost por P80 y tenemos Apache sirviendo.

<img width="1216" height="722" alt="image" src="https://github.com/user-attachments/assets/3530264c-ebd6-4e6b-86d3-97f112f5e259" />

#### Versión 2: Desde una imagen con apache2

Creo estructura, archivo y carpeta.

<img width="1219" height="154" alt="image" src="https://github.com/user-attachments/assets/b5aeaf6e-2bfb-4dcd-9289-3d9934d5daa5" />

Creo un dockerfile donde esta vez trabajaremos directamente con la imagen de Apache y se expondrá por puerto 81.

<img width="1207" height="149" alt="image" src="https://github.com/user-attachments/assets/487b8a9e-79c0-403d-914e-3f84f9eee171" />

Creamos la imagen igual que antes, con ```docker build -t``` y revisamos correcta creación con ```docker image ls``` o ```docker images```.

<img width="1216" height="584" alt="image" src="https://github.com/user-attachments/assets/fe7119cb-5b69-4f13-acb7-3d5a2dc3eb31" />

Levanto el ct con el comando ```$ docker run -d -p 81:81 --name nombrect dueño/imagen:version```.

<img width="1211" height="193" alt="image" src="https://github.com/user-attachments/assets/0c33c4ba-ef1b-44cc-a8e0-994642605bae" />

Apache escuchando por P81 :)

<img width="1211" height="477" alt="image" src="https://github.com/user-attachments/assets/e00c2518-cbcc-4416-af39-a3ce94d4f2d8" />

#### Versión 3: 

Preparo la estructura, archivo Dockerfile y carpeta public_html.

<img width="1220" height="153" alt="image" src="https://github.com/user-attachments/assets/3f3bb35b-5670-483c-8138-a8a799f5ab3d" />

Voy a borrar los otros dos contenedores para tener el P80 libre y poder usarlo con nginx. En esta imagen se usa nginx 1.24.

<img width="1212" height="123" alt="image" src="https://github.com/user-attachments/assets/a7801c7c-4a5b-42d4-9f8a-9abf1cbf6e9a" />

Wait, me equivoque de letra en la carpeta publica :( ->> Lo arrego :)

<img width="1213" height="69" alt="image" src="https://github.com/user-attachments/assets/5a7c6b30-aed0-4640-bd8c-05ab27e3d343" />

Puse public_hmtl en lugar de public_html. Cambio y lanzo imagen. Creada correctamente.

<img width="1211" height="644" alt="image" src="https://github.com/user-attachments/assets/818bd2f7-903b-43a3-abf8-c4886ad71a6d" />

Levanto contenedor con puerto 80 en anfitrión y 80 en ct con la imagen creada de nginx (v3).

<img width="1214" height="140" alt="image" src="https://github.com/user-attachments/assets/dd90cf07-b965-4819-a42a-9a87885287f5" />

NGINX escuchando por el puerto 80 del localhost correctamente.

<img width="1214" height="260" alt="image" src="https://github.com/user-attachments/assets/e31a41f5-261a-4570-96c7-a59659e90f84" />

Si nos fijamos, se puede crear una imagen con mismo propietario, mismo nombre pero con distinto tag o versión (v1,v2,v3), esto para proyectos con escalabilidad viene genial :)

### Ejemplo 2: Construcción de imágenes con una una aplicación PHP

#### Versión 1: Desde una imagen base
