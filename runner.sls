mine.update:
  salt.function:
    - tgt: '*'

haproxy_and_web:
  salt.state:
   - tgt: 'G@roles:lamp-web or G@roles:lamp-haproxy or G@roles:lamp-mysql-master'
   - tgt_type: compound
   - highstate: True
   - require:
     - salt: mine.update

mysql_slave:
  salt.state:
    - tgt: 'roles:lamp-mysql-slave'
    - tgt_type: grain
    - highstate: True
    - require:
      - salt: haproxy_and_web

hardening:
  salt.state:
    - tgt: '*'
    - sls:
      - lamp.hardening
    - require:
      - salt: mysql_slave
