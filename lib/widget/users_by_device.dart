import 'package:flutter/material.dart';
import 'package:SolarExperto/constants/app_colors.dart';
import 'package:SolarExperto/constants/constants.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../constants/app_responsive.dart';

class UsersByDevice extends StatefulWidget {
  const UsersByDevice({Key? key}) : super(key: key);

  @override
  State<UsersByDevice> createState() => _UsersByDeviceState();
}

class _UsersByDeviceState extends State<UsersByDevice> {
  bool issolar = true;
  int userbtdevise = 70;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: appPadding),
      child: Container(
        height: 350,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(appPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customers by device',
              style: TextStyle(
                color: AppColor.black,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: EdgeInsets.all(appPadding),
              padding: EdgeInsets.all(appPadding),
              height: 230,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                      showLabels: false,
                      showTicks: false,
                      startAngle: 270,
                      endAngle: 270,
                      radiusFactor: 1.2,
                      axisLineStyle: const AxisLineStyle(
                          thicknessUnit: GaugeSizeUnit.factor, thickness: 0.15),
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                          angle: 180,
                          widget: Text(
                            '${userbtdevise}%',
                            style: TextStyle(
                              color: AppColor.black,
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                      pointers: <GaugePointer>[
                        RangePointer(
                            value: userbtdevise.toDouble(),
                            cornerStyle: CornerStyle.bothCurve,
                            enableAnimation: true,
                            animationDuration: 1200,
                            sizeUnit: GaugeSizeUnit.factor,
                            color: AppColor.yellow,
                            width: 0.15),
                      ]),
                ],
              ),
              // CustomPaint(
              //   foregroundPainter: RadialPainter(
              //     bgColor: AppColor.black.withOpacity(0.1),
              //     lineColor: AppColor.yellow,
              //     percent: userbtdevise,
              //     width: 18.0,
              //   ),
              //   child: Center(
              //     child: Text(
              //       '${userbtdevise * 100}%',
              //       style: TextStyle(
              //         color: AppColor.black,
              //         fontSize: 36,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //   ),
              // ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: appPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          issolar = true;
                          userbtdevise = 70;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: issolar
                                ? AppColor.yellow
                                : AppColor.black.withOpacity(0.5),
                            size: 10,
                          ),
                          SizedBox(
                            width: appPadding / 2,
                          ),
                          Text(
                            'Solar',
                            style: TextStyle(
                              color: AppColor.black.withOpacity(0.5),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          issolar = false;
                          userbtdevise = 40;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: !issolar
                                ? AppColor.yellow
                                : AppColor.black.withOpacity(0.5),
                            size: 10,
                          ),
                          SizedBox(
                            width: appPadding / 2,
                          ),
                          Text(
                            'Relays',
                            style: TextStyle(
                              color: AppColor.black.withOpacity(0.5),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
