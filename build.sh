#!/bin/bash

export HOST_UID=$(id -u)

echo '---> Cleaning'
rm app/.env
rm -rf app/var/cache
git clone https://github.com/SkvokeN/BillingTest.git app
docker-compose up -d
sh run.sh php-cli composer install --no-interaction
cat certificates/.env > app/.env


sh run.sh php-cli bin/console doctrine:migrations:migrate
sh run.sh php-cli bin/console doctrine:fixtures:load