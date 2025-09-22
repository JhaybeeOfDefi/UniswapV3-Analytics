with count_tx as (
SELECT
    date_trunc ('day', block_time) as daily,
    count (tx_hash) as number_of_tansactions
    -- count(DISTINCT taker) as unique_traders,
    -- sum(amount_usd) as trading_volume
from dex.trades
    where block_date >= now() - INTERVAL '180' day
    and project = 'uniswap'
    and version = '3'
group by 1
order by 1 desc
),


vol as (
SELECT
    date_trunc ('day', block_time) as daily,
    -- count (tx_hash) as number_of_tansactions,
    -- count(DISTINCT taker) as unique_traders,
    sum(amount_usd) as trading_volume
from dex.trades
    where block_date >= now() - INTERVAL '180' day
    and project = 'uniswap'
    and version = '3'
group by 1
order by 1 desc
)

SELECT
    tx.daily,
    tx.number_of_tansactions,
    vl.trading_volume
from count_tx tx
join vol vl
    on tx.daily = vl.daily
order by 1 desc
