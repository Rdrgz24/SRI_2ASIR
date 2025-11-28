# Actividad 8 - Configurando VirtualHost

## Lee el artículo siguiente y lleva a cabo la práctica propuesta:


### Paso Uno - Crear la Estructura del Directorio

sudo mkdir -p /var/www/ejemplo.com/public_html
sudo mkdir -p /var/www/pruebas.com/public_html

### Paso Dos - Otorgar Permisos

sudo chown -R $USER:$USER /var/www/ejemplo.com/public_html
sudo chown -R $USER:$USER /var/www/pruebas.com/public_html

sudo chmod -R 755 /var/www

### Paso Tres — Crear una Página de Prueba para cada Virtual Host

nano /var/www/ejemplo.com/public_html/index.html

cp /var/www/ejemplo.com/public_html/index.html /var/www/pruebas.com/public_html/index.html

nano /var/www/pruebas.com/public_html/index.html

### Paso Cuatro — Crear Nuevos Archivos Virtual Host

Apache incluye un archivo Virtual Host por defecto denominado 000-default.conf

#### Crear el Archivo Virtual Host

sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/ejemplo.com.conf

sudo nano /etc/apache2/sites-available/ejemplo.com.conf

### Paso Cinco — Habilita los nuevos Archivos Virtual Host
