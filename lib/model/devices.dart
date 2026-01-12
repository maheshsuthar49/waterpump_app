class Device {
  Device({required this.success, required this.msg, required this.data});
  late final bool success;
  late final String msg;
  late final List<DevicesData> data;

  Device.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    data = List.from(json['data']).map((e) => DevicesData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['success'] = success;
    json['msg'] = msg;
    json['data'] = data.map((e) => e.toJson()).toList();
    return json;
  }

}

class DevicesData {
  List<int>? ai;
  List<int>? di;
  List<int>? doo; // here is do according to mqtt but dart do is function
  List<int>? flt;
  DevicesData({
    required this.id,
    required this.uuid,
    required this.alertMode,
    this.mobile,
    required this.expDate,
    required this.registeredDate,
    required this.version,
    this.model,
    required this.lat,
    required this.lng,
    required this.userId,
    required this.name,
    required this.area,
    required this.flowMultiplier,
    required this.underloadLimit,
  }){isConnected = false;
    ai = [];
    di = [];
    doo = [];
    flt = [];
  }
  late final int id;
  late final int uuid;
  late final int alertMode;
  late final Null mobile;
  late final String expDate;
  late final String registeredDate;
  late final int version;
  late final Null model;
  late final double lat;
  late final double lng;
  late final int userId;
  late final String name;
  late final String area;
  late final int flowMultiplier;
  late final int underloadLimit;
  late bool isConnected; //temperory

  DevicesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    alertMode = json['alert_mode'];
    mobile = null;
    expDate = json['exp_date'];
    registeredDate = json['registered_date'];
    version = json['version'];
    model = null;
    lat = (json['lat'] as num).toDouble();
    lng = (json['lng'] as num).toDouble();
    userId = json['user_id'];
    name = json['name'];
    area = json['area'];
    flowMultiplier = json['flow_multiplier'];
    underloadLimit = json['underload_limit'];
    isConnected = false;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['uuid'] = uuid;
    data['alert_mode'] = alertMode;
    data['mobile'] = mobile;
    data['exp_date'] = expDate;
    data['registered_date'] = registeredDate;
    data['version'] = version;
    data['model'] = model;
    data['lat'] = lat;
    data['lng'] = lng;
    data['user_id'] = userId;
    data['name'] = name;
    data['area'] = area;
    data['flow_multiplier'] = flowMultiplier;
    data['underload_limit'] = underloadLimit;
    data['isConnected'] = isConnected; //temprory
    return data;
  }
}
