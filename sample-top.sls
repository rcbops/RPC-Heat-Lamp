base:
  'roles:lamp-mysql-master':
    - match: grain
    - lamp.mysql
    - lamp.mysql.master

  'roles:lamp-mysql-slave':
    - match: grain
    - lamp.mysql
    - lamp.mysql.slave

  'roles:lamp-haproxy':
    - match: grain
    - lamp.haproxy

  'roles:lamp-web':
    - match: grain
    - lamp.web
