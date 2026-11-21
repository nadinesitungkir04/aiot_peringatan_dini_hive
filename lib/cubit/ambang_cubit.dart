import 'package:flutter_bloc/flutter_bloc.dart';
import '../helpers/pengaturan_helper.dart';

class AmbangCubit extends Cubit<Map<String, AmbangBatas>> {
  AmbangCubit() : super(Map.of(PengaturanHelper.defaultBatas));

  Future<void> muatSemua() async {
    final hasil = <String, AmbangBatas>{};
    for (final jenis in PengaturanHelper.jenis) {
      hasil[jenis] = await PengaturanHelper.muat(jenis);
    }
    emit(hasil);
  }

  Future<void> simpan(String jenis, double waspada, double siaga) async {
    final baru = AmbangBatas(waspada, siaga);
    await PengaturanHelper.simpan(jenis, baru);
    emit({...state, jenis: baru});
  }
}
