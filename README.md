VARS
====

defaults/main.yml

```yaml
# Enable mixed to allow plain passwords https://git.ziirish.me/ziirish/burp-ui/issues/177#note_1794
burpui_basic_mixed: "true"
burpui_basic_users:
  - { name: "admin", password: "admin" }
```

```yaml
# bui-agent
burpui_agents:
  - { name: "localhost", address: "127.0.0.1", port: "10000", password: "password", ssl: "false" }
```


Notes upgrading:
================

http://burp-ui.readthedocs.io/en/latest/upgrading.html#v0-4-0

Trying to do all what's required automatically.

