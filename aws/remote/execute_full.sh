#!/bin/bash

sh clean_dfs.sh

sh execute-mr-job.sh /usr/lib/hadoop-mapreduce/hadoop-streaming.jar /input/historical_stock_prices.csv /output_full/
