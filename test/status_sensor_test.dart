import 'package:flutter_test/flutter_test.dart';
import 'package:aiot_peringatan_dini_hive/helpers/pengaturan_helper.dart';
import 'package:aiot_peringatan_dini_hive/widgets/status_sensor.dart';

void main() {
  test('status Aman, Waspada, Siaga mengikuti ambang', () {
    const batas = AmbangBatas(100, 200);
    expect(statusUntuk(99, batas), 'Aman');
    expect(statusUntuk(100, batas), 'Waspada');
    expect(statusUntuk(200, batas), 'Siaga');
  });
}
