# BillingTestDocker

## Stable on ##
* ubuntu 16.04 LTS
* docker version 17.09.0-ce, build afdb6d4 
    * after installing docker run `sudo usermod -a -G docker $USER`
    * re-login(in system) after this command
* docker-compose version 1.15.0, build e12f3b9

## Запуск тестового скрипта ##
* mkdir iqOptionTest && cd iqOptionTest
* git clone https://github.com/SkvokeN/BillingTestDocker.git .
* sh build.sh
* sh run.sh php-cli bin/console app:test-consumer

## Решение ##
* Для развертывание проекта используется Docker.
* Для реализации микросервиса был выбран фреймворк Symfony 4 - skeleton.
* В качестве брокера сообщений был выбран RabbitMQ. Для работы с RabbitMQ используется RabbitMqBundle. Для контроля воркеров используется Supervision.
* В качестве системы хранения баланса был выбран Mysql 5.7. Для работы с mysql используется Doctrine.

Для тестирование воркеров можно использовать тестовую команду:  
```bash 
sh run.sh php-cli bin/console app:test-consumer 
```


