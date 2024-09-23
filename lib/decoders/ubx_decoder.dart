import 'dart:typed_data';

import '../models/ubx_message.dart';

class UBXDecoder {
  static UBXMessage decodeNavPvt(Uint8List payload) {
    ByteData byteData = ByteData.sublistView(payload);

    String time =
        "${byteData.getUint8(8)}:${byteData.getUint8(9)}:${byteData.getUint8(10)}";
    double latitude = byteData.getInt32(28, Endian.little) / 1e7;
    double longitude = byteData.getInt32(24, Endian.little) / 1e7;
    double altitude = byteData.getInt32(32, Endian.little) / 1000.0;
    double seaLevelAltitude = byteData.getInt32(36, Endian.little) / 1000.0;

    return UBXMessage(
      time: time,
      latitude: latitude,
      longitude: longitude,
      altitude: altitude,
      seaLevelAltitude: seaLevelAltitude,
    );
  }

  static String decodeUBX(int msgClass, int msgId, Uint8List payload) {
    if (msgClass == 0x01 && msgId == 0x07 && payload.length == 92) {
      UBXMessage message = decodeNavPvt(payload);
      return '''
Время: ${message.time}
Широта: ${message.latitude}
Долгота: ${message.longitude}
Высота: ${message.altitude} м
Высота над уровнем моря: ${message.seaLevelAltitude} м
''';
    }
    return "Сообщение UBX не поддерживается";
  }
}