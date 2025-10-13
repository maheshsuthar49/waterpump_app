import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:water_pump/controller/controller.dart';
import 'package:water_pump/model/devices.dart';
import 'package:water_pump/shared/component.dart';

class EditDevice extends StatelessWidget {
  TextEditingController DeviceNameController = TextEditingController();
  TextEditingController DeviceLocController = TextEditingController();
  TextEditingController DeviceFlowController = TextEditingController();
  final controller = Get.find<TaskController>();
  final DevicesData devicesData;
  EditDevice({required this.devicesData});
  @override
  Widget build(BuildContext context) {
  DeviceNameController.text = devicesData.name;
  DeviceLocController.text = devicesData.area;
  DeviceFlowController.text = devicesData.flowMultiplier.toString();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Card(
            elevation: 2,
            color: Colors.grey.shade100,
            child: Form(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Service Expire",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      controller.formatDate(devicesData.expDate),
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Device Name",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    CustomTextFormField(
                      controller: DeviceNameController,
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.devices,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Location",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    CustomTextFormField(
                      controller: DeviceLocController,
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.location_on,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Flow Multiplier",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    CustomTextFormField(
                      controller: DeviceFlowController,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.water_drop,
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff024a06),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: Text("Update"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      )
    );
  }
}
