Nombre del rol
==============
Descripcion breve del rol.

Procedimiento
=============

Troubleshooting
===============

Si tienes cualquier problema con burpui, primero verifica que el cliente burp puede conectarse al monitor: 

    burp -c burpui.conf -a m

Cambios en ansible
------------------

Cambios en inventario
---------------------

Cambios en monitoreo
--------------------

Cambios en runbook
------------------

Cambios en otras planillas
--------------------------

Requerimientos
--------------

Cualquier requerimiento necesario para ejecutar el rol, ya sea otros roles o especificaciones en los servidores destino.

Variables
---------

### Add to your host/group_vars:
 
 burp_version: 1/2 (1 for version 1 on server or 2 for version 2 of burp server"

Tags
----

Breve descripcion de cada una de las tags del rol.

Dependencias
------------

Los roles de los que depende.

Ejemplo en Playbook
-------------------

Incluir un ejemplo de como agregar el rol a un playbook.

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

Afecta
------

Archivos de sistema o servicios que este rol afecte y que sea necesario aclarar para no interferir con otros roles.

Licencia
--------

Aclarar la licencia.

Informacion del autor
---------------------

Informacion opcional del autor.