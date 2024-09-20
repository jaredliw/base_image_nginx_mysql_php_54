# jaredliw/base_image_nginx_mysql_php_54

Docker: https://hub.docker.com/r/jaredliw/base_image_nginx_mysql_php_54 \
GitHub: https://github.com/jaredliw/base_image_nginx_mysql_php_54

## Base Image LNMP

- L: Linux alpine
- N: Nginx
- M: MySQL
- P: PHP 5.4.45
    + mysql ext.
    + mysqli ext.

## Usage

```cmd
docker run -p 80:80 -p 9000:9000 jaredliw/base_image_nginx_mysql_php_54 myapp
```

Modified from [CTFTraining/base_image_nginx_mysql_php_56](https://github.com/CTFTraining/base_image_nginx_mysql_php_56).