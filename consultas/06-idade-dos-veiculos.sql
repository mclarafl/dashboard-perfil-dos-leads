-- (Query 6) Idade dos veículos visitados
-- Colunas: Idade do veículo, veículos visitados (%), ordem

with
	faixa_de_idade_veiculos as (
		select 
			fun.visit_page_date,
			pro.model_year,
			extract('year' from visit_page_date) - pro.model_year::int as idade_veiculo,
			case
				when (extract('year' from visit_page_date) - pro.model_year::int) <= 2 then 'até 2 anos'
				when (extract('year' from visit_page_date) - pro.model_year::int) <= 4 then 'de 2 à 4 anos'
				when (extract('year' from visit_page_date) - pro.model_year::int) <= 6 then 'de 4 à 6 anos'
				when (extract('year' from visit_page_date) - pro.model_year::int) <= 8 then 'de 6 à 8 anos'
				when (extract('year' from visit_page_date) - pro.model_year::int) <= 10 then 'de 8 à 10 anos'
				else 'acima de 10 anos'
				end as "idade do veículo",
			case
				when (extract('year' from visit_page_date) - pro.model_year::int) <= 2 then 1
				when (extract('year' from visit_page_date) - pro.model_year::int) <= 4 then 2
				when (extract('year' from visit_page_date) - pro.model_year::int) <= 6 then 3
				when (extract('year' from visit_page_date) - pro.model_year::int) <= 8 then 4
				when (extract('year' from visit_page_date) - pro.model_year::int) <= 10 then 5
				else 6
				end as "ordem"

		
		from sales.funnel as fun
		left join sales.products as pro
			on fun.product_id = pro.product_id
	)
select 
	"idade do veículo",
	count(*)::float/(select count(*) from sales.funnel) as "veículos visitados (%)",
	ordem
from faixa_de_idade_veiculos
group by "idade do veículo", ordem
order by ordem