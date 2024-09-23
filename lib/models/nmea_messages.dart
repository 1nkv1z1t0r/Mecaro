class NMEAGGA {
  final String time;
  final double latitude;
  final String latitudeDirection;
  final double longitude;
  final String longitudeDirection;
  final int fixQuality;
  final int numberOfSatellites;
  final double hdop;
  final double altitude;
  final String altitudeUnits;
  final double geoidHeight;
  final String geoidUnits;

  NMEAGGA({
    required this.time,
    required this.latitude,
    required this.latitudeDirection,
    required this.longitude,
    required this.longitudeDirection,
    required this.fixQuality,
    required this.numberOfSatellites,
    required this.hdop,
    required this.altitude,
    required this.altitudeUnits,
    required this.geoidHeight,
    required this.geoidUnits,
  });
}

class NMEARMC {
  final String time;
  final String status;
  final double latitude;
  final String latitudeDirection;
  final double longitude;
  final String longitudeDirection;
  final double speed;
  final double course;
  final String date;
  final double magneticVariation;
  final String magneticVariationDirection;

  NMEARMC({
    required this.time,
    required this.status,
    required this.latitude,
    required this.latitudeDirection,
    required this.longitude,
    required this.longitudeDirection,
    required this.speed,
    required this.course,
    required this.date,
    required this.magneticVariation,
    required this.magneticVariationDirection,
  });
}

class NMEAGLL {
  final double latitude;
  final String latitudeDirection;
  final double longitude;
  final String longitudeDirection;
  final String time;
  final String status;
  final String mode;

  NMEAGLL({
    required this.latitude,
    required this.latitudeDirection,
    required this.longitude,
    required this.longitudeDirection,
    required this.time,
    required this.status,
    required this.mode,
  });
}

class NMEAVTG {
  final double trackTrue;
  final String trackTrueIndicator;
  final double trackMagnetic;
  final String trackMagneticIndicator;
  final double speedKnots;
  final String speedKnotsIndicator;
  final double speedKph;
  final String speedKphIndicator;

  NMEAVTG({
    required this.trackTrue,
    required this.trackTrueIndicator,
    required this.trackMagnetic,
    required this.trackMagneticIndicator,
    required this.speedKnots,
    required this.speedKnotsIndicator,
    required this.speedKph,
    required this.speedKphIndicator,
  });
}

class NMEAGSA {
  final String mode;
  final int fixType;
  final List<int> satelliteIDs;
  final double pdop;
  final double hdop;
  final double vdop;

  NMEAGSA({
    required this.mode,
    required this.fixType,
    required this.satelliteIDs,
    required this.pdop,
    required this.hdop,
    required this.vdop,
  });
}

class NMEAGSV {
  final int totalMessages;
  final int messageNumber;
  final int totalSatellites;
  final List<SatelliteInfo> satellites;

  NMEAGSV({
    required this.totalMessages,
    required this.messageNumber,
    required this.totalSatellites,
    required this.satellites,
  });
}

class SatelliteInfo {
  final String prn;
  final double elevation;
  final double azimuth;
  final double snr;

  SatelliteInfo({
    required this.prn,
    required this.elevation,
    required this.azimuth,
    required this.snr,
  });
}