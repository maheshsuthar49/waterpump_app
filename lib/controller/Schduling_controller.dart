import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_pump/controller/mqtt_controller.dart';

class ScheduleSlot {
  var isEnable = false.obs;
  String fromTime;
  String toTime;
  ScheduleSlot({
    required bool enable,
    required this.fromTime,
    required this.toTime,
  }) {
    isEnable.value = enable;
  }
}

class SchedulingController extends GetxController {
  final MqttController mqttController = Get.find<MqttController>();
  var isLoading = true.obs;
  var slots = <ScheduleSlot>[].obs;

  late List<TextEditingController> fromTimeController;
  late List<TextEditingController> toTimeController;

  @override
  void onClose() {
    for(var controller in fromTimeController){
      controller.dispose();
    }
    for(var controller  in toTimeController){
      controller.dispose();
    }
    super.onClose();
  }
  //fetch schedule initial
  void fetchSchedule (String uuid){
    isLoading.value = true;
    mqttController.get_time(uuid);
  }

  //Process data receive fromm mqtt
void processScheduleData(List<dynamic> scheduleValues){
    try{
      slots.clear();
      fromTimeController = [];
      toTimeController = [];

      for(var value in scheduleValues){
        final parts = value.toString().split(",");
        if(parts.length == 3){
          final isEnable = parts[0] == "1";
          final fromMinutes = int.tryParse(parts[1]) ?? 0;
          final toMinutes = int.tryParse(parts[2]) ?? 0;

          final fromTime = _minutesToHHmm(fromMinutes);
          final toTime = _minutesToHHmm(toMinutes);

          slots.add(ScheduleSlot(enable: isEnable, fromTime: fromTime, toTime: toTime));
          fromTimeController.add(TextEditingController(text: fromTime));
          toTimeController.add(TextEditingController(text: toTime));
        }
      }
    }catch(e){
      print("Error to processing data:$e");
    }finally{
      isLoading.value = false;
    }
}

//update  schedule
  Future<void> updateSchedule(String uuid, int slotIndex) async{
    final slot = slots[slotIndex];
    final fromTime = fromTimeController[slotIndex].text;
    final toTime = toTimeController[slotIndex].text;

    final fromMinutes = _HHmmToMinutes(fromTime);
    final toMinutes = _HHmmToMinutes(toTime);

    mqttController.set_Time(uuid: uuid, slotIndex: slotIndex, isEnable: slot.isEnable.value, fromMinutes: fromMinutes, toMinutes: toMinutes);

    await Future.delayed(Duration(seconds: 1));
    fetchSchedule(uuid);
  }


///Helper for convert total minutes into HH:mm
String _minutesToHHmm(int minutes){
    if(minutes < 0 || minutes > 1440) return "00:00";
    final hour = minutes ~/ 60;
    final mins= minutes % 60;

    return "${hour.toString().padLeft(2,'0')}:${mins.toString().padLeft(2,"0")}";
}

///Helper font convert HH:mm into total minutes
int _HHmmToMinutes(String time){
    try{
      final parts = time.split(':');
      if(parts.length != 2) return 0;
      final hours = int.tryParse(parts[0]) ?? 0;
      final minutes = int.tryParse(parts[1]) ?? 0;
      return hours * 60 + minutes;
    }catch (e){
      return 0;
    }
  }

  //show time picker
Future<void> selectTime(BuildContext context, TextEditingController controller) async{
    final now = TimeOfDay.now();
    final selectedTime = await showTimePicker(context: context, initialTime: now);
    if(selectedTime != null){
      final totalMiutes = selectedTime.hour * 60 + selectedTime.minute;
      controller.text = _minutesToHHmm(totalMiutes);
    }
}
}
