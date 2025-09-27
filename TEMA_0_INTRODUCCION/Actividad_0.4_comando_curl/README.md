# Actividad 0.4 - Usando Curl

Investigar posibles comandos en -> https://curl.se/docs/manual.html

## Busca información sobre el comando curl y muestra al menos cinco ejemplos de uso

### 1. Comando curl para mostrar el contenido de una página web:
```
curl https://www.ejemplo.com/
```
Muestra de uso:

<img width="800" height="420" alt="image" src="https://github.com/user-attachments/assets/afa339b9-e0fc-4703-848c-840b2b6ea2c1" />


### 2. Comando curl para guardar el contenido de una página web en un fichero:
```
curl -o nombrearchivo.html https://www.ejemplo.com/
```
Muestra de uso:

<img width="900" height="680" alt="image" src="https://github.com/user-attachments/assets/7e7c8603-30a4-4efd-abe9-2d8433bb4bdb" />


### 3. Comando curl para mostrar el contenido de una página web por rangos:
· Mostrar los primeros 99 bytes:
```
curl -r 0-99 https://www.ejemplo.com/
```

· Mostrar los bytes entre posición 100-250:
```
curl -r 100-250 https://www.ejemplo.com/
```

· Mostrar los últimos 500 bytes:
```
curl -r -500 https://www.ejemplo.com/
```
Muestra de uso: 

<img width="900" height="500" alt="image" src="https://github.com/user-attachments/assets/e38f2884-b70a-490f-8486-8523edfeb366" />


