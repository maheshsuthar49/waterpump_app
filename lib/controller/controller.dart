import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:water_pump/model/deivces.dart';
import 'package:water_pump/presentation/screens/device_detail.dart';

class TaskController extends GetxController {

  ///navbar
  // var currentIndex = 0.obs;
  // List<Widget> get pages => [
  //   DeviceDetail(),
  // ];
  // void changeNavigation (int index){
  //     currentIndex.value = index;
  // }

  var index = 0.obs;
  void changeNavigation ({required int currentIndex}){
    index.value = currentIndex;
  }

  var selectedFilter = "All".obs;
  void setFillter(String value){
    selectedFilter.value = value;
  }
  ///Refresh screen
  var isLoading = false.obs;
  Future<void> refreshData() async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));
    isLoading.value = false;
  }

  var power = false.obs;
  void powerOnOff(bool value){
    power.value = value;
  }
}