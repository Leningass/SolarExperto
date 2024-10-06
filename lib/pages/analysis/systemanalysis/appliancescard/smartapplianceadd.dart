import 'package:SolarExperto/pages/analysis/systemanalysis/appliancescard/smartappliancescard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_responsive.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/size_config.dart';
import '../../../../global_widgets/Loading/loading.dart';
import '../../../../global_widgets/header/header_widget.dart';
import '../../../../global_widgets/nodata/noitems.dart';
import '../../../../models/appliances/appliancemodel.dart';
import '../../../../models/categories/categorymodel.dart';
import '../../../../navbar/locator.dart';
import '../../../../navbar/navigation_service.dart';
import '../../../../provider/app_provider.dart';
import '../../../../screen_widget/appliancemeter/appliancemeter.dart';
import '../../../../screen_widget/horizontalmeter/appliancemeterwidget.dart';
import '../../../../services/database/database_service.dart';
import '../../../../utilis/calculation.dart';
import '../../../../utilis/round-utils.dart';
import '../../../header/header.dart';
import '../../analysis.dart';

class SmartAppliancesAdd extends StatefulWidget {
  const SmartAppliancesAdd(
      {Key? key, required this.appProvider, this.onNext, this.applianceModel})
      : super(key: key);
  final AppProvider appProvider;

  final Function()? onNext;
  final ApplianceModel? applianceModel;

  @override
  State<SmartAppliancesAdd> createState() => _SmartAppliancesAddState();
}

class _SmartAppliancesAddState extends State<SmartAppliancesAdd> {
  bool isrelay = false;

  String? Userid;
  final _addFormKey = GlobalKey<FormState>();
  bool applianceStatus = false;
  String? search;
  String categoryname = 'All';
  String? selected;
  bool isfirst = true;
  TextEditingController searched = TextEditingController();
  List<ApplianceModel> _searchlist = [];
  String name = '';
  num Ns = 0;
  num costNs = 0;
  num Np = 0;
  num costNp = 0;
  num Nsp = 0;
  num costNsp = 0;
  List<String> listcategory = [];
  List<ApplianceModel> appliancelist = [];
  @override
  void initState() {
    getcategories();
    getappliancebycategory(null);
    _searchlist.clear();

    searched.addListener(_onSearchChanged);
    getuerid();
    super.initState();
  }

  @override
  void dispose() {
    searched.removeListener(_onSearchChanged);
    searched.dispose();
    _searchlist.clear();
    super.dispose();
  }

  void getcategories() {
    listcategory.add('All');
    FirebaseFirestore.instance
        .collection(appliancescategoryCollection)
        .orderBy('name')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (mounted) {
          setState(() {
            print(element.get('name'));

            listcategory.add(element.get('name'));
          });
        }
      });
    });
  }

  void getappliancebycategory(dynamic categoryname) {
    appliancelist.clear();
    FirebaseFirestore.instance
        .collection(appliancesCollection)
        .where('categoryid', isEqualTo: categoryname)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (mounted) {
          setState(() {
            appliancelist.add(ApplianceModel(
                id: element.get('id'),
                name: element.get('name'),
                categoryid: element.get('categoryid'),
                type: element.get('type'),
                ratedwattage: element.get('ratedwattage'),
                timeofusage: element.get('timeofusage'),
                quatity: element.get('quatity'),
                image: element.get('image'),
                addedday: element.get('addedday')));
          });
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _searchlist.clear();
  }

  void _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    _searchlist.clear();
    if (searched.text != "") {
      FirebaseFirestore.instance
          .collection(appliancesCollection)
          .orderBy('name')
          .get()
          .then((value) {
        _searchlist = [];
        value.docs.forEach((element) {
          if (element
              .get('name')
              .toLowerCase()
              .contains(searched.text.toLowerCase())) {
            setState(() {
              print('${element.get('name')}');

              _searchlist.add(ApplianceModel(
                  id: element.get('id'),
                  name: element.get('name'),
                  categoryid: element.get('categoryid'),
                  type: element.get('type'),
                  ratedwattage: element.get('ratedwattage'),
                  timeofusage: element.get('timeofusage'),
                  quatity: element.get('quatity'),
                  image: element.get('image'),
                  addedday: element.get('addedday')));

              // result = LinkedHashSet<BatteriesModel>.from(_searchlist).toList();
            });
            //result = LinkedHashSet<BatteriesModel>.from(_searchlist).toList();
            _searchlist.toList();
            print('Search List: ${_searchlist.length}');
          }
        });
      });
    }
  }

  void getuerid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Userid = prefs.getString('id') ?? '';
    });
    print('User: ${Userid}');
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final AppProvider appProvider = Provider.of<AppProvider>(context);

    return ListView(
      children: [
        HeaderWidget(Routname: "Analysis"),
        Header(
          text: 'Appliances',
          backDisabled: false,
          forwardDisabled: (appProvider.maxmimumACpower != 0) ? false : true,
          onNavigate: (int index) {
            if (index == 1) {
              if (widget.appProvider!.maxmimumACpower != 0) {
                Future.delayed(Duration.zero, () async {
                  print("One 1");
                  if (widget.appProvider!.maxmimumACpower <= 1200) {
                    widget.appProvider!.batterybusvoltage = 12;
                    widget.appProvider!.updatebatterybusvoltage(
                        batterybusvoltage:
                            widget.appProvider!.batterybusvoltage);
                  } else if (widget.appProvider!.maxmimumACpower > 1200 &&
                      widget.appProvider!.maxmimumACpower <= 2400) {
                    widget.appProvider!.batterybusvoltage = 24;
                    widget.appProvider!.updatebatterybusvoltage(
                        batterybusvoltage:
                            widget.appProvider!.batterybusvoltage);
                  } else if (widget.appProvider!.maxmimumACpower > 2400) {
                    widget.appProvider!.batterybusvoltage = 48;
                    widget.appProvider!.updatebatterybusvoltage(
                        batterybusvoltage:
                            widget.appProvider!.batterybusvoltage);
                  }
                  print('battery Bus ${widget.appProvider!.batterybusvoltage}');
                  Calculation().caltotalamphour(widget.appProvider!);
                  Calculation().calrequiredbatterycapcity(widget.appProvider!);
                  print('B3: ${widget.appProvider!.required_batteryc}');
                  FirebaseFirestore.instance
                      .collection(equipmentCollection)
                      .where('Categoryname', isEqualTo: 'Battery')
                      .get()
                      .then((value) {
                    value.docs.forEach((element) {
                      String id = UniqueKey().toString();
                      if (widget.appProvider!.batterybusvoltage >
                              element.data()['voltage'] &&
                          widget.appProvider!.required_batteryc <=
                              element.data()['capacity']) {
                        Ns = roundvalue((widget.appProvider!.batterybusvoltage /
                            element.data()['voltage']));
                        costNs = Ns * element.data()['sellingprice'];
                        DatabaseService().updatetempbattery(
                            Userid,
                            element.data()['id'],
                            element.data()['id'],
                            element.data()['name'],
                            element.data()['type'],
                            Ns,
                            element.data()['voltage'],
                            element.data()['capacity'],
                            element.data()['deep_of_discharge'],
                            element.data()['sellingprice'],
                            element.data()['buyingprice'],
                            element.data()['image'],
                            Ns,
                            0,
                            element.data()['quantity'],
                            costNs);
                      }
                      if (widget.appProvider!.batterybusvoltage ==
                              element.data()['voltage'] &&
                          widget.appProvider!.required_batteryc >=
                              element.data()['capacity']) {
                        Np = roundvalue((widget.appProvider!.required_batteryc /
                            element.data()['capacity']));
                        costNp = Np * element.data()['sellingprice'];
                        DatabaseService().updatetempbattery(
                            Userid,
                            element.data()['id'],
                            element.data()['id'],
                            element.data()['name'],
                            element.data()['type'],
                            Np,
                            element.data()['voltage'],
                            element.data()['capacity'],
                            element.data()['deep_of_discharge'],
                            element.data()['sellingprice'],
                            element.data()['buyingprice'],
                            element.data()['image'],
                            0,
                            Np,
                            element.data()['quantity'],
                            costNp);
                      }
                      print("Voltage ${widget.appProvider!.batterybusvoltage}");
                      print(
                          "Capacty ${widget.appProvider!.required_batteryc.roundToDouble()}");
                      if (widget.appProvider!.batterybusvoltage >
                              element.data()['voltage'] &&
                          widget.appProvider!.required_batteryc >
                              element.data()['capacity']) {
                        Ns = roundvalue((widget.appProvider!.batterybusvoltage /
                            element.data()['voltage']));
                        Np = roundvalue((widget.appProvider!.required_batteryc /
                            element.data()['capacity']));
                        Nsp = Ns * Np;
                        costNsp = Nsp * element.data()['sellingprice'];
                        DatabaseService().updatetempbattery(
                            Userid,
                            element.data()['id'],
                            element.data()['id'],
                            element.data()['name'],
                            element.data()['type'],
                            Nsp,
                            element.data()['voltage'],
                            element.data()['capacity'],
                            element.data()['deep_of_discharge'],
                            element.data()['sellingprice'],
                            element.data()['buyingprice'],
                            element.data()['image'],
                            Ns,
                            Np,
                            element.data()['quantity'],
                            costNsp);
                      }
                    });
                  });
                });
              }

              if (widget.appProvider!.maxmimumACpower != 0) {
                Future.delayed(Duration.zero, () async {
                  print("Two 2");
                  Calculation().calrequire_array_panel(widget.appProvider!);
                  print(
                      'widget.appProvider!.batterybusvoltage : ${widget.appProvider!.batterybusvoltage}');
                  FirebaseFirestore.instance
                      .collection(equipmentCollection)
                      .where('Categoryname', isEqualTo: 'Panels')
                      .get()
                      .then((value) {
                    value.docs.forEach((element) {
                      String id = UniqueKey().toString();

                      if (widget.appProvider!.batterybusvoltage >
                              (element.data()['systemvoltage'] * 0.85) &&
                          (widget.appProvider!.require_array_panel /
                                  widget.appProvider!.peaksunhour) <=
                              element.data()['power']) {
                        Ns = roundvalue((widget.appProvider!.batterybusvoltage /
                            (element.data()['systemvoltage'] * 0.85)));
                        costNs = Ns * element.data()['sellingprice'];
                        DatabaseService().updatetemppanel(
                            Userid!,
                            element.data()['id'],
                            element.data()['id'],
                            element.data()['name'],
                            element.data()['type'],
                            Ns,
                            element.data()['power'],
                            element.data()['systemvoltage'],
                            element.data()['short_circuit_current'],
                            element.data()['open_circuit_voltage'],
                            element.data()['sellingprice'],
                            element.data()['buyingprice'],
                            element.data()['image'],
                            Ns,
                            0,
                            element.data()['current'],
                            element.data()['quantity'],
                            costNs);
                      }
                      if (widget.appProvider!.batterybusvoltage <=
                              (element.data()['systemvoltage'] * 0.85) &&
                          (widget.appProvider!.require_array_panel /
                                  widget.appProvider!.peaksunhour) >=
                              element.data()['power']) {
                        Np = roundvalue(
                            ((widget.appProvider!.require_array_panel /
                                    widget.appProvider!.peaksunhour) /
                                element.data()['power']));
                        costNp = Np * element.data()['sellingprice'];
                        DatabaseService().updatetemppanel(
                            Userid!,
                            element.data()['id'],
                            element.data()['id'],
                            element.data()['name'],
                            element.data()['type'],
                            Np,
                            element.data()['power'],
                            element.data()['systemvoltage'],
                            element.data()['short_circuit_current'],
                            element.data()['open_circuit_voltage'],
                            element.data()['sellingprice'],
                            element.data()['buyingprice'],
                            element.data()['image'],
                            0,
                            Np,
                            element.data()['current'],
                            element.data()['quantity'],
                            costNp);
                      }
                      if (widget.appProvider!.batterybusvoltage >
                              (element.data()['systemvoltage'] * 0.85) &&
                          (widget.appProvider!.require_array_panel /
                                  widget.appProvider!.peaksunhour) >
                              element.data()['power']) {
                        Ns = roundvalue((widget.appProvider!.batterybusvoltage /
                            (element.data()['systemvoltage'] * 0.85)));
                        Np = roundvalue(
                            ((widget.appProvider!.require_array_panel /
                                    widget.appProvider!.peaksunhour) /
                                element.data()['power']));
                        Nsp = Ns * Np;
                        costNsp = Nsp * element.data()['sellingprice'];
                        DatabaseService().updatetemppanel(
                            Userid!,
                            element.data()['id'],
                            element.data()['id'],
                            element.data()['name'],
                            element.data()['type'],
                            Nsp,
                            element.data()['power'],
                            element.data()['systemvoltage'],
                            element.data()['short_circuit_current'],
                            element.data()['open_circuit_voltage'],
                            element.data()['sellingprice'],
                            element.data()['buyingprice'],
                            element.data()['image'],
                            Ns,
                            Np,
                            element.data()['current'],
                            element.data()['quantity'],
                            costNsp);
                      }
                    });
                  });
                });
              }
              //DatabaseService().deletetempinverter(widget.Userid!);

              if (widget.appProvider!.maxmimumACpower != 0) {
                //Inverter
                Future.delayed(Duration.zero, () async {
                  print("Three 3");
                  FirebaseFirestore.instance
                      .collection(equipmentCollection)
                      .where('Categoryname', isEqualTo: 'Inverter')
                      .get()
                      .then((value) {
                    value.docs.forEach((element) {
                      String id = UniqueKey().toString();
                      if (element.data()['nominalvoltage'] ==
                              widget.appProvider!.batterybusvoltage &&
                          element.data()['ratedpower'] >=
                              (widget.appProvider!.maxmimumACpower * 1.3)) {
                        DatabaseService().updatetempinverter(
                          Userid!,
                          element.data()['id'],
                          element.data()['id'],
                          element.data()['name'],
                          element.data()['type'],
                          element.data()['quantity'],
                          element.data()['ratedpower'],
                          element.data()['nominalvoltage'],
                          element.data()['acvoltage'],
                          element.data()['sellingprice'],
                          element.data()['buyingprice'],
                          element.data()['efficiency'],
                          element.data()['image'],
                        );
                      }
                    });
                  });
                });
              }
            }
            //if (appProvider.maxmimumACpower != 0) {
            appProvider.screenindex = appProvider.screenindex + index;
            appProvider.incrementScreen(appProvider.screenindex);

            // } else {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //       const SnackBar(content: Text("Select Appliances")));
            // }
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Container(
              margin: EdgeInsets.all(appPadding),
              padding: EdgeInsets.all(appPadding),
              height: (!AppResponsive.isMobile(context))?150:100,
              width: (!AppResponsive.isMobile(context))?150:100,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                      showLabels: false,
                      showTicks: false,
                      startAngle: 270,
                      endAngle: 270,
                      radiusFactor: 1.2,
                      maximum: 15000,
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
                              Text(
                                'AC Power',
                                style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: (!AppResponsive.isMobile(context))?14:12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Center(
                                child: Text(
                                  '${widget.appProvider.maxmimumACpower.toInt()} W',
                                  style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: (!AppResponsive.isMobile(context))?14:12,
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
                            value: widget.appProvider.maxmimumACpower
                                .toDouble(),
                            cornerStyle: CornerStyle.bothCurve,
                            enableAnimation: true,
                            animationDuration: 1200,
                            sizeUnit: GaugeSizeUnit.factor,
                            color: Colors.red,
                            width: 0.15),
                      ]),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(appPadding),
              padding: EdgeInsets.all(appPadding),
              height: (!AppResponsive.isMobile(context))?150:100,
              width: (!AppResponsive.isMobile(context))?150:100,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                      showLabels: false,
                      showTicks: false,
                      startAngle: 270,
                      endAngle: 270,
                      radiusFactor: 1.2,
                      maximum: 10000,
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
                              Text(
                                'Energy',
                                style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: (!AppResponsive.isMobile(context))?14:12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Center(
                                child: Text(
                                  '${widget.appProvider.totalenergy} Wh',
                                  style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: (!AppResponsive.isMobile(context))?14:12,
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
                            value:
                            widget.appProvider.totalenergy.toDouble(),
                            cornerStyle: CornerStyle.bothCurve,
                            enableAnimation: true,
                            animationDuration: 1200,
                            sizeUnit: GaugeSizeUnit.factor,
                            color: Colors.green,
                            width: 0.15),
                      ]),
                ],
              ),
            ),

          ],
        ),
        // const Horizontal_Meter(),
        // const Horizontal_ApplianceMeter(),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          margin: EdgeInsets.only(left: 10, right: 10),
          child: TextField(
            controller: searched,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search Appliances',
            ),
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColor.bgColor,
          ),
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Align(
            alignment: Alignment.topRight,
            child: ElevatedButton(
              onPressed: () {
                int length = Userid!.length;
                print('User LENGTH: ${length}');

                FirebaseFirestore.instance
                    .collection(tempappliances)
                    .get()
                    .then((value) {
                  value.docs.forEach((element) async {
                    if (element.data()['id'].substring(0, length) == Userid!) {
                      await tempappliancesrefference
                          .doc(element.data()['id'])
                          .delete();
                    }
                  });
                });
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Reseting..")));
                Future.delayed(const Duration(seconds: 1), () {
                  appProvider.adjustedwattage = 0;
                  appProvider.totalenergy = 0;
                  appProvider.maxmimumACpower = 0;
                  appProvider.updatemaximumdc(
                      maxmimudcwattage: appProvider.adjustedwattage);
                  appProvider.updatetotalenergy(
                      totalenergy: appProvider.totalenergy);
                  appProvider.maxmimumACpower = 0;
                  appProvider.updatemaxmimumACpower(
                      maxmimumACpower: appProvider.maxmimumACpower);
                  locator<NavigationService>().navigateTo(AnalysisRoute);
                });
              },
              child: const Text('Reset'),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.only(top: 20, left: 10, right: 10),
          child: (name != '')
              ? Padding(
                  padding: EdgeInsets.all(16),
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            (!AppResponsive.isMobile(context)) ? 340 : 390,
                        childAspectRatio:
                            (!AppResponsive.isMobile(context)) ? 3 / 2 : 3 / 2,
                        crossAxisSpacing:
                            (!AppResponsive.isMobile(context)) ? 10 : 0,
                        mainAxisSpacing:
                            (!AppResponsive.isMobile(context)) ? 5 : 20),
                    itemBuilder: (context, index) {
                      return SmartAppliancesCard(
                        applianceModel: _searchlist[index],
                        appProvider: appProvider,
                        Userid: Userid!,
                      );
                    },
                    itemCount: _searchlist.length,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        color: AppColor.bgColor,
                        // change your height based on preference
                        height: 50,
                        width: double.infinity,
                        child: ListView.builder(
                           physics: ScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: listcategory.length,
                            itemBuilder: (context, index) => Container(
                                  padding: const EdgeInsets.only(
                                      top: 2, left: 5, right: 5, bottom: 2),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(60)),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        categoryname = listcategory[index];
                                        selected = listcategory[index];
                                        if (categoryname == 'All') {
                                          selected = null;
                                        }

                                        // to = timemodel[index].to;
                                        // from = timemodel[index].from;
                                      });
                                      if (selected != null) {
                                        getappliancebycategory(selected!);
                                      } else {
                                        getappliancebycategory(null);
                                      }
                                    },
                                    child: Container(
                                      height: 10,
                                      width: 100,
                                      decoration: (categoryname ==
                                              listcategory[index])
                                          ? BoxDecoration(
                                              color: AppColor.bgSideMenu,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)))
                                          : BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black
                                                      .withOpacity(0.3)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                      child: Center(
                                        child: Text(
                                          listcategory[index],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: (categoryname ==
                                                      listcategory[index])
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))),
                    (appliancelist.isNotEmpty)
                        ? Padding(
                            padding: EdgeInsets.all(16),
                            child: GridView.builder(
                              physics: PageScrollPhysics(),
                             // scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent:
                                          (!AppResponsive.isMobile(context))
                                              ? 340
                                              : 390,
                                      childAspectRatio:
                                          (!AppResponsive.isMobile(context))
                                              ? 3 / 2
                                              : 3 / 2,
                                      crossAxisSpacing:
                                          (!AppResponsive.isMobile(context))
                                              ? 10
                                              : 0,
                                      mainAxisSpacing:
                                          (!AppResponsive.isMobile(context))
                                              ? 5
                                              : 20),
                              itemBuilder: (context, index) {
                                return SmartAppliancesCard(
                                  applianceModel: appliancelist[index],
                                  appProvider: appProvider,
                                  Userid: Userid!,
                                );
                              },
                              itemCount: appliancelist.length,
                            ),
                          )
                        : const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: yelloNoData(),
                            ),
                          ),
                  ],
                ),
        ),
      ],
    );
  }
}
// Column(
// crossAxisAlignment:
// CrossAxisAlignment.start,
// children: [
// Text(
// snapshot.data![index]!.name!,
// style: const TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 16.0),
// ),
//
// ],
// ),
