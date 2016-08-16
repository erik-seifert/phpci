#!/bin/sh
# if [ -d "/var/www/phpci/public/" ]; then
# 	cd /var/www/phpci/
# 	VERSION=`git status|grep HEAD|awk '{print $4}'`
# 	if [ "$PHPCI_VERSION" != "$VERSION" ]; then
# 		echo "Need to be upgrade"
# 		cd /var/www/
# 		rm -rf /var/www/phpci/*
# 	fi
# fi

if [ ! -f "/var/www/.installed" ]; then
	rm -rf /var/www/html/PHPCI/config.yml
	/var/www/html/console phpci:install --queue-disabled \
																		  --url=$PHPCI_URL \
															  		  --db-host=$PHPCI_DB_HOST \
																			--db-name=$PHPCI_DB_NAME \
																			--db-user=$PHPCI_DB_USER \
																			--db-pass=$PHPCI_DB_PASSWORD \
																			--admin-name=$PHPCI_ADMIN_LOGIN \
																			--admin-pass=$PHPCI_ADMIN_PASSWORD \
																			--admin-mail=$PHPCI_ADMIN_MAIL \
																			-n
  status=$?
	# if [ $status -eq 0 ]; then
	# else
	# fi
	chown -R www-data: /var/www/html
	echo $PHPCI_VERSION > /var/www/.installed
fi

/usr/sbin/apache2 -DFOREGROUND
