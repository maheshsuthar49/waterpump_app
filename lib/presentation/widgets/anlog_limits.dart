import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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

      return Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 10),
            AnalogLimitCard(
              title: "Voltage(R)",
              titleColor: Color(0xff024a06),
              icon: Icons.bolt,
              isExpended: expendedTileIndex == 0,
              onExpansionChanged: (expanded) {
                setState(() {
                  expendedTileIndex = expanded ? 0 : null;
                });
              },
              switchValue: limits[0][0] == "1",
              onSwitchChanged: (value) {
                final keyIndex = 0;
                final enable = value ? 1 : 0;
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMaxMin: () {
                final keyIndex = 0;
                final enable = limits[keyIndex][0];
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMulti: () {},
              minController: _minControllers[0],
              maxController: _maxControllers[0],
              multiController: _multiControllers[0],
            ), //0
            SizedBox(height: 10),
            AnalogLimitCard(
              title: "Voltage(Y)",
              titleColor: Color(0xff024a06),
              icon: Icons.bolt,
              isExpended: expendedTileIndex == 1,
              onExpansionChanged: (expanded) {
                setState(() {
                  expendedTileIndex = expanded ? 1 : null;
                });
              },
              switchValue: limits[1][0] == "1",
              onSwitchChanged: (value) async{
                final keyIndex = 1;
                final enable = value ? 1 : 0;
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";

                await mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,);
              },
              onUpdatePressedMaxMin: () {
                final keyIndex = 1;
                final enable = limits[keyIndex][0];
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal = "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMulti: () {},
              minController: _minControllers[1],
              maxController: _maxControllers[1],
              multiController: TextEditingController(text: limits[1][3]),
            ), //1
            SizedBox(height: 10),
            AnalogLimitCard(
              title: "Voltage(B)",
              titleColor: Color(0xff024a06),
              icon: Icons.bolt,
              isExpended: expendedTileIndex == 2,
              onExpansionChanged: (expanded) {
                setState(() {
                  expendedTileIndex = expanded ? 2 : null;
                });
              },
              switchValue: limits[2][0] == '1',
              onSwitchChanged: (value) {
                final keyIndex = 2;
                final enable = value ? 1 : 0;
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMaxMin: () {
                final keyIndex = 2;
                final enable = limits[keyIndex][0];
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMulti: () {},
              minController: _minControllers[2],
              maxController: _maxControllers[2],
              multiController: _multiControllers[2]
            ), //2
            SizedBox(height: 10),
            AnalogLimitCard(
              title: "Current(R)",
              titleColor: Colors.blue,
              icon: Icons.power,
              isExpended: expendedTileIndex == 3,
              onExpansionChanged: (expanded) {
                setState(() {
                  expendedTileIndex = expanded ? 3 : null;
                });
              },
              switchValue: limits[3][0] == "1",
              onSwitchChanged: (value) {
                final keyIndex = 3;
                final enable = value ? 1 : 0;
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMaxMin: () {
                final keyIndex = 3;
                final enable = limits[keyIndex][0];
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMulti: () {},
              minController: _minControllers[3],
              maxController: _maxControllers[3],
              multiController: _multiControllers[3],
            ), //3
            SizedBox(height: 10),
            AnalogLimitCard(
              title: "Current(Y)",
              titleColor: Colors.blue,
              icon: Icons.power,
              isExpended: expendedTileIndex == 4,
              onExpansionChanged: (expanded) {
                setState(() {
                  expendedTileIndex = expanded ? 4 : null;
                });
              },
              switchValue: limits[4][0] == '1',
              onSwitchChanged: (value) {
                final keyIndex = 4;
                final enable = value ? 1 : 0;
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMaxMin: () {
                final keyIndex = 4;
                final enable = limits[keyIndex][0];
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMulti: () {},
              minController: _minControllers[4],
              maxController: _maxControllers[4],
              multiController: _multiControllers[4],
            ), //4
            SizedBox(height: 10),
            AnalogLimitCard(
              title: "Current(B)",
              titleColor: Colors.blue,
              icon: Icons.power,
              isExpended: expendedTileIndex == 5,
              onExpansionChanged: (expanded) {
                setState(() {
                  expendedTileIndex = expanded ? 5 : null;
                });
              },
              switchValue: limits[5][0] == '1',
              onSwitchChanged: (value) {
                final keyIndex = 5;
                final enable = value ? 1 : 0;
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMaxMin: () {
                final keyIndex = 5;
                final enable = limits[keyIndex][0];
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMulti: () {},
              minController: _minControllers[5],
              maxController: _maxControllers[5],
              multiController: _multiControllers[5],
            ), //5
            SizedBox(height: 10),
            AnalogLimitCard(
              title: "Imbalance voltage(R-Y)",
              titleColor: Color(0xff024a06),
              icon: Icons.bolt,
              isExpended: expendedTileIndex == 6,
              onExpansionChanged: (expanded) {
                setState(() {
                  expendedTileIndex = expanded ? 6 : null;
                });
              },
              switchValue: limits[6][0] == '1',
              onSwitchChanged: (value) {
                final keyIndex = 6;
                final enable = value ? 1 : 0;
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMaxMin: () {
                final keyIndex = 6;
                final enable = limits[keyIndex][0];
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMulti: () {},
              minController: _minControllers[6],
              maxController: _maxControllers[6],
              multiController: _multiControllers[6],
            ), //6
            SizedBox(height: 10),
            AnalogLimitCard(
              title: "Imbalance voltage(Y-B)",
              titleColor: Color(0xff024a06),
              icon: Icons.bolt,
              isExpended: expendedTileIndex == 7,
              onExpansionChanged: (expanded) {
                setState(() {
                  expendedTileIndex = expanded ? 7 : null;
                });
              },
              switchValue: limits[7][0] == '1',
              onSwitchChanged: (value) {
                final keyIndex = 7;
                final enable = value ? 1 : 0;
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMaxMin: () {
                final keyIndex = 7;
                final enable = limits[keyIndex][0];
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMulti: () {},
              minController:_minControllers[7],
              maxController: _maxControllers[7],
              multiController: _multiControllers[7],
            ), //7
            SizedBox(height: 10),
            AnalogLimitCard(
              title: "Imbalance voltage(B-R)",
              titleColor: Color(0xff024a06),
              icon: Icons.bolt,
              isExpended: expendedTileIndex == 8,
              onExpansionChanged: (expanded) {
                setState(() {
                  expendedTileIndex = expanded ? 8 : null;
                });
              },
              switchValue: limits[8][0] == '1',
              onSwitchChanged: (value) {
                final keyIndex = 8;
                final enable = value ? 1 : 0;
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMaxMin: () {
                final keyIndex = 8;
                final enable = limits[keyIndex][0];
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMulti: () {},
              minController: _minControllers[8],
              maxController:_maxControllers[8],
              multiController: _multiControllers[8],
            ), //8
            SizedBox(height: 10),
            AnalogLimitCard(
              title: "Imbalance current(R-Y)",
              titleColor: Colors.blue,
              icon: Icons.power,
              isExpended: expendedTileIndex == 9,
              onExpansionChanged: (expanded) {
                setState(() {
                  expendedTileIndex = expanded ? 9 : null;
                });
              },
              switchValue: limits[9][0] == '1',
              onSwitchChanged: (value) {
                final keyIndex = 9;
                final enable = value ? 1 : 0;
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMaxMin: () {
                final keyIndex = 9;
                final enable = limits[keyIndex][0];
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMulti: () {},
              minController: _minControllers[9],
              maxController: _maxControllers[9],
              multiController: _multiControllers[9],
            ), //9
            SizedBox(height: 10),
            AnalogLimitCard(
              title: "Imbalance current(Y-B)",
              titleColor: Colors.blue,
              icon: Icons.power,
              isExpended: expendedTileIndex == 10,
              onExpansionChanged: (expanded) {
                setState(() {
                  expendedTileIndex = expanded ? 10 : null;
                });
              },
              switchValue: limits[10][0] == '1',
              onSwitchChanged: (value) {
                final keyIndex = 10;
                final enable = value ? 1 : 0;
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMaxMin: () {
                final keyIndex = 10;
                final enable = limits[keyIndex][0];
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMulti: () {},
              minController: _minControllers[10],
              maxController: _maxControllers[10],
              multiController: _multiControllers[10],
            ), //10
            SizedBox(height: 10),
            AnalogLimitCard(
              title: "Imbalance current(B-R)",
              titleColor: Colors.blue,
              icon: Icons.power,
              isExpended: expendedTileIndex == 11,
              onExpansionChanged: (expanded) {
                setState(() {
                  expendedTileIndex = expanded ? 11 : null;
                });
              },
              switchValue: limits[11][0] == '1',
              onSwitchChanged: (value) {
                final keyIndex = 11;
                final enable = value ? 1 : 0;
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMaxMin: () {
                final keyIndex = 11;
                final enable = limits[keyIndex][0];
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMulti: () {},
              minController: _minControllers[11],
              maxController: _maxControllers[11],
              multiController:_multiControllers[11],
            ), //11
            SizedBox(height: 10),
            AnalogLimitCard(
              title: "Technical fault(R)",
              titleColor: Colors.red,
              icon: Icons.error,
              isExpended: expendedTileIndex == 12,
              onExpansionChanged: (expanded) {
                setState(() {
                  expendedTileIndex = expanded ? 12 : null;
                });
              },
              switchValue: limits[12][0] == '1',
              onSwitchChanged: (value) {
                final keyIndex = 12;
                final enable = value ? 1 : 0;
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMaxMin: () {
                final keyIndex = 12;
                final enable = limits[keyIndex][0];
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMulti: () {},
              minController: _minControllers[12],
              maxController: _maxControllers[12],
              multiController:_multiControllers[12],
            ), //12
            SizedBox(height: 10),
            AnalogLimitCard(
              title: "Technical fault(Y)",
              titleColor: Colors.red,
              icon: Icons.error,
              isExpended: expendedTileIndex == 13,
              onExpansionChanged: (expanded) {
                setState(() {
                  expendedTileIndex = expanded ? 13 : null;
                });
              },
              switchValue: limits[13][0] == '1',
              onSwitchChanged: (value) {
                final keyIndex = 13;
                final enable = value ? 1 : 0;
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMaxMin: () {
                final keyIndex = 13;
                final enable = limits[keyIndex][0];
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMulti: () {},
              minController: _minControllers[13],
              maxController: _maxControllers[13],
              multiController: _multiControllers[13],
            ), //13
            SizedBox(height: 10),
            AnalogLimitCard(
              title: "Technical fault(B)",
              titleColor: Colors.red,
              icon: Icons.error,
              isExpended: expendedTileIndex == 14,
              onExpansionChanged: (expanded) {
                setState(() {
                  expendedTileIndex = expanded ? 14 : null;
                });
              },
              switchValue: limits[14][0] == '1',
              onSwitchChanged: (value) {
                final keyIndex = 14;
                final enable = value ? 1 : 0;
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMaxMin: () {
                final keyIndex = 14;
                final enable = limits[keyIndex][0];
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMulti: () {},
              minController: _minControllers[14],
              maxController: _maxControllers[14],
              multiController: _multiControllers[14],
            ), //14
            SizedBox(height: 10),
            AnalogLimitCard(
              title: "",
              titleColor: Colors.red,

              isExpended: expendedTileIndex == 15,
              onExpansionChanged: (expanded) {
                setState(() {
                  expendedTileIndex = expanded ? 15 : null;
                });
              },
              switchValue: limits[15][0] == '1',
              onSwitchChanged: (value) {
                final keyIndex = 15;
                final enable = value ? 1 : 0;
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMaxMin: () {
                final keyIndex = 15;
                final enable = limits[keyIndex][0];
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMulti: () {},
              minController: _minControllers[15],
              maxController: _maxControllers[15],
              multiController: _multiControllers[15],
            ), //15
            SizedBox(height: 10),
            AnalogLimitCard(
              title: "",
              titleColor: Colors.red,

              isExpended: expendedTileIndex == 16,
              onExpansionChanged: (expanded) {
                setState(() {
                  expendedTileIndex = expanded ? 16 : null;
                });
              },
              switchValue: limits[16][0] == '1',
              onSwitchChanged: (value) {
                final keyIndex = 16;
                final enable = value ? 1 : 0;
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMaxMin: () {
                final keyIndex = 16;
                final enable = limits[keyIndex][0];
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMulti: () {},
              minController: _minControllers[16],
              maxController: _maxControllers[16],
              multiController: _multiControllers[16],
            ), //16
            SizedBox(height: 10),
            AnalogLimitCard(
              title: "",
              titleColor: Colors.red,

              isExpended: expendedTileIndex == 17,
              onExpansionChanged: (expanded) {
                setState(() {
                  expendedTileIndex = expanded ? 17 : null;
                });
              },
              switchValue: limits[17][0] == '1',
              onSwitchChanged: (value) {
                final keyIndex = 17;
                final enable = value ? 1 : 0;
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMaxMin: () {
                final keyIndex = 17;
                final enable = limits[keyIndex][0];
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMulti: () {},
              minController: _minControllers[17],
              maxController: _maxControllers[17],
              multiController: _multiControllers[17],
            ), //17
            SizedBox(height: 10),
            AnalogLimitCard(
              title: "",
              titleColor: Colors.red,

              isExpended: expendedTileIndex == 18,
              onExpansionChanged: (expanded) {
                setState(() {
                  expendedTileIndex = expanded ? 18 : null;
                });
              },
              switchValue: limits[18][0] == '1',
              onSwitchChanged: (value) {
                final keyIndex = 18;
                final enable = value ? 1 : 0;
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMaxMin: () {
                final keyIndex = 18;
                final enable = limits[keyIndex][0];
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMulti: () {},
              minController: _minControllers[18],
              maxController: _maxControllers[18],
              multiController: _multiControllers[18],
            ), //18
            SizedBox(height: 10),
            AnalogLimitCard(
              title: "Phase reverse",
              titleColor: Color(0xff024a06),
              icon: Icons.swap_vert_circle,
              isExpended: expendedTileIndex == 19,
              onExpansionChanged: (expanded) {
                setState(() {
                  expendedTileIndex = expanded ? 19 : null;
                });
              },
              switchValue: limits[19][0] == '1',
              onSwitchChanged: (value) {
                final keyIndex = 19;
                final enable = value ? 1 : 0;
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMaxMin: () {
                final keyIndex = 19;
                final enable = limits[keyIndex][0];
                final min = _minControllers[keyIndex].text.padLeft(4, '0');
                final max = _maxControllers[keyIndex].text.padLeft(4, '0');
                final commandVal =
                    "${keyIndex.toString().padLeft(2, '0')},$enable,$min,$max";
                mqttController.analogLimitsConfig(
                  widget.devicesData.uuid.toString(),
                  commandVal,
                );
              },
              onUpdatePressedMulti: () {},
              minController: _minControllers[19],
              maxController: _maxControllers[19],
              multiController: _multiControllers[19]
            ),
          ],
        ),
      );
    });
  }
}
