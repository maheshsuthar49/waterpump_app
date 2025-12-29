import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_pump/binding/all_binding.dart';
import 'package:water_pump/controller/controller.dart';
import 'package:water_pump/controller/mqtt_controller.dart';
import 'package:water_pump/firebase_options.dart';
import 'package:water_pump/presentation/screens/welcome_screen.dart';
import 'package:water_pump/services/calling_service.dart';
import 'package:water_pump/services/notification_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (!Get.isRegistered<MqttController>()) {
    Get.put(MqttController(), permanent: true);
  }
  if (!Get.isRegistered<TaskController>()) {
    Get.put(TaskController(), permanent: true);
  }
  final taskController = Get.find<TaskController>();
  if (taskController.devices.isEmpty) {
    final token = taskController.box.read('token');
    if (token != null) {
      await taskController.fetchDeviceAll(token);
    }
  }
  if(message.data['type'] == "21"){
    await CallingService().showCallKitIncoming(message.data['uuid'], message);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(MqttController(),permanent: true);
  await GetStorage.init();
  Get.put(TaskController(),permanent: true);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  // This widget is the root of your application.
  final NotificationService notificationService = NotificationService();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await CallingService().checkActiveCall();
    },);
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.resumed){
      CallingService().checkActiveCall();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AllBinding(),
      debugShowCheckedModeBanner: false,
      title: 'Water Pump',
      theme: ThemeData(useMaterial3: true),
      home: WelcomeScreen(),
    );
  }
}

