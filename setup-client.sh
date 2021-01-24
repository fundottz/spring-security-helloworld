#!/bin/bash

REALM=demorealm
CLIENT_ID=helloworld-app
CLIENT_SECRET=d0b8122f-8dfb-46b7-b68a-f5cc4e25d000

echo ------- Setup config
./kcadm.sh config credentials --server http://localhost:8080/auth \
 --user $KEYCLOAK_USER --password $KEYCLOAK_PASSWORD --realm master

echo ------- Creating realm $REALM
./kcadm.sh create realms -s realm=$REALM -s enabled=true -o

echo ------- Creating client $CLIENT_ID
./kcadm.sh create clients -r $REALM -s clientId=$CLIENT_ID -s enabled=true -s \
 clientAuthenticatorType=client-secret -s secret=$CLIENT_SECRET
export MODIFY_ID=`./kcadm.sh get clients -r $REALM --fields id,clientId | grep $CLIENT_ID -B 1 | grep id | awk -F '"' '{print $4}'`
./kcadm.sh update clients/$MODIFY_ID -r $REALM -s serviceAccountsEnabled=true -s 'redirectUris=["*"]'
