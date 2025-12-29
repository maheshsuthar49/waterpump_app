import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_pump/controller/controller.dart';

class MapScreen extends StatelessWidget {
  final TaskController controller = Get.find<TaskController>();
  MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Connected Devices")),
      body: Obx(() {
        // Agar list khali hai to loading ya empty message dikhayein
        if (controller.connectedList.isEmpty) {
          return const Center(child: Text("No connected devices found."));
        }

        // List ko readable format mein print karne ke liye ListView use karein
        return ListView.builder(
          itemCount: controller.connectedList.length,
          itemBuilder: (context, index) {
            final device = controller.connectedList[index];
            return ListTile(
              leading: const Icon(Icons.router, color: Colors.green),
              title: Text(device.name), // DevicesData model se name field
              subtitle: Text("UUID: ${device.uuid}"),
              trailing: const Icon(Icons.check_circle, color: Colors.green),
            );
          },
        );
      }),
    );
  }
}