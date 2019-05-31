# easy-registry
🐳 Kit for creating safe docker registry with basic http auth

Для настройки docker-registry на сервере понадобится:
* [Docker](https://docs.docker.com/install) и [docker-compose](https://docs.docker.com/compose/install)
* SSL-сертификат. Лучше использовать бесплатные сертификаты от [letsencrypt](https://letsencrypt.org), для генерации [certbot](https://certbot.eff.org)
* [Nginx](https://nginx.org) для проксирования запросов на запущенный registry контейнер

Сначала нужно настроить хост с которого запросы будем проксировать на контейнер.
Конфиг nginx'a может выглядеть примерно так:
``` nginx
 server {
    server_name registry.host.com;
    location / {
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Server $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass https://localhost:5000;
        client_max_body_size 100M;
    }
}
```

Теперь для хоста нужно сгенерировать сертификат. Выполняем в консоли `sudo certbot` и следуем инструкциям бота.

Клонируем репозиторий: `git clone https://github.com/1g0rbm/easy-registry.git`. Далее переходим в склонированную директорию, выполняем команду `cp .env.dist .env` и открываем `.env` на редактирование.

В секции `replace this values` нужно заменить переменные окружения на свои значения:
``` config
PATH_TO_REGISTRY_DIR=/var/www/registry.host.com # путь до директории куда склонировн репозиторий
PATH_TO_CERTS=/etc/letsencrypt/archive/registry.host.com # путь до диретории с файлами сертификата (для контейнера используем тот же сертификат что и для хоста)
```

Теперь нужно сгенеририровать логин и пароль для basic http auth. Запускаем команды `make prepare_scripts` и `make basic_http_auth`. Скрипт предложит ввести логин пользователя и пароль.

Далее нужно просто запустить контейнер registry через docker-compose: `docker-compose up -d`.
