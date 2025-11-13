import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_pump/controller/Schduling_controller.dart';
import 'package:water_pump/shared/custome_button.dart';

class scheduleSlotCard extends StatelessWidget {
  final int slotIndex;
  final String deviceUuid;
  final SchedulingController schedulingController;

  scheduleSlotCard({
    required this.slotIndex,
    required this.deviceUuid,
    required this.schedulingController,
  });
  @override
  Widget build(BuildContext context) {
    final slot = schedulingController.slots[slotIndex];
    return Card(
      elevation: 2,
      color: Colors.grey.shade100,
      child: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Slot ${slotIndex + 1}",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade600,
                  fontSize: 18,
                ),
              ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 _slotTimeField(context, 'Form', schedulingController.fromTimeController[slotIndex]),
                 SizedBox(width: 10,),
                 _slotTimeField(context, "To", schedulingController.toTimeController[slotIndex])
               ],
             ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: CustomButton(text: "Update", onPressed: () {
                  schedulingController.updateSchedule(deviceUuid, slotIndex);
                },)
              ),
            ],
          ),
        ),
      ),
    );
  }

  //helper for text-field
Widget _slotTimeField(BuildContext context, String label, TextEditingController textController){
    return Expanded(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),),
        TextFormField(
          controller: textController,
          readOnly: true,
          onTap:() => schedulingController.selectTime(context, textController),
          decoration: InputDecoration(
            hintText: "--:--",
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            suffixIcon: Icon(Icons.access_time, color: Colors.grey.shade100,)
          ),
        )
      ],
    ));
}
}
