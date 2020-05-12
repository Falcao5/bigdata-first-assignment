#!/usr/bin/python3

import sys

PRECISION = 8
TIME_WINDOW_START=2008
TIME_WINDOW_END=2018

for line in sys.stdin:
    line = line.strip()
    values = line.split(',')    # input is in csv format

    if values[1].isalpha():     # skip first line
        continue

##### filtering condition
# don't move this snippet from here, if you don't want to loose performance
# skip this iteration if this record isn't in the time window selected
    date = values[7]                # string AAAA-MM-GG
    year = int(date.split('-')[0])  # integer
    if year < TIME_WINDOW_START or year > TIME_WINDOW_END:
        continue

##### data acquisition (only relevant data)
    # ticker, open, close, adj_close, low, high, volume, date

    ticker = values[0]      # string
    # open = values[1]        # float
    close = values[2]       # float
    # adj_close = values[3]   # float
    low = values[4]         # float
    high = values[5]        # float
    volume = values[6]      # number

##### data manipulation

    try:
        close_price = round(float(close), PRECISION)    # float with fixed precision
        local_min = round(float(low), PRECISION)        # float with fixed precision
        local_max = round(float(high), PRECISION)       # float with fixed precision
        volume = int(volume)                            # integer
    except ValueError:
        continue

##### producing output
# ticker    close_price local_min   local_max   volume  date
    print ('%s\t%s' % (ticker, (close_price, local_min, local_max, volume, date)))