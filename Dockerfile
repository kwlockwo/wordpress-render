# You can change this to a different version of Wordpress available at
# https://hub.docker.com/_/wordpress
FROM wordpress:5.8-apache

RUN apt-get update && apt-get install -y magic-wormhole

RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log

# Symlink PHP error log to stderr
RUN ln -sf /dev/stderr /var/log/php_errors.log

# Configure PHP to log to stderr
RUN echo "log_errors = On" >> /usr/local/etc/php/conf.d/error-logging.ini && \
    echo "error_log = /dev/stderr" >> /usr/local/etc/php/conf.d/error-logging.ini && \
    echo "display_errors = Off" >> /usr/local/etc/php/conf.d/error-logging.ini && \
    echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/error-logging.ini

RUN usermod -s /bin/bash www-data
RUN chown www-data:www-data /var/www
USER www-data:www-data
