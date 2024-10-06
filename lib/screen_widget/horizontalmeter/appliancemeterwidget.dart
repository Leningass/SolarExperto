import 'package:SolarExperto/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Horizontal_Meter extends StatefulWidget {
  const Horizontal_Meter({Key? key}) : super(key: key);
  @override
  State<Horizontal_Meter> createState() => _Horizontal_MeterState();
}

class _Horizontal_MeterState extends State<Horizontal_Meter> {
  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    return SfLinearGauge(
        maximum: 15000.0,
        interval: 0.0,
        minorTicksPerInterval: 0,
        animateAxis: true,
        axisTrackStyle: const LinearAxisTrackStyle(thickness: 1),
        barPointers: <LinearBarPointer>[
          LinearBarPointer(
              value: 15000,
              thickness: 24,
              position: LinearElementPosition.outside,
              shaderCallback: (Rect bounds) {
                return const LinearGradient(colors: <Color>[
                  Colors.green,
                  Colors.orange,
                  Colors.red
                ], stops: <double>[
                  0.1,
                  0.4,
                  0.9,
                ]).createShader(bounds);
              }),
        ],
        markerPointers: <LinearMarkerPointer>[
          LinearWidgetPointer(
              value: appProvider.totalenergy.toDouble(),
              offset: 26,
              position: LinearElementPosition.outside,
              child: SizedBox(
                width: 55,
                height: 45,
              )),
          LinearShapePointer(
            offset: 25,
            onChanged: (dynamic value) {
              // setState(() {
              //   _widgetPointerWithGradientValue = value as double;
              // });
            },
            value: appProvider.totalenergy.toDouble(),
            color: appProvider.totalenergy.toDouble() < 10000
                ? Colors.green
                : appProvider.totalenergy.toDouble() < 15000
                    ? Colors.orange
                    : Colors.red,
          ),
        ]);
  }
}
