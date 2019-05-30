#!/bin/bash

echo "Enter login for basic http auth:"
read name

echo "Enter password for basic http auth:"
read password

hash=`echo ${password}|md5`

echo "$name:$hash" > ./pswd/htpasswd

echo "Well done!"