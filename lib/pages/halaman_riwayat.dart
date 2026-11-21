import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/sensor_cubit.dart';
import '../cubit/ambang_cubit.dart';
import '../widgets/kartu_pembacaan.dart';
import '../models/pembacaan_sensor.dart';

class HalamanRiwayat extends StatelessWidget {
  const HalamanRiwayat({super.key});

  Future<void> _edit(BuildContext context, PembacaanSensor item) async {
    final controller = TextEditingController(text: item.nilai.toString());
    final baru = await showDialog<double>(context: context, builder: (dialogContext) => AlertDialog(
      title: const Text('Koreksi Nilai Pembacaan'),
      content: TextField(controller: controller, autofocus: true,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(labelText: 'Nilai baru')),
      actions: [TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Batal')),
        FilledButton(onPressed: () {
          final n = double.tryParse(controller.text.trim().replaceAll(',', '.'));
          if (n == null || !n.isFinite || n < 0) return;
          Navigator.pop(dialogContext, n);
        }, child: const Text('Simpan'))],
    ));
    controller.dispose();
    if (baru == null || !context.mounted) return;
    await context.read<SensorCubit>().koreksi(item.id, baru);
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<SensorCubit>().state;
    final ambang = context.watch<AmbangCubit>().state;
    if (data.isEmpty) return const Center(child: Text('Riwayat sensor masih kosong.'));
    return ListView.builder(padding: const EdgeInsets.all(12), itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return Dismissible(key: ValueKey(item.id), direction: DismissDirection.endToStart,
          background: Container(alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 24), color: Colors.red,
            child: const Icon(Icons.delete, color: Colors.white)),
          confirmDismiss: (_) async => await showDialog<bool>(context: context,
            builder: (d) => AlertDialog(title: const Text('Hapus pembacaan?'),
              content: const Text('Data yang dihapus tidak dapat dikembalikan.'),
              actions: [TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Batal')),
                TextButton(onPressed: () => Navigator.pop(d, true), child: const Text('Hapus'))])) ?? false,
          onDismissed: (_) => context.read<SensorCubit>().hapus(item.id),
          child: KartuPembacaan(item: item, batas: ambang[item.jenisSensor]!,
            onEdit: () => _edit(context, item)));
      });
  }
}
