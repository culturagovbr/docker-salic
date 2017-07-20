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


    echo "[ ****************** ] Downloading composer "

    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

    echo "[ ****************** ] Installing composer "
    php composer-setup.php

    echo "[ ****************** ] Unlinking and moving composer to '/usr/local/bin/' directory"
    php -r "unlink('composer-setup.php');"
    mv composer.phar /usr/local/bin/composer

fi


# X-Debug

echo "$XDEBUG_REMOTE_ENABLE"

if ! [ -v $XDEBUG_REMOTE_ENABLE ] ; then
    echo "[ ****************** ] Starting install of XDebug and dependencies."
    yes | pecl install xdebug
    echo "zend_extension="`find /usr/local/lib/php/extensions/ -iname 'xdebug.so'` > $XDEBUGINI_PATH
    echo "xdebug.remote_enable=$XDEBUG_REMOTE_ENABLE" >> $XDEBUGINI_PATH

    if ! [ -v $XDEBUG_REMOTE_AUTOSTART ] ; then
        echo "xdebug.remote_autostart=$XDEBUG_REMOTE_AUTOSTART" >> $XDEBUGINI_PATH
    fi
    if ! [ -v $XDEBUG_REMOTE_CONNECT_BACK ] ; then
        echo "xdebug.remote_connect_back=$XDEBUG_REMOTE_CONNECT_BACK" >> $XDEBUGINI_PATH
    fi
    if ! [ -v $XDEBUG_REMOTE_HANDLER ] ; then
        echo "xdebug.remote_handler=$XDEBUG_REMOTE_HANDLER" >> $XDEBUGINI_PATH
    fi
    if ! [ -v $XDEBUG_PROFILER_ENABLE ] ; then
        echo "xdebug.profiler_enable=$XDEBUG_PROFILER_ENABLE" >> $XDEBUGINI_PATH
    fi
    if ! [ -v $XDEBUG_PROFILER_OUTPUT_DIR ] ; then
        echo "xdebug.profiler_output_dir=$XDEBUG_PROFILER_OUTPUT_DIR" >> $XDEBUGINI_PATH
    fi
    if ! [ -v $XDEBUG_REMOTE_PORT ] ; then
        echo "xdebug.remote_port=$XDEBUG_REMOTE_PORT" >> $XDEBUGINI_PATH
    fi

    echo "xdebug.remote_host="`/sbin/ip route|awk '/default/ { print $3 }'` >> $XDEBUGINI_PATH
    echo "[ ****************** ] Ending install of XDebug and dependencies."
fi

echo "[ ****************** ] Ending Endpoint of Application"
exec "$@"