#!/bin/bash

if [ $1 -z ]; then
	echo "Input missing. I want a path to the input file you uploaded in HDFS."
	exit
fi

if [ $2 -z ]; then
	echo "Output folder missing. Tell me where you want to place output in HDFS."
	exit
fi

if [ $3 -z ]; then
	echo "Thrid parameter: output file name"
	exit
fi

$HOME/hadoop-3.2.1/bin/mapred streaming -files ../mapper.py,../reducer.py -mapper ../mapper.py -reducer ../reducer.py -input $1 -output $2

$HOME/hadoop-3.2.1/bin/hdfs dfs -getmerge $2 $3
