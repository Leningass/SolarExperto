import 'package:SolarExperto/models/othersettings/batteryiconratio.dart';
import 'package:SolarExperto/models/city/city.dart';
import 'package:SolarExperto/models/othersettings/efficieny.dart';
import 'package:SolarExperto/models/othersettings/paneliconratio.dart';
import 'package:SolarExperto/screen_widget/systemsettings/additionalsettings/addcity.dart';
import 'package:SolarExperto/screen_widget/systemsettings/additionalsettings/addefficiency.dart';
import 'package:SolarExperto/screen_widget/systemsettings/additionalsettings/citytiles.dart';
import 'package:SolarExperto/screen_widget/systemsettings/additionalsettings/efficiencytiles.dart';
import 'package:SolarExperto/screen_widget/systemsettings/additionalsettings/panelratiotiles.dart';
import 'package:SolarExperto/screen_widget/systemsettings/additionalsettings/ratiobatterytiles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_responsive.dart';
import '../../../constants/constants.dart';
import '../../../global_widgets/Loading/loading.dart';
import '../../../global_widgets/header/editpage_header.dart';
import '../../../services/database/database_service.dart';
import 'addratiobattery.dart';
import 'addratiopanel.dart';

class AdditionalSettings extends StatefulWidget {
  const AdditionalSettings({Key? key}) : super(key: key);

  @override
  State<AdditionalSettings> createState() => _AdditionalSettingsState();
}

class _AdditionalSettingsState extends State<AdditionalSettings> {
  String? _category;
  @override
  void initState() {
    _category = 'City';
    // TODO: implement initState
    super.initState();
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
      child: Column(
        children: [
          /// Header Part
          HeaderEdidPage(
            label: "Additional",
            routname: SettingsRoute,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: DropdownButton(
                  isExpanded: true,
                  hint: const Text(
                    'Choose Setting',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  value: _category,
                  //isExpanded: true,
                  //isDense: true,
                  onChanged: (newValue) {
                    setState(() {
                      _category = newValue.toString();
                      //dropDown = false;
                      print(_category);
                    });
                  },
                  items: <String>[
                    'City',
                    'Efficiency',
                    'Battery Icons',
                    'Panels Icon'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_category == 'City') ...{
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          //NotificationCardWidget(),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              padding: EdgeInsets.all(appPadding),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Cities',
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor:
                                                AppColor.bgSideMenu,
                                            padding: EdgeInsets.all(20.0),
                                            elevation: 5.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (dialogContext) {
                                                return AddCity();
                                              });
                                        },
                                        child: Center(
                                          child: Text(
                                            'Add City',
                                            style: TextStyle(
                                              color: AppColor.bgColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 0.0,
                                  ),
                                  StreamBuilder<List<CityModel?>?>(
                                    stream: DatabaseService().cities,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data!.length == 0) {
                                          return const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text('No Cities'),
                                            ),
                                          );
                                        } else {
                                          return Expanded(
                                            child: SingleChildScrollView(
                                              child: ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    snapshot.data!.length,
                                                itemBuilder: (context, index) =>
                                                    CityTiles(
                                                  cityModel:
                                                      snapshot.data![index]!,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      } else {
                                        return const Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Loading(),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                },
                if (_category == 'Efficiency') ...{
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          //NotificationCardWidget(),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              padding: EdgeInsets.all(appPadding),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Efficieny',
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor:
                                                AppColor.bgSideMenu,
                                            padding: EdgeInsets.all(20.0),
                                            elevation: 5.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (dialogContext) {
                                                return AddEfficiency();
                                              });
                                        },
                                        child: Center(
                                          child: Text(
                                            'Add Efficiency',
                                            style: TextStyle(
                                              color: AppColor.bgColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 0.0,
                                  ),
                                  StreamBuilder<List<EfficiencyModel?>?>(
                                    stream: DatabaseService().efficiencies,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data!.length == 0) {
                                          return const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text('No Value'),
                                            ),
                                          );
                                        } else {
                                          return Expanded(
                                            child: SingleChildScrollView(
                                              child: ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    snapshot.data!.length,
                                                itemBuilder: (context, index) =>
                                                    EfficienyTiles(
                                                  efficiencyModel:
                                                      snapshot.data![index]!,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      } else {
                                        return const Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Loading(),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                },
                if (_category == 'Battery Icons') ...{
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          //NotificationCardWidget(),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              padding: EdgeInsets.all(appPadding),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Battery Icons',
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor:
                                                AppColor.bgSideMenu,
                                            padding: EdgeInsets.all(20.0),
                                            elevation: 5.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (dialogContext) {
                                                return AddBatteryRationIcon();
                                              });
                                        },
                                        child: Center(
                                          child: Text(
                                            'Add Icons',
                                            style: TextStyle(
                                              color: AppColor.bgColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 0.0,
                                  ),
                                  StreamBuilder<List<BatteryIconratioModel?>?>(
                                    stream:
                                        DatabaseService().batteriesratioicon,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data!.length == 0) {
                                          return const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text('No Data'),
                                            ),
                                          );
                                        } else {
                                          return Expanded(
                                            child: SingleChildScrollView(
                                              child: ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    snapshot.data!.length,
                                                itemBuilder: (context, index) =>
                                                    BatteriesRatioTiles(
                                                  batteryIconratioModel:
                                                      snapshot.data![index]!,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      } else {
                                        return const Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Loading(),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                },
                if (_category == 'Panels Icon') ...{
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          //NotificationCardWidget(),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              padding: EdgeInsets.all(appPadding),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Panel Icons',
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor:
                                                AppColor.bgSideMenu,
                                            padding: EdgeInsets.all(20.0),
                                            elevation: 5.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (dialogContext) {
                                                return AddPanelRatioIcon();
                                              });
                                        },
                                        child: Center(
                                          child: Text(
                                            'Add Icons',
                                            style: TextStyle(
                                              color: AppColor.bgColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 0.0,
                                  ),
                                  StreamBuilder<List<PanelIconratioModel?>?>(
                                    stream: DatabaseService().panelsratioicon,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data!.length == 0) {
                                          return const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text('No Value'),
                                            ),
                                          );
                                        } else {
                                          return Expanded(
                                            child: SingleChildScrollView(
                                              child: ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    snapshot.data!.length,
                                                itemBuilder: (context, index) =>
                                                    PanelRatioTiles(
                                                  panelIconratioModel:
                                                      snapshot.data![index]!,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      } else {
                                        return const Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Loading(),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                },
                //Categories Equipments..
              ],
            ),
          ),
        ],
      ),
    );
  }
}
