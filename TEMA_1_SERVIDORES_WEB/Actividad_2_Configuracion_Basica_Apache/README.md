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

<img width="551" height="388" alt="image" src="https://github.com/user-attachments/assets/e9e5a03a-728b-452b-9f2c-ddf2cef8221e" />

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

<img width="580" height="237" alt="image" src="https://github.com/user-attachments/assets/6a9c8a52-0a44-4bf5-8062-bd375a5d580d" />

Tras realizar este cambio, en vez de acceder a nuestro sitio web mediante la IP, podemos acceder con el dominio marisma.intranet.

<img width="440" height="168" alt="image" src="https://github.com/user-attachments/assets/e8fab724-55e0-4c8b-b5a1-e3511e3f7980" />

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

<img width="857" height="447" alt="image" src="https://github.com/user-attachments/assets/d9c46f94-405b-4e88-ab2e-65bc7f3da9a6" />

Para comprobar la sintaxis es correcta y reinicar el servicio para aplicar cambios, usamos el siguiente comando:

<img width="942" height="111" alt="image" src="https://github.com/user-attachments/assets/1327229f-0776-430e-933f-e7b1015742cd" />

Como podemos comprobar muestra que la sintaxis aplicada fue válida.

### 4. Comprueba si se visualiza el pie de página en las páginas generadas por Apache (por ejemplo, en las páginas de error). Cambia el valor de la directiva “ServerSignature” y comprueba que funciona correctamente. 
-----------------------------------------------

### 5. Crea un directorio “prueba” y otro directorio “prueba2”. Incluye un par de páginas en cada una de ellas.
-----------------------------------------------

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
