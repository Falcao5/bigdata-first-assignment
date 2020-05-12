#!/bin/bash

echo "********* Downloading dataset"
wget http://torlone.dia.uniroma3.it/bigdata/daily-historical-stock-prices-1970-2018.zip

echo "********* Unzipping dataset"
chmod 700 daily-historical-stock-prices-1970-2018.zip
unzip daily-historical-stock-prices-1970-2018.zip
rm daily-historical-stock-prices-1970-2018.zip

chmod 700 historical_stock_prices.csv

echo "********* Setupping hdfs directories"
hdfs dfs -mkdir /input/

head -4000000 historical_stock_prices.csv > input_4kk.txt
hdfs dfs -put input_4kk.txt /input/input_4kk.txt
rm input_4kk.txt

head -8000000 historical_stock_prices.csv > input_8kk.txt
hdfs dfs -put input_8kk.txt /input/input_8kk.txt
rm input_8kk.txt

head -12000000 historical_stock_prices.csv > input_12kk.txt
hdfs dfs -put input_12kk.txt /input/input_12kk.txt
rm input_12kk.txt

head -16000000 historical_stock_prices.csv > input_16kk.txt
hdfs dfs -put input_16kk.txt /input/input_16kk.txt
rm input_16kk.txt

hdfs dfs -put historical_stock_prices.csv /input/historical_stock_prices.csv
rm historical_stock_prices.csv

chmod +x mapper.py
chmod +x reducer.py

echo "\nYou should use one of these paths to launch the job:"
find /usr/lib/ -name *hadoop*streaming*.jar
