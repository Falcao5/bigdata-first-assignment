CREATE TABLE historical_stock_prices
(ticker STRING,open DOUBLE,close DOUBLE,adj_close DOUBLE,low DOUBLE,high DOUBLE,volume INT,dates DATE)
row format delimited fields terminated by ',';
