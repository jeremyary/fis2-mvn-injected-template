#!/bin/sh

echo "Starting maven dependency resolution..."
for d in $(find . -name 'pom.xml')
do
    cd $(echo $d | tr -d '\r' | awk '{print $2}')
    echo "currently in $d..."
    eval 'mvn dependency:go-offline'
done
echo "DONE W/SCRIPT"
