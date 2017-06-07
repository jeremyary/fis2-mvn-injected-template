#!/bin/sh

echo "STARTING SCRIPT"
echo $PWD
echo $(ls -la)
for d in $(find . -name 'pom.xml')
do
    echo "$d"
done
echo "DONE W/SCRIPT"
