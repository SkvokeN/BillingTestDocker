#!/bin/bash
set -e

mysql -u root -h localhost -p${MYSQL_ROOT_PASSWORD} <<-EOSQL
CREATE USER 'monitor'@'%' IDENTIFIED BY 'monitor';
GRANT USAGE ON *.* TO 'monitor'@'%';

GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO ${MYSQL_USER}@'%' REQUIRE X509;
EOSQL