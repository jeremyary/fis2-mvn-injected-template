#!/bin/sh

echo "Git project fetched. Starting maven dependency resolution..."
for d in $(find ./* -name 'Model')
do
    NAME=$(dirname "${d//\.\///tmp/}")
    cd "$NAME"
    echo "Model module detected at $NAME, injecting......"
    mvn -s /tmp/settings.xml -Dmaven.repo.local=/tmp/artifacts/m2 install -B
    if [ "$?" -ne 0 ]; then
        echo "Maven packaging unsuccessful"
        exit 1
    fi
    cd /tmp
done
for d in $(find ./* -name 'pom.xml')
do
    NAME=$(dirname "${d//\.\///tmp/}")
    if [[ ${NAME} != *Model* ]]; then
      cd "$NAME"
      echo "pom.xml file detected in: $NAME, fetching dependencies..."
      mvn -s /tmp/settings.xml -Dmaven.repo.local=/tmp/artifacts/m2 package -DskipTests -e -Dfabric8.skip=true -B
      if [ "$?" -ne 0 ]; then
          echo "Maven packaging unsuccessful"
          exit 1
      fi
    fi
done
echo "maven dependency resolution complete"
