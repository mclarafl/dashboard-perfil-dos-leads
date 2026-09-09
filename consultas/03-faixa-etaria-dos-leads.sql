-- (Query 3) Faixa etária dos leads
-- Colunas: faixa etária, leads (%)
select
	case
		when datediff('years', birth_date, current_date) < 20 then '0-20'
		when datediff('years', birth_date, current_date) < 40 then '20-40'
		when datediff('years', birth_date, current_date) < 60 then '40-60'
		when datediff('years', birth_date, current_date) < 80 then '60-80'
		else '80+' end as "faixa etária",
		count(*)::float/(select count(*) from sales.customers) as "leads (%)"
from sales.customers
group by "faixa etária"
order by "faixa etária" desc
-- Função personalizada `datediff`
-- A consulta de faixa etária utiliza a função `datediff`, criada durante as aulas do curso.
-- Antes de executar `03-faixa-etaria-dos-leads.sql`, é necessário criar essa função no banco utilizado pelo projeto. Sua definição está nas anotações do repositório [SQL para Análise de Dados](https://github.com/mclarafl/sql-para-analise-de-dados).
-- A consulta utiliza `current_date` como referência, portanto a distribuição das faixas etárias pode mudar conforme a data de execução.