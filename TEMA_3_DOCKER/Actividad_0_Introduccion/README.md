# Actividad 0 - Introducción a Docker

## Objetivos de la actividad

En general, familiarizarse con Docker y tener conocimiento, como mínimo, los siguientes conceptos:

### 1. Conceptos básicos sobre Docker
---------------------------------------------------------------------------------------------------------------------------------------------------------
Docker es una plataforma donde podemos crear, ejecutar y gestionar aplicaciones y/o servicios dentro de contenedores. Pero, ¿Qué es un contenedor? Se puede definir como un entorno aislado, que usa el mismo núcleo que el sistema anfitrión pero de manera independiente. Como ejemplo, podría decirse que es como un gimnasio completo (núcleo anfitrión), donde cada sala es un contenedor, y tiene "x" máquinas aisladamente en base a las utilidades y necesidades de uso.

Cada contenedor, contiene el código, librerías, dependencias y configuración necesarias para correr un servicio, lo que permite facilitar el despliegue operativo prácticamente instantáneo. Es un sistema escalable y ligero.

### 2. Imagenes Docker y contenedores
---------------------------------------------------------------------------------------------------------------------------------------------------------
En el apartado anterior nombré "librerías, dependencias, código...", pues bien, todo esto se encuentra dentro de las imágenes de docker. Estas, no dejan de ser una especie de plantilla "preconfiguradas" que contienen todo lo necesario para desplegar un servicio o aplicación.

Las imágenes se construyen a partir de Dockerfiles, estas, disponen de montón de versiones estábles. Siendo "latest" la última y x.y.z (10.2.1) versiones específicas de imagen. 

El propio contenedor es el que usa estas imágenes. Contiene su propio sistema de archivos, red y procesos, pudiendo crear redes de todo tipo (bridge, macvlan...). La ventaja es que podemos modificarlo durante su ejecución, detenerlo, o eliminarlo sin restricción alguna.

### 3. Volúmenes de almacenamiento
---------------------------------------------------------------------------------------------------------------------------------------------------------
Los volúmenes en Docker se utilizan para guardar datos de manera persistente, es decir, si un contenedor no tiene asignado un volumen, no tiene donde guardar los datos, es totalmente inútil en cuanto a persistencia de los datos. 

Por ello, si queremos tener datos dentro de un contenedor, es importante tener un volumen asignado, esto, literalmente guarda los datos dentro de nuestro sistema anfitrión (quien aloja los container). 

Y no, los datos no pertenecen al contenedor, están fuera de este, simplemente que se vincula, y mientras el contenedor está en ejecución, tenemos los datos disponibles desde la terminal.

Tenemos dos tipos de volúmenes (esto es importante diferenciar):
 
 · Volúmenes nombrados: Los gestiona docker y deciden dónde almacenarse físicamente, sin definición previa.
 · Bind mounts: Usan una carpeta específica del sistema, y nosotros controlamos exactamente la ruta donde se guarda (lo más recomendable porque tenemos más control).
