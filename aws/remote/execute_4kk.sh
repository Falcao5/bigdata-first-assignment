#!/bin/bash

sh clean_dfs.sh

sh execute-mr-job.sh /usr/lib/hadoop-mapreduce/hadoop-streaming.jar /input/input_4kk.txt /output_4kk/
