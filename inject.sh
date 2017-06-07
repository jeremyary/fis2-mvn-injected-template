#!/bin/sh

echo "STARTING SCRIPT"
echo "__" + $PROJECT_REPO
for d in (find . -name 'pom.xml')
do
    echo "$d"
done
echo "DONE W/SCRIPT"
