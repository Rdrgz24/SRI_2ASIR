# Actividad 1 - Instalación de Apache

## Preguntas

### 1. La arquitectura Web es un modelo compuesto de tres capas, ¿cuáles son y cuál es  la función de cada una de ellas?
---------------------------
Esta arquitectura predomina en las aplicaciones cliente-servidor tradicionales, está compuesta por:

· Nivel de presentación
---------------------------
Es la interfaz donde el usuario final se comunica e interactua con la aplicación. Su objetivo es mostrar la información al usuario y recopilar datos de este.

Este nivel se puede ejecutar en un navegador web, una aplicación de escritorio o una interfaz gráfica (GUI). Esta capa se suele desarrollar en HTML, CSS y JavaScript.

· Nivel de aplicación
---------------------------
Conocido nivel lógico o medio, es el núcleo de la aplicación; procesa la información recopilada en el nivel de presentación y utilizando la "lógica empresarial" y un conjunto de reglas comerciales se manda información al nivel de datos. 

Esta capa se suele desarrollar en Python, Perl, Java, PHP o Ruby; se comunica con el nivel de datos mediante las API.  

· Nivel de datos
---------------------------
Conocido como nivel de acceso a datos o backend, es donde se almacena y gestiona la información procesada por la aplicación. 

Puede integrar un sistema relacional de administración de bases de datos como MySQL, PostgreSQL, MariaDB, Oracle, DB2 o Microsoft SQL Server; O un servidor NoSQL de bases de datos como Cassandra,CouchDB o MongoDB.


### 2. Una plataforma web es el entorno de desarrollo de software empleado para  diseñar y ejecutar un sitio web; destacan dos plataformas web, LAMP y WISA. Explica en qué consiste cada una de ellas.

**LAMP (Linux, Apache, MySQL, PHP/Python/Perl)**
---------------------------
Plataforma web de código abierto ampliamente utilizada para desarrollar y ejecutar sitios web dinámicos.

· **L**inux como sistema operativo.

· **A**pache como servidor web para procesar solicitudes HTTP/HTTPS.

· **M**ySQL como sistema gestor de bases de datos.

· **P**HP/Python/Perl para programar la lógica de la aplicación.

**WISA (Windows, IIS, SQL Server, ASP.NET)**
---------------------------
Plataforma web basada en tecnologías propietarias de Microsoft, diseñada para entornos corporativos o sistemas preferentes de esta compañía.

· **W**indows como sistema operativo.

· **I**IS (Internet Information Services) como servidor web de Microsoft.

· **S**QL Server para la gestión de bases de datos de Microsoft.

· **A**SP.NET como Framework para crear aplicaciones web dinámicas en .NET.


## Instalación de pila LAMP en Ubuntu 24.04
La pila “LAMP” se refiere al conjunto de aplicaciones software que se instalan juntas para que un servidor permita alojar aplicaciones y sitios web dinámicos escritos en PHP. 
El término en realidad se refiere al Sistema Operativo "Linux" junto al servidor web "Apache", almacenando los datos en una base de datos "MySQL" y procesando el contenido dinámico mediante "PHP".

## Pasos de Instalación
**1. Instalar Apache y actualizar el firewall**  
   ------------------------------------------------------

**2. Instalar MySQL**  
   ----------------------------------------------
**3. Instalar PHP**  
   -------------------------------------------

**4. Crear host virtual para nuestro sitio web**
   ---------------------------------------

**5. Probar procesamiento PHP en el servidor web**
   -------------------------------
