import 'package:flutter/material.dart';
import 'package:water_pump/shared/component.dart';

class EditDevice extends StatelessWidget {
  TextEditingController DeviceNameController = TextEditingController();
  TextEditingController DeviceLocController = TextEditingController();
  TextEditingController DeviceFlowController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
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
                    "Jan 1,2027",
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
      ),
    );
  }
}
