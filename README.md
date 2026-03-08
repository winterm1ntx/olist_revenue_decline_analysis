Dataset: Brazilian E-Commerce Public Dataset by Olist
Dataset telah divalidasi dengan memeriksa anomali harga, transaksi tanpa item, serta konsistensi revenue setelah proses join.

🔎 Investigation Process

1️⃣ Revenue Trend Analysis

Revenue Olist mengalami penurunan pada Februari 2018, namun kembali pulih secara signifikan pada Maret. Pada dua bulan berikutnya, performa revenue cenderung
stabil sebelum akhirnya mengalami penurunan tajam pada Juni 2018.
Oleh karena itu, fokus analisis dilakukan pada periode Juni 2018 ketika revenue mengalami sudden drop.

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

5️⃣ Hypothesis Testing
    
1. Product Category Investigation
        Apakah penurunan jumlah new customer disebabkan oleh masalah pada produk tertentu?
        Analisis lebih lanjut dilakukan terhadap kategori produk yang dibeli oleh new customer.
        Hasilnya menunjukkan bahwa penurunan revenue terjadi secara merata di hampir semua kategori, tanpa adanya satu kategori yang mengalami penurunan secara           dominan.
        Hal ini menunjukkan bahwa penurunan revenue tidak disebabkan oleh performa produk tertentu.
    
2. Delivery Time Investigation
        Apakah penurunan jumlah new customer disebabkan oleh masalah pada delivery time?
        Hasil analisis menunjukkan bahwa delivery time bahkan secara performa malah membaik.
        Dengan demikian, penurunan revenue kemungkinan tidak disebabkan oleh masalah pengiriman.

⸻

💡 Key Insight

Penurunan revenue pada Juni 2018 kemungkinan besar disebabkan oleh penurunan jumlah new customers.
Hasil investigasi menunjukkan bahwa penurunan tidak disebabkan oleh performa kategori produk maupun kualitas pengiriman, sehingga mengindikasikan adanya 
potensi masalah pada customer acquisition.

⸻

📌 Recommendation

Tim marketing olist disarankan untuk mengevaluasi strategi akuisisi customer guna mengidentifikasi faktor yang menyebabkan penurunan jumlah customer baru.

⸻

🛠 Tools Used
•    SQL
•    PostgreSQL
