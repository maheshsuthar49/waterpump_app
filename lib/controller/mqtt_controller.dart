import 'dart:convert';

import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:water_pump/controller/Schduling_controller.dart';
import 'package:water_pump/controller/configController.dart';
import 'package:water_pump/controller/controller.dart';

import 'analoglimit_controller.dart';

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
    if (isConnected.value) {
      final fullTopic = '$maintopic/$topic/$uuid/config';
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

  void get_time(String uuid) {
    if (isConnected.value) {
      final fullTopic = '$maintopic/$topic/$uuid';
      final Map<String, dynamic> command = {
        "type": "command",
        "id": 1,
        "cmd": "get_time",
      };
      final String payload = jsonEncode(command);
      final builder = MqttClientPayloadBuilder();
      builder.addString(payload);
      try {
        client.publishMessage(fullTopic, MqttQos.atLeastOnce, builder.payload!);
        print("Published command to $fullTopic : $payload");
      } catch (e) {
        print("Published is Failed: $e");
      }
    }
  }

  void set_Time({
    required String uuid,
    required int slotIndex,
    required bool isEnable,
    required fromMinutes,
    required toMinutes,
  }) {
    if (isConnected.value) {
      final fullTopic = '$maintopic/$topic/$uuid';
      final valuePayload =
          "${slotIndex.toString().padLeft(2, '0')},${isEnable ? 1 : 0},${fromMinutes.toString().padLeft(4, "0")},${toMinutes.toString().padLeft(4, "0")}";
      ;
      final Map<String, dynamic> command = {
        "type": "config",
        "id": 1,
        "key": "stime",
        "value": valuePayload,
      };
      final String payload = jsonEncode(command);
      final builder = MqttClientPayloadBuilder();
      builder.addString(payload);
      try {
        client.publishMessage(fullTopic, MqttQos.atLeastOnce, builder.payload!);
        print("Published Command to $fullTopic : $payload");
      } catch (e) {
        print("Published is Failed: $e");
      }
    }
  }

  void controlPublish(String uuid, int value) {
    if (isConnected.value) {
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
      try {
        client.publishMessage(fullTopic, MqttQos.atLeastOnce, builder.payload!);
        print("Published command to $fullTopic : $payload");
      } catch (e) {
        print("Published failed : $e");
      }
    } else {
      print("Mqtt not Connected , Cannot published Command");
    }
  }

///Device Config
void get_config (String uuid){
    if(isConnected.value){
      final fullTopic = '$maintopic/$topic/$uuid';
      final Map<String, dynamic> command = {
        "type": "command",
        "id": 1,
        "cmd": "get_config",
      };
      final String payload = jsonEncode(command);
      final builder = MqttClientPayloadBuilder();
      builder.addString(payload);
      try {
        client.publishMessage(fullTopic, MqttQos.atLeastOnce, builder.payload!);
        print("Published command to $fullTopic : $payload");
      } catch (e) {
        print("Published is Failed: $e");
      }
    }
}
void deviceConfig(String uuid, String key, String value){
    if(isConnected.value){
      final fullTopic = "$maintopic/$topic/$uuid";
      final Map<String, dynamic> command = {
        "type": "config",
        "id": 1,
        "key": key,
        "value": value,
      };
      final String payload = jsonEncode(command);
      final builder = MqttClientPayloadBuilder();
      builder.addString(payload);
      try{
        client.publishMessage(fullTopic, MqttQos.atLeastOnce, builder.payload!);
        print("Published config command to $fullTopic : $payload");
      }catch (e){
        print("Config published failed: $e");
      }
    }else{
      print("Mqtt not connected, cannot send config command");

    }
}

///Analog Limit
  analogLimitsConfig(String uuid , String value) {
    final fullTopic = "$maintopic/$topic/$uuid";
    final Map<String, dynamic> command = {
      "type": "config",
      "id": 1,
      "key": "analog",
      "value": value,
    };
    final String payload = jsonEncode(command);
    final builder = MqttClientPayloadBuilder();
    builder.addString(payload);
    if (isConnected.value) {
      try {
        client.publishMessage(fullTopic, MqttQos.atLeastOnce, builder.payload!);
        print("Published config command to $fullTopic : $payload");
      } catch (e) {
        print("Config published failed: $e");
      }
    }else{
      print("Mqtt not connected, cannot send config command");

    }
  }

  analogLimitMulti(String uuid , String value){
    final fullTopic = "$maintopic/$topic/$uuid";
    final Map<String, dynamic> command = {
      "type": "config",
      "id": 1,
      "key": "multpl",
      "value": value,
    };
    final String payload = jsonEncode(command);
    final builder = MqttClientPayloadBuilder();
    builder.addString(payload);
    if(isConnected.value){
      try{
        client.publishMessage(fullTopic, MqttQos.atLeastOnce, builder.payload!);
        print("Publish Config command to $fullTopic : $payload");
      }catch (e){
        print("Config published failed: $e ");
      }
    }else{
      print("Mqtt is not connected, cannot send config command");
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
      print("Message String = $message");
      try {
        final jsonData = jsonDecode(message);
        if (jsonData["type"] == 'data') {
          final deviceList = jsonData['devices'] as List;
          final controller = Get.find<TaskController>();

          final fullTopic = c[0].topic;
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
              controller.updatePowerOnOff(device);
            }
          }
        } else if (jsonData["type"] == 'time' && jsonData['key'] == 'stime') {
          if (Get.isRegistered<SchedulingController>()) {
            final schedulingController = Get.find<SchedulingController>();
            schedulingController.processScheduleData(jsonData['value']);
          }
        }else if(jsonData["type"] == 'config'){
          if (Get.isRegistered<ConfigController>()) {
            final configController = Get.find<ConfigController>();
            configController.updateConfig(jsonData);
          }

          if (Get.isRegistered<AnalogLimitController>()) {
            final analogController = Get.find<AnalogLimitController>();
            analogController.updateAnalogLimitData(jsonData);

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
