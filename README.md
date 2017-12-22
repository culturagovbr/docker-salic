# docker-salic

Repositório utilizado como receita para utilização da plataforma [Docker](http://pt.slideshare.net/vinnyfs89/docker-essa-baleia-vai-te-conquistar?qid=aed7b752-f313-4515-badd-f3bf811c8a35&v=&b=&from_search=1) e arquivo Dockerfile e construir novas imagens para o SALIC (Sistema de Apoio às Leis de Incentivo à Cultura)	.
   
## Sobre
		
Dentro do Dockerfile, na construção da imagem, para cada módulo PHP que for instalado, o PHP será recompilado.

Esse repositório tinha sido descontinuado mas de acordo com uma necessidade de infraestrutura tornou a ser necessário para que seja utilizado apenas para a geração de uma imagem fechada do PHP já contendo o código da aplicação.
		
## Construindo uma nova imagem e gerando novos containers		
		
 * Copie o arquivo ```docker-compose.yml_sample``` para ```docker-compose.yml``` 		
 * Defina a localização como você preferir para a propriedade "volumes", mapeando host e container
 * Execute o comando ``` docker-compose up -d --build	```
		
## Monitoramento do status do servidor		
		
Para monitoramento do seu container, basta executar o comando abaixo:
   	
    docker exec -it salic-br bash -c "cd /tmp && wget 127.0.0.1/server-status -o server-status && cat server-status"		

## Extra		
	
Caso seja necessário verificar algo dentro do seu container você poderá acessá-lo utilizando o comando abaixo:
```
    docker exec -it salic-web bash		
```

## Desenvolvedores

O arquivo docker-compose.yml_dev é uma sugestão para desenvolvedores:
* mem_limit: 1g # limitar espaço do container em memoria da maquina.
* XDEBUG_INSTALL="true" # Adiciona as configurações do xdebug
* networks: # Configuração estatica de ips para container, possibilita incluir o ip no /etc/hosts
