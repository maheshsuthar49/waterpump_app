import 'package:get/get.dart';
import 'package:water_pump/controller/Schduling_controller.dart';
import 'package:water_pump/controller/analoglimit_controller.dart';
import 'package:water_pump/controller/configController.dart';
import 'package:water_pump/controller/controller.dart';
import 'package:water_pump/controller/mqtt_controller.dart';

class AllBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MqttController>(() => MqttController(),);
    Get.lazyPut<TaskController>(() => TaskController(),);
    Get.lazyPut<ConfigController>(()=> ConfigController());
    Get.lazyPut<AnalogLimitController>(() => AnalogLimitController(),);
    Get.lazyPut<SchedulingController>(() => SchedulingController(),);

  }

}