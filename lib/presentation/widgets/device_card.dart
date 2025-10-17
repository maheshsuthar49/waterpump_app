import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:water_pump/controller/controller.dart';
import 'package:water_pump/model/devices.dart';
import 'package:water_pump/presentation/screens/device_detail.dart';
import 'package:water_pump/presentation/widgets/gauge2_widget.dart';
import 'package:water_pump/presentation/widgets/gauge_widget.dart';

import 'bottomnav_screen.dart';

class DeviceCard extends StatelessWidget {
  final DevicesData deviceData;
  const DeviceCard({required this.deviceData, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isConnected = deviceData.isConnected;
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.circle, size: 16, color: Colors.grey),
                      SizedBox(width: 10),
                      Text(
                        deviceData.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(deviceData.area, style: TextStyle(color: Colors.grey)),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: isConnected
                          ? Colors.green.shade100
                          : Colors.red.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isConnected ? "Connected" : "Disconnected",
                      style: TextStyle(
                        color: isConnected ? Color(0xff024a06) : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("Type: MANUAL"),
                  ),
                ],
              ),
            ],
          ),
          if (isConnected) ...[
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      GaugeWidget(
                        value: deviceData.ai?[0].toDouble() ?? 0,
                        label: "",
                      ),
                      Positioned(
                        top: 15,
                        right: 5,
                        child: GaugeTwoWidget(
                          value1: deviceData.ai?[3].toDouble() ?? 0,
                          label2: "R",
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      GaugeWidget(
                        value: deviceData.ai?[1].toDouble() ?? 0,
                        label: "",
                      ),
                      Positioned(
                        top: 15,
                        right: 5,
                        child: GaugeTwoWidget(
                          value1: deviceData.ai?[4].toDouble() ?? 0,
                          label2: "Y",
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      GaugeWidget(
                        value: deviceData.ai?[2].toDouble() ?? 0,
                        label: "",
                      ),
                      Positioned(
                        top: 15,
                        right: 5,
                        child: GaugeTwoWidget(
                          value1: deviceData.ai?[5].toDouble() ?? 0,
                          label2: "B",
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),

          ],
        ],
      ),
    );
  }
}
