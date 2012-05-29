#!/bin/bash


if [ ! -d bin ]; then
	mkdir bin
else
	rm bin/HectorRunner.class
fi 


while getopts s:c:o: option
do
        case "${option}"
        in
                s) SERVER=${OPTARG};;
                c) CLUSTER=${OPTARG};;
                o) COMMAND=${OPTARG};;
        esac
done

echo $SERVER is the server
echo $CLUSTER is the cluster
echo $COMMAND is the command

javac -cp .:./lib/*:../lib/classes/thrift -d ./bin/ src/HectorRunner.java
# java -cp ./lib/*:./bin/:./lib/classes/thrift HectorRunner $SERVER $CLUSTER

java -cp ./lib/*:./bin/:./lib/classes/thrift HectorRunner $SERVER $CLUSTER $COMMAND
