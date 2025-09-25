import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeTwoWidget extends StatelessWidget {
  GaugeTwoWidget({required this.value1, required this.label2, this.height = 70, this.width = 100 });
  final double value1;
  final String label2;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    Color pointerColor = value1 > 320 ? Colors.red : Colors.blue;
    return Column(
      children: [
        Container(
          height:height,
          width: width,
          child: SfRadialGauge(
            enableLoadingAnimation: true,
            animationDuration: 4500,
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 500,
                startAngle: 180,
                endAngle: 0,
                showLabels: false,
                showTicks: false,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.16,
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                // axisLineStyle: AxisLineStyle(thickness: 0.15,
                // thicknessUnit: GaugeSizeUnit.factor),
                pointers: <GaugePointer>[
                  RangePointer(
                    animationType: AnimationType.bounceOut,
                    value: value1,
                    color: pointerColor,
                    width: 0.16,
                    sizeUnit: GaugeSizeUnit.factor,
                  ),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    widget: Text(
                      label2,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: pointerColor,
                      ),
                    ),
                    angle: 90,
                    positionFactor: 0,
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(
          "(I): ${value1}A",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: pointerColor,
          ),
        ),
      ],
    );
  }
}
