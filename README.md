Dataset: Brazilian E-Commerce Public Dataset by Olist
Dataset telah divalidasi dengan memeriksa anomali harga, transaksi tanpa item, serta konsistensi revenue setelah proses join.

🔎 Investigation Process

1️⃣ Revenue Trend Analysis

Analisis awal menunjukkan bahwa revenue relatif stabil selama tiga bulan sebelumnya (Maret–Mei 2018), namun mengalami penurunan tajam pada Juni 2018 sebesar 12.4%.
Hal ini mengindikasikan bahwa penurunan tersebut kemungkinan merupakan kejadian yang terjadi secara tiba-tiba, bukan tren penurunan jangka panjang.

⸻

2️⃣ Revenue Decomposition

Revenue kemudian diuraikan menjadi dua komponen utama:
Revenue = Volume × Average Order Value (AOV)
Hasil analisis menunjukkan:
Volume Order -9.6%
AOV -2.4%

Penurunan revenue terutama disebabkan oleh turunnya volume transaksi, sementara AOV relatif stabil.

⸻

3️⃣ Customer Analysis

Investigasi lebih lanjut menunjukkan bahwa active customer juga mengalami penurunan sebesar 9.4%, sejalan dengan turunnya volume order.

Hal ini menunjukkan bahwa penurunan transaksi terutama disebabkan oleh berkurangnya jumlah customer yang melakukan pembelian.

⸻

4️⃣ Customer Segmentation

Customer kemudian dianalisis berdasarkan tipe:
New Customer -9.6%
Returning Customer -2.1%

Penurunan terutama berasal dari new customer, sementara returning customer tidak mengalami perubahan signifikan.

⸻

5️⃣ Product Category Investigation

Analisis lebih lanjut dilakukan terhadap kategori produk yang dibeli oleh new customer.

Hasilnya menunjukkan bahwa penurunan revenue terjadi secara merata di hampir semua kategori, tanpa adanya satu kategori yang mengalami penurunan secara dominan.

Hal ini menunjukkan bahwa penurunan revenue tidak disebabkan oleh performa produk tertentu.

⸻

💡 Key Insight

Penurunan revenue pada Juni 2018 kemungkinan besar disebabkan oleh penurunan jumlah new customer, yang mengindikasikan adanya masalah pada customer acquisition, bukan pada performa produk atau kategori tertentu.

⸻

📌 Recommendation

Tim marketing olist disarankan untuk mengevaluasi strategi akuisisi customer guna mengidentifikasi faktor yang menyebabkan penurunan jumlah customer baru.

⸻

🛠 Tools Used
    •    SQL
    •    PostgreSQL
