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
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['msg'] = msg;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DevicesData {
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
  }){isConnected = false;} //temprory
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
    lat = json['lat'];
    lng = json['lng'];
    userId = json['user_id'];
    name = json['name'];
    area = json['area'];
    flowMultiplier = json['flow_multiplier'];
    underloadLimit = json['underload_limit'];
    isConnected = false;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['uuid'] = uuid;
    _data['alert_mode'] = alertMode;
    _data['mobile'] = mobile;
    _data['exp_date'] = expDate;
    _data['registered_date'] = registeredDate;
    _data['version'] = version;
    _data['model'] = model;
    _data['lat'] = lat;
    _data['lng'] = lng;
    _data['user_id'] = userId;
    _data['name'] = name;
    _data['area'] = area;
    _data['flow_multiplier'] = flowMultiplier;
    _data['underload_limit'] = underloadLimit;
    _data['isConnected'] = isConnected; //temprory
    return _data;
  }
}
