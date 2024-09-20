FROM yeszao/php:5.4.45-fpm-alpine

COPY _files /tmp/
COPY src /var/www/html

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    && apk add --update --no-cache tar nginx mariadb mariadb-client \
    && mkdir /run/nginx

# mysql ext
RUN docker-php-source extract \
    && docker-php-ext-install mysql mysqli pdo_mysql \
    && docker-php-source delete

# init mysql
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql \
    && sh -c 'mysqld_safe &' \
    && sleep 5s \
    && mysqladmin -uroot password 'root' \
    && mysql -e "source /var/www/html/db.sql;" -uroot -proot

# configure file
RUN mv /tmp/docker-php-entrypoint /usr/local/bin/docker-php-entrypoint \
    && chmod +x /usr/local/bin/docker-php-entrypoint \
    && sed -i "s/\r$//" /usr/local/bin/docker-php-entrypoint \
    && mv /tmp/nginx.conf /etc/nginx/nginx.conf \
    && chown -R www-data:www-data /var/www/html

# clear
RUN rm -rf /var/www/html/db.sql \
    && rm -rf /tmp/*

WORKDIR /var/www/html

EXPOSE 80

VOLUME ["/var/log/nginx"]

CMD ["/bin/sh", "/usr/local/bin/docker-php-entrypoint"]
