# Actividad 0.4 - Usando Curl

Investigar posibles comandos en -> https://curl.se/docs/manual.html

## Busca información sobre el comando curl y muestra al menos cinco ejemplos de uso

### 1. Mostrar el contenido de un sitio web:
```
curl https://www.ejemplo.com/
```
Muestra de uso:

<img width="600" height="380" alt="image" src="https://github.com/user-attachments/assets/afa339b9-e0fc-4703-848c-840b2b6ea2c1" />


### 2. Guardar el contenido de un sitio web en un fichero local:
```
curl -o nombrearchivo.html https://www.ejemplo.com/
```
Muestra de uso:

<img width="700" height="500" alt="image" src="https://github.com/user-attachments/assets/7e7c8603-30a4-4efd-abe9-2d8433bb4bdb" />


### 3. Mostrar el contenido de un sitio web por rangos:
· Mostrar los primeros 99 bytes:
```
curl -r 0-99 https://www.ejemplo.com/
```

· Mostrar los bytes entre posición 100-250:
```
curl -r 100-250 https://www.ejemplo.com/
```

· Mostrar los últimos 550 bytes:
```
curl -r -550 https://www.ejemplo.com/
```
Muestra de uso: 

<img width="800" height="500" alt="image" src="https://github.com/user-attachments/assets/e38f2884-b70a-490f-8486-8523edfeb366" />


### 4. Guardar las cookies de un sitio web (Formato Netscape) dentro de un fichero local:
```
curl -c nombrearchivo.txt https://www.ejemplo.com/
```
Muestra de uso (datos tapados):

<img width="600" height="180" alt="image" src="https://github.com/user-attachments/assets/1336dabc-5abf-4fd4-b6fb-7eff5324f7b9" />


### 5. Mostrar la cabecera de un sitio web:
```
curl -I https://www.ejemplo.com/
```
Muestra de uso:

<img width="800" height="200" alt="image" src="https://github.com/user-attachments/assets/8816c5cc-6e8e-4aaa-b3fd-0137cea9fca3" />

