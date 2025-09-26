import 'package:get/get.dart';
import 'package:water_pump/controller/controller.dart';

class BottomNavScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<TaskController>(() => TaskController(),);
  }

}