SELECT * FROM TOP_ATHLETES WHERE NAME LIKE '%Mayweather%';

WITH temp as (
SELECT
    NAME,
    SPORT,
    SUM(EARNINGS) AS TOTAL_EARNINGS,
    RANK() OVER (PARTITION BY SPORT ORDER BY TOTAL_EARNINGS DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS SPORT_RANK
FROM
    TOP_ATHLETES
GROUP BY
    NAME, SPORT)

SELECT
    NAME,
    SPORT,
    TOTAL_EARNINGS,
    COUNT(SPORT_RANK) OVER (PARTITION BY SPORT ORDER BY SPORT_RANK ASC ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS NUMBER_EARNING_MORE_IN_SPORT,
    RANK() over (PARTITION BY SPORT ORDER BY TOTAL_EARNINGS DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) - 1 AS RANK_MINUS
FROM
    temp
ORDER BY
    3 DESC;


SELECT
    NAME,
    SPORT,
    EARNINGS,
    ROUND(CUME_DIST() over (PARTITION BY SPORT ORDER BY EARNINGS ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),2)
FROM
    TOP_ATHLETES
ORDER BY
    EARNINGS DESC;