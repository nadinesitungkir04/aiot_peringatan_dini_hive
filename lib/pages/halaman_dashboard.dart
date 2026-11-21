
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/sensor_cubit.dart';
import '../cubit/ambang_cubit.dart';
import '../helpers/pengaturan_helper.dart';
import '../widgets/kartu_pembacaan.dart';

class HalamanDashboard extends StatefulWidget {
  const HalamanDashboard({super.key});

  @override
  State<HalamanDashboard> createState() =>
      _HalamanDashboardState();
}

class _HalamanDashboardState extends State<HalamanDashboard> {
  String jenis = PengaturanHelper.jenis.first;

  final nilai = TextEditingController();
  final lokasi = TextEditingController(
    text: 'Pos Pemantauan A',
  );

  @override
  void dispose() {
    nilai.dispose();
    lokasi.dispose();
    super.dispose();
  }

  Future<void> _simpan() async {
    final angka = double.tryParse(
      nilai.text.trim().replaceAll(',', '.'),
    );

    if (angka == null ||
        !angka.isFinite ||
        angka < 0 ||
        lokasi.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Isi nilai nonnegatif dan lokasi pos yang valid.',
          ),
        ),
      );
      return;
    }

    await context.read<SensorCubit>().tambah(
      jenis,
      angka,
      lokasi.text.trim(),
    );

    if (!mounted) return;

    nilai.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pembacaan tersimpan di Hive.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<SensorCubit>().state;
    final ambang = context.watch<AmbangCubit>().state;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Pemantauan Sensor',
          style: Theme.of(context).textTheme.headlineSmall,
        ),

        const SizedBox(height: 8),

        const Text(
          'Simulasi input pembacaan sensor secara manual (offline).',
        ),

        const SizedBox(height: 18),

        DropdownButtonFormField<String>(
          initialValue: jenis,
          decoration: const InputDecoration(
            labelText: 'Jenis Sensor',
            border: OutlineInputBorder(),
          ),
          items: PengaturanHelper.jenis.map((e) {
            return DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            );
          }).toList(),
          onChanged: (v) {
            if (v != null) {
              setState(() {
                jenis = v;
              });
            }
          },
        ),

        const SizedBox(height: 12),

        TextField(
          controller: nilai,
          keyboardType:
              const TextInputType.numberWithOptions(
            decimal: true,
          ),
          decoration: InputDecoration(
            labelText:
                'Nilai sensor (${PengaturanHelper.satuan[jenis]})',
            border: const OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 12),

        TextField(
          controller: lokasi,
          decoration: const InputDecoration(
            labelText: 'Lokasi pos pemantauan',
            border: OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 12),

        FilledButton.icon(
          onPressed: _simpan,
          icon: const Icon(Icons.save_outlined),
          label: const Text('Simpan Pembacaan'),
        ),

        const SizedBox(height: 20),

        Text(
          'Pembacaan Terbaru',
          style: Theme.of(context).textTheme.titleLarge,
        ),

        const SizedBox(height: 12),

        if (data.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Belum ada pembacaan. Tambahkan data pertama.',
            ),
          ),

        if (data.isNotEmpty)
          KartuPembacaan(
            item: data.first,
            batas: ambang[data.first.jenisSensor]!,
          ),

        const SizedBox(height: 12),

        Text(
          'Total pembacaan tersimpan: ${data.length}',
        ),
      ],
    );
  }
}
