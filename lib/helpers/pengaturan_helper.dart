import 'package:shared_preferences/shared_preferences.dart';

class AmbangBatas {
  final double waspada;
  final double siaga;
  const AmbangBatas(this.waspada, this.siaga);
}

class PengaturanHelper {
  static const jenis = ['Ketinggian Air', 'Pergeseran Tanah', 'Curah Hujan'];
  static const satuan = {'Ketinggian Air': 'cm', 'Pergeseran Tanah': 'mm', 'Curah Hujan': 'mm'};
  static const defaultBatas = {
    'Ketinggian Air': AmbangBatas(100, 200),
    'Pergeseran Tanah': AmbangBatas(20, 50),
    'Curah Hujan': AmbangBatas(50, 100),
  };
  static String _key(String jenis, String tingkat) =>
      'ambang_${jenis.replaceAll(' ', '_')}_$tingkat';

  static Future<AmbangBatas> muat(String jenis) async {
    final pref = await SharedPreferences.getInstance();
    final awal = defaultBatas[jenis]!;
    return AmbangBatas(
      pref.getDouble(_key(jenis, 'waspada')) ?? awal.waspada,
      pref.getDouble(_key(jenis, 'siaga')) ?? awal.siaga,
    );
  }

  static Future<void> simpan(String jenis, AmbangBatas batas) async {
    if (batas.waspada < 0 || batas.siaga <= batas.waspada) {
      throw ArgumentError('Batas Siaga harus lebih besar dari Waspada');
    }
    final pref = await SharedPreferences.getInstance();
    await pref.setDouble(_key(jenis, 'waspada'), batas.waspada);
    await pref.setDouble(_key(jenis, 'siaga'), batas.siaga);
  }
}
