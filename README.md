# spa-cms
Проект, которым я собираюсь заниматься в свободное от работы время для собственного удовольствия.

Планируется создание CMS, с помощью которой можно будет строить spa прилоджения, готовые к seo.

В качестве инструментов для проекта были выбраны:
* Yii2
* Angular2
* Postgresql

Было принято решение писать комментарии к коду и описание проекта на русском языке, 
потому что для меня проще выражать свои мысли на нем, задача о переводе на английский
 язык поставлена https://github.com/potupchik/spa-cms/issues/1
  
Причины по которым я решил заняться проектом:
* Мне интересна сама задача
* Есть желание в использовании подобного инструмента
* Не нашел подобных решений на рынке  (если вы найдет хорошее решение, пожалуйста,
не поленитесь написать мне об этом в лс)

# Сборка проекта dev

* Создать базу данных и прописать ее реквизиты в **environments/dev/common/config/params-local.php**
* Выполнить в корне проекта **make build-dev**
* Настроить веб сервер.

# Настройка веб сервера nginx

Для api:
```server {
    charset utf-8;
    client_max_body_size 128M;

    listen 80;

    server_name cms.local;
    root        /path/to/spa-cms/api/web/;
    index       index.php;

    access_log  /path/to/log/cms-access.log;
    error_log   /path/to/log/cms-error.log;

    location / {
        # Redirect everything that isn't a real file to index.php
        try_files $uri $uri/ /index.php$is_args$args;
    }

    # deny accessing php files for the /assets directory
    location ~ ^/assets/.*\.php$ {
        deny all;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
        try_files $uri =404;
    }

    location ~* /\. {
        deny all;
    }
}
```

Для фронта:
```
server {
    charset utf-8;
    client_max_body_size 128M;

    listen 80; ## listen for ipv4

    server_name spa.local;
    root        /path/to/work/spa-cms/frontend/;
    index       index.html;

    access_log  /path/to/spa-access.log;
    error_log   /path/to/spa-error.log;

    location ~* /\. {
        deny all;
    }
}
```