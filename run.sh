#!/bin/bash

count=0

while read line; do
	echo $line
	SETTING[$count]=$line
	count=1
done < current.conf
	
echo Would you like to use ${SETTING[0]} again?
echo Please enter either Y or N - case sens.
read HECTOR_SAME
echo Would you like to use ${SETTING[1]} again?
echo Please enter either Y or N - case sens.
read CASSANDRA_SAME


if [ "${SETTING[0]}" == "hector-must-choose-new-ver" ]; then
	git submodule update --init --recursive
fi

if [ "$HECTOR_SAME" != "Y" ]; then
	cd hector
	if [ "${SETTING[0]}" != "hector-must-choose-new-ver" ]; then
		mvn clean
		git clean -d -x -f
	fi
	echo Please choose the Hector client you would like to launch:
	git tag
	read LINE;
	SETTING[0]=$LINE
	git checkout $LINE
	mvn package
	cd ..
fi

if [ "$CASSANDRA_SAME" != "Y" ]; then
	cd cassandra
	if [ "${SETTING[1]}" != "cassandra-must-choose-new-ver" ]; then
		ant clean	
		git clean -d -x -f	
	fi
	echo Please choose the Cassandra version you would like:
	git tag
	read LINE;
	git checkout $LINE
	SETTING[1]=$LINE
	ant
	cd ..
fi


echo ${SETTING[0]} > current.conf
echo ${SETTING[1]} >> current.conf

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

if [ "$SERVER" == "" ]; then 
 SERVER="localhost:9160"
fi
if [ "$CLUSTER" == "" ]; then 
 CLUSTER="Tutorial"
fi
if [ "$COMMAND" == "" ]; then 
 COMMAND="status"
fi
echo $SERVER is the server
echo $CLUSTER is the cluster
echo $COMMAND is the operation

javac -cp hector/core/target/*:hector/core/target/classes:cassandra/lib/*:cassandra/build/classes/thrift -d ./bin/ src/HectorRunner.java
# java -cp ./lib/*:./bin/:./lib/classes/thrift HectorRunner $SERVER $CLUSTER

java -cp hector/core/target/*:hector/core/target/classes:cassandra/lib/*:cassandra/build/classes/thrift:./bin/ HectorRunner $SERVER $CLUSTER $COMMAND
