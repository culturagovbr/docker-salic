
echo "[******] Copying and enable virtualhost 'site.conf'";
cp /tmp/src/actions/apache2/sites-available/site.conf /etc/apache2/sites-available/site.conf

echo "[******] Copying and enable virtualhost 'status.conf'";
cp /tmp/src/actions/apache2/sites-available/status.conf /etc/apache2/sites-available/status.conf

echo "[******] Copying configurations for security of apache.";
cp /tmp/src/actions/apache2/conf-available/security.conf /etc/apache2/conf-available/security.conf

echo "[******] Copying configurations for security of apache.";
cp /tmp/src/actions/apache2/ports.conf /etc/apache2/ports.conf

a2ensite site.conf
a2ensite status.conf

echo "[******] Disable default virtualhost '000-default.conf'";
a2dissite 000-default.conf

echo "[******] Enable Apache Mod Rewrite";
a2enmod rewrite

echo "[******] Enable Apache Mod Headers";
a2enmod headers

echo "[******] Restarting Apache 2 Service";

#ps auxw | grep apache2 | grep -v grep > /dev/null
#
#if [ $? != 0 ]
#then
#        /etc/init.d/apache2 start > /dev/null
#fi

echo "[******] Starts Apache using Foreground Mode";
apache2ctl -D FOREGROUND
#exec apache2 -DFOREGROUND