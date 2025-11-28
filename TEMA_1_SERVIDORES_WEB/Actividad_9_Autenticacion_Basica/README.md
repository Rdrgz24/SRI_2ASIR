# Actividad 9 - Autenticación Básica

Se recomienda echar un vistazo a la documentación de Apache sobre autenticación -> https://httpd.apache.org/docs/2.4/es/howto/auth.html

## Ejercicios adicionales de autenticación básica

### 1. Crea cinco usuarios: usuario1, usuario2, usuario3, usuario4, usuario5.

Creamos usuarios con el comando ```sudo useradd``` y asignamos contraseña a cada uno de estos con ```sudo passwd nombreusuario```:

<img width="861" height="535" alt="image" src="https://github.com/user-attachments/assets/5a5ad756-3ad7-45d6-8107-3f63d2d34446" />

Comprobamos que los usuarios se han creado correctamente y tienen contraseña asignada desde /etc/passwd

<img width="438" height="107" alt="image" src="https://github.com/user-attachments/assets/c8b7da0c-0c93-4bb6-917f-93717a63c84f" />

### 2. Crea dos grupos de usuarios, el primero formado por usuario1 y usuario2; y el segundo por el resto de usuarios.

Creamos los grupos con el comando ```sudo addgroup``` y asignamos cada usuario con su grupo determinado con el comando ```sudo usermod -aG grupoX usuarioX```

<img width="882" height="158" alt="image" src="https://github.com/user-attachments/assets/82ec1c72-cdaf-4101-b2a0-6e71f83ef0ab" />

Comprobamos que estén correctamente asignados:

<img width="633" height="90" alt="image" src="https://github.com/user-attachments/assets/7b0bce1d-52ba-4475-8f40-4d34853a1cd1" />


### 3. Crea un directorio llamado privado1 que permita el acceso a todos los usuarios.

wasd 

### 4. Crea un directorio llamado privado2 que permita el acceso sólo a los usuarios del grupo1.

wasd 

### 5. La directiva satisfy controla cómo se debe comportar el servidor cuando tenemos autorizaciones a nivel de host (order, allow, deny) y autorizaciones de usuarios (require). 
https://httpd.apache.org/docs/2.4/es/mod/mod_access_compat.html#satisf

### 6. En el directorio privado2 haz que sólo sea accesible desde el localhost, y estudia cómo se comporta la autorización si ponemos: satisfy any, satisfy all

wasd 
