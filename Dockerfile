FROM bconnect/php

# Enable apache rewrite
RUN a2enmod rewrite

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid

ENV TZ Europe/Berlin
ENV PHPCI_VERSION 1.7.1
ENV PHPCI_URL http://phpci.domain.tld
ENV PHPCI_DB_HOST 127.0.0.1
ENV PHPCI_DB_NAME root
ENV PHPCI_DB_USER root
ENV PHPCI_DB_PASSWORD xxx
ENV PHPCI_ADMIN_LOGIN admin
ENV PHPCI_ADMIN_PASSWORD xxx
ENV PHPCI_ADMIN_MAIL admin@domain.tld

COPY init.sh /root/init.sh
RUN chmod +x /root/init.sh
ADD supervisord.conf /etc/supervisor/conf.d
ADD phpci.conf /etc/apache2/sites-enabled

EXPOSE 80
CMD ["/root/init.sh"]
