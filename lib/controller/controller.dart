import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:water_pump/model/devices.dart';
import 'package:water_pump/services/api_service.dart';

class TaskController extends GetxController {

  final ApiService apiService = ApiService();
  final box = GetStorage();

  @override
  void onInit() {
    final token = box.read('token');
    // TODO: implement onInit
    super.onInit();
    fetchDeviceAll(token);
  }
  ///navbar
  var index = 0.obs;

  void changeNavigation({required int currentIndex}) {
    index.value = currentIndex;
  }

  var selectedFilter = "All".obs;

  void setFillter(String value) {
    selectedFilter.value = value;
  }

  ///Refresh screen
  var isLoading = false.obs;

  Future<void> refreshData() async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 7));
    isLoading.value = false;
  }

  //switch
  var power = false.obs;

  void powerOnOff(bool value) {
    power.value = value;
  }

  //device list
  var devices= <DevicesData>[].obs;

  Future<void> fetchDeviceAll(String token) async{
    try{
      isLoading.value = true;
      final result = await apiService.getDevices(token);

      if(result != null && result.success == true){
        devices.value = result.data;
        print("device All: ${devices.length}",);
      }else{
        print("failed to fetch device");
      }
    }catch(e){
      debugPrint("fetch error $e");
    }finally{
      isLoading.value = false;
    }
  }

  //var devices = <Devices>[].obs;

  //helper getter for connectedDevice or disconnected
  int get totalDevices => devices.length;

  int get connectedDevices =>
      devices
          .where((d) => d.isConnected)
          .length;

  int get disconnectedDevices =>
      devices
          .where((d) => !d.isConnected)
          .length;

  List<DevicesData> get connectedList =>
      devices.where((d) => d.isConnected).toList();

  List<DevicesData> get disconnectedList =>
      devices.where((d) => !d.isConnected).toList();

}
