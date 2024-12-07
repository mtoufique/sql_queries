
WITH all_data AS(
SELECT a.*,b.[TRADE_ID]AS TRADE_ID_2,b.TRADE_Timestamp AS TRADE_Timestamp_2,
b.Price AS Price_2,DATEDIFF(SECOND,a.[Trade_Timestamp],b.[Trade_Timestamp]) AS Time_delta,
abs(a.[Price]-b.[Price])*100/a.[Price] AS Change
FROM Trade_tbl a
INNER JOIN Trade_tbl b
ON a.TRADE_Timestamp<b.TRADE_Timestamp
)
SELECT * FROM all_data
WHERE Time_delta<=10 AND Change>10