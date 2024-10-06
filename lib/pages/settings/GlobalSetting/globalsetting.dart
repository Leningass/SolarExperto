import 'package:SolarExperto/constants/app_colors.dart';
import 'package:SolarExperto/constants/constants.dart';
import 'package:SolarExperto/global_widgets/header/editpage_header.dart';
import 'package:SolarExperto/global_widgets/header/header_widget.dart';
import 'package:SolarExperto/pages/settings/GlobalSetting/Servicefee/servicefee.dart';
import 'package:SolarExperto/pages/settings/GlobalSetting/city/cities.dart';
import 'package:SolarExperto/screen_widget/systemsettings/additionalsettings/addcity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/app_provider.dart';
import '../../../constants/app_responsive.dart';
import '../../../data/data.dart';
import '../../../global_widgets/Loading/loading.dart';
import '../../../models/city/city.dart';
import '../../../models/othersettings/efficieny.dart';
import '../../../screen_widget/systemsettings/additionalsettings/citytiles.dart';
import '../../../screen_widget/systemsettings/appliancesdata/appliancespage.dart';
import '../../../services/database/database_service.dart';
import '../../../widget/discussion_info_detail.dart';
import 'Servicefee/addservicefee.dart';
import 'globals.dart';

class GlobalSetting extends StatefulWidget {
  GlobalSetting({Key? key, required this.appProvider}) : super(key: key);
  final AppProvider appProvider;

  @override
  State<GlobalSetting> createState() => _GlobalSettingState();
}

class _GlobalSettingState extends State<GlobalSetting> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*if (widget.appProvider.autonomy_in_days == 0) {
      widget.appProvider.autonomy_in_days = 1;
      widget.appProvider.updateautonomy_in_days(
          autonomy_in_days: widget.appProvider.autonomy_in_days);
    }
    autonomy_in_days.text = widget.appProvider.autonomy_in_days.toString();

    if (widget.appProvider.controller_safety == 0) {
      widget.appProvider.controller_safety = 1.25;
      widget.appProvider.updatecontrollersafety(
          controller_safety: widget.appProvider.controller_safety);
    }
    controller_safety.text = widget.appProvider.controller_safety.toString();

    if (widget.appProvider.inverter_efficiency == 0) {
      widget.appProvider.inverter_efficiency = 0.85;
      widget.appProvider.updateinverterefficeiency(
          inverter_efficiency: widget.appProvider.inverter_efficiency);
    }
    inverterefficiency.text = widget.appProvider.inverter_efficiency.toString();
    if (widget.appProvider.battery_dod == 0) {
      widget.appProvider.battery_dod = 0.8;
      widget.appProvider.updatebatterydod(
          battery_dod: widget.appProvider.battery_dod);
    }
    batterydod.text = widget.appProvider.battery_dod.toString();

    if (widget.appProvider.batery_round_trip == 0) {
      widget.appProvider.batery_round_trip = 0.8;
      widget.appProvider.updatebatteryroundtrip(
          batery_round_trip: widget.appProvider.batery_round_trip);
    }
    batteryroundtrip.text = widget.appProvider.batery_round_trip.toString();

    if (widget.appProvider.derating_factor == 0) {
      widget.appProvider.derating_factor = 0.9;
      widget.appProvider.updatederatingfactor(
          derating_factor:  widget.appProvider.derating_factor);
    }
    deratingfactor.text = widget.appProvider.derating_factor.toString();
    if (widget.appProvider.system_life == 0) {
      widget.appProvider.system_life = 1;
      widget.appProvider.updatesystemlife(
          system_life:  widget.appProvider.system_life);
    }
    systemlifetime.text = widget.appProvider.system_life.toString();
*/
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListView(
        children: [
          HeaderEdidPage(label: "Global Parameters", routname: SettingsRoute),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GlobalPage(
                                appProvider: widget.appProvider,
                              )),
                    );
                  },
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      // color: Colors.indigo[900],
                      elevation: 10,
                      // margin: (!AppResponsive.isMobile(context))
                      //     ? EdgeInsets.fromLTRB(32, 32, 64, 32)
                      //     : EdgeInsets.fromLTRB(32, 32, 32, 32),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Color.fromARGB(255, 38, 156, 235)!,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              child: Column(
                                children: [
                                  Center(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.abc,
                                          size: ((!AppResponsive.isMobile(
                                                  context))
                                              ? 150
                                              : 70),
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          height: appPadding,
                                        ),
                                        Center(
                                          child: Text(
                                            'Globals',
                                            style: TextStyle(
                                              color: AppColor.white,
                                              fontSize:
                                                  ((!AppResponsive.isMobile(
                                                          context))
                                                      ? 24
                                                      : 16),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //SelectionSection(),
                                ],
                              )),
                          // ),
                        ),
                      )),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Cities()),
                    );
                  },
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      // color: AppColor.bgSideMenu,
                      elevation: 10,
                      // margin: (!AppResponsive.isMobile(context))
                      //     ? EdgeInsets.fromLTRB(32, 32, 64, 32)
                      //     : EdgeInsets.fromLTRB(32, 32, 32, 32),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Color.fromARGB(255, 38, 156, 235)!,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              child: Column(
                                children: [
                                  Center(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.location_city,
                                          size: ((!AppResponsive.isMobile(
                                                  context))
                                              ? 150
                                              : 70),
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          height: appPadding,
                                        ),
                                        Center(
                                          child: Text(
                                            'Cities',
                                            style: TextStyle(
                                              color: AppColor.bgColor,
                                              fontSize:
                                                  ((!AppResponsive.isMobile(
                                                          context))
                                                      ? 24
                                                      : 16),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //SelectionSection(),
                                ],
                              )),
                          // ),
                        ),
                      )),
                ),
              )
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ServiceFee()),
                  );
                },
                child: Card(
                  elevation: 30,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: GestureDetector(
                    // onTap: (){
                    //   Navigator.push(context, MaterialPageRoute(builder:
                    //       (context)=>ManageChargeControler())
                    //   );
                    // },
                    child: Container(
                      padding:  EdgeInsets.all(appPadding * 0.75),
                      width: (!AppResponsive.isMobile(context))?450:300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Color.fromARGB(255, 38, 156, 235)!,
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.device_hub,
                            size: ((!AppResponsive.isMobile(
                                context))
                                ? 150
                                : 70),
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: appPadding,
                          ),
                          Center(
                            child: Text(
                              'Service Fee',
                              style: TextStyle(
                                color: AppColor.bgColor,
                                fontSize:
                                ((!AppResponsive.isMobile(
                                    context))
                                    ? 24
                                    : 16),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}
