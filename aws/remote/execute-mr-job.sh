#!/bin/bash

# prerequisite: launch 'find /usr/lib/ -name *hadoop*streaming*.jar' and use it as first argument of this command

if [ $1 -z ]; then
	echo "Argument missing. You have to tell me the full path to hadoop-streaming library. Try to launch 'find /usr/lib/ -name *hadoop*streaming*.jar', and give me the path to that jar."
	exit
fi

if [ $2 -z ]; then
	echo "Input missing. I want a path to the input file you uploaded in hdfs."
	exit
fi

if [ $3 -z ]; then
	echo "Output folder missing. Tell me where you want to place output."
	exit
fi

hadoop jar $1 -files mapper.py,reducer.py -mapper mapper.py -reducer reducer.py -input $2 -output $3
