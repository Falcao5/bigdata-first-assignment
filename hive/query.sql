-- Crea una tabella con il ticker, e la il prezzo di chiusura più recente
CREATE TEMPORARY TABLE newest_closures AS
SELECT
        ticker, close AS newest_closure_price
FROM
        historical_stock_prices AS hsp_a
WHERE
        dates = (SELECT MAX(dates) FROM historical_stock_prices AS hsp_b WHERE hsp_b.ticker = hsp_a.ticker);
--
-- Crea una tabella con il ticker, e la il prezzo di chiusura più vecchio
CREATE TEMPORARY TABLE oldest_closures AS
SELECT
        ticker, close AS oldest_closure_price
FROM
        historical_stock_prices AS hsp_a
WHERE
        dates = (SELECT MIN(dates) FROM historical_stock_prices AS hsp_b WHERE hsp_b.ticker = hsp_a.ticker);
--
-- Crea una tabella con ticker e le statistiche richieste
CREATE TEMPORARY TABLE stats AS
SELECT
        ticker,
        MIN(low) AS min_price,
        MAX(high) AS max_price,
        AVG(volume) AS avg_volume
FROM
        historical_stock_prices
WHERE
        YEAR(dates) > 2007 and
        YEAR(dates) < 2019
GROUP BY
        ticker
;
--
-- Query per ottenere il risultato voluto
SELECT
        s.ticker AS ticker,
        s.min_price AS minimum,
        s.max_price AS maximum,
        s.avg_volume AS average_volume,
        (nc.newest_closure_price - oc.oldest_closure_price)/oc.oldest_closure_price AS variation
FROM
        stats s
        JOIN newest_closures nc ON (nc.ticker = s.ticker)
        JOIN oldest_closures oc ON (oc.ticker = s.ticker)
ORDER BY
        variation
LIMIT 10
;
