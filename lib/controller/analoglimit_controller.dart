import 'package:get/get.dart';
import 'package:water_pump/controller/mqtt_controller.dart';

class AnalogLimitController extends GetxController{
  final MqttController mqttController = Get.find<MqttController>();
  var isLoading = true.obs;
  var isUpdating = false.obs;
  var analogLimits = <List<String>>[].obs;
  void fetchAnalogConfig(String uuid){
    mqttController.get_config(uuid);
  }

  void updateAnalogLimitData(Map<String, dynamic> jsonData) {
    if (jsonData.containsKey("analog_limit")) {
      final List<dynamic> rawList = jsonData["analog_limit"];
      analogLimits.value =
          rawList.map((e) => e.toString().split(",")).toList();
    }
    isLoading.value = false;
  }

}