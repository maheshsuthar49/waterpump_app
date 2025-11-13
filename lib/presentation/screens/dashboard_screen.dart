import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_pump/controller/controller.dart';
import 'package:water_pump/controller/mqtt_controller.dart';
import 'package:water_pump/model/devices.dart';
import 'package:water_pump/presentation/screens/flutter_map.dart';
import 'package:water_pump/presentation/screens/map_screen.dart';

import 'package:water_pump/presentation/widgets/device_card.dart';
import 'package:water_pump/presentation/screens/drawer_screen.dart';
import 'package:water_pump/presentation/screens/profile_screen.dart';
import 'package:water_pump/services/api_service.dart';

import '../widgets/bottomnav_screen.dart';

class DashboardScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.find<TaskController>();
  final mqttController = Get.find<MqttController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xffeafbea),
      drawer: Drawer(

         backgroundColor: Color(0xffeafbea),
        child: DrawerScreen(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage("assets/images/agromation.jpg")
                      ),
                    ),
                    Text(
                      "DASHBOARD",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xff024a06),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){

                      },
                      child: Icon(
                        Icons.notifications_none,
                        size: 28,
                        color: Color(0xff024a06),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextField(
                          onChanged: (value) => controller.updateSearchQuery(value),
                          decoration: InputDecoration(
                            prefixIcon: Icon(CupertinoIcons.search),
                            hintText: "Search..",
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Obx(() => PopupMenuButton(
                      onSelected: (value) {
                        controller.setFillter(value);
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: "All", child: Text("All")),
                        const PopupMenuItem(value: "Running", child: Text("Running")),
                        const PopupMenuItem(value: "Stopped", child: Text("Stopped")),
                      ],
                      child: Container(
                        // height: 45,
                        // width: 100,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children:  [
                            Icon(Icons.filter_list, size: 18),
                            SizedBox(width: 4),
                            Text(controller.selectedFilter.value, style: TextStyle(fontSize: 14),),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      //margin: EdgeInsets.symmetric(horizontal: 4),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Column(
                        children: [
                          Text("Total Devices"),
                          Center(
                            child: Obx(() =>  Text(
                              "${controller.devices.length}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),)
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //margin: EdgeInsets.symmetric(horizontal: 4),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.green.shade300),
                      ),
                      child: Column(
                        children: [
                          Text("Connected"),
                          Center(
                            child:Obx(() => Text(
                              "${controller.countConnected.value}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.green,
                              ),
                            ),)
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //margin: EdgeInsets.symmetric(horizontal: 4),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.red.shade300),
                      ),
                      child: Column(
                        children: [
                          Text("Disconnected"),
                          Center(
                            child:Obx(() =>  Text(
                              "${controller.countDisconnected.value}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.red,
                              ),
                            ),)
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Connected Devices",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color(0xffc3f3c3),
                      ),
                      child:Obx(() =>  Text(
                        "${controller.countConnected.value}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.green,
                        ),
                      ),)
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Obx(() {

                  if (controller.connectedList.isEmpty) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(child: Text("No devices in this category.")),
                    );
                  }
                  return  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.filteredConnectedList.length,
                    itemBuilder: (context, index) {
                      final device = controller.filteredConnectedList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: InkWell(
                            onTap: () {
                              controller.index.value = 0;
                              Get.to(() => BottomNavScreen(selectedDevice: device,), transition: Transition.zoom);
                            },
                            child:DeviceCard(deviceData: device)

                        ),
                      );
                    },
                  );
                },),

                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Disconnected Devices",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey.shade200,
                      ),
                      child:Obx(() =>  Text(
                        "${controller.countDisconnected.value}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),)
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Obx(() {
                  if(controller.disconnectedList == 0){
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(child: Text("No devices in this category.")),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.filteredDisconnectedList.length,
                    itemBuilder: (context, index) {
                      final device = controller.filteredDisconnectedList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: InkWell(
                            onTap: () {
                              controller.index.value = 0;
                              Get.to(() => BottomNavScreen(selectedDevice: device,), transition: Transition.zoom);
                            },
                            child: DeviceCard(deviceData: device),
                        )
                      );
                    },
                  );
                },)
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "mapTag",
          backgroundColor: Colors.green.shade100,
      onPressed: () {

              Get.to(()=> FMaps(), transition: Transition.fadeIn, );

      },
      child: const Icon(Icons.map, color: Color(0xff024a06)),
    ),
          SizedBox(height: 10,),
          Obx(() {
            if(controller.isLoading.value){
              return FloatingActionButton(
                backgroundColor: Colors.grey,
                onPressed: () {},
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );
            }else{
              return FloatingActionButton(
                heroTag: "refreshTag",
                backgroundColor: const Color(0xff024a06),
                onPressed: () async {
                  final token = controller.box.read('token');
                  print("token is: $token" );

                  if(!mqttController.isConnected.value){
                    mqttController.connect();
                  }
                  await controller.fetchDeviceAll(token);


                },
                child: const Icon(Icons.refresh, color: Colors.white),
              );
            }

          },),
        ],
      )


    );
  }
}
