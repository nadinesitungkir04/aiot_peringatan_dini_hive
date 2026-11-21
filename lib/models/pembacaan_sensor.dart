import 'package:hive/hive.dart';

class PembacaanSensor {
  final String id;
  final String jenisSensor;
  final double nilai;
  final String lokasiPos;
  final DateTime waktu;

  const PembacaanSensor({required this.id, required this.jenisSensor,
    required this.nilai, required this.lokasiPos, required this.waktu});

  PembacaanSensor salinDenganNilai(double nilaiBaru) => PembacaanSensor(
    id: id, jenisSensor: jenisSensor, nilai: nilaiBaru,
    lokasiPos: lokasiPos, waktu: waktu);
}

class PembacaanSensorAdapter extends TypeAdapter<PembacaanSensor> {
  @override
  final int typeId = 17;

  @override
  PembacaanSensor read(BinaryReader reader) => PembacaanSensor(
    id: reader.readString(),
    jenisSensor: reader.readString(),
    nilai: reader.readDouble(),
    lokasiPos: reader.readString(),
    waktu: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
  );

  @override
  void write(BinaryWriter writer, PembacaanSensor obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.jenisSensor);
    writer.writeDouble(obj.nilai);
    writer.writeString(obj.lokasiPos);
    writer.writeInt(obj.waktu.millisecondsSinceEpoch);
  }
}
