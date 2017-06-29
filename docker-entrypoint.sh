#!/bin/bash
set -e
echo "[ ****************** ] Starting Endpoint of Application"
if ! [ -d "/var/www/salic" ] || ! [ -d "/var/www/salic/application" ]; then
    echo "Application not found in /var/www/salic - cloning now..."
    if [ "$(ls -A)" ]; then
        echo "WARNING: /var/www/salic is not empty - press Ctrl+C now if this is an error!"
        ( set -x; ls -A; sleep 10 )
    fi
    echo "[ ****************** ] Cloning Project repository to tmp folder"
    git clone -b 'develop' http://git.cultura.gov.br/sistemas/novo-salic.git /tmp/salic
    ls -la /tmp/salic

    echo "[ ****************** ] Copying Project from temporary folder to workdir"
    cp /tmp/salic -r /var/www

    echo "[ ****************** ] Copying sample application configuration to real one"
    cp /var/www/salic/application/configs/exemplo-application.ini /var/www/salic/application/configs/application.ini

    echo "[ ****************** ] Changing owner and group from the Project to 'www-data' "
    chown www-data:www-data -R /var/www/salic

    ls -la /var/www/salic

    echo "Complete! The application has been successfully copied to /var/www/salic"
fi
echo "[ ****************** ] Ending Endpoint of Application"
exec "$@"