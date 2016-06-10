{% from "lamp/mysql/db.jinja" import db with context %}

{% if db.master %}
stop_slave:
  cmd.run:
    - name: mysql --defaults-extra-file=/root/.my.cnf -e 'STOP SLAVE'

change_master:
  cmd.run:
    - name: mysql --defaults-extra-file=/root/.my.cnf -e "CHANGE MASTER TO MASTER_HOST='{{ db.master }}', MASTER_USER='{{ db.slave.username }}', MASTER_PASSWORD='{{ db.slave.password }}';"
    - require:
      - cmd: stop_slave

dump_master:
  cmd.run:
    - name: mysqldump -h{{ db.master }} -u{{ db.slave.username }} -p{{ db.slave.password }} --add-drop-database --add-drop-table --master-data --all-databases > /root/db.sql
    - require:
      - cmd: change_master

load_dump:
  cmd.wait:
    - name: mysql --defaults-extra-file='/root/.my.cnf' < /root/db.sql
    - watch:
      - cmd: dump_master

start_slave:
  cmd.wait:
    - name: mysql --defaults-extra-file=/root/.my.cnf -e "START SLAVE"
    - watch:
      - cmd: load_dump

check_status:
  cmd.wait:
    - name: mysql --defaults-extra-file=/root/.my.cnf -e "SHOW SLAVE STATUS\G"
    - watch:
      - cmd: start_slave

delete_sql:
  cmd.run:
    - name: rm -rf /root/db.sql
    - require:
      - cmd: load_dump
{% endif %}
