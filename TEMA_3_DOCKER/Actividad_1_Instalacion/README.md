# Práctica 1 - Instalación de Docker

## Objetivos de la actividad

 · Instalar Docker en Ubuntu

### Instalación de Docker Engine en Ubuntu 24.04.1

Para instalar docker, usaré la documentación oficial: https://docs.docker.com/engine/install/ubuntu/

Primero, comprobar la información de nuestros sistema con el comando ```uname -a``` y luego, borramos posibles paquetes conflictivos o instalaciones anteriores.

<img width="1636" height="663" alt="image" src="https://github.com/user-attachments/assets/6d0d7a77-ed63-46f1-a3a7-de4296815f61" />

Luego, usamos el comando ```sudo apt update && sudo apt install -y ca-certificates curl```, estos paquetes contiene dependencias para instalar docker. Con && estamos indicando que haga ambos comandos, primero actualiza lista de paquetes, luego instala los indicados.

<img width="1632" height="721" alt="image" src="https://github.com/user-attachments/assets/1bc7c0d1-99d4-4064-856c-65e475391a5f" />

Añadimos las claves gpg necesarias e insertamos los repositorios dentro de los recursos APT.

<img width="1643" height="639" alt="image" src="https://github.com/user-attachments/assets/d89d4a48-2add-41f3-b7fa-3993630c2f9a" />

Tras insertar los repos de docker dentro de APT, debemos actualizar la lista dentro del sistema, usando el comando ```sudo apt update```.

<img width="1638" height="428" alt="image" src="https://github.com/user-attachments/assets/148475f3-9602-45ab-8ae9-d9d60868dd19" />

Por último, usamos el comando para instalar todas las utilidades de Docker: ```sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin```.

<img width="1641" height="674" alt="image" src="https://github.com/user-attachments/assets/96c0271c-b158-4380-b4b1-a59cb3e7206f" />

Tras completar la instalación, comprobamos el estado del servicio Docker, para ello usamos el comando ```sudo systemctl status docker```, hay que ver que esté activo y habilitado (enabled) en ambos casos. A mí me aparece habilitado, pero en caso contrario, usamos el comando ```sudo systemctl enable docker```.
 
<img width="1641" height="627" alt="image" src="https://github.com/user-attachments/assets/f8732b53-71d6-4ab0-9472-47dfa7145fbf" />

Realizamos una comprobación básica corriendo el contenedor "hello-world" con el comando ```sudo docker run hello-world```.

<img width="1639" height="769" alt="image" src="https://github.com/user-attachments/assets/5b5ea79b-4294-461f-b610-569b7d3a6161" />

Esto, literalmente nos baja una imagen de docker, podemos visualizarlo con ```sudo docker image ls```. Donde "U" indica que la imagen está en uso.

<img width="1635" height="168" alt="image" src="https://github.com/user-attachments/assets/6c089290-587d-49ca-bb65-4a554db8e9cc" />

Por último, para evitar estar usando "sudo" en todo momento y tener que hacer las operaciones como superusuario, voy a añadir mi usuario al grupo de docker con el comando ```sudo usermod -aG docker rafael```, quizás se tenga que reiniciar la máquina o la sesión para aplicar los cambios, en mi caso no fue necesario. Compruebo con ```groups rafael``` que pertenezca a docker y uso el comando ```docker ps``` y ```sudo docker image ls``` sin tener que añadir sudo delante, lo que facilita y asegura el trabajo.

<img width="1637" height="335" alt="image" src="https://github.com/user-attachments/assets/ac7b7a7c-6663-4666-9b0c-60a275ecd8b4" />
