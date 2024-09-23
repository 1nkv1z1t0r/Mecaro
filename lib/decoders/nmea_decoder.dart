import 'package:flutter/material.dart';
import '../models/decoded_message.dart';
import '../models/nmea_messages.dart';

class NMEADecoder {
  static DecodedMessage decodeNMEA(String nmeaMessage) {
    if (nmeaMessage.length < 6) {
      return DecodedMessage(
        text: "NMEA сообщение слишком короткое: $nmeaMessage",
        icon: Icons.error,
        type: 'Error',
      );
    }

    String messageType = nmeaMessage.substring(3, 6);
    List<String> parts =
    nmeaMessage.substring(7, nmeaMessage.length - 4).split(',');

    switch (messageType) {
      case 'GGA':
        return _decodeGGA(parts);
      case 'RMC':
        return _decodeRMC(parts);
      case 'GLL':
        return _decodeGLL(parts);
      case 'VTG':
        return _decodeVTG(parts);
      case "GSV":
        return _decodeGSV(parts);
      case 'GSA':
        return _decodeGSA(parts);
      default:
        return DecodedMessage(
          text: "NMEA сообщение не поддерживается: $nmeaMessage",
          icon: Icons.help_outline,
          type: 'Unknown',
        );
    }
  }

  static DecodedMessage _decodeGGA(List<String> parts) {
    if (parts.length < 14) {
      return DecodedMessage(
        text: "Некорректное NMEA GGA сообщение",
        icon: Icons.error,
        type: 'Error',
      );
    }

    NMEAGGA ggaMessage = NMEAGGA(
      time: parts[0],
      latitude: double.tryParse(parts[1]) ?? 0.0,
      latitudeDirection: parts[2],
      longitude: double.tryParse(parts[3]) ?? 0.0,
      longitudeDirection: parts[4],
      fixQuality: int.tryParse(parts[5]) ?? 0,
      numberOfSatellites: int.tryParse(parts[6]) ?? 0,
      hdop: double.tryParse(parts[7]) ?? 0.0,
      altitude: double.tryParse(parts[8]) ?? 0.0,
      altitudeUnits: parts[9],
      geoidHeight: double.tryParse(parts[10]) ?? 0.0,
      geoidUnits: parts[11],
    );

    String ggaText = '''
Время: ${ggaMessage.time}
Широта: ${ggaMessage.latitude} ${ggaMessage.latitudeDirection}
Долгота: ${ggaMessage.longitude} ${ggaMessage.longitudeDirection}
Качество фиксации: ${ggaMessage.fixQuality}
Количество спутников: ${ggaMessage.numberOfSatellites}
HDOP: ${ggaMessage.hdop}
Высота: ${ggaMessage.altitude} ${ggaMessage.altitudeUnits}
Высота геоида: ${ggaMessage.geoidHeight} ${ggaMessage.geoidUnits}
''';

    return DecodedMessage(
      text: ggaText,
      icon: Icons.location_on,
      description: "Глобальные данные позиционирования",
      type: 'GGA',
    );
  }

  static DecodedMessage _decodeRMC(List<String> parts) {
    if (parts.length < 12) {
      return DecodedMessage(
        text: "Некорректное NMEA RMC сообщение",
        icon: Icons.error,
        type: 'Error',
      );
    }

    NMEARMC rmcMessage = NMEARMC(
      time: parts[0],
      status: parts[1],
      latitude: double.tryParse(parts[2]) ?? 0.0,
      latitudeDirection: parts[3],
      longitude: double.tryParse(parts[4]) ?? 0.0,
      longitudeDirection: parts[5],
      speed: double.tryParse(parts[6]) ?? 0.0,
      course: double.tryParse(parts[7]) ?? 0.0,
      date: parts[8],
      magneticVariation: double.tryParse(parts[9]) ?? 0.0,
      magneticVariationDirection: parts[10],
    );

    String rmcText = '''
Время: ${rmcMessage.time}
Статус: ${rmcMessage.status}
Широта: ${rmcMessage.latitude} ${rmcMessage.latitudeDirection}
Долгота: ${rmcMessage.longitude} ${rmcMessage.longitudeDirection}
Скорость: ${rmcMessage.speed} узлов
Курс: ${rmcMessage.course} градусов
Дата: ${rmcMessage.date}
Магнитное отклонение: ${rmcMessage.magneticVariation} ${rmcMessage.magneticVariationDirection}
''';

    return DecodedMessage(
      text: rmcText,
      icon: Icons.navigation,
      description: "Рекомендуемые минимальные данные",
      type: 'RMC',
    );
  }

  static DecodedMessage _decodeGLL(List<String> parts) {
    if (parts.length < 7) {
      return DecodedMessage(
        text: "Некорректное NMEA GLL сообщение",
        icon: Icons.error,
        type: 'Error',
      );
    }

    NMEAGLL gllMessage = NMEAGLL(
      latitude: double.tryParse(parts[0]) ?? 0.0,
      latitudeDirection: parts[1],
      longitude: double.tryParse(parts[2]) ?? 0.0,
      longitudeDirection: parts[3],
      time: parts[4],
      status: parts[5],
      mode: parts[6],
    );

    String gllText = '''
Широта: ${gllMessage.latitude} ${gllMessage.latitudeDirection}
Долгота: ${gllMessage.longitude} ${gllMessage.longitudeDirection}
Время: ${gllMessage.time}
Статус: ${gllMessage.status}
Режим: ${gllMessage.mode}
''';

    return DecodedMessage(
      text: gllText,
      icon: Icons.gps_fixed,
      description: "Данные местоположения",
      type: 'GLL',
    );
  }

  static DecodedMessage _decodeVTG(List<String> parts) {
    if (parts.length < 9) {
      return DecodedMessage(
        text: "Некорректное NMEA VTG сообщение",
        icon: Icons.error,
        type: 'Error',
      );
    }

    NMEAVTG vtgMessage = NMEAVTG(
      trackTrue: double.tryParse(parts[0]) ?? 0.0,
      trackTrueIndicator: parts[1],
      trackMagnetic: double.tryParse(parts[2]) ?? 0.0,
      trackMagneticIndicator: parts[3],
      speedKnots: double.tryParse(parts[4]) ?? 0.0,
      speedKnotsIndicator: parts[5],
      speedKph: double.tryParse(parts[6]) ?? 0.0,
      speedKphIndicator: parts[7],
    );

    String vtgText = '''
Истинный курс: ${vtgMessage.trackTrue} ${vtgMessage.trackTrueIndicator}
Магнитный курс: ${vtgMessage.trackMagnetic} ${vtgMessage.trackMagneticIndicator}
Скорость: ${vtgMessage.speedKnots} узлов (${vtgMessage.speedKph} км/ч)
''';

    return DecodedMessage(
      text: vtgText,
      icon: Icons.speed,
      description: "Данные о курсе и скорости",
      type: 'VTG',
    );
  }

  static DecodedMessage _decodeGSV(List<String> parts) {
    if (parts.length < 3) {
      return DecodedMessage(
        text: "Некорректное NMEA GSV сообщение",
        icon: Icons.error,
        type: 'Error',
      );
    }

    int totalMessages = int.tryParse(parts[0]) ?? 0;
    int messageNumber = int.tryParse(parts[1]) ?? 0;
    int totalSatellites =
        int.tryParse(parts[2]) ?? 0;

    StringBuffer buffer = StringBuffer();
    buffer.writeln("Всего сообщений: $totalMessages");
    buffer.writeln("Номер сообщения: $messageNumber");
    buffer.writeln("Всего спутников: $totalSatellites");

    for (int i = 3; i < parts.length; i += 4) {
      if (i + 3 < parts.length) {
        String prn = parts[i];
        double elevation = double.tryParse(parts[i + 1]) ?? 0.0;
        double azimuth = double.tryParse(parts[i + 2]) ?? 0.0;
        double snr = double.tryParse(parts[i + 3]) ?? 0.0;

        buffer.writeln('Спутник ${((i - 3) ~/ 4) + 1}:');
        buffer.writeln('  Номер спутника (PRN): $prn');
        buffer.writeln('  Угол возвышения: $elevation°');
        buffer.writeln('  Азимут: $azimuth°');
        buffer.writeln('  SNR: $snr dB');
      }
    }

    return DecodedMessage(
      text: buffer.toString(),
      icon: Icons.map,
      description: "Данные о спутниках в зоне видимости",
      type: 'GSV',
    );
  }

  static DecodedMessage _decodeGSA(List<String> parts) {
    if (parts.length < 17) {
      return DecodedMessage(
        text: "Некорректное NMEA GSA сообщение",
        icon: Icons.error,
        type: 'Error',
      );
    }

    List<int> satelliteIDs =
    parts.sublist(2, 14).map((s) => int.tryParse(s) ?? 0).toList();
    NMEAGSA gsaMessage = NMEAGSA(
      mode: parts[0],
      fixType: int.tryParse(parts[1]) ?? 0,
      satelliteIDs: satelliteIDs,
      pdop: double.tryParse(parts[14]) ?? 0.0,
      hdop: double.tryParse(parts[15]) ?? 0.0,
      vdop: double.tryParse(parts[16]) ?? 0.0,
    );

    String gsaText = '''
Режим: ${gsaMessage.mode}
Тип фиксации: ${gsaMessage.fixType}
ID спутников: ${gsaMessage.satelliteIDs.join(', ')}
PDOP: ${gsaMessage.pdop}
HDOP: ${gsaMessage.hdop}
VDOP: ${gsaMessage.vdop}
''';

    return DecodedMessage(
      text: gsaText,
      icon: Icons.satellite,
      description: "Данные о спутниках",
      type: 'GSA',
    );
  }
}