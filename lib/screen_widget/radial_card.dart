import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialCard extends StatelessWidget {
  RadialCard({Key? key, required this.margin}): super(key: key);
  EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: EdgeInsets.all(10),
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(1, 2), // changes position of shadow
          ),
        ],
      ),
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 150,
            ranges: <GaugeRange>[
              GaugeRange(startValue: 0, endValue: 50, color: Colors.green),
              GaugeRange(startValue: 50, endValue: 100, color: Colors.orange),
              GaugeRange(startValue: 100, endValue: 150, color: Colors.red)
            ],
            pointers: const <GaugePointer>[NeedlePointer(value: 90, needleEndWidth: 3,)],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Container(
                  child: const Text(
                    '90.0',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                angle: 90,
                positionFactor: 0.8,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
