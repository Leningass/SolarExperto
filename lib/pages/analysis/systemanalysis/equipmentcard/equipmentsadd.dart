import 'package:SolarExperto/pages/analysis/systemanalysis/equipmentcard/batterycard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_responsive.dart';
import '../../../../constants/constants.dart';
import '../../../../provider/app_provider.dart';

class EquipmentCardadd extends StatefulWidget {
  const EquipmentCardadd(
      {Key? key,
      required this.appProvider,
      required this.onNext,
      required this.onBack})
      : super(key: key);
  final AppProvider appProvider;
  final Function() onNext;
  final Function() onBack;
  @override
  State<EquipmentCardadd> createState() => _EquipmentCardaddState();
}

class _EquipmentCardaddState extends State<EquipmentCardadd> {
  int selected_inverter_voltage = 0;
  void initState() {
    // if (widget.appProvider.ptotal <= 600) {
    //   selected_inverter_voltage = 12;
    // } else if (widget.appProvider.ptotal > 600) {
    //   selected_inverter_voltage = 24;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: (!AppResponsive.isMobile(context)) ? 4 : 2,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          padding: EdgeInsets.all(appPadding),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: AppColor.bgSideMenu),
              onPressed: widget.onBack,
              label: Text(
                "Back",
                style: TextStyle(color: AppColor.bgColor, fontSize: 16.0),
              ),
              icon: Icon(Icons.arrow_back, size: 16, color: AppColor.bgColor),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: AppColor.bgSideMenu),
              onPressed: widget.onNext,
              label: Text(
                "Next",
                style: TextStyle(color: AppColor.bgColor, fontSize: 16.0),
              ),
              icon:
                  Icon(Icons.arrow_forward, size: 16, color: AppColor.bgColor),
            ),
          ],
        ),
      ],
    );
  }
}
