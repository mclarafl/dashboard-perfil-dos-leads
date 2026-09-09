-- (Query 4) Faixa salarial dos leads
-- Colunas: faixa salarial, leads (%), ordem
select
	case
		when income < 5000 then '0-5000'
		when income < 10000 then '5000-10000'
		when income < 15000 then '10000-15000'
		when income < 20000 then '15000-20000'
		else '20000+' end as "faixa salarial",
		count(*)::float/(select count(*) from sales.customers) as "leads (%)",
	case
		when income < 5000 then 1
		when income < 10000 then 2
		when income < 15000 then 3
		when income < 20000 then 4
		else 5 end as "ordem"
from sales.customers
group by "faixa salarial", "ordem"
order by "ordem" desc