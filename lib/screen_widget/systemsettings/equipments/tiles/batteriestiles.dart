import 'package:SolarExperto/models/equipments/batteriesmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_responsive.dart';

class BatteriesTiles extends StatelessWidget {
  const BatteriesTiles({Key? key, required this.batteriesModel})
      : super(key: key);
  final BatteriesModel batteriesModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${batteriesModel.name}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ((!AppResponsive.isMobile(context)) ? 24 : 12),
                      color: AppColor.bgSideMenu),
                ),
                Text(
                  'Voltage: ${batteriesModel.voltage} V',
                  style: TextStyle(
                      fontSize: ((!AppResponsive.isMobile(context)) ? 18 : 10),
                      color: AppColor.bgSideMenu),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  height: ((!AppResponsive.isMobile(context)) ? 100 : 80),
                  width: ((!AppResponsive.isMobile(context)) ? 100 : 80),
                  child: SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                          showLabels: false,
                          showTicks: false,
                          startAngle: 270,
                          endAngle: 270,
                          radiusFactor: 1.2,
                          maximum: 500,
                          axisLineStyle: const AxisLineStyle(
                              thicknessUnit: GaugeSizeUnit.factor,
                              thickness: 0.15),
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                              angle: 180,
                              widget: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      '${batteriesModel.capacity} Ah',
                                      style: TextStyle(
                                        color: AppColor.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          pointers: <GaugePointer>[
                            RangePointer(
                                value: batteriesModel.capacity!.toDouble(),
                                cornerStyle: CornerStyle.bothCurve,
                                enableAnimation: true,
                                animationDuration: 1200,
                                sizeUnit: GaugeSizeUnit.factor,
                                color:
                                     Colors.green,

                                width: 0.15),
                          ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child:

                        Image.asset(
                      "assets/accumulator.png",
                      height: (!AppResponsive.isMobile(context)) ? 200 : 100,
                      width: (!AppResponsive.isMobile(context)) ? 200 : 100,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
