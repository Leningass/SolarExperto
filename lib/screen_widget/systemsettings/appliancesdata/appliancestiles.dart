import 'package:SolarExperto/constants/app_responsive.dart';
import 'package:SolarExperto/models/appliances/appliancemodel.dart';
import 'package:SolarExperto/screen_widget/systemsettings/appliancesdata/updateappliances.dart';
import 'package:SolarExperto/services/database/database_service.dart';
import 'package:SolarExperto/utilis/UplaodImages.dart';
import 'package:flutter/material.dart';
import 'package:SolarExperto/constants/constants.dart';
import 'package:SolarExperto/constants/app_colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AppliancesTiles extends StatelessWidget {
  const AppliancesTiles({Key? key, required this.applianceModel})
      : super(key: key);

  final ApplianceModel applianceModel;

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
                  '${applianceModel.name}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ((!AppResponsive.isMobile(context)) ? 14 : 12),
                      color: AppColor.bgSideMenu),
                ),
                Text(
                  'Usage: ${applianceModel.timeofusage} hrs',
                  style: TextStyle(
                      fontSize: ((!AppResponsive.isMobile(context)) ? 12 : 10),
                      color: AppColor.bgSideMenu),
                ),
                SizedBox(
                  height: 5,
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
                          maximum: 1000,
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
                                      '${applianceModel.ratedwattage} W',
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
                                value: applianceModel.ratedwattage!.toDouble(),
                                cornerStyle: CornerStyle.bothCurve,
                                enableAnimation: true,
                                animationDuration: 1200,
                                sizeUnit: GaugeSizeUnit.factor,
                                color:  Colors.green,

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
                Image.asset(
                  'assets/appliances.png',
                  height: (!AppResponsive.isMobile(context)) ? 200 : 100,
                  width: (!AppResponsive.isMobile(context)) ? 200 : 100,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
