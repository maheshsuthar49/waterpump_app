import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_pump/controller/controller.dart';
import 'package:water_pump/model/deivces.dart';
import 'package:water_pump/presentation/widgets/bottomnav_screen.dart';

import '../widgets/gauge2_widget.dart';
import '../widgets/gauge_widget.dart';

class DeviceDetail extends StatelessWidget {
  final controller = Get.find<TaskController>();
  final Devices device;
  DeviceDetail({required this.device});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  color: Colors.grey.shade100,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              device.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              device.location,
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                        Obx(
                          () => Switch(
                            activeColor: Color(0xff024a06),

                            value: controller.power.value,
                            onChanged: (bool value) {
                              controller.powerOnOff(value);
                              if(value == true){
                                Get.snackbar("${device.name}", "Device is on",);
                              }else{
                                Get.snackbar("${device.name}", "Device is off");
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                if(!device.isConnected)...[
                  Card(
                    elevation: 2,
                    color: Colors.red.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.warning, color: Colors.red),
                      title: Text("Device is disconnected"),
                    ),
                  ),
                ],
                SizedBox(height: 10),
                Card(
                  color: Colors.grey.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Phase 1(R)",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GaugeWidget(value: device.voltageValues[0], label: "V", height: 100,),
                            GaugeTwoWidget(value1: device.currentValues[0], label2: "I",  height: 100,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Card(
                  color: Colors.grey.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Phase 2(Y)",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GaugeWidget(value: device.voltageValues[1], label: "V", height: 100,),
                            GaugeTwoWidget(value1: device.currentValues[1], label2: "I",  height: 100,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Card(
                  color: Colors.grey.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Phase 3(B)",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GaugeWidget(value: device.voltageValues[2], label: "V", height: 100,),
                            GaugeTwoWidget(value1: device.currentValues[2], label2: "I",  height: 100,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
