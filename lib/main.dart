import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'helpers/hive_helper.dart';
import 'cubit/sensor_cubit.dart';
import 'cubit/ambang_cubit.dart';
import 'pages/halaman_dashboard.dart';
import 'pages/halaman_riwayat.dart';
import 'pages/halaman_pengaturan.dart';
import 'theme/app_theme.dart';
import 'widgets/status_sensor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.instance.init();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => SensorCubit()),
    BlocProvider(create: (_) => AmbangCubit()..muatSemua()),
  ], child: const AplikasiPeringatanDini()));
}

class AplikasiPeringatanDini extends StatelessWidget {
  const AplikasiPeringatanDini({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'AIoT Peringatan Dini', theme: AppTheme.light,
    debugShowCheckedModeBanner: false,
    home: const KerangkaUtama(),
  );
}

class KerangkaUtama extends StatefulWidget {
  const KerangkaUtama({super.key});
  @override
  State<KerangkaUtama> createState() => _KerangkaUtamaState();
}

class _KerangkaUtamaState extends State<KerangkaUtama> {
  int indeks = 0;
  static const halaman = [HalamanDashboard(), HalamanRiwayat(), HalamanPengaturan()];
  @override
  Widget build(BuildContext context) {
    final data = context.watch<SensorCubit>().state;
    final ambang = context.watch<AmbangCubit>().state;
    final status = statusTerbaru(data, ambang);
    return Scaffold(
      appBar: AppBar(title: const Text('AIoT Peringatan Dini'),
        actions: [Padding(padding: const EdgeInsets.only(right: 8),
          child: Center(child: StatusChip(status: status)))]),
      body: halaman[indeks],
      bottomNavigationBar: NavigationBar(selectedIndex: indeks,
        onDestinationSelected: (i) => setState(() => indeks = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.sensors), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.history), label: 'Riwayat'),
          NavigationDestination(icon: Icon(Icons.tune), label: 'Pengaturan'),
        ]),
    );
  }
}
