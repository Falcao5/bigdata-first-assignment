#!/bin/bash

sh clean_dfs.sh

sh execute-mr-job.sh /usr/lib/hadoop-mapreduce/hadoop-streaming.jar /input/input_8kk.txt /output_8kk/
