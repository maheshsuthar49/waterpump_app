import 'package:flutter/material.dart';

class SchedulingScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       Center(child: Text("Schedule is pending",style: TextStyle(fontSize: 25),))
      ],
    ));
  }
}