import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../provider/app_provider.dart';

class Horizontal_ApplianceMeter extends StatefulWidget {
  const Horizontal_ApplianceMeter({Key? key}) : super(key: key);

  @override
  State<Horizontal_ApplianceMeter> createState() =>
      _Horizontal_ApplianceMeterState();
}

class _Horizontal_ApplianceMeterState extends State<Horizontal_ApplianceMeter> {
  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    return SfLinearGauge(
        maximum: 10000.0,
        interval: 0.0,
        minorTicksPerInterval: 0,
        animateAxis: true,
        axisTrackStyle: const LinearAxisTrackStyle(thickness: 1),
        barPointers: <LinearBarPointer>[
          LinearBarPointer(
              value: 10000,
              thickness: 24,
              position: LinearElementPosition.outside,
              shaderCallback: (Rect bounds) {
                return const LinearGradient(colors: <Color>[
                  Colors.blue,
                  Colors.brown,
                  Colors.deepPurple
                ], stops: <double>[
                  0.1,
                  0.4,
                  0.9,
                ]).createShader(bounds);
              }),
        ],
        markerPointers: <LinearMarkerPointer>[
          LinearWidgetPointer(
              value: appProvider.maxmimumACpower.toDouble(),
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
            value: appProvider.maxmimumACpower.toDouble(),
            color: appProvider.maxmimumACpower.toDouble() < 5000
                ? Colors.blue
                : appProvider.maxmimumACpower.toDouble() < 10000
                    ? Colors.brown
                    : Colors.deepPurple,
          ),
        ]);
  }
}
