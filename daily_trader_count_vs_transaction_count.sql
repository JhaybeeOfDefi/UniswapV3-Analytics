-- Uniswap V3 Dex Overview
-- Total unique users
-- Total Trading Volume
-- Monthly Users vs Transaction Count
-- Trading Volume (180 Days)
-- Number Of Traders (180 Days)
-- Top 20 tokens by usd vol (180 days)

SELECT
    date_trunc ('day', block_time) as daily,
    count (tx_hash) as number_of_tansactions,
    count(DISTINCT taker) as unique_traders,
    sum(amount_usd) as trading_volume
from dex.trades
where block_date >= now() - INTERVAL '180' day
    and project = 'uniswap'
    and version = '3'
group by 1
order by 1 desc
