import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_pump/controller/mqtt_controller.dart';

class ConfigController extends GetxController {
  final MqttController mqttController = Get.find<MqttController>();
  var isLoading = true.obs;
  var amode = false.obs;
  var timer = false.obs;
  var prot = false.obs;
  var lpt = ''.obs;
  var time = ''.obs;
  void fetchConfig(String uuid) {
    mqttController.get_config(uuid);
  }

  void updateConfig(Map<String, dynamic> jsonData){
    amode.value = (jsonData["amode"] ?? '0') == '1';
    timer.value = (jsonData["timer"] ?? '0') == '1';
    prot.value = (jsonData["prot"] ?? '0') == '1';
    lpt.value = jsonData["lpt"] ?? '0';
    time.value = jsonData["time"] ?? '';
  isLoading.value = false;
  }

  void updateConfigVal(String uuid, String key, String value){
    mqttController.deviceConfig(uuid, key, value);
  }


}
