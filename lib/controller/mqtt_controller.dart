import 'dart:convert';

import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:water_pump/controller/controller.dart';

class MqttController extends GetxController {
  var latestMessage = "".obs;
  late MqttServerClient client;
  var isConnected = false.obs;
  final String maintopic = 'vidani';
  final String topic = "mc";
  Stream<List<MqttReceivedMessage<MqttMessage>>>? _messages;
  Stream<List<MqttReceivedMessage<MqttMessage>>>? get messages => _messages;

  final broker = 'wss://mc.shreeiot.com/mqtt';
  final int port = 443;
  final String username = '';
  final String password = "";
  final String clientIdentifier =
      "flutter_${DateTime.now().millisecondsSinceEpoch}";

  @override
  void onInit() {
    super.onInit();
    _connect();
  }

  Future<void> _connect() async {
    client = MqttServerClient(broker, clientIdentifier);
    client.port = 443;
    client.useWebSocket = true;
    client.logging(on: true);
    client.keepAlivePeriod = 20;

    client.websocketProtocols = ['mqtt'];

    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.pongCallback = pong;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier(clientIdentifier)
        .startClean()
        .keepAliveFor(20)
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;

    try {
      print("Connecting to $broker...");
      await client.connect();
    } catch (e) {
      print('Mqtt Connection failed: $e');
      client.disconnect();
    }
  }

  void subscribeToDevice(String uuid) {
    if (isConnected.value) {
      final fullTopic = '$maintopic/$topic/$uuid/data';
      try {
        client.subscribe(fullTopic, MqttQos.atLeastOnce);
        print("Subscribed to $fullTopic");
      } catch (e) {
        print("Subscribed data error: $e");
      }
    } else {
      print('Mqtt not connected, cannot Subscribed');
    }
  }

  void GetDataPublish(String uuid, int value) {
  if(isConnected.value){
    final fullTopic = '$maintopic/$topic/$uuid';
    final Map<String, dynamic> command = {
      "type": "control",
      "id": 1,
      "key": 1,
      "value": value,
    };
    final String payload = jsonEncode(command);
    final builder = MqttClientPayloadBuilder();
    builder.addString(payload);
    try{
      client.publishMessage(fullTopic, MqttQos.atLeastOnce, builder.payload!);
      print("Published command to $fullTopic : $payload");
    }catch(e){
      print("Published failed : $e");
    }
  }else{
    print("Mqtt not Connected , Cannot published Command");
  }
  }

  void connect() {
    client.connect();
  }

  void disconnect() {
    client.disconnect();
  }

  void onConnected() {
    print("Connected to Mqtt broker!");
    isConnected.value = true;
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      final String message = MqttPublishPayload.bytesToStringAsString(
        recMess.payload.message,
      );
      latestMessage.value = message;

      try {
        final jsonData = jsonDecode(message);
        if (jsonData["type"] == 'data') {
          final deviceList = jsonData['devices'] as List;
          final controller = Get.find<TaskController>();

          final fullTopic = c[0].topic; // e.g., vidani/mc/862360073397494/data
          final topicParts = fullTopic.split('/');
          final mqttUuid = int.tryParse(topicParts[2]);

          if (mqttUuid != null) {
            // find Uuid in Api Devices.
            final index = controller.devices.indexWhere(
              (d) => d.uuid == mqttUuid,
            );
            if (index != -1) {
              final device = controller.devices[index];
              final dev = deviceList[0];
              device.ai = List<int>.from(dev["ai"]);
              device.di = List<int>.from(dev["di"]);
              device.doo = List<int>.from(dev["do"]);
              device.flt = List<int>.from(dev["flt"]);
              device.isConnected = true;

              controller.devices[index] = device;
              controller.devices.refresh();
              controller.updateCount();
              // Debug print
              print(
                "Updated Device: ${device.name}, UUID: ${device.uuid}, AI: ${device.ai},AI = 1 : ${device.ai?[0]}, DI: ${device.di}, DO: ${device.doo}, FLT: ${device.flt}",
              );
            }
          }
        }
      } catch (e) {
        print("Mqtt message parse error: $e");
      }
    });
  }

  void onDisconnected() {
    print("Disconnected form Mqtt Broker!");
    isConnected.value = false;
  }

  void onSubscribed(String fulltopic) {
    print("Subscribed to topic: $fulltopic");
  }

  void pong() {
    print('Ping response received');
  }
}
