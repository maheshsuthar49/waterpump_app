import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_pump/controller/controller.dart';
import 'package:water_pump/controller/mqtt_controller.dart';
import 'package:water_pump/model/devices.dart';
import 'package:water_pump/presentation/widgets/bottomnav_screen.dart';

import '../widgets/gauge2_widget.dart';
import '../widgets/gauge_widget.dart';

class DeviceDetail extends StatelessWidget {
  final controller = Get.find<TaskController>();
  final mqttController = Get.find<MqttController>();
  final DevicesData deviceData;
  DeviceDetail({required this.deviceData,});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() => Column(
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
                              deviceData.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              deviceData.area,
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                         Switch(
                            activeColor: Color(0xff024a06),

                            value: controller.power.value,
                            onChanged: (bool value) {
                              controller.powerOnOff(value);
                              mqttController.GetDataPublish(deviceData.uuid.toString(), value ? 1 : 0);
                              if(value == true){
                                Get.snackbar("${deviceData.name}", "Device is on",duration: Duration(seconds: 1));
                              }else{
                                Get.snackbar("${deviceData.name}", "Device is off",duration: Duration(seconds: 1));
                              }
                            },
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),


                if(!deviceData.isConnected)...[
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
                            GaugeWidget(value: deviceData.ai?[0].toDouble() ?? 0, label: "V", height: 100,),
                            GaugeTwoWidget(value1: deviceData.ai?[3].toDouble() ?? 0, label2: "I",  height: 100,),
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
                            GaugeWidget(value: deviceData.ai?[1].toDouble() ?? 0, label: "V", height: 100,),
                            GaugeTwoWidget(value1: deviceData.ai?[4].toDouble() ?? 0, label2: "I",  height: 100,),
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
                            GaugeWidget(value: deviceData.ai?[2].toDouble() ?? 0, label: "V", height: 100,),
                            GaugeTwoWidget(value1: deviceData.ai?[5].toDouble() ?? 0, label2: "I",  height: 100,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),),
          ),
        ),
      );
  }
}
