import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeTwoWidget extends StatelessWidget {
  const GaugeTwoWidget({super.key, required this.value1, required this.label2, this.height, this.width });
  final double value1;
  final String label2;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    Color pointerColor = value1 > 320 ? Colors.red : Colors.blue;
    return Column(
      children: [
        SizedBox(
          height:height ,
          width: width ,
          child: SfRadialGauge(

            enableLoadingAnimation: true,
            animationDuration: 4500,
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 60,
                startAngle: 140,
                endAngle: 40,
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
                    widget:  Text(
                      label2,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
          "${value1}A",
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
