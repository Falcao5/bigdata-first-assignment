#!/usr/bin/python3

import sys
from datetime import date, datetime
from collections import OrderedDict

OUTPUT_PRECISION = 4

# datastruct declaration

tickers = set()

newest_closure = {}     # ticker: (date, price)
oldest_closure = {}     # ticker: (date, price)

global_min_price = {}   # ticker: price
global_max_price = {}   # ticker: price

avg_volume = {}         # ticker: (amount, elements_counted)

result = {}

##### input format
# ticker    [(close_price local_min   local_max   volume  date),...]

for line in sys.stdin:

    ticker, values = line.split('\t')
    close_price, local_min, local_max, volume, date = values[1:len(values)-2].split(', ')
    
######## data parsing

    try:
        close_price = float(close_price)
        local_min = float(local_min)
        local_max = float(local_max)
        volume = int(volume)
        date = datetime.strptime(date, "'%Y-%m-%d'").date()
    except ValueError:
        continue

    if not ticker in newest_closure:                        # if ticker key doesn't exist
        newest_closure[ticker] = list([date, close_price])  # init with the first value you read
    
    if not ticker in oldest_closure:                        # if ticker key doesn't exist
        oldest_closure[ticker] = list([date, close_price])  # init with the first value you read

    if not ticker in avg_volume:                            # if ticker key doesn't exist
        avg_volume[ticker] = list([0, 0])                   # zero initialization

    if not ticker in global_min_price:                      # if ticker key doesn't exist
        global_min_price[ticker] = local_min                # init with the first value you read

    if not ticker in global_max_price:                      # if ticker key doesn't exist
        global_max_price[ticker] = local_max                # init with the first value you read

####### human readable variables assignment
    
    newest_closure_for_this_ticker = newest_closure[ticker]
    newest_closure_date_for_this_ticker = newest_closure_for_this_ticker[0]
    newest_closure_price_for_this_ticker = newest_closure_for_this_ticker[1]
    
    oldest_closure_for_this_ticker = oldest_closure[ticker]
    oldest_closure_date_for_this_ticker = oldest_closure_for_this_ticker[0]
    oldest_closure_price_for_this_ticker = oldest_closure_for_this_ticker[1]
    
    global_min_for_this_ticker = global_min_price[ticker]
    global_max_for_this_ticker = global_max_price[ticker]
        
    avg_volume_for_this_ticker = avg_volume[ticker]
    
####### computation

    tickers.add(ticker)

    if date > newest_closure_date_for_this_ticker:
        newest_closure_for_this_ticker[0] = date
        newest_closure_for_this_ticker[1] = close_price

    if date < oldest_closure_date_for_this_ticker:
        oldest_closure_for_this_ticker[0] = date
        oldest_closure_for_this_ticker[1] = close_price

    # min price
    if local_min < global_min_for_this_ticker:
        global_min_price[ticker] = local_min
    
    # max price
    if local_max > global_max_for_this_ticker:
        global_max_price[ticker] = local_max

    avg_volume_for_this_ticker[0] = avg_volume_for_this_ticker[0] + volume
    avg_volume_for_this_ticker[1] = avg_volume_for_this_ticker[1] + 1

##### output organization

for ticker in tickers:
   
    newest_closure_for_this_ticker = newest_closure[ticker]
    newest_closure_price_for_this_ticker = newest_closure_for_this_ticker[1]
    
    oldest_closure_for_this_ticker = oldest_closure[ticker]
    oldest_closure_price_for_this_ticker = oldest_closure_for_this_ticker[1]
    
    global_min_for_this_ticker = global_min_price[ticker]
    
    global_max_for_this_ticker = global_max_price[ticker]
        
    avg_volume_for_this_ticker = avg_volume[ticker]
    avg_volume_amount_for_this_ticker = avg_volume_for_this_ticker[0]
    avg_volume_elements_counted_for_this_ticker = avg_volume_for_this_ticker[1]
    
    # (A - B)/B
    try:
        diff = newest_closure_price_for_this_ticker - oldest_closure_price_for_this_ticker
        percentile = diff/oldest_closure_price_for_this_ticker
    except ZeroDivisionError:
        continue
    
    # average
    avg_volume_value = avg_volume_amount_for_this_ticker/avg_volume_elements_counted_for_this_ticker
    avg_volume_value = int(avg_volume_value)
    
    result[ticker] = (global_min_for_this_ticker, global_max_for_this_ticker, percentile, avg_volume_value)
    
##### output sorting by percentile
result = sorted(result.items(), key = lambda kv:(kv[1][2], kv[0]))

##### output printing
# format: ticker,min_price,max_price,percentile,average_volume"

for r in result:
    ticker = r[0]
    min = r[1][0]
    max = r[1][1]
    percentile = r[1][2]
    average_volume = r[1][3]

##### output data parsing

    min = float(min)
    max = float(max)
    percentile = float(percentile)
    
##### output data formatting
    
    min = round(min, OUTPUT_PRECISION)
    max = round(max, OUTPUT_PRECISION)
    percentile = round(percentile, OUTPUT_PRECISION)
    
    print(ticker, min, max, percentile, average_volume, sep=',')