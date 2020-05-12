#!/bin/bash

sh clean_dfs.sh
sh execute-locally-mr-job.sh /input/historical_stock_prices.csv /output_full/
