import 'package:flutter/material.dart';
import '../helpers/pengaturan_helper.dart';
import '../models/pembacaan_sensor.dart';

String statusUntuk(double nilai, AmbangBatas batas) {
  if (nilai >= batas.siaga) return 'Siaga';
  if (nilai >= batas.waspada) return 'Waspada';
  return 'Aman';
}

String statusTerbaru(List<PembacaanSensor> data, Map<String, AmbangBatas> ambang) {
  if (data.isEmpty) return 'Belum Ada Data';
  final terakhir = data.first;
  return statusUntuk(terakhir.nilai, ambang[terakhir.jenisSensor]!);
}

Color warnaStatus(String status) {
  switch (status) {
    case 'Siaga': return Colors.red.shade700;
    case 'Waspada': return Colors.orange.shade800;
    case 'Aman': return Colors.green.shade700;
    default: return Colors.blueGrey;
  }
}

class StatusChip extends StatelessWidget {
  final String status;
  const StatusChip({super.key, required this.status});
  @override
  Widget build(BuildContext context) => Chip(
    label: Text(status, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    backgroundColor: warnaStatus(status), side: BorderSide.none,
    visualDensity: VisualDensity.compact,
  );
}
