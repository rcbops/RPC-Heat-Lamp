{% from "lamp/mysql/db.jinja" import db with context %}

slave_user:
  mysql_user.present:
    - name: {{ db.slave.username }}
    - password: {{ db.slave.password }}
    - host: {{ db.slave.host }}
    - connection_default_file: /root/.my.cnf
    - require:
      - pkg: mysql-software

  mysql_grants.present:
    - user: {{ db.slave.username }}
    - host: {{ db.slave.host }}
    - database: '*.*'
    - grant: replication slave, reload, replication client, select
    - connection_default_file: /root/.my.cnf
    - require:
      - pkg: mysql-software
