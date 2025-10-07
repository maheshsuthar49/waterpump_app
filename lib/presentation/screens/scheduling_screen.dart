import 'package:flutter/material.dart';
import 'package:water_pump/model/devices.dart';


class SchedulingScreen extends StatelessWidget{
  final DevicesData deviceData;
  SchedulingScreen({required this.deviceData});
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Text("Schedule for ${deviceData.name} at ${deviceData.area}",style: TextStyle(fontSize: 25),)
        ],
      ),
    ));
  }
}