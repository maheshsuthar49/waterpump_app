import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_pump/controller/Schduling_controller.dart';
import 'package:water_pump/model/devices.dart';
import 'package:water_pump/presentation/widgets/scheduleSlot_card.dart';

class SchedulingScreen extends StatefulWidget {
  final DevicesData deviceData;
  const SchedulingScreen({super.key, required this.deviceData});

  @override
  State<SchedulingScreen> createState() => _SchedulingScreenState();
}

class _SchedulingScreenState extends State<SchedulingScreen> {
  final SchedulingController schedulingController = Get.put(
    SchedulingController(),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      schedulingController.fetchSchedule(widget.deviceData.uuid.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        if (schedulingController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: Color(0xff024a06)),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: schedulingController.slots.length,
            itemBuilder: (context, index) {
              return scheduleSlotCard(
                slotIndex: index,
                deviceUuid: widget.deviceData.uuid.toString(),
                schedulingController: schedulingController,
              );
            },
          ),
        );
      }),
    );
  }
}
