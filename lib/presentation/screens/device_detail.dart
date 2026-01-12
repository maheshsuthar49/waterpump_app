import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_pump/controller/controller.dart';
import 'package:water_pump/controller/mqtt_controller.dart';
import 'package:water_pump/model/devices.dart';

import '../widgets/gauge2_widget.dart';
import '../widgets/gauge_widget.dart';

class DeviceDetail extends StatelessWidget {
  final controller = Get.find<TaskController>();
  final mqttController = Get.find<MqttController>();
  final DevicesData deviceData;
  DeviceDetail({super.key, required this.deviceData,});
  @override
  Widget build(BuildContext context) {
    controller.updatePowerOnOff(deviceData);
    return Scaffold(
      backgroundColor: Colors.white,
      body:  SafeArea(
        child:  Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            String faultMsg = controller.buildFaultMessage(deviceData);
            return SingleChildScrollView(
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
                              // controller.powerOnOff(value);
                              controller.powerOnOff(value, deviceData);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                      const SizedBox(height: 10),
                      if(faultMsg.isNotEmpty)...[
                        Card(
                          color: Colors.red[100],
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(padding:  EdgeInsets.all(12.0),
                            child: Row(

                              children: [
                                Icon(Icons.warning_amber_outlined, color: Colors.red,),
                                const SizedBox(width: 10,),
                                Expanded(
                                  child: Text(
                                    faultMsg,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                    maxLines: 3,
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],

                  const SizedBox(height: 10),
                if(!deviceData.isConnected)...[
                  Card(
                    color: Colors.red[100],
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(padding:  EdgeInsets.all(12.0),
                    child: Row(
              
                      children: [
                        Icon(Icons.warning_amber_outlined, color: Colors.red,),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: Text(
                        "Device is disconnected. Please check power supply or network connection.",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 3,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                    ),
                  )
                ],
                if(deviceData.isConnected)...[
                SizedBox(height:180 ,child: _buildPhaseCard("Phase 1 (R)", deviceData.ai?[0].toDouble() ?? 0, deviceData.ai?[3].toDouble() ?? 0)),
                SizedBox(height:180 ,child: _buildPhaseCard("Phase 2 (Y)", deviceData.ai?[1].toDouble() ?? 0, deviceData.ai?[4].toDouble() ?? 0)),
                SizedBox(height:180 ,child: _buildPhaseCard("Phase 3 (B)", deviceData.ai?[2].toDouble() ?? 0, deviceData.ai?[5].toDouble() ?? 0)),
                ]
                ],
              ),
            );
            },
          ),
        ),
      ),
    );
  }
  Widget _buildPhaseCard(String title, voltage, current){
    return Card(
      color: Colors.grey.shade100,
      child:  Padding(padding:const EdgeInsets.all(16.0),
      child: LayoutBuilder(builder: (context, constraints) {
        final gaugeSize = constraints.maxWidth * 0.30;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
           const SizedBox(height: 10,),
            Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GaugeWidget(value: voltage, label: "V", height: gaugeSize,width: gaugeSize,),
                GaugeTwoWidget(value1: current, label2: "I", height: gaugeSize, width: gaugeSize,)
              ],
            ))
          ],
        );
      },),
      ),
    );
  }



}