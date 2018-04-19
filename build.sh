#!/bin/bash

export HOST_UID=$(id -u)

git clone https://github.com/SkvokeN/BillingTest.git app

docker-compose build
docker-compose up -d

cat certificates/.env > app/.env
sh run.sh php-cli composer install --no-interaction

sleep 30s

sh run.sh php-cli bin/console doctrine:migrations:migrate --no-interaction
sh run.sh php-cli bin/console doctrine:fixtures:load --no-interaction