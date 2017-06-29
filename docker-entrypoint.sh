#!/bin/bash
set -e

if ! [ -e index.php ] || ! [ -n "$(ls -A /var/www/salic)" ] || ! [ -n "$(ls -A /var/www/salic/application)" ]; then
    echo "Application not found in /var/www/salic - copying now..."
    if [ "$(ls -A)" ]; then
        echo "WARNING: /var/www/salic is not empty - press Ctrl+C now if this is an error!"
        ( set -x; ls -A; sleep 10 )
    fi

    git clone -b 'develop' http://git.cultura.gov.br/sistemas/novo-salic.git /tmp/salic
    ls -la /tmp/salic

    cp /tmp/salic -r /var/www
    chown www-data:www-data -R /var/www/salic
    echo "Complete! The application has been successfully copied to /var/www/salic"

    ls -la /var/www/salic
fi

exec "$@"