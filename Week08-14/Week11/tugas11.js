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

/* ------TUGAS------ */

// 1. Penambahan Data
db.buku.insertMany([
    {
        judul: "Harry Potter and the Philosopher's Stone",
        penulis: "J.K. Rowling",
        tahun: 2022,
        stok: 8,
        kategori: "Fiksi",
        harga: 135000
    },
    {
        judul: "The Lord of the Rings",
        penulis: "J.R.R. Tolkien",
        tahun: 2021,
        stok: 2,
        kategori: "Fiksi",
        harga: 185000
    },
    {
        judul: "The Intelligent Investor",
        penulis: "Benjamin Graham",
        tahun: 2023,
        stok: 6,
        kategori: "Umum",
        harga: 160000
    },
    {
        judul: "Steve Jobs",
        penulis: "Walter Isaacson",
        tahun: 2024,
        stok: 5,
        kategori: "Umum",
        harga: 170000
    },
    {
        judul: "Poor Charlie's Almanack",
        penulis: "Peter D. Kaufman",
        tahun: 2023,
        stok: 1,
        kategori: "Bisnis",
        harga: 145000
    }
]);

// 2. Pembaruan Data
db.buku.updateOne({judul:"Harry Potter and the Philosopher's Stone"}, {$inc: {stok:5}})

db.buku.updateOne({ judul: "The Intelligent Investor" }, { $set: { kategori: "Bisnis" } })
db.buku.updateOne({ judul: "Steve Jobs" }, { $set: { kategori: "Teknologi" } })

// 3. Penghapusan Data
db.buku.deleteMany({ stok: { $lt: 3 } })

// 4.  Pencarian Data
db.buku.find({ kategori: "Teknologi" }).pretty() // Buku Teknologi
db.buku.find({ harga: { $gt: 100000 } }).pretty() // harga > 100k
db.buku.find({ tahun: { $gte: 2022 } }, { judul: 1, tahun: 1, stok: 1, _id: 0 }).pretty() // ttahun >= 2022

//5. Koleksi Baru
db.pelanggan.insertMany([
    { nama: "Harry Potter", email: "potter@email.com", buku_dibeli: ["Harry Potter and the Philosopher's Stone", "Steve Jobs"] },
    { nama: "Warren Buffet", email: "berkshire@email.com", buku_dibeli: ["The Intelligent Investor", "Belajar MongoDB"] },
    { nama: "Linus Torvalds", email: "linux@email.com", buku_dibeli: ["Steve Jobs", "Pemrograman Java"] }
])

db.pelanggan.find().pretty()
