# docker-salic

Repo used to have a recipe(Dockerfile) to create a image used by SALIC (Sistema de Apoio às Leis de Incentivo à Cultura)

## Prerequisites
* Docker - More information [here](http://pt.slideshare.net/vinnyfs89/docker-essa-baleia-vai-te-conquistar?qid=aed7b752-f313-4515-badd-f3bf811c8a35&v=&b=&from_search=1).

## Details

For Each extension installed inside DockerFile, PHP will be compiled again.

## How to build new image and create a container

 * Copy the file ```docker-compose.yml_sample``` to ```docker-compose.yml``` 
 * Set the locations as you prefer in 'volumes' attribute
 * Run the command below

```
 docker-compose up -d
```

## Monitoring Server status

To monitor your container, just run the command below:
```
docker exec -it salic-web bash -c "cd /tmp && wget 127.0.0.1/server-status -o server-status && cat server-status"
```

## Extra

If you wanna check something inside your container you can access using the command below:
```
docker exec -it salic-web bash
```

See the authors of this repo:
* [Authors](./Authors.md).
