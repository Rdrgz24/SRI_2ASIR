# Actividad 9 - Autenticación Básica

Se recomienda echar un vistazo a la documentación de Apache sobre autenticación -> https://httpd.apache.org/docs/2.4/es/howto/auth.html

## Ejercicios adicionales de autenticación básica

### 1. Crea cinco usuarios: usuario1, usuario2, usuario3, usuario4, usuario5.

Creamos usuarios con el comando ```sudo useradd``` y asignamos contraseña a cada uno de estos con ```sudo passwd nombreusuario```:

<img width="600" height="450" alt="image" src="https://github.com/user-attachments/assets/5a5ad756-3ad7-45d6-8107-3f63d2d34446" />

Comprobamos que los usuarios se han creado correctamente y tienen contraseña asignada desde /etc/passwd

<img width="438" height="107" alt="image" src="https://github.com/user-attachments/assets/c8b7da0c-0c93-4bb6-917f-93717a63c84f" />

### 2. Crea dos grupos de usuarios, el primero formado por usuario1 y usuario2; y el segundo por el resto de usuarios.

Creamos los grupos con el comando ```sudo addgroup``` y asignamos cada usuario con su grupo determinado con el comando ```sudo usermod -aG grupoX usuarioX```

<img width="882" height="158" alt="image" src="https://github.com/user-attachments/assets/82ec1c72-cdaf-4101-b2a0-6e71f83ef0ab" />

Comprobamos que estén correctamente asignados:

<img width="633" height="90" alt="image" src="https://github.com/user-attachments/assets/7b0bce1d-52ba-4475-8f40-4d34853a1cd1" />


### 3. Crea un directorio llamado privado1 que permita el acceso a todos los usuarios.

Aquí explico la creación de las carpetas privado1 y privado2, cambio el propietario en base a cada caso y asigno permisos adecuados.

<img width="1326" height="143" alt="image" src="https://github.com/user-attachments/assets/3719336e-ed79-4406-8c3b-cd73f314a95f" />

(Estos permisos son de sistema, no del servidor apache, por lo que debemos realizar las modificaciones sobre el archivo de configuración de Apache.)

<img width="815" height="204" alt="image" src="https://github.com/user-attachments/assets/1399c70b-3aee-4986-af54-242e3ecebe90" />

Probamos a entrar al sitio:

<img width="451" height="111" alt="image" src="https://github.com/user-attachments/assets/2245d74e-5767-441b-8fe8-b8c5c04f6886" />

### 4. Crea un directorio llamado privado2 que permita el acceso sólo a los usuarios del grupo1.

El directorio ya lo creamos anteriormente, también administramos los permisos locales, ahora añadimos la configuración

<img width="1080" height="384" alt="image" src="https://github.com/user-attachments/assets/f978dec5-db35-42b2-906c-29609570c6cc" />

Añadimos los usuarios al archivo de autenticación mediante el comando ```sudo htpasswd /etc/apache2/.htpasswd nombreusuario```

<img width="710" height="137" alt="image" src="https://github.com/user-attachments/assets/974ed7e9-fd0f-41a3-a9b4-16b91f1a01b9" />

<img width="721" height="79" alt="image" src="https://github.com/user-attachments/assets/4b5b3fce-daa6-41d1-8afc-b9c0cee1da7b" />

wasd 

<img width="654" height="282" alt="image" src="https://github.com/user-attachments/assets/66f5cb4d-2456-40fc-90af-7b66a955a107" />


### 5. La directiva satisfy controla cómo se debe comportar el servidor cuando tenemos autorizaciones a nivel de host (order, allow, deny) y autorizaciones de usuarios (require). 

Ya usamos la directiva satisfy arriba, usamos "any" esto indica que si se cumple alguna de las autorizaciones a nivel de host o alguna de las autorizaciones de usuario ya te deja entrar; como pusimos en los dos casos credenciales y direcciones locales, todo se gestiona de manera local, evita conexiones externas o de usuarios que no sean del equipo.

### 6. En el directorio privado2 haz que sólo sea accesible desde el localhost, y estudia cómo se comporta la autorización si ponemos: satisfy any, satisfy all

Ya se mostró en la última captura de "<Directory>" que con Order, deny, allow, denegamos todas las conexiones y permitimos las entrantes desde 127.0.0.1.
