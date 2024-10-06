import 'package:SolarExperto/models/equipments/pvmodulemodel.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_responsive.dart';

class PvModuleTiles extends StatelessWidget {
  const PvModuleTiles({Key? key, required this.equipmentModel})
      : super(key: key);
  final PvModuleModel equipmentModel;
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
                  '${equipmentModel.name}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ((!AppResponsive.isMobile(context)) ? 24 : 12),
                      color: AppColor.bgSideMenu),
                ),
                Text(
                  'Voltage: ${equipmentModel.voltage} V',
                  style: TextStyle(
                      fontSize: ((!AppResponsive.isMobile(context)) ? 18 : 10),
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
                                      '${equipmentModel.power} W',
                                      style: TextStyle(
                                        color: AppColor.black,
                                        fontSize:
                                            ((!AppResponsive.isMobile(context))
                                                ? 14
                                                : 12),
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
                                value: equipmentModel.power!.toDouble(),
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
                ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      "assets/solar-cell.png",
                      height: (!AppResponsive.isMobile(context)) ? 200 : 100,
                      width: (!AppResponsive.isMobile(context)) ? 200 : 100,
                    )
                    /* Image.network(
                    '${equipmentModel.image}',
                    loadingBuilder:
                        (BuildContext
                    context,
                        Widget
                        child,
                        ImageChunkEvent?
                        loadingProgress) {
                      if (loadingProgress ==
                          null)
                        return child;
                      return Center(
                        child:
                        CircularProgressIndicator(
                          value: loadingProgress
                              .expectedTotalBytes !=
                              null
                              ? loadingProgress
                              .cumulativeBytesLoaded /
                              loadingProgress
                                  .expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder:
                        (BuildContext
                    context,
                        Object
                        exception,
                        StackTrace?
                        stackTrace) {
                      return const CircularProgressIndicator();
                    },
                    height:
                    (!AppResponsive.isMobile(
                        context))
                        ? 200
                        : 100,
                    width: (!AppResponsive.isMobile(
                        context))
                        ? 200
                        : 100,
                    fit: BoxFit.cover,
                  ),*/
                    )
              ],
            ),
          )
        ],
      ),
    );
  }
}
