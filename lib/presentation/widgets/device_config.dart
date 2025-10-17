import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:water_pump/controller/controller.dart';
import 'package:water_pump/model/devices.dart';

class DeviceConfig extends StatelessWidget {
  final DevicesData devicesData;
  DeviceConfig({required this.devicesData});
  final TextEditingController loopingTimeController = TextEditingController();
  String formattedTime = DateFormat('dd-MM-yyy HH:mm:ss').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Obx(() =>
          Card(
            elevation: 2,
            color: Colors.grey.shade100,
            child: Form(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [Icon(Icons.shield_outlined,color: Colors.grey.shade600,),SizedBox(width: 4,), Text("Protection", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18,),)]),
                        Switch(
                          activeColor: Color(0xff024a06),
                          value: true,
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                    Divider(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [Icon(Icons.loop,color: Colors.grey.shade600,),SizedBox(width: 4,), Text("Looping Time", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18,),)]),
                        SizedBox(
                          width: 40,
                          child:
                            TextFormField(
                              controller: loopingTimeController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 10, bottom: 10, right: 25),
                                isDense: true,
                                hintText: '5',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none
                                ),
                              ),
                          ),
                        )
                      ],
                    ),
                    Divider(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [Icon(Icons.auto_mode,color: Colors.grey.shade600,),SizedBox(width: 4,), Text("Auto Mode", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18,),)]),
                        Switch(
                          activeColor: Color(0xff024a06),
                          value: controller.power.value,
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                    Divider(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [Icon(Icons.timer_outlined,color: Colors.grey.shade600,),SizedBox(width: 4,), Text("Timer Status", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18,),)]),
                        Switch(
                          activeColor: Color(0xff024a06),
                          value: controller.power.value,
                          onChanged: (value) {},
                        ),
                      ],
                    ),Divider(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [Icon(Icons.access_time,color: Colors.grey.shade600,),SizedBox(width: 4,), Text("Time", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18,),)]),
                        Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 10,),
                          child: Text(formattedTime,style: TextStyle(fontSize: 18),textAlign: TextAlign.center,),
                        )
                      ],
                    ),
                    Divider(height: 4,),
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
                        child: Text("Save"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),)
        ],
      ),
    );
  }
}
