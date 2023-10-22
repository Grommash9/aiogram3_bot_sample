## Під час отримання доменного імені вам слід перевірити його тут
https://www.nslookup.io/

## Якщо доменне ім'я вказує на IP-адреси Cloudflare і ви бачите логотип Cloudflare, вам не потрібно використовувати certbot
# У вас не буде жодних даних в `/etc/nginx/sites-available/default`, тому вам слід створити віртуальний хост, що вказує на вашу локальну адресу, як це:

# Адміністративна панель Django (config буде згенеровано під час встановлення за допомогою `systemd/create_and_install_systemctl_files.py`, тому вам слід просто скопіювати його сюди)

```
server {
        listen 80;
        listen [::]:80;
        root /var/www/;
        index index.html index.htm index.nginx-debian.html;
        server_name prud-super-payment-api.telegram-crm.work;
        include /etc/nginx/admin_panel_bot-bestchange-price-gap-notify/*.conf;
}
}
```

# Бот чи будь-який мікросервіс
```
server {
        listen 80;
        listen [::]:80;
        root /var/www/;
        index index.html index.htm index.nginx-debian.html;
        server_name prud-super-payment-api.telegram-crm.work;
        location / {
            proxy_pass         http://127.0.0.1:2102;
            proxy_redirect     off;
            proxy_set_header   Host $host;
            proxy_set_header   X-Real-IP $remote_addr;
            proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header   X-Forwarded-Host $server_name;
}
}
```

## Якщо домен вказує на IP-адрес вашого сервера - у вас немає Cloudflare і вам слід створити сертифікат
`sudo apt install certbot python3-certbot-nginx`

`sudo ufw allow 22`
`sudo ufw allow 'Nginx Full'`
`sudo ufw delete allow 'Nginx HTTP'`
`sudo ufw enable`
`sudo certbot --nginx -d prud-super-payment-api.telegram-crm.work`

# Після створення сертифіката ви матимете запис для нього в `/etc/nginx/sites-available/default`, тому вам слід відредагувати його та змінити локалі або додати інструкцію include!


## Приклади та додаткова інформація:

- Щоб перевірити правильність конфігурації Nginx, ви можете використовувати команду:
```
sudo nginx -t
```

Ця команда допомагає переконатися, що конфігурація Nginx не містить синтаксичних помилок.

- Після внесення змін до конфігураційних файлів Nginx, вам слід перезавантажити службу, щоб зміни набули чинності:
```
sudo systemctl restart nginx
```

Ця команда перезавантажує Nginx, щоб відобразити оновлену конфігурацію.

Це різновид посібника для налаштування сервера Nginx та настроювання доменних імен на вашому сервері. Не забудьте зробити резервні копії своєї конфігурації перед внесенням змін та переконайтеся, що служба Nginx правильно працює після всіх змін.