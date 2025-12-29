import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:water_pump/controller/configController.dart';
import 'package:water_pump/controller/controller.dart';
import 'package:water_pump/model/devices.dart';

class DeviceConfig extends StatefulWidget {
  final DevicesData devicesData;
  DeviceConfig({required this.devicesData});

  @override
  State<DeviceConfig> createState() => _DeviceConfigState();
}

class _DeviceConfigState extends State<DeviceConfig> {
  final TextEditingController loopingTimeController = TextEditingController();
  final ConfigController configController = Get.put(ConfigController());
  late Timer _timer;
  String currentTime = '';

  @override
  void initState() {
    super.initState();
    configController.fetchConfig(widget.devicesData.uuid.toString());
    _updateTime();
    _startClock();
  }
  void _updateTime() {
    setState(() {
      currentTime = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());
    });
  }
  void _startClock() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }
  @override
  void dispose() {
    _timer.cancel();
    loopingTimeController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();
    return Padding(
      padding: EdgeInsets.all(16.0),
      child:
      Obx(() {
        if(configController.isLoading.value){
          return Center(child: CircularProgressIndicator(color: Color(0xff024a06),),);
        }
        final isUpdating = configController.isConfigUpdate.value;
        if(loopingTimeController.text != configController.lpt.value){
          loopingTimeController.text = configController.lpt.value;
        }
       return ListView(
          children: [
              Stack(
                children: [
                  Opacity(
                    opacity: isUpdating ? 0.5 : 1.0,
                    child: AbsorbPointer(
                      absorbing: isUpdating,
                      child: Card(
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
                                      value: configController.prot.value,
                                      onChanged: (val) {
                                        _showConfirmationDialog(title: "Confirm Change", message: "Do you want to turn ${val ? "On" : "Off"} Protection ?", onConfirm: () {
                                          configController.prot.value = val;
                                          configController.updateConfigVal(widget.devicesData.uuid.toString(), "prot", val ? "1" : "0");

                                        },);
                                      },
                                    ),
                                  ],
                                ),
                              const Divider(height: 4,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [ Icon(Icons.loop,color: Colors.grey.shade600,),const SizedBox(width: 4,), const Text("Looping Time", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18,),)]),
                                    SizedBox(
                                      width: 50,
                                      child:
                                      TextFormField(
                                        controller: loopingTimeController..text = configController.lpt.value,
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        onFieldSubmitted: (value) {
                                          _showConfirmationDialog(
                                            title: "Confirm Change",
                                            message: "Do you want to set Looping Time to $value?",
                                            onConfirm: () {

                                              configController.lpt.value = value;
                                              configController.updateConfigVal(widget.devicesData.uuid.toString(), "lpt", value);

                                            },
                                          );
                                        },

                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(top: 10, bottom: 10, right: 24),
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
                               const Divider(height: 4,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [Icon(Icons.auto_mode,color: Colors.grey.shade600,),const SizedBox(width: 4,), const Text("Auto Mode", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18,),)]),
                                    Switch(
                                      activeColor: Color(0xff024a06),
                                      value: configController.amode.value,
                                      onChanged: (val) {
                                        _showConfirmationDialog(title: "Confirm Change", message: "Do you want to turn ${val ? "On" : "Off"} Auto Mode ?", onConfirm: () {
                                          configController.amode.value = val;
                                          configController.updateConfigVal(widget.devicesData.uuid.toString(), "amode", val ? "1" : "0");

                                        },);
                                      },
                                    ),
                                  ],
                                ),
                                const Divider(height: 4,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [Icon(Icons.timer_outlined,color: Colors.grey.shade600,),const SizedBox(width: 4,), const Text("Timer Status", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18,),)]),
                                    Switch(
                                      activeColor: Color(0xff024a06),
                                      value: configController.timer.value,
                                      onChanged: (val) {
                                        _showConfirmationDialog(title: "Confirm Change", message: "Do you want to turn ${val ? "On" : "Off"} Timer Status ?", onConfirm: () {
                                          configController.timer.value = val;
                                          configController.updateConfigVal(widget.devicesData.uuid.toString(), "timer", val ? "1" : "0");

                                        },);
                                      },
                                    ),
                                  ],
                                ),
                                const Divider(height: 4,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [Icon(Icons.access_time,color: Colors.grey.shade600,),const SizedBox(width: 4,), const Text("Time", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18,),)]),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10,bottom: 10,),
                                      child: Text( currentTime),
                                    )
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if(isUpdating)
                    Positioned.fill(child: Center(
                      child: Container(
                        width: 30,height: 30,
                        child: CircularProgressIndicator(color: Color(0xff024a06),),
                      ),
                    ))
                ],
              )

          ],
        );
      },
      ),
    );
  }

  Future<void> _showConfirmationDialog({
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel",style: TextStyle(color: Colors.black),),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xff024a06)),
            onPressed: () => Navigator.pop(context, true),
            child: Text("Yes",style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (result == true) onConfirm();
  }
}
