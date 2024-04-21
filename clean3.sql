
INSERT INTO WALMART_STOCK(Timestamp, Open, High, Low, Close, Volume)
SELECT
    key::TIMESTAMP AS Timestamp,
    (value->>'1. open')::NUMERIC(10, 4) AS Open,
    (value->>'2. high')::NUMERIC(10, 4) AS High,
    (value->>'3. low')::NUMERIC(10, 4) AS Low,
    (value->>'4. close')::NUMERIC(10, 4) AS Close,
    (value->>'5. volume')::BIGINT AS Volume
FROM
    RawData3,
    jsonb_each(raw_json->'Time Series (60min)') AS timeseries(key, value)
ON CONFLICT (Timestamp)
DO NOTHING;
DELETE FROM RawData3
