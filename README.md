[![Molecule pipeline test](https://github.com/CoffeeITWorks/ansible_burpui_server/actions/workflows/molecule-test.yml/badge.svg)](https://github.com/CoffeeITWorks/ansible_burpui_server/actions/workflows/molecule-test.yml)

Getting Started
================

Check the documentation added in: 

https://github.com/CoffeeITWorks/ansible-generic-help#getting-started


Role Name
=========

ansible_burpui_server deploy and maintenance role.

This roles builds burpui version specified on defaults/main.yml. 
Also configures it to get it working and maintained in a centralized way.

VARS
====

defaults/main.yml

```yaml
# burp backend to load either one of 'burp1', 'burp2', 'parallel' or 'multi'.
# If you choose 'multi', you will have to declare at lease one 'Agent' section.
# If you choose 'parallel', you need to configure the [Parallel] section.
# If you choose either 'burp1' or 'burp2', you need to configure the [Burp]
# section.
# The [Burp] section is also used with the 'parallel' backend for the restoration
# process.
# You can also use whatever custom backend you like if it is located in the
# 'plugins' directory and if it implements the right interface.
burpui_backend = burp2
```

By default this role will configure nginx as proxy for gunicorn (the service that starts burpui), the variable that will expose the tcp port for burpui is: 

    burpui_nginx_port: "8080"

### Burpui users:
    
To enable users you can add a list of basic users: 

```yaml
# Enable mixed to allow plain passwords https://git.ziirish.me/ziirish/burp-ui/issues/177#note_1794
burpui_basic_enabled: false
burpui_basic_users:
  - { name: "admin", password: "plain$$admin" }
```

Use the following method to create hash passwords:

    pip install --user werkzeug

```python
werkzeug.security.generate_password_hash('plainpassword', method='pbkdf2:sha256')

'pbkdf2:sha256:260000$hZ7teoNFWtkS6g4J$4ff797c0f8d1d59009a8ef8d9ee1d1126fae1713d7128d66d1132005dcfe7c9a'
```

Other optional acl for users is to use the basic acl: 

Check the burp-ui docs, you can use wildcards and others special characters here.
```yaml
# http://burp-ui.readthedocs.io/en/latest/usage.html#basic-acl
burpui_global_acl: 'basic'
burpui_basic_acl_admins: "user1,user2"
burpui_basic_acl_users: false
burpui_basic_acl_users:
  - { name: "user3", value: '["client4", "client5"]' }
  - { name: "user4", value: '{"agent2": ["client8"], "agent1": ["client6", "client7"]}' }
```

### Multi-agent mode: 

By default burpui is installed as standalone server, it means it will configure /etc/burp/burp.conf as client for burp2 server in localhost and will not connect to any other server, but one very good advantage of using burpui is to have multiple servers connected to it, so you can use to manage the clients on all servers and better the API for burp_reports.

To enable the connection of burpui multi-agent mode, use these vars, example: 

```yaml
# bui-agent
burpui_backend: multi
burpui_agents:
  - { name: "localhost", address: "127.0.0.1", port: "5001", password: "password", ssl: "false" }
  - { name: "host2", address: "192.168.122.202", port: "5001", password: "password", ssl: "false" }
```

You can use a recommended role created by us: ansible_burp2_server to configure burp2_server and also the burpui_agent to use with burpui multi-agent mode. 

You can check more variables to modify at `defaults/main.yml` file.


Notes upgrading:
================

http://burp-ui.readthedocs.io/en/latest/upgrading.html

Upgrade steps are managed automatically by this role. 


Installed services
==================


by default systemd is used for bui-celery and gunicorn
default service manager for the package manager of your distribution is used for gunicorn (the service responsible to start burpui) and same for nginx (the proxy configured to expose burpui)

Python virtualenv is used, by default you will see packages in:

    /venv_apps/bui/lib/python3.10/site-packages/

And binaries in:

    /venv_apps/bui/bin

You can change the variable for virtualenv, see defaults vars.

Accessing burpui
----------------

You will be able to access to http://YOURADDRESS:8080 or whatever you have used in your own `group_vars/burpui_servers` for variable: 

```yaml
burpui_nginx_port: "8080"
```

License
-------

MIT

Author Information
------------------

This role was main developed by Diego Daguerre with collaboration of Pablo Estigarribia (pablodav at gmail)

Burp backup and restore
=======================

Main page: http://burp.grke.org/

Burpui
======

Main page: https://git.ziirish.me/ziirish/burp-ui

