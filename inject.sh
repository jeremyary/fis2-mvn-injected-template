#!/bin/sh

echo "STARTING SCRIPT"
for d in $(find . -name 'pom.xml')
do
    echo "$d"
done
echo "DONE W/SCRIPT"
