echo "[******] This scripts will begin when you create your container! Because was used the command "CMD" on DockerFile =) \n \n ";

echo "[******] Adding new Hosts to /etc/hosts";
bash /tmp/src/actions/addHosts.sh

echo "[******] Handling with Apache things";
bash /tmp/src/actions/apache.sh

exit 0