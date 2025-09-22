SELECT
  count(DISTINCT taker) as total_unique_traders,
  sum(amount_usd) as total_trading_volume
from dex.trades
where block_date >= CURRENT_DATE - interval '180' DAY
and project = 'uniswap'
and version = '3'
