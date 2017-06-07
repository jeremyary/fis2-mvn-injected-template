#!/bin/sh

echo $PROJECT_REPO
pom_dirs=(find . -name 'pom.xml' -printf '%h\n' | sort -u)
for i in "${pom_dirs[@]}"
do
   echo "$i"
done
echo "DONE W/SCRIPT"
