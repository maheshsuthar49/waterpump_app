class Devices {
  final String name;
  final bool isConnected;
  final String location;
  final List<double> voltageValues;
  final List<double> currentValues;

  Devices({
    required this.name,
    required this.isConnected,
    required this.location,
    required this.voltageValues,
    required this.currentValues,
  });
}
