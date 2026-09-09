-- (Query 7) Veículos mais visitados por marca
-- Colunas: brand, model, visitas (#)
select 
	pro.brand,
	pro.model, 
	count(*) as "visitas(#)"
from sales.funnel as fun
left join sales.products as pro
	on fun.product_id = pro.product_id
group by pro.brand, pro.model
order by pro.brand, pro.model,"visitas(#)"