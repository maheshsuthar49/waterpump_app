import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:water_pump/controller/controller.dart';
import 'package:water_pump/presentation/screens/device_detail.dart';
import 'package:water_pump/presentation/widgets/gauge2_widget.dart';
import 'package:water_pump/presentation/widgets/gauge_widget.dart';

import 'bottomnav_screen.dart';

class DeviceCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.circle, size: 16, color: Colors.grey,),
                      SizedBox(width: 10),
                      Text("Jyoti", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text("Pune", style: TextStyle(color: Colors.grey)),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("Connecting...",style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("Type: MANUAL",),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             Expanded(child: GaugeWidget(value: 320, label: "R")),
             Expanded(child: GaugeWidget(value: 240, label: "Y")),
             Expanded(child: GaugeWidget(value: 40, label: "B")),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: GaugeTwoWidget(value1: 150, label2: "R")),
              Expanded(child: GaugeTwoWidget(value1: 250, label2: "Y")),
              Expanded(child: GaugeTwoWidget(value1: 350, label2: "B")),
            ],
          )
        ],
      ),
    );
  }
}
