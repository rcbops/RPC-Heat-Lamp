base:
  'roles:lamp-web':
    - match: grain
    - lamp
  'roles:lamp-haproxy':
    - match: grain
    - lamp
  'roles:lamp-mysql-master':
    - match: grain
    - lamp
  'roles:lamp-mysql-slave':
    - match: grain
    - lamp
