import 'package:get/get.dart';
import 'package:water_pump/controller/mqtt_controller.dart';

class AnalogLimitController extends GetxController{
  final MqttController mqttController = Get.find<MqttController>();
  var isLoading = true.obs;
  var cardUpdate = RxList<bool>.filled(20, false);
  var analogLimits = <List<String>>[].obs;


  void fetchAnalogConfig(String uuid){
    mqttController.get_config(uuid);
  }

  Future<void> updateAnalogLimits( String uuid, String value) async {

    mqttController.analogLimitsConfig(uuid, value);

    await Future.delayed(Duration(seconds: 3));
    fetchAnalogConfig(uuid);
  }
  Future<void> updateAnalogLimitMulti(String uuid, String value)async{
    mqttController.analogLimitMulti(uuid, value);
    await Future.delayed(Duration(seconds: 3));
    fetchAnalogConfig(uuid);
  }
  void updateAnalogLimitData(Map<String, dynamic> jsonData) {
    if (jsonData.containsKey("analog_limit")) {
      final List<dynamic> rawList = jsonData["analog_limit"];
      analogLimits.value =
          rawList.map((e) => e.toString().split(",")).toList();

      for(int i =0 ; i < cardUpdate.length; i++){
        cardUpdate[i] = false;
      }
    }
    isLoading.value = false;
  }

}