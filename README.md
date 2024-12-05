# Library App
Web интерфейс библиотеки

Выберите предпочтительный метод установки ниже:

Docker: официально поддерживается и рекомендуется для большинства пользователей.

Скачайте файлы проекта, необходимые для запуска
```
https://github.com/terratensor/library-app/archive/refs/heads/master.zip
```
Или клонируйте репозиторий с  помощью команды git:
```
git clone https://github.com/terratensor/library-app.git
```


Для запуска приложения в windows запустите файл start.bat
```
start.bat
```
Для запуска приложения в linux или в консоли wsl, выполните команду в консоли
```
make
```

Утилита make должна быть установлена
```
sudo apt install make
```

## Запуск Library App
После запуска контейнера откройте Library App по адресу:

http://localhost:8030

Подробную справку по каждому флагу Docker смотрите в документации Docker.

### Хранение данных и привязка подключений
В этом проекте для сохранения данных используются именованные тома Docker. При необходимости замените имя тома каталогом хоста:

Пример:

-v /путь/к/папке:/приложение/серверная часть/данные

Убедитесь, что у папки хоста есть правильные разрешения.

## Альтернативный способ

Можно ничего не скачивать, а создать файл docker-compose.yml по инструкции ниже.
И выполнить команды для запуска.

## Установка Docker Compose
Использование Docker Compose упрощает управление многоконтейнерными приложениями Docker.

Если у вас не установлен Docker, ознакомьтесь с руководством по установке Docker.

Для установки Docker Compose требуется дополнительный пакет, docker-compose-v2.

Внимание: в более старых руководствах по Docker Compose могут использоваться ссылки на синтаксис версии 1, в котором используются такие команды, как `docker-compose build`. Убедитесь, что вы используете синтаксис версии 2, в котором используются такие команды, как `docker compose build` (обратите внимание на пробел вместо дефиса).

### Пример docker-compose.yml
Вот пример файла конфигурации для настройки Library App с помощью Docker Compose:

```
services:
  app:
    image: ghcr.io/terratensor/library-app:main
    container_name: library-app  
    volumes:
      - library-app:/app/data
    ports:
      - '8030:80'

  manticore:
    container_name: library-manticore
    image: manticoresearch/manticore
    environment:
      - EXTRA=1
    ports:
      - "127.0.0.1:9306:9306"
      - "127.0.0.1:9308:9308"
      - "127.0.0.1:9312:9312"

    cap_add:
      - IPC_LOCK
    ulimits:
      nproc: 65535
      nofile:
        soft: 65535
        hard: 65535
      memlock:
        soft: -1
        hard: -1
    volumes:
      - manticore:/var/lib/manticore
      - manticore:/var/log/manticore

volumes:
  library-app:
    name: library-app
    external: true
  manticore:
    name: library_manticore
    external: true
```

## Запуск служб
Чтобы запустить ваши службы, выполните следующую команды:

```
docker compose up -d
```
```
docker exec -it library-app php init-actions --interactive=0 \
docker exec -it library-app php yii initial/index --interactive=0 \
docker exec -it library-app php yii migrate --interactive=0
```
