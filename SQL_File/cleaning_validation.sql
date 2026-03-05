select min(price) as min_price , max(price) as max_price --- memastikan tidak ada nilai absurd sebelum menghitung revenue
from order_item

select count(*) total_rows -- cek cepat apa ada order yang delivered tapi tidak punya item
from orders as o
left join order_item as oi
on o.order_id = oi.order_id
where o.order_status = 'delivered' and oi.order_id is null

select c.customer_unique_id as customer , count(o.customer_id) as jumlah_beli --- validasi customer_id di tabel orders itu bisa muncul 2x jadi lebih aman untuk menghitung growth customer pakai customer unique id dari taable customer
from customer as c
join orders as o
on c.customer_id = o.customer_id
group by 1
having count(o.customer_id) > 1

select count(*) --- cek cepat apa ada transaksi customer yang tidak ada customernya
from customer
where customer_unique_id is null

---------- bandingkan revenue hasil dari tabel mentah dengan hasil join saya, untuk cek apa terjadi duplikasi atau tidak.
---------- hasil revenue sama, query saya dapat dipertanggungjawabkan.
select sum(oi.price)
from order_item as oi
join orders as o
on oi.order_id = o.order_id
where o.order_status = 'delivered'
--- revenue = 13221498.11

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
select sum(revenue)
from final_query
--- revenue = 13221498.11