# Installed required software
web-software:
  pkg.installed:
    - pkgs:
      - gcc
      - make
      - apache2
      - php5
      - php5-mysql
      - php-apc
      - php-pear

/var/www:
  file.directory:
    - user: www-data
    - group: www-data
    - mode: 744
    - recurse:
      - user
      - group
      - mode

/var/www/html/status.php:
  file.managed:
    - user: www-data
    - group: www-data
    - mode: 644
    - source: salt://lamp/web/files/status.php

apache-service:
  service.running:
    - name: apache2
    - enable: True
    - require:
      - pkg: web-software
