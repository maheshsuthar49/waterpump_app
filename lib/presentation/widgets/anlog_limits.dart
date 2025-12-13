import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_pump/controller/analoglimit_controller.dart';
import 'package:water_pump/controller/controller.dart';
import 'package:water_pump/controller/mqtt_controller.dart';
import 'package:water_pump/presentation/widgets/analog_card.dart';

import '../../model/devices.dart';

class AnalogLimits extends StatefulWidget {
  final DevicesData devicesData;
  AnalogLimits({required this.devicesData});
  @override
  State<AnalogLimits> createState() => _AnalogLimitsState();
}

class _AnalogLimitsState extends State<AnalogLimits> {
  int? expendedTileIndex;
  final controller = Get.find<TaskController>();
  final MqttController mqttController = Get.find<MqttController>();
  final AnalogLimitController analogLimitController = Get.put(
    AnalogLimitController(),
  );
  final List<TextEditingController> _minControllers = List.generate(
    20,
    (_) => TextEditingController(),
  );
  final List<TextEditingController> _maxControllers = List.generate(
    20,
    (_) => TextEditingController(),
  );
  final List<TextEditingController> _multiControllers = List.generate(
    20,
    (_) => TextEditingController(),
  );

  final List<Map<String, dynamic>> _cardsMetaData = [
    {'tile': 'Voltage(R)', 'icon': Icons.bolt, 'color': Color(0xff024a06)},
    {'tile': 'Voltage(Y)', 'icon': Icons.bolt, 'color': Color(0xff024a06)},
    {'tile': 'Voltage(B)', 'icon': Icons.bolt, 'color': Color(0xff024a06)},
    {'tile': 'Current(R)', 'icon': Icons.power, 'color': Colors.blue},
    {'tile': 'Current(Y)', 'icon': Icons.power, 'color': Colors.blue},
    {'tile': 'Current(B)', 'icon': Icons.power, 'color': Colors.blue},
    {'tile': 'Imbalance voltage(R-Y)', 'icon': Icons.bolt, 'color': Color(0xff024a06)},
    {'tile': 'Imbalance voltage(Y-B)', 'icon': Icons.bolt, 'color': Color(0xff024a06)},
    {'tile': 'Imbalance voltage(B-R)', 'icon': Icons.bolt, 'color': Color(0xff024a06)},
    {'tile': 'Imbalance current(R-Y)', 'icon': Icons.power, 'color': Colors.blue},
    {'tile': 'Imbalance current(Y-B)', 'icon': Icons.power, 'color': Colors.blue},
    {'tile': 'Imbalance current(B-R)', 'icon': Icons.power, 'color': Colors.blue},
    {'tile': 'Technical fault(R)', 'icon': Icons.error, 'color': Colors.red},
    {'tile': 'Technical fault(Y)', 'icon': Icons.error, 'color': Colors.red},
    {'tile': 'Technical fault(B)', 'icon': Icons.error, 'color': Colors.red},
    {'tile': '', },
    {'tile': '', },
    {'tile': '', },
    {'tile': '', },
    {'tile': 'Phase reverse', 'icon': Icons.swap_vert_circle, 'color': Color(0xff024a06)},
  ];

  @override
  void initState() {
    super.initState();
    ever(analogLimitController.analogLimits, (List<List<String>> limits) {
        for(int i = 0; i<limits.length && i < 20 ; i++){
          if(mounted){
            if (_minControllers[i].text != limits[i][1]) {
              _minControllers[i].text = limits[i][1];
            }
            if (_maxControllers[i].text != limits[i][2]) {
              _maxControllers[i].text = limits[i][2];
            }
            if (_multiControllers[i].text != limits[i][3]) {
              _multiControllers[i].text = limits[i][3];
            }
          }
        }
    },);
    analogLimitController.fetchAnalogConfig(widget.devicesData.uuid.toString());
  }

  @override
  void dispose() {
    for (int i = 0; i < 20; i++) {
      _minControllers[i].dispose();
      _maxControllers[i].dispose();
      _multiControllers[i].dispose();
    }    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (analogLimitController.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(color: Color(0xff024a06)),
        );
      }

      final limits = analogLimitController.analogLimits;
      final cardUpdate = analogLimitController.cardUpdate;
      final _ = cardUpdate.length;
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: limits.length,
          itemBuilder: (context, index) {
            final metadata = _cardsMetaData[index];
            final cardData = limits[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AnalogLimitCard(
                  title: metadata['tile'],
                  titleColor: metadata['color'],
                  icon: metadata['icon'],
                  isExpended: expendedTileIndex == index,
                  onExpansionChanged: (expended) {
                    setState(() {
                      expendedTileIndex = expended ? index : null;
                    });
                  },
                  switchValue: cardData[0] == '1',
                  isCardUpdate: cardUpdate[index],
                  onSwitchChanged: (value) {
                    final keyIndex = index;
                    final enable = value ? 1 : 0;
                    final min = _minControllers[keyIndex].text.padLeft(4, '0');
                    final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                    final commandVal = '${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max';
                    analogLimitController.updateAnalogLimits(widget.devicesData.uuid.toString(), commandVal);
                  },
                  onUpdatePressedMaxMin: () {
                    final keyIndex = index;
                    final enable = limits[keyIndex][0];
                    final min = _minControllers[keyIndex].text.padLeft(4, '0');
                    final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                    final commandVal = '${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max';
                    analogLimitController.updateAnalogLimits(widget.devicesData.uuid.toString(), commandVal);
                  },
                  onUpdatePressedMulti: () {
                    final keyIndex = index;
                    final multi = _multiControllers[keyIndex].text.padLeft(4, '0');
                    final commandVal = "${keyIndex.toString().padLeft(2, '0')},0,$multi";
                    analogLimitController.updateAnalogLimitMulti(widget.devicesData.uuid.toString(), commandVal);
                  }, minController: _minControllers[index], maxController: _maxControllers[index], multiController: _multiControllers[index]),
            );
          },

        ),
      );
    });
  }
}
