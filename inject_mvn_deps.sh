#!/bin/sh

echo "Git project fetched. Starting maven dependency resolution..."
if [ -d "Model" ]; then
  echo "Model module detected, injecting..."
  cd Model
  mvn -s /tmp/settings.xml -Dmaven.repo.local=/tmp/artifacts/m2 install -B
  cd ../
fi
for d in $(find ./*/ -name 'pom.xml')
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
