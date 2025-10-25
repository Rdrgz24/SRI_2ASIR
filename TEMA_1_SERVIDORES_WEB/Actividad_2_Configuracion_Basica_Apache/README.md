# Actividad 2.1 - Configuración básica de Apache

## Preguntas

### 1. Apache utilizará el puerto 81 además del 80
-----------------------------------------------
Para añadir el puerto 81, editamos el archivo "/etc/apache2/ports.conf" y agregamos la línea de código:
```
Listen 81
```

<img width="420" height="220" alt="image" src="https://github.com/user-attachments/assets/cee193fa-6712-45fd-9f5d-bffe09a2fa5a" />

Para comprobar que Apache está escuchando por el puerto 81, añadiremos un VirtualHost en el archivo de configuración de nuestro sitio web, en mi caso "/etc/apache2/sites-enabled/myweb.conf".

<img width="420" height="315" alt="image" src="https://github.com/user-attachments/assets/e9e5a03a-728b-452b-9f2c-ddf2cef8221e" />

Reiniciamos el servicio de Apache para aplicar los cambios:
```
sudo systemctl restart apache2
```

Comprobamos la dirección localhost:81 en el navegador.

<img width="356" height="172" alt="image" src="https://github.com/user-attachments/assets/65667b79-156c-4e1b-9344-85c7504ee410" />

Con esta captura podemos afirmar que apache escucha por el puerto 81, ya que muestra el VirtualHost que hemos configurado.

### 2. Añadir el dominio “marisma.intranet” en el fichero “hosts”
-----------------------------------------------
Accedemos al fichero hosts con el comando:
```
sudo nano /etc/hosts
```

Añadimos a la dirección IP del localhost (127.0.0.1) el nombre de dominio "marisma.intranet".

<img width="480" height="217" alt="image" src="https://github.com/user-attachments/assets/6a9c8a52-0a44-4bf5-8062-bd375a5d580d" />

Tras realizar este cambio, en vez de acceder a nuestro sitio web mediante la IP, podemos acceder con el dominio marisma.intranet.

<img width="380" height="148" alt="image" src="https://github.com/user-attachments/assets/e8fab724-55e0-4c8b-b5a1-e3511e3f7980" />

### 3. Cambia la directiva “ServerTokens” para mostrar el nombre del producto.
-----------------------------------------------
Editamos el archivo apache2.conf con el comando:
```
sudo nano /etc/apache2/apache2.conf
```

Añadimos al final de archivo, la línea:
```
ServerTokens Prod
```

Esto, mostrará solo el nombre de producto, no mostrará otros datos relacionados con el sistema.

<img width="600" height="340" alt="image" src="https://github.com/user-attachments/assets/d9c46f94-405b-4e88-ab2e-65bc7f3da9a6" />

Para comprobar la sintaxis es correcta y reinicar el servicio para aplicar cambios, usamos el siguiente comando:
```
sudo apachectl -t && sudo systemctl restart apache2
```
Cambios en la configuración:
Antes (Apache + versión + sistema) -> ServerTokens en Full o sin restricción.

<img width="400" height="155" alt="image" src="https://github.com/user-attachments/assets/4da9b488-75cd-48e8-8e0f-59d2ec35fbd3" />

Después (Apache solo) -> ServerTokens en Prod

<img width="400" height="152" alt="image" src="https://github.com/user-attachments/assets/907635ef-409c-4fee-adbd-33562f4dacac" />

### 4. Comprueba si se visualiza el pie de página en las páginas generadas por Apache (por ejemplo, en las páginas de error). Cambia el valor de la directiva “ServerSignature” y comprueba que funciona correctamente. 
-----------------------------------------------

Comprobamos el pide de página introduciendo una página que no esté en nuestro servidor web.

<img width="400" height="200" alt="image" src="https://github.com/user-attachments/assets/c3aed660-fda9-4be2-84cd-35655344db13" />

Como vemos, se muestra el pie de página e información correspondiente.

Editamos la directiva "ServerSignatura" en el archivo apache2.conf.
```
sudo nano /etc/apache2/apache2.conf
```

Añadimos al final de archivo, la línea:
```
ServerSignature Off
```

<img width="400" height="275" alt="image" src="https://github.com/user-attachments/assets/f731d192-35c6-4a8d-a663-b86271f760c2" />

Guardamos los cambios, comprobamos la sintaxis y reiniciamos el servicio de apache.

Ahora, al introducir una página que no esté en nuestro servidor web, no se mostrará el pie de página generado por Apache.

<img width="400" height="208" alt="image" src="https://github.com/user-attachments/assets/375ed26d-dc4e-4315-8143-0dd06637d8ee" />

### 5. Crea un directorio “prueba” y otro directorio “prueba2”. Incluye un par de páginas en cada una de ellas.
-----------------------------------------------

Dentro del directorio /var/www/html creamos las carpetas con el comando:

<img width="500" height="100" alt="image" src="https://github.com/user-attachments/assets/0a32b828-6556-48d9-848b-25346392013d" />

Creamos la página web en el directorio prueba:

<img width="557" height="284" alt="image" src="https://github.com/user-attachments/assets/b0ed9ca9-09b1-425c-9519-cd37938fa6ac" />

Creamos la página web en el directorio prueba2:

<img width="557" height="284" alt="image" src="https://github.com/user-attachments/assets/380328ee-35da-448b-b680-1d92e1c9a039" />

### 6. Redirecciona el contenido de la carpeta “prueba” hacia “prueba2”
-----------------------------------------------

### 7. Es posible redireccionar tan solo una página en lugar de toda la carpeta. Pruébalo.
-----------------------------------------------

### 8. Usa la directiva userdir
-----------------------------------------------

### 9. Usa la directiva alias para redireccionar a una carpeta dentro del directorio de usuario.
-----------------------------------------------

### 10. ¿Para qué sirve la directiva Options y dónde aparece. Comprueba si apache indexa los directorios. Si es así, ¿cómo lo desactivamos?
-----------------------------------------------



# Actividad 2.2 - Trabajando con scripts
