import 'package:flutter/material.dart';
import '../helpers/pengaturan_helper.dart';
import '../models/pembacaan_sensor.dart';
import 'status_sensor.dart';

String formatWaktu(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year} '
    '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}:${d.second.toString().padLeft(2, '0')}';

class KartuPembacaan extends StatelessWidget {
  final PembacaanSensor item;
  final AmbangBatas batas;
  final VoidCallback? onEdit;
  const KartuPembacaan({super.key, required this.item, required this.batas, this.onEdit});
  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.symmetric(vertical: 5),
    child: Padding(padding: const EdgeInsets.all(12), child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [Expanded(child: Text(item.jenisSensor,
          style: Theme.of(context).textTheme.titleMedium)),
          StatusChip(status: statusUntuk(item.nilai, batas)),
          if (onEdit != null) IconButton(tooltip: 'Koreksi nilai',
            onPressed: onEdit, icon: const Icon(Icons.edit_outlined))]),
        Text('${item.nilai.toStringAsFixed(1)} ${PengaturanHelper.satuan[item.jenisSensor]}',
          style: Theme.of(context).textTheme.headlineSmall),
        Text('Pos: ${item.lokasiPos}'),
        Text('Waktu: ${formatWaktu(item.waktu)}',
          style: Theme.of(context).textTheme.bodySmall),
      ],
    )),
  );
}
