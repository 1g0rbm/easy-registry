#!/bin/bash

echo "Enter login for basic http auth:"
read name

echo "Enter password for basic http auth:"
read password

docker run --entrypoint htpasswd registry -Bbn ${name} ${password} > ./pswd/htpasswd

echo "Well done!"