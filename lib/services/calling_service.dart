import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../controller/controller.dart';
import '../presentation/screens/ongoing_call_Screen.dart';
import '../presentation/widgets/bottomnav_screen.dart';

class CallingService{
  static final CallingService _instance = CallingService._internal();
  factory CallingService()=> _instance;
  CallingService._internal(){
    listenCallEvent();
  }

  //Incoming Call
  Future<void> showCallKitIncoming(String uuid, RemoteMessage message) async {

    await FlutterCallkitIncoming.canUseFullScreenIntent();
    final String callId = const Uuid().v4();
    CallKitParams params = CallKitParams(
      id: callId,
      nameCaller: "Gudipadara airtel ",
      appName: "Water pump",
      avatar: Icon(Icons.person).toString(),
      handle: uuid,
      type: 0,
      duration: 30000,
      textAccept: "Accept",
      textDecline: "Decline",
      extra: <String, dynamic>{'type': "21", "uuid": uuid, "device_name": "Gudipadara airtel "},
      android: AndroidParams(
        isCustomNotification: true,
        isShowCallID: true,
        isShowLogo: false,
        ringtonePath: 'system_ringtone_default',
        backgroundColor: '#024A06',
        actionColor: '#4CAF50',
        incomingCallNotificationChannelName: "Incoming Call",
      ),
    );
    await FlutterCallkitIncoming.showCallkitIncoming(params);

  }

  void listenCallEvent() {
    FlutterCallkitIncoming.onEvent.listen((CallEvent? event) {
      if (event == null) return;
      switch (event.event) {
        case Event.actionCallAccept:
          if(event.body != null){
            Get.to(() => OngoingCallScreen(data: event.body['extra']));
          }
          break;

        case Event.actionCallDecline:
          if (event.body['extra'] != null && event.body != null) {
            handleCallAction(event.body['extra']);
          }
        case Event.actionCallEnded:
          if (event.body['extra'] != null && event.body != null) {
            handleCallAction(event.body['extra']);
          }
          break;
        default:
          break;
      }
    });
  }

 Future<void> handleCallAction(Map data) async{
   if (data['type'] != "21") return;

   final TaskController controller = Get.find<TaskController>();

   if (controller.devices.isEmpty) {
     String? token = controller.box.read('token');
     if (token != null) {
       await controller.fetchDeviceAll(token);
     }
   }

   try {
     final device = controller.devices.firstWhere(
           (d) => d.uuid.toString() == data['uuid'],
     );

     controller.index.value = 0;
     Get.to(() => BottomNavScreen(selectedDevice: device));
   } catch (_) {}
 }

  Future<void> checkActiveCall() async {
    var calls = await FlutterCallkitIncoming.activeCalls();
    if (calls is List && calls.isNotEmpty) {
      Get.to(OngoingCallScreen(data: calls[0]['extra']));
    }
  }
}