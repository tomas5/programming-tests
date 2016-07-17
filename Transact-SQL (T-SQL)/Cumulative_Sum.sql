/*
Cumulative SUM

How to get sumTotal as shown below:
+----+--------+------------+
| id | number | sumTotal |
+----+--------+------------+
| 1  | 10       | 		10   |
+----+--------+------------+
| 2  | 20       | 		30   |
+----+--------+------------+
| 3  | 30       | 		60   |
+----+--------+------------+
| 4  | 40       | 		100  |
+----+--------+------------+
*/

declare  @t table ( id int, number int)
insert into @t values (1,10), (2,20), (3,30), (4,40)

select * from @t

select t1.id, t1.number, SUM(t2.number) as 'sumTotal'
from @t t1
inner join @t t2 on t1.id >= t2.id
group by t1.id, t1.number
order by t1.id

SELECT t1.id, t1.number, SUM(t1.number) OVER(ORDER BY t1.id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'sumTotal'
FROM @t t1
ORDER BY t1.id

-- use ROWS UNBOUNDED PRECEDING instead of ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW. 
SELECT t1.id, t1.number, SUM(t1.number) OVER(ORDER BY t1.id ROWS UNBOUNDED PRECEDING) AS 'sumTotal'
FROM @t t1
ORDER BY t1.id