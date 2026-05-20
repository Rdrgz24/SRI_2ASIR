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

Para esta versión, se usará un Dockerfile y un directorio llamado app. Para evitar conflictos, desplegaré todas las versiones por el puerto 80, apagando el container cada vez que termine de explicarlo.

Comienzo creando la estructura, con su Dockerfile y directorio "app".

<img width="1211" height="139" alt="image" src="https://github.com/user-attachments/assets/c1d39c17-da1f-42f3-b2d9-526d11ecb570" />

Luego es muy simple, dentro de la imagen de debian descargamos los paquetes de apache2, mod-php y php, limpiamos los paquetes y todo el contenido de /var/www/html se manda al dir app. Exponemos P80.

<img width="1213" height="176" alt="image" src="https://github.com/user-attachments/assets/422d697f-c943-474a-8f21-f79679bd592b" />

Epaa, error al crear la imagen. Se ve claro, no ha encontrado el paquete para 7.4.

<img width="1200" height="628" alt="image" src="https://github.com/user-attachments/assets/8b62f7f4-4535-451c-b410-bf75129f92e2" />

Vamos a modificar esto a la versión más reciente, basta con quitar 7.4 del nombre:

<img width="1206" height="164" alt="image" src="https://github.com/user-attachments/assets/11bb5163-3756-49da-b5c5-62cc65133650" />

Ahora sí que funcionó, ha descargado la última versión de PHP, así que sin problemas.

<img width="1208" height="660" alt="image" src="https://github.com/user-attachments/assets/4302c258-26df-4d5d-8a96-e8a06eaa3de4" />

Levanto container usando puerto 80 y la imagen recién creada.

<img width="1209" height="158" alt="image" src="https://github.com/user-attachments/assets/f8f5421b-35bb-484e-9af6-1bb3326cb884" />

Para hacer una dinámica distinta y corroborar que el container sirve por P80 sin problemas, contenido. He creado un pequeño index.html conectándome al ct recién creado.

<img width="1216" height="170" alt="image" src="https://github.com/user-attachments/assets/bbef6abb-e39e-4d46-951b-0619cd438d94" />

Luego creo el archivo info.php.

<img width="1215" height="179" alt="image" src="https://github.com/user-attachments/assets/29b0e62c-c9ac-4185-a002-755a16d04b1b" />

Reviso la página creada con HTML y la info de PHP. Todo concuerda.

<img width="453" height="99" alt="image" src="https://github.com/user-attachments/assets/e47943c0-e170-44c1-935c-125bbe05a746" />
<img width="1214" height="722" alt="image" src="https://github.com/user-attachments/assets/a6007d20-409a-4b34-b930-284ff16e14a3" />

#### Versión 2: Desde imagen con PHP instalado

Creo estructura, incluyendo Dockerfile y directorio app.

<img width="1214" height="154" alt="image" src="https://github.com/user-attachments/assets/c3fe625e-ef70-4073-af90-75becffdf375" />

En el dockerfile pongo la versión 8.2 de PHP que se que sí va a funcionar 100%.

<img width="1203" height="149" alt="image" src="https://github.com/user-attachments/assets/507b053a-83fc-4bcf-84af-3e5da0d77dbc" />

Creamos la imagen con ```docker build -t```, el log es demasiado grande, pero se ha creado OK ;)

<img width="1210" height="584" alt="image" src="https://github.com/user-attachments/assets/1c99fb56-bd48-4b74-827a-36e99664d086" />

Como se puede ver aquí...

<img width="1213" height="355" alt="image" src="https://github.com/user-attachments/assets/9292d9bf-7702-4791-bc8c-682569c8b9c8" />

Levanto container que use P80 y la imagen recién creada.

<img width="1217" height="167" alt="image" src="https://github.com/user-attachments/assets/e396fef5-6950-4331-a00f-49108414bbf9" />

Tenemos PHP 8.2 activo sirviendo por puerto 80 señores :)

<img width="1214" height="724" alt="image" src="https://github.com/user-attachments/assets/ee26f915-d453-46be-a413-7d9794b075b4" />

### Ejemplo 3: Construir imágenes con una aplicación Python

Se supone que para este ejemplo, vamos a desplegar el framework flask, expuesto por el puerto 3000.

Para ello, primero hay que bajarse el contenido del repo, yo lo tengo ya por aquí, así que simplemente me voy a copiar el contenido, ya que se la ruta, hacia la nueva carpeta del 

<img width="1210" height="447" alt="image" src="https://github.com/user-attachments/assets/33ef7650-0b55-4ed2-8d2f-449834f53c9e" />

Aquí se puede observar el contenido copiado, lo que hay dentro del Dockerfile y los permisos de los que dispone.

<img width="1212" height="428" alt="image" src="https://github.com/user-attachments/assets/d2a57707-e641-43d9-8b38-72f1865caaf7" />

Muy interesante antes de realizar el despliegue. En el dockerfile "WORKDIR" es donde se ejecutarán todas las instrucciones del Dockerfile, requeriments.txt guarda líneas con el contenido a instalar con pip. Y por último, dentro de app está "app.py", que contiene la app a desplegar. Guay :)

Tenemos una facilidad, ya tenemos el Dockerfile y el directorio del contenido, así que, para lante como los de alicante, que creamos imagen directamente. (Cuidado que tarda, pip pesa...)

<img width="1211" height="532" alt="image" src="https://github.com/user-attachments/assets/911124e7-6951-4600-b7d3-97d049dda37e" />

Revisamos imagen creada. Todo OK.

<img width="1215" height="367" alt="image" src="https://github.com/user-attachments/assets/31659c0c-80c9-44e3-a86f-6e0fcd2abbfd" />

Desplegamos contenedor para que sirva por puerto 80 en el anfitrión y puerto 3000 en ct.

<img width="1213" height="167" alt="image" src="https://github.com/user-attachments/assets/662bea1f-46b8-40c0-9bbc-092eee7d5397" />

Página web funciona correctamente. Vamos a pulsar sobre "Click to scroll down" para ver que pasa.

<img width="1212" height="441" alt="image" src="https://github.com/user-attachments/assets/a3dc9d79-3a83-44db-9000-f78cd967a7b5" />

Muy simple, nos manda al About. Esto corrobora que Python funciona OK :)

<img width="1211" height="312" alt="image" src="https://github.com/user-attachments/assets/84fcba94-b9b9-4ca8-b188-60942fd2dfa4" />

#### Versión 2: Desde imagen con python instalado

Voy a copiar el contenido de la versión 1 y modifico el Dockerfile. Para ello uso ```cp -R origen destino```.

<img width="1214" height="155" alt="image" src="https://github.com/user-attachments/assets/2778a6b7-00ee-4d5a-a6ed-8a3e1a5d9e5a" />

Tras modificarlo, quedaría tal que así.

<img width="1212" height="188" alt="image" src="https://github.com/user-attachments/assets/71eb3410-3b2d-4d68-b354-49ddce3f4baf" />

Creamos imagen usando la predefinida de python (v3.12.1) y finaliza correctamente.

<img width="1213" height="369" alt="image" src="https://github.com/user-attachments/assets/55291f9f-f264-4be1-9119-0e1619846ad3" />

Levantamos contenedor con la nueva imagen que sirva por P80 en anfitrión.

<img width="1212" height="168" alt="image" src="https://github.com/user-attachments/assets/2bf160c7-f313-4474-8b98-4f9eea7dbc7e" />

Esto funciona perfectamente! :)
