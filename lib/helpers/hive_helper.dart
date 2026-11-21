import 'package:hive_flutter/hive_flutter.dart';
import '../models/pembacaan_sensor.dart';

class HiveHelper {
  HiveHelper._internal();
  static final HiveHelper instance = HiveHelper._internal();
  static const String namaBox = 'pembacaanSensorBox';

  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(17)) {
      Hive.registerAdapter(PembacaanSensorAdapter());
    }
    if (!Hive.isBoxOpen(namaBox)) {
      await Hive.openBox<PembacaanSensor>(namaBox);
    }
  }

  Box<PembacaanSensor> get box => Hive.box<PembacaanSensor>(namaBox);
  List<PembacaanSensor> semua() {
    final data = box.values.toList();
    data.sort((a, b) => b.waktu.compareTo(a.waktu));
    return data;
  }
  Future<void> tambah(PembacaanSensor item) => box.put(item.id, item);
  Future<void> koreksi(String id, double nilai) async {
    final lama = box.get(id);
    if (lama == null) throw StateError('Pembacaan tidak ditemukan');
    await box.put(id, lama.salinDenganNilai(nilai));
  }
  Future<void> hapus(String id) => box.delete(id);
}
