use('163633_toko_buku');

db.createCollection("buku");



db.buku.insertMany([
    { judul: "Belajar MongoDB", penulis: "Andi", tahun: 2024, stok: 10 },
    { judul: "Pemrograman Java", penulis: "Budi", tahun: 2023, stok: 5 },
    { judul: "Data Science Dasar", penulis: "Citra", tahun: 2022, stok: 8 }
]);

db.buku.updateOne({ judul: "Pemrograman Java" }, { $set: { stok: 12 } });
db.buku.deleteOne({ tahun: 2022 });

db.buku.find();

db.buku.find().pretty();

db.buku.find({tahun:2023})

db.buku.find({}, {judul:1, penulis:1, _id:0})