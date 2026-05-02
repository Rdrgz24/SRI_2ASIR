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
