#!/bin/sh

echo "Starting maven dependency resolution..."
for d in $(find . -name 'pom.xml')
do
    NAME=$(dirname "${d//\.//tmp}")
    echo "changing to $NAME"
    cd $(dirname "$NAME")
    echo $(pwd)
    echo "currently in $d..."
    eval 'mvn -Dmaven.repo.local=/tmp/artifacts/m2 -B dependency:go-offline'
done
echo "DONE W/SCRIPT"
