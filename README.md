# docker-salic

Repo used to have a recipe(Dockerfile) to create a image used by SALIC (Sistema de Apoio às Leis de Incentivo à Cultura)

## Prerequisites
* Docker - More information [here](http://pt.slideshare.net/vinnyfs89/docker-essa-baleia-vai-te-conquistar?qid=aed7b752-f313-4515-badd-f3bf811c8a35&v=&b=&from_search=1).

## Details

For Each extension installed inside DockerFile, PHP will be compiled again.

## How to build - New image
* Enter inside this cloned repository;
* Execute the commando below to create a new image.
```
docker build -t culturagovbr/salic-web:1.0 -t culturagovbr/salic-web:latest .
```

This code `-t culturagovbr/salic-web:1.0` means you will create a image named 'salic-web' and tag '1.0' and the `.` means your build will use the same folder.

You can execute the command below to create a new container using this new image created. Note: `$(pwd)` means your current directory. You can also change it, if you want.
```
 docker run -it -v $(pwd)/novo-salic:/var/www -v $(pwd)/log/apache2:/var/log/apache2 -v /var/www/salic/public/txt:/var/www/public/txt/ -v /var/www/salic/public/plenaria:/var/www/public/plenaria/ --name salic-webv1.0 -e APPLICATION_ENV="development" -p 80:80 -p 9000:9000 -p 8888:8888 culturagovbr/salic-web:1.0
```

Or You you can also execute the same command above, but arranging using docker-compose:
```
 docker-compose up -d
```
## Monitoring Server status
```
docker exec -it salic-webv1.0 bash -c "cd /tmp && wget 127.0.0.1/server-status -o server-status && cat server-status"
```

## Extra

If you wanna check something inside your container you can access using the command below:
```
docker exec -it salic-webv1.0 bash
```

See the authors of this repo:
* [Authors](./Authors.md).
