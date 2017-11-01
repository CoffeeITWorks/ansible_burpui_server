[![CircleCI](https://circleci.com/gh/CoffeeITWorks/ansible_burpui_server.svg?style=svg)](https://circleci.com/gh/CoffeeITWorks/ansible_burpui_server)

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

By default this role will configure nginx as proxy for gunicorn (the service that starts burpui), the variable that will expose the tcp port for burpui is: 

    burpui_nginx_port: "8080"

### Burpui users:
    
To enable users you can add a list of basic users: 

```yaml
# Enable mixed to allow plain passwords https://git.ziirish.me/ziirish/burp-ui/issues/177#note_1794
burpui_basic_enabled: false
burpui_basic_mixed: "true"
burpui_basic_users:
  - { name: "admin", password: "admin" }
```

Other optional acl for users is to use the basic acl: 

```yaml
# http://burp-ui.readthedocs.io/en/latest/usage.html#basic-acl
burpui_basic_acl_enabled: false
burpui_basic_acl_admins: "user1,user2"
burpui_basic_acl_users: false
#burpui_basic_acl_users:
#  - { name: "user3", value: '["client4", "client5"]' }
#  - { name: "user4", value: '{"agent2": ["client8"], "agent1": ["client6", "client7"]}' }
```

### Multi-agent mode: 

By default burpui is installed as standalone server, it means it will configure /etc/burp/burp.conf as client for burp2 server in localhost and will not connect to any other server, but one very good advantage of using burpui is to have multiple servers connected to it, so you can use to manage the clients on all servers and better the API for burp_reports.

To enable the connection of burpui multi-agent mode, use these vars, example: 

```yaml
# bui-agent
burpui_standalone: false
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

It uses http://supervisord.org/ for better management of third-party  services on the system and to be compatible with most systems (ubuntu trusty+, debian, centos, fedora, etc).

supervisor is used for bui-celery
default service manager for the package manager of your distribution is used for gunicorn (the service responsible to start burpui) and same for nginx (the proxy configured to expose burpui)

So to restart installed services/daemons you should use: 

    sudo supervisorctl restart bui-celery  (depends on the service you want to restart)

you can also use supervisorctl shell: 

    sudo supervisorctl

And then interactively use all options. 

*Logs:* 

Also supervisord allow proper stdout and stderror to logs redirection, so all logs are under `/var/logs/supervisor`

Logs are also rotated by logrotate automatically.

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

