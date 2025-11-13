import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeWidget extends StatelessWidget {
  GaugeWidget({required this.value, required this.label, this.height, this.width});
  final double value;
  final String label;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    Color pointerColor = value > 400 ? Colors.red : Color(0xff4c8750);
    return Column(
      children: [
        Container(
          height: height ,
          width: width ,
          child: SfRadialGauge(
            enableLoadingAnimation: true,
            animationDuration: 4500,
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 400,
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
                    value: value,

                    color: pointerColor,
                    width: 0.16,
                    sizeUnit: GaugeSizeUnit.factor,
                  ),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    widget: Text(
                      label,
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
          "${value}V",
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
