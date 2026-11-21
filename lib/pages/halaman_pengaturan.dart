import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/ambang_cubit.dart';
import '../helpers/pengaturan_helper.dart';

class HalamanPengaturan extends StatelessWidget {
  const HalamanPengaturan({super.key});

  Future<void> _ubah(BuildContext context, String jenis, AmbangBatas batas) async {
    final waspada = TextEditingController(text: batas.waspada.toString());
    final siaga = TextEditingController(text: batas.siaga.toString());
    final hasil = await showDialog<AmbangBatas>(context: context,
      builder: (d) => AlertDialog(title: Text('Ambang $jenis'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: waspada, keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Batas Waspada')),
          const SizedBox(height: 12),
          TextField(controller: siaga, keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Batas Siaga')),
        ]),
        actions: [TextButton(onPressed: () => Navigator.pop(d), child: const Text('Batal')),
          FilledButton(onPressed: () {
            final w = double.tryParse(waspada.text.replaceAll(',', '.'));
            final s = double.tryParse(siaga.text.replaceAll(',', '.'));
            if (w == null || s == null || !w.isFinite || !s.isFinite || w < 0 || s <= w) return;
            Navigator.pop(d, AmbangBatas(w, s));
          }, child: const Text('Simpan'))]));
    waspada.dispose(); siaga.dispose();
    if (hasil == null || !context.mounted) return;
    await context.read<AmbangCubit>().simpan(jenis, hasil.waspada, hasil.siaga);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ambang batas tersimpan.')));
  }

  @override
  Widget build(BuildContext context) {
    final ambang = context.watch<AmbangCubit>().state;
    return ListView(padding: const EdgeInsets.all(16), children: [
      Text('Pengaturan Ambang Batas', style: Theme.of(context).textTheme.headlineSmall),
      const SizedBox(height: 8),
      const Text('Nilai tersimpan secara lokal dengan SharedPreferences. Siaga harus lebih besar dari Waspada.'),
      const SizedBox(height: 12),
      for (final jenis in PengaturanHelper.jenis)
        Card(child: ListTile(title: Text(jenis),
          subtitle: Text('Waspada ≥ ${ambang[jenis]!.waspada} ${PengaturanHelper.satuan[jenis]}  •  '
            'Siaga ≥ ${ambang[jenis]!.siaga} ${PengaturanHelper.satuan[jenis]}'),
          trailing: const Icon(Icons.edit), onTap: () => _ubah(context, jenis, ambang[jenis]!))),
    ]);
  }
}
