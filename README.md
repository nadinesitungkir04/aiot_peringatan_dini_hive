# AIoT Peringatan Dini — Modul IX

Aplikasi Flutter offline untuk simulasi pembacaan sensor, penyimpanan riwayat Hive dan ambang batas SharedPreferences.

## Memulai (Windows / VS Code)

1. Buat proyek asli Flutter dengan `flutter create aiot_peringatan_dini_hive` di direktori kerja Anda.
2. Salin `pubspec.yaml`, `analysis_options.yaml`, folder `lib/`, dan `test/` dari paket ini ke proyek yang baru dibuat (timpa jika diminta).
3. Dari direktori proyek yang memuat `pubspec.yaml`, jalankan `flutter pub get`, `flutter analyze`, lalu `flutter run`.
4. Sambungkan HP Android melalui USB debugging atau gunakan emulator.

**Penting:** Paket ini adalah source overlay, bukan proyek Flutter lengkap dengan folder platform (`android/`, `ios/`, dan sebagainya). `flutter create` harus dijalankan agar folder platform dibuat dengan versi Flutter lokal Anda.

## Fitur
- Dashboard input sensor manual; jenis: Ketinggian Air (cm), Pergeseran Tanah (mm), Curah Hujan (mm).
- Riwayat terbaru dahulu; koreksi nilai lewat ikon pensil; geser ke kiri untuk hapus dengan konfirmasi.
- Ambang Waspada/Siaga per sensor; indikator AppBar dari **satu pembacaan terbaru secara global**, bukan nilai maksimum semua sensor.
- Hive menyimpan pembacaan dengan key `id` unik; SharedPreferences menyimpan ambang batas.

## Catatan
- Ambang awal adalah **contoh simulasi praktikum**, bukan ambang resmi BPBD. Jangan gunakan untuk keputusan evakuasi nyata.
- `flutter analyze` dan pengujian perangkat belum dijalankan dalam lingkungan penyusunan paket ini. Pengujian aktual, bukti screenshot, serta push Git perlu dilakukan di perangkat pengguna.
- Data tidak dikirim melalui jaringan. Jangan uninstall/clear data aplikasi saat menguji persistensi.
