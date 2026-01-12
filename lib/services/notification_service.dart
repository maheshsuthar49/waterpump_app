import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:water_pump/controller/controller.dart';
import 'package:water_pump/presentation/widgets/bottomnav_screen.dart';
import 'package:water_pump/services/calling_service.dart';


class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();
  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      //print("User granted Permission ");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      //print("User granted provisional permission");
    } else {
      AppSettings.openAppSettings();
     // print("User permission denied");
    }
  }

  void initialNotification(BuildContext context, RemoteMessage message) async {
    var androidInitialization = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    var iOSInitialization = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: androidInitialization,
      iOS: iOSInitialization,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        handleMessage(message);
      },
    );
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      //print(message.notification!.title.toString());
      //print(message.notification!.body.toString());
      //print(message.data.toString());
      //print(message.data["type"]);
      //print(message.data["id"]);

      if (Platform.isAndroid) {
        initialNotification(context, message);
        showNotification(message);
        CallingService().showCallKitIncoming(message.data['uuid'], message);
      } else {
        showNotification(message);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    if (message.notification == null) return;
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      "high_importance_channel",
      "High Importance Notifications",
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
      showBadge: true,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          channel.id.toString(),
          channel.name.toString(),
          channelDescription: "Water pump fcm",
          importance: Importance.high,
          priority: Priority.high,
          ticker: "ticker",
        );

    DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
          presentSound: true,
          presentAlert: true,
          presentBadge: true,
        );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(
      Duration.zero,
      () => _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      ),
    );
  }

  Future<void> setUpInteractMessage(BuildContext context) async {
    //When app is terminated
    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();

    if (initialMessage != null) {
      handleMessage(initialMessage);
    }

    //when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(message);
    });
  }




  Future<void> handleMessage(RemoteMessage message) async {
    await _navigateToDevice(message.data['uuid'], message.data['type']);
  }

  Future<void> _navigateToDevice(String? uuid, String? type) async {
    if (type != "21" || uuid == null) return;
    final TaskController controller = Get.find<TaskController>();
    if (controller.devices.isEmpty) {
      String? token = controller.box.read('token');
      if (token != null) {
        await controller.fetchDeviceAll(token);
      } else {
        //debugPrint("token not found");
      }
    }
    try {
      final device = controller.devices.firstWhere(
        (d) => d.uuid.toString() == uuid,
      );
      controller.index.value = 0;

      Get.to(() => BottomNavScreen(selectedDevice: device));
    } catch (e) {
      //debugPrint("Device not found:= $e");
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }
}
