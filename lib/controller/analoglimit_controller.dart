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
      final parts = value.split(",");
      final index = int.tryParse(parts[0]);

      if(index == null) return;
      cardUpdate[index] = true;
      cardUpdate.refresh();

    mqttController.analogLimitsConfig(uuid, value);

  }
  Future<void> updateAnalogLimitMulti(String uuid, String value)async{
    final parts = value.split(",");
    final index = int.tryParse(parts[0]);

    if(index == null) return;
    cardUpdate[index] = true;
    cardUpdate.refresh();
    mqttController.analogLimitMulti(uuid, value);

  }
  void updateAnalogLimitData(Map<String, dynamic> jsonData) {
    if (jsonData.containsKey("analog_limit")) {
      final List<dynamic> rawList = jsonData["analog_limit"];
      analogLimits.value =
          rawList.map((e) => e.toString().split(",")).toList();

      for(int i =0 ; i < cardUpdate.length; i++){
        cardUpdate[i] = false;
      }
      cardUpdate.refresh();
    }
    isLoading.value = false;
  }

}