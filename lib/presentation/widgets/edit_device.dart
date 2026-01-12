import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_pump/controller/controller.dart';
import 'package:water_pump/model/devices.dart';
import 'package:water_pump/shared/component.dart';
import 'package:water_pump/shared/custome_button.dart';

class EditDevice extends StatelessWidget {
 final  TextEditingController deviceNameController = TextEditingController();
  final TextEditingController deviceLocController = TextEditingController();
  final TextEditingController deviceFlowController = TextEditingController();
  final controller = Get.find<TaskController>();
  final DevicesData devicesData;
  EditDevice({super.key, required this.devicesData});
  @override
  Widget build(BuildContext context) {
    deviceNameController.text = devicesData.name;
    deviceLocController.text = devicesData.area;
    deviceFlowController.text = devicesData.flowMultiplier.toString();
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
                   const Text(
                      "Service Expire",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                   const SizedBox(height: 10),
                    Text(
                      controller.formatDate(devicesData.expDate),
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Device Name",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    customTextFormField(
                      controller: deviceNameController,
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.devices,
                    ),
                   const SizedBox(height: 10),
                   const Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    customTextFormField(
                      controller: deviceLocController,
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.location_on,
                    ),
                   const SizedBox(height: 10),
                    const Text(
                      "Flow Multiplier",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    customTextFormField(
                      controller: deviceFlowController,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.water_drop,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(text: "Update", onPressed: () {

                      },),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
