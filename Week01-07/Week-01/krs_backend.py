"""
===================================================================
FILE        : krs_backend.py
DESKRIPSI   : Contoh Sederhana Backend Python yang Terhubung ke Database MySQL
MATERI      : Logika Backend, Validasi Input, & Eksekusi Query SQL dari Python
===================================================================
"""

import sys

# Memastikan output Windows terminal mendukung UTF-8
if sys.platform == 'win32':
    try:
        sys.stdout.reconfigure(encoding='utf-8')
    except Exception:
        pass

# Mencoba mengimpor library penghubung MySQL di Python
try:
    import mysql.connector
    HAS_MYSQL_LIB = True
except ImportError:
    HAS_MYSQL_LIB = False


class KRSBackendService:
    """
    Kelas ini bertindak sebagai 'Otak Backend' yang menjembatani
    tampilan web/aplikasi dengan Database MySQL db_krs.
    """

    def __init__(self):
        # Konfigurasi Koneksi ke MySQL XAMPP
        self.host = "localhost"
        self.user = "root"
        self.password = ""
        self.database = "db_krs"

    def get_connection(self):
        """Membuat koneksi langsung ke MySQL XAMPP"""
        if not HAS_MYSQL_LIB:
            print("[WARNING] Library 'mysql-connector-python' belum diinstall.")
            print("[INFO] Jalankan di terminal: pip install mysql-connector-python")
            return None

        try:
            connection = mysql.connector.connect(
                host=self.host,
                user=self.user,
                password=self.password,
                database=self.database
            )
            return connection
        except Exception as err:
            print(f"[ERROR] Gagal terkoneksi ke Database MySQL: {err}")
            return None

    # ===============================================================
    # 1. LOGIKA BACKEND: Menambah Mahasiswa Baru (Validasi + SQL)
    # ===============================================================
    def tambah_mahasiswa_baru(self, nim: str, nama: str, prodi: str, semester: int):
        print(f"\n[BACKEND RECEIVED] Menerima data pendaftaran: {nama} ({nim})")

        # --- LOGIKA BISNIS & VALIDASI OLEH PYTHON ---
        # Validasi 1: Panjang NIM harus 6 karakter
        if len(nim) != 6:
            return {"success": False, "message": "[ERROR BACKEND] NIM harus persis 6 karakter!"}

        # Validasi 2: Semester harus antara 1 sampai 14
        if semester < 1 or semester > 14:
            return {"success": False, "message": "[ERROR BACKEND] Semester tidak valid! (Harus 1-14)"}

        # --- JIKA VALIDASI LOLOS, PYTHON MEMANGGIL SQL ---
        conn = self.get_connection()
        if not conn:
            return {"success": False, "message": "[ERROR] Tidak terhubung ke MySQL."}

        try:
            cursor = conn.cursor()
            
            # Query SQL buatan Python
            query_sql = """
                INSERT INTO mahasiswa (nim_mahasiswa, nama_mahasiswa, program_studi, semester_mahasiswa)
                VALUES (%s, %s, %s, %s)
            """
            val = (nim, nama, prodi, semester)
            
            # Meminta MySQL mengeksekusi Query
            cursor.execute(query_sql, val)
            conn.commit()  # Simpan perubahan
            
            cursor.close()
            conn.close()
            return {"success": True, "message": f"[SUCCESS] Data {nama} ({nim}) berhasil disimpan ke MySQL!"}

        except Exception as e:
            return {"success": False, "message": f"[ERROR MYSQL] {e}"}

    # ===============================================================
    # 2. LOGIKA BACKEND: Mengambil Daftar Mahasiswa (SELECT SQL -> JSON)
    # ===============================================================
    def ambil_daftar_mahasiswa(self):
        print("\n[BACKEND PROCESSING] Mengambil data mahasiswa dari MySQL...")
        
        conn = self.get_connection()
        if not conn:
            return []

        try:
            cursor = conn.cursor(dictionary=True) # Mengambil data dalam bentuk Dictionary/JSON
            
            # Query SQL dipanggil oleh Python
            query_sql = "SELECT * FROM mahasiswa"
            cursor.execute(query_sql)
            
            hasil_data = cursor.fetchall()
            
            cursor.close()
            conn.close()
            return hasil_data

        except Exception as e:
            print(f"[ERROR MYSQL] {e}")
            return []


# ===============================================================
# SIMULASI JALANNYA SISTEM BACKEND (DEMO RUNNER)
# ===============================================================
if __name__ == "__main__":
    print("=" * 60)
    print("DEMO SISTEM BACKEND KRS UNIVERSITAS (PYTHON + MYSQL)")
    print("=" * 60)

    # Inisialisasi Service Backend
    backend = KRSBackendService()

    # TEST CASE 1: Coba Tambah Mahasiswa yang NIM-nya Salah (Panjang != 6)
    respon1 = backend.tambah_mahasiswa_baru("123", "Budi KW", "Informatika", 3)
    print(f"Respon ke Web/User: {respon1['message']}")

    # TEST CASE 2: Coba Tambah Mahasiswa yang Valid
    respon2 = backend.tambah_mahasiswa_baru("163635", "Randi Pratama", "Informatika", 3)
    print(f"Respon ke Web/User: {respon2['message']}")

    # TEST CASE 3: Python Mengambil Data dari MySQL dan Menampilkannya
    data_mahasiswa = backend.ambil_daftar_mahasiswa()
    print("\nDAFTAR MAHASISWA TERSEDIA (DIPROSES PYTHON):")
    for mhs in data_mahasiswa:
        sem_val = mhs.get('semester_mahasiswa') or mhs.get('semester')
        print(f" - [{mhs['nim_mahasiswa']}] {mhs['nama_mahasiswa']} | Prodi: {mhs['program_studi']} | Semester: {sem_val}")
    
    print("\n" + "=" * 60)
    print("Penjelasan: Python bertindak sebagai pengolah logika & pembatas security,")
    print("lalu meneruskan query SQL ke MySQL XAMPP untuk disimpan.")
    print("=" * 60)
