#!/bin/sh

echo "Git project fetched. Starting maven dependency resolution..."
for d in $(find . -name 'pom.xml')
do
    NAME=$(dirname "${d//\.//tmp}")
    cd $(dirname "$NAME")
    echo "pom.xml file detected in: $(pwd), fetching dependencies..."
    eval 'mvn -Dmaven.repo.local=/tmp/artifacts/m2 -B dependency:go-offline'
done
echo "maven dependency resolution complete"
