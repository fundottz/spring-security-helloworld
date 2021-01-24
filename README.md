Spring Security OAuth2.0: Resource Server + Client App + Keycloak as Authorization Server
---


- run keycloak 
```shell
docker-compose -f keycloak-postgres.yml up -d
```
- create client application

```shell
docker ps
CONTAINER ID   IMAGE                              COMMAND                  CREATED      STATUS      PORTS                              NAMES
8a223a16fed7   quay.io/keycloak/keycloak:latest   "/opt/jboss/tools/do…"   2 days ago   Up 2 days   0.0.0.0:8080->8080/tcp, 8443/tcp   composes_keycloak_1
b639d6e6e019   postgres                           "docker-entrypoint.s…"   2 days ago   Up 2 days   5432/tcp                           composes_postgres_1

docker cp setup-client.sh 8a223:/opt/jboss/keycloak/bin
docker exec 8a223 /opt/jboss/keycloak/bin/setup-client.sh
```

- get access token via clientId + clientSecret
```
  curl --location --request POST 'http://localhost:8080/auth/realms/demorealm/protocol/openid-connect/token' \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --data-urlencode 'client_id=helloworld-app' \
  --data-urlencode 'client_secret=d0b8122f-8dfb-46b7-b68a-f5cc4e25d000' \
  --data-urlencode 'grant_type=client_credentials'
```
- check token is valid
```  
  curl -v http://localhost:8080/auth/realms/demorealm/protocol/openid-connect/token/introspect \
   --data "client_secret=d0b8122f-8dfb-46b7-b68a-f5cc4e25d000&client_id=hellowold-app&token=${TOKEN}"
```