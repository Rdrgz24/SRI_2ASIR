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

Páginas web en funcionamiento:

<img width="398" height="176" alt="image" src="https://github.com/user-attachments/assets/c457f48e-350e-496b-b87b-7b82c433ade5" />
<img width="398" height="176" alt="image" src="https://github.com/user-attachments/assets/98adba19-8c06-4901-aaa8-c8f45d671967" />

### 6. Redirecciona el contenido de la carpeta “prueba” hacia “prueba2”
-----------------------------------------------

Editamos el fichero de configuración /etc/apache2/apache2.conf y añadimos la línea de código:
```
Redirect /prueba /prueba2
```
<img width="400" height="280" alt="image" src="https://github.com/user-attachments/assets/9a9441c2-c11e-42ee-91aa-583933b49c37" />

Comprobamos el funcionamiento en el navegador, al entrar en prueba, automáticamente nos redirecciona a prueba2 (código 302).

<img width="700" height="300" alt="image" src="https://github.com/user-attachments/assets/8dac82fe-68c8-4091-bb86-229ebb16d683" />

### 7. Es posible redireccionar tan solo una página en lugar de toda la carpeta. Pruébalo.
-----------------------------------------------
Sí, es posible, para ello voy a crear dentro de prueba2 el archivo "index2.html" y lo redireccionamos desde apache2.conf:

<img width="450" height="280" alt="image" src="https://github.com/user-attachments/assets/c843dfd2-be4d-45e9-be96-d1c60b617e55" />

Ahora, al intentar acceder al sitio prueba desde el navegador, nos redirige hacia "prueba2/index2.html":

<img width="700" height="322" alt="image" src="https://github.com/user-attachments/assets/63c34a3c-2c53-4003-8b44-9cf7e707a9d1" />

### 8. Usa la directiva userdir
-----------------------------------------------

Habilitamos el módulo userdir con el comando ``` sudo a2enmod userdir ``` y reiniciamos el servicio de apache:

<img width="500" height="136" alt="image" src="https://github.com/user-attachments/assets/a9fbf6ab-4861-4449-a677-3c65578c8276" />

Creamos la carpeta "public_html" y dentro, un index.html para mostrar.

<img width="654" height="187" alt="image" src="https://github.com/user-attachments/assets/aeab8346-9e0e-4882-bd62-3298fe07ba11" />

Asignamos los permisos necesarios para poder visualizar la página desde el navegador ```sudo chmod -R 755 ~/public_html```.

<img width="500" height="200" alt="image" src="https://github.com/user-attachments/assets/41591c5e-7c36-4c14-b098-8e1684590415" />

Editamos el archivo userdir.conf y habilitamos nuestro usuario:

<img width="400" height="200" alt="image" src="https://github.com/user-attachments/assets/d5c930ab-6be2-4a40-b557-cb2ba77d955b" />

Comprobamos que tenemos acceso a public_html desde el navegador:

<img width="372" height="110" alt="image" src="https://github.com/user-attachments/assets/d0cf0584-6ecc-4cd5-aa9a-7205999e3ca8" />

### 9. Usa la directiva alias para redireccionar a una carpeta dentro del directorio de usuario.
-----------------------------------------------

Editamos el fichero de alias con el comando ```sudo nano /etc/apache2/mods-enabled/alias.conf```; añadimos las siguientes líneas:

<img width="611" height="395" alt="image" src="https://github.com/user-attachments/assets/681cf895-12e1-4ca0-a479-1a4340b84632" />

Reiniciamos el servicio de apache con ```sudo systemctl restart apache2``` y probamos desde el navegador:

<img width="365" height="121" alt="image" src="https://github.com/user-attachments/assets/96700104-c832-4a7f-9b2c-5c8fa40cc5fb" />

### 10. ¿Para qué sirve la directiva Options y dónde aparece. Comprueba si apache indexa los directorios. Si es así, ¿cómo lo desactivamos?
-----------------------------------------------
La directiva "Options" sirve para definir que características están permitidas en un directorio de apache, por ejemplo si el contenido puede indexarse o no, permitir enlaces simbólicos, etc...

Se usa dentro de bloques, los más comunes son <Directory>, <Location> y <Files>.

Apache si indexa los directorios, normalmente buscará index.html o index.php, en el caso de no estar disponible, mostrará el contenido del directorio en plano.

Para desactivar esta característica, editamos el fichero apache2.conf con ```sudo nano /etc/apache2/apache2.conf```.

De manera predeterminada:

<img width="537" height="137" alt="image" src="https://github.com/user-attachments/assets/7c468bc2-ad99-4898-b26f-dfacb8d96c9c" />

Editamos temporalmente:

<img width="542" height="132" alt="image" src="https://github.com/user-attachments/assets/515eae78-24fe-460a-bf81-9c1108452c42" />

He creado un directorio con multiples contenidos dentro llamado "prueba3-indexes", al desactivar los indexes sale 403 Forbidden, ya que apache no está ni listando ni mostrando contenido que no sean index.html o similares.

<img width="400" height="170" alt="image" src="https://github.com/user-attachments/assets/130d8bae-3e35-425f-a7ba-99e2e5c5ab1d" />
<img width="400" height="170" alt="image" src="https://github.com/user-attachments/assets/1a1df8ce-e01c-437a-9980-1fa879f709aa" />

# Actividad 2.2 - Trabajando con scripts
