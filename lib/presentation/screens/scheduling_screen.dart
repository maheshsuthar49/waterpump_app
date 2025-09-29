import 'package:flutter/material.dart';

import '../../model/deivces.dart';

class SchedulingScreen extends StatelessWidget{
  final Devices device;
  SchedulingScreen({required this.device});
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Text("Schedule for ${device.name} at ${device.location}",style: TextStyle(fontSize: 25),)
        ],
      ),
    ));
  }
}