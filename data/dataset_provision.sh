#!/bin/bash

if [ ! -f "daily-historical-stock-prices-1970-2018.zip" ]; then
	echo "********* Downloading dataset"
	wget http://torlone.dia.uniroma3.it/bigdata/daily-historical-stock-prices-1970-2018.zip
fi

chmod 700 daily-historical-stock-prices-1970-2018.zip
echo "********* Unzipping dataset"
unzip daily-historical-stock-prices-1970-2018.zip

chmod 700 historical_stock_prices.csv
chmod 700 historical_stocks.csv

echo "********* Splitting dataset"

head -4000000 historical_stock_prices.csv > input_4kk.txt
head -8000000 historical_stock_prices.csv > input_8kk.txt
head -12000000 historical_stock_prices.csv > input_12kk.txt
head -16000000 historical_stock_prices.csv > input_16kk.txt
