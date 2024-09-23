class UBXMessage {
  final String time;
  final double latitude;
  final double longitude;
  final double altitude;
  final double seaLevelAltitude;

  UBXMessage({
    required this.time,
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.seaLevelAltitude,
  });
}