import 'package:flutter_bloc/flutter_bloc.dart';
import '../helpers/hive_helper.dart';
import '../models/pembacaan_sensor.dart';

class SensorCubit extends Cubit<List<PembacaanSensor>> {
  SensorCubit() : super(HiveHelper.instance.semua());
  void segarkan() => emit(HiveHelper.instance.semua());

  Future<void> tambah(String jenis, double nilai, String lokasi) async {
    final waktu = DateTime.now();
    final id = '${waktu.microsecondsSinceEpoch}_${jenis.hashCode}';
    await HiveHelper.instance.tambah(PembacaanSensor(
      id: id, jenisSensor: jenis, nilai: nilai,
      lokasiPos: lokasi, waktu: waktu));
    segarkan();
  }

  Future<void> koreksi(String id, double nilai) async {
    await HiveHelper.instance.koreksi(id, nilai);
    segarkan();
  }

  Future<void> hapus(String id) async {
    await HiveHelper.instance.hapus(id);
    segarkan();
  }
}
