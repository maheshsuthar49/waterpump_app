import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:water_pump/controller/controller.dart';

class OngoingCallScreen extends StatefulWidget {
  final Map<dynamic, dynamic> data;
  const OngoingCallScreen({super.key, required this.data});

  @override
  State<OngoingCallScreen> createState() => _OngoingCallScreenState();
}

class _OngoingCallScreenState extends State<OngoingCallScreen>  with SingleTickerProviderStateMixin{
  late AnimationController _animationController ;
  final TaskController controller = Get.find<TaskController>();
  int _second = 0;
  Timer? _timer;
  Timer? _speakTimer;
  bool _callActive = true;
  final bool _isLoadingData = false;

  final FlutterTts _flutterTts = FlutterTts();
  String faultMag = '';
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    _startTimer();

    _initMsgSpeak();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _second++;
      });
    });
  }

  String get formattedTime {
    final minutes = (_second ~/ 60).toString().padLeft(2, '0');
    final seconds = (_second % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Future<void> _initMsgSpeak() async {
    if (controller.devices.isEmpty) {
      String? token = controller.box.read('token');
      if (token != null) {
        await controller.fetchDeviceAll(token);
      }
    }

    final device = controller.devices.firstWhereOrNull(
          (d) => d.uuid.toString() == widget.data['uuid'],
    );

    if (device == null) {
      faultMag = 'There is a fault detected in your device';
    } else {
      faultMag = controller.buildFaultMessage(device);
      if (faultMag.isEmpty) {
        faultMag = 'There is a fault detected in your device';
      }
    }

    await _flutterTts.setLanguage("en-IN");
    await _flutterTts.setSpeechRate(0.45);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);

    await _flutterTts.speak(faultMag);

    _flutterTts.setCompletionHandler(() {
      if(!_callActive)return;
      _speakTimer = Timer(
        const Duration(milliseconds: 500),
        () {
          if(_callActive){
            _initMsgSpeak();
          }
        },
      );
    });
  }

  @override
  void dispose() {
    _callActive = false;
    _timer?.cancel();
    _speakTimer?.cancel();
    _flutterTts.stop();
    _animationController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff024a06),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      _buildAnimation(250),
                      _buildAnimation(200),
                      _buildAnimation(150),
                      _buildAnimation(100),
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, size: 60, color: Colors.white),
                      ),
                    ],
                  ),
                  Text(
                    widget.data['device_name'] ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.data['uuid'],
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    formattedTime,
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),

              const SizedBox(height: 40),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                width: 180,
                decoration: BoxDecoration(
                  color: Colors.grey[500],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.volume_up_sharp, color: Colors.white, size: 20),
                    const SizedBox(width: 5),
                    Text(
                      "Fault message...",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              FloatingActionButton.large(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                onPressed: () async {
                  _callActive = false;
                  await FlutterCallkitIncoming.endAllCalls();
                  Get.back();
                },
                child: const Icon(
                  Icons.call_end,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildAnimation(double size){
    return AnimatedBuilder(animation: _animationController, builder: (_, _) {
      return Transform.scale(
        scale: _animationController.value,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green.withOpacity(
              1.0 - _animationController.value,
            ),
          ),
        ),
      );
    },);
  }
}
