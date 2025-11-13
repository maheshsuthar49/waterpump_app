import 'package:intl/intl.dart';

class ReportsData {
  final DateTime timestamp;
  final int vr;
  final int vy;
  final int vb;
  final int ir;
  final int iy;
  final int ib;
  final int status;
  final String fault;
  final int runtime;
  ReportsData({
    required this.timestamp,
    required this.vr,
    required this.vy,
    required this.vb,
    required this.ir,
    required this.iy,
    required this.ib,
    required this.status,
    required this.fault,
    required this.runtime,
  });

  factory ReportsData.fromjson(Map<String, dynamic> json) {
    return ReportsData(
      timestamp: DateTime.parse(json['timestamp'] as String),
      vr: json['vr'] as int,
      vy: json['vy'] as int,
      vb: json['vb'] as int,
      ir: json['vb'] as int,
      iy: json['iy'] as int,
      ib: json['ib'] as int,
      status: json['status'] as int,
      fault: (json['fault'] ?? '') as String,
      runtime: json['runtime'] as int,
    );

  }
  String get formattedTime {
    return DateFormat('hh:mm a').format(timestamp.toLocal());
  }

  String get statusText {
    return status == 0 ? "Stopped" : "Running";
  }

  String get faultText{
    if(fault == null || fault.isEmpty){
      return "No Fault";
    }
    return fault.replaceAll("_", " ");
  }
}
