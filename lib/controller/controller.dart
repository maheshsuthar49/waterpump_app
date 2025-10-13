import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:water_pump/controller/mqtt_controller.dart';
import 'package:water_pump/model/devices.dart';
import 'package:water_pump/services/api_service.dart';

class TaskController extends GetxController {

  final ApiService apiService = ApiService();
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    final token = box.read('token');

    if (token != null && token.toString().isNotEmpty) {
      print("Auto fetching devices with token: $token");
      fetchDeviceAll(token);
    } else {
      print("No token found in GetStorage");
    }
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

  //Date formater
  String formatDate(String isoDate){
    try{
      final DateTime parsedDate = DateTime.parse(isoDate);
      return DateFormat('dd-MM-yyyy').format(parsedDate);
    }catch (e){
      return 'Invalid Date';
    }
  }
  ///Refresh screen
  var isLoading = false.obs;

  Future<void> refreshData() async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 7));
    isLoading.value = false;
  }

//SearchBox
  var searchQuery  = ''.obs;
  void updateSearchQuery(String value){
    searchQuery.value = value.toLowerCase();
  }
  // update count
  var countConnected = 0.obs;
  var countDisconnected = 0.obs;
  void updateCount(){
    countConnected.value = devices.where((d) => d.isConnected,).length;
    countDisconnected.value = devices.where((d) => !d.isConnected,).length;
  }
  //switch
  var power = false.obs;

  void powerOnOff(bool value) {
    power.value = value;
  }

  //device list
  var devices= <DevicesData>[].obs;

  Future<void> fetchDeviceAll(String token) async{
    final mqttController = Get.find<MqttController>();
    try{
      isLoading.value = true;
      final result = await apiService.getDevices(token);

      if(result != null && result.success == true){
        devices.assignAll(result.data);
        updateCount();
        print("device All: ${devices.length}",);
      }else{
        print("failed to fetch device");
      }
    }catch(e){
      debugPrint("fetch error $e");
    }finally{
      isLoading.value = false;
    }

      //subscribe for uuid
    if(mqttController.isConnected.value){
      for(var d in devices) {
        mqttController.subscribeToDevice(d.uuid.toString());
      }
    }
  }

  //get Report
  Future<void> fetchReport({required String id,required String from, required String to }) async{
    final token = box.read("token");
    if(token == null){
      print("No token found");
      return;
    }

    await apiService.getReport(token: token, id: id, from: from, to: to);
  }


  //helper getter for connectedDevice or disconnected
  int get totalDevices => devices.length;


  List<DevicesData> get connectedList =>
      devices.where((d) => d.isConnected).toList();

  List<DevicesData> get disconnectedList =>
      devices.where((d) => !d.isConnected).toList();

  List<DevicesData> get filteredConnectedList {
    if (searchQuery.isEmpty) return connectedList;
    return connectedList
        .where((d) => d.name.toLowerCase().contains(searchQuery.value))
        .toList();
  }

  List<DevicesData> get filteredDisconnectedList {
    if (searchQuery.isEmpty) return disconnectedList;
    return disconnectedList
        .where((d) => d.name.toLowerCase().contains(searchQuery.value))
        .toList();
  }
}
