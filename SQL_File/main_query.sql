---- menampilkan revenue setiap bulannya dan bandingkan dengan bulan sebelumnya, tetapi hanya dengan yang status ordernya delivered ( uang sudah masuk ke perusahaan ) saja.
with final_query as ( select month , revenue , case when lag(revenue)over(order by month) = 0 then null
else ( revenue - lag(revenue)over(order by month) ) *1.0 / lag(revenue)over(order by month) end as mom_growth_revenue
from ( select date_trunc('month',o.order_purchase_timestamp) as month, sum(oi.price) as revenue
from orders as o
join order_item as oi
on o.order_id = oi.order_id
where o.order_status = 'delivered'
group by 1 )
order by month )
select*
from final_query
where month between date'2018-03-01' and date'2018-06-01'


---- menampilkan volume transaksi dan aov transaksi setiap bulannya dan bandingkan kedua metrik tersebut dengan bulan sebelumnya, untuk mengetahui metrik penyebab perubahan revenue.
with final_query as ( select month , volume , case when lag(volume)over(order by month) = 0 then null
else ( volume - lag(volume)over(order by month) ) *1.0 / lag(volume)over(order by month) end as mom_growth_volume ,
case when lag(aov)over(order by month) = 0 then null
else ( aov - lag(aov)over(order by month) ) *1.0 / lag(aov)over(order by month) end as mom_growth_aov
from (
select date_trunc('month',o.order_purchase_timestamp) as month , count(distinct o.order_id) as volume , sum(oi.price)*1.0/count(o.order_id) as aov
from orders as o
join order_item as oi
on o.order_id = oi.order_id
where o.order_status = 'delivered'
group by 1 ))
select *
from final_query
where month between date'2018-03-01' and date'2018-06-01'

---- tampilkan jumlah aktif customer yang ada setiap bulannya dan bandingkan dengan bulan sebelumnya
with final_query as ( select month , case when lag(active_customer)over(order by month) = 0 then null
else ( active_customer - lag(active_customer)over(order by month) ) *1.0 / lag(active_customer)over(order by month) end as mom_growth_customer
from ( select date_trunc('month', o.order_purchase_timestamp) as month , count(distinct c.customer_unique_id) as active_customer
from orders as o
join customer as c
on o.customer_id = c.customer_id
where o.order_status = 'delivered'
group by 1))
select *
from final_query
where month = date'2018-06-01'

---- tampilkan dari customer hilang itu yang hilang customer baru atau yang sudah ada.
with first_purchase_date as ( select c.customer_unique_id as customer , min(o.order_purchase_timestamp) as first_purchase
from customer as c
join orders as o
on c.customer_id = o.customer_id
where o.order_status = 'delivered'
group by 1 )
, monthly_customer as ( select distinct c.customer_unique_id as customer , date_trunc('month', o.order_purchase_timestamp) as month
from orders as o
join customer as c
on o.customer_id = c.customer_id
where o.order_status = 'delivered' )
, customer_type as ( select mc.month , mc.customer , 
case when date_trunc('month',f.first_purchase) = mc.month then 'New' else 'Returning' end as customer_type
from monthly_customer as mc
join first_purchase_date as f
on mc.customer = f.customer )
, monthly_customer_type as ( select month , customer_type , count(distinct customer) as active_customer_type
from customer_type
group by 1 , 2 )
, final_query as ( select*, 
case when lag(active_customer_type)over(partition by customer_type order by month) = 0 then null
else ( active_customer_type - lag(active_customer_type)over(partition by customer_type order by month) ) *1.0 / lag(active_customer_type)over(partition by customer_type order by month) end as mom_growth_customer_type
from monthly_customer_type )
select*
from final_query 
where month = date'2018-06-01'
order by customer_type

---- tampilkan category product yang dibeli new customer lalu bandingkan dengan bulan sebelumnya.
with first_purchase_date as ( select c.customer_unique_id as customer , min(o.order_purchase_timestamp) as first_purchase
from customer as c
join orders as o
on c.customer_id = o.customer_id
where o.order_status = 'delivered'
group by 1 )
, monthly_customer as ( select distinct c.customer_unique_id as customer , date_trunc('month', o.order_purchase_timestamp) as month
from orders as o
join customer as c
on o.customer_id = c.customer_id
where o.order_status = 'delivered' )
, customer_type as ( select mc.month , mc.customer , 
case when date_trunc('month',f.first_purchase) = mc.month then 'New' else 'Returning' end as customer_type
from monthly_customer as mc
join first_purchase_date as f
on mc.customer = f.customer )
, revenue_breakdown as ( select date_trunc('month', o.order_purchase_timestamp) as month , ct.customer_type , p.product_category_name as category , sum(oi.price) as revenue
from orders as o
join order_item as oi
on o.order_id = oi.order_id
join product as p
on oi.product_id = p.product_id
join customer as c
on o.customer_id = c.customer_id
join customer_type as ct
on c.customer_unique_id = ct.customer and date_trunc('month', o.order_purchase_timestamp) = ct.month
where o.order_status = 'delivered'
group by 1 , 2 , 3 )
, final_query as ( select * , 
case when lag(revenue)over(partition by customer_type , category order by month) = 0 then null
else ( revenue - lag(revenue)over(partition by customer_type , category order by month) ) *1.0 / lag(revenue)over(partition by customer_type , category order by month) end as mom_growth_revenue
from revenue_breakdown )
select *
from final_query
where month = date'2018-06-01' and customer_type = 'New'
order by customer_type  , mom_growth_revenue 