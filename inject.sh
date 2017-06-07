#!/bin/sh

echo "Starting maven dependency resolution..."
for d in $(find . -name 'pom.xml')
do
    cd $d
    echo "currently in $d..."
    eval 'mvn dependency:go-offline'
done
echo "DONE W/SCRIPT"
