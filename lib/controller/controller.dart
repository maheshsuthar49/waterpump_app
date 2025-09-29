import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:water_pump/model/deivces.dart';
import 'package:water_pump/presentation/screens/device_detail.dart';
import 'package:path/path.dart';

class TaskController extends GetxController {
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
    await Future.delayed(Duration(seconds: 2));
    isLoading.value = false;
  }

  //switch
  var power = false.obs;
  void powerOnOff(bool value) {
    power.value = value;
  }

  //device list
  List<Devices> devices = [
    Devices(
      name: "Device 1",
      isConnected: true,
      location: "Pune Maharashtra",
      voltageValues: [320, 240, 40],
      currentValues: [150, 250, 350],
    ),
    Devices(
      name: "Device 2",
      isConnected: true,
      location: "Nashik Maharashtra",
      voltageValues: [300, 220, 60],
      currentValues: [140, 230, 330],
    ),
    Devices(
      name: "Device 3",
      isConnected: false,
      location: "Mumbai Maharashtra",
      voltageValues: [340, 280, 50],
      currentValues: [180, 130, 230],
    ),
    Devices(
      name: "Device 4",
      isConnected: true,
      location: "Pune Maharashtra",
      voltageValues: [140, 330, 130],
      currentValues: [340, 430, 130],
    ),
    Devices(
      name: "Device 5",
      isConnected: false,
      location: "Mumbai Maharashtra",
      voltageValues: [340, 430, 130],
      currentValues: [320, 240, 40],
    ),
    Devices(
      name: "Device 6",
      isConnected: true,
      location: "Nashik Maharashtra",
      voltageValues: [210, 330, 30],
      currentValues: [180, 130, 230],
    ),
    Devices(
      name: "Device 7",
      isConnected: false,
      location: "Pune Maharashtra",
      voltageValues: [180, 130, 230],
      currentValues: [140, 330, 130],
    ),
  ].obs;

  //helper getter for connectedDevice or disconnected
  int get totalDevices => devices.length;
  int get connectedDevices => devices.where((d) => d.isConnected).length;
  int get disconnectedDevices => devices.where((d) => !d.isConnected).length;

  List<Devices> get connectedList =>
      devices.where((d) => d.isConnected).toList();
  List<Devices> get disconnectedList =>
      devices.where((d) => !d.isConnected).toList();

  @override
  void onInit() {
    createDatabase();
    super.onInit();
  }

  void createDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'auth.db');
    openAppDatabase(path: path);
  }

  void openAppDatabase({required String path}) async{
    Database database = await openDatabase(path,version: 1,
    onCreate: (Database db,int version) async{
      await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT UNIQUE,
            password TEXT
          )
        ''');
      debugPrint("Database is created");
    },
      onOpen: (Database db) {
        debugPrint("Database is open");
      },
    );
  }
}
