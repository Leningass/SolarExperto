import 'package:SolarExperto/constants/app_responsive.dart';
import 'package:SolarExperto/models/accessories/accessoriesmodel.dart';
import 'package:SolarExperto/models/equipments/batteriesmodel.dart';
import 'package:SolarExperto/models/equipments/inverter_model.dart';
import 'package:SolarExperto/pages/analysis/systemanalysis/equipmentcard/InverterCard.dart';
import 'package:SolarExperto/pages/analysis/systemanalysis/equipmentcard/accessoriescard.dart';
import 'package:SolarExperto/pages/analysis/systemanalysis/equipmentcard/batterycard.dart';
import 'package:SolarExperto/pages/analysis/systemanalysis/equipmentcard/panelcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/constants.dart';
import '../../../../global_widgets/Loading/loading.dart';
import '../../../../global_widgets/header/header_widget.dart';
import '../../../../global_widgets/nodata/noitems.dart';
import '../../../../models/Service Fee/servicefeemodel.dart';
import '../../../../models/equipments/controllermodel.dart';
import '../../../../models/equipments/pvmodulemodel.dart';
import '../../../../provider/app_provider.dart';
import '../../../../services/database/database_service.dart';
import '../../../../utilis/calculation.dart';
import '../../../header/header.dart';
import '../../../settings/GlobalSetting/Servicefee/servicefeecard.dart';
import '../equipmentcard/ControllerCard.dart';

class Equipment extends StatefulWidget {
  Equipment({Key? key, this.appProvider, this.Userid}) : super(key: key);

  final AppProvider? appProvider;

  final String? Userid;

  @override
  State<Equipment> createState() => _EquipmentState();
}

class _EquipmentState extends State<Equipment> {
  String id = '';
  String name = '';
  String name1 = '';
  String type = '';
  String image = '';
  num quantity = 0;
  num buyingprice = 0;
  num sellingprice = 0;
  num stockquantity = 0;
  String serviceid = '';
  String servicename = '';
  String servicedescription = '';
  int install = 0;
  int maintain = 0;
  int transport = 0;
  int additional = 0;
  TextEditingController searched = TextEditingController();
  TextEditingController searched1 = TextEditingController();
  List<AccessoriesModel> _searchlist = [];
  List<ServiceFeeModel> _searchlist1 = [];
  List<AccessoriesModel> temp = [];
  bool checkbox = false;
  String description = '';




  @override
  void dispose() {
    // searched.removeListener(_onSearchChanged);
    searched1.removeListener(_onSearchChanged1);
    // searched.dispose();
    searched1.dispose();
    // _searchlist.clear();
    _searchlist1.clear();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _searchlist.clear();
    _searchlist1.clear();
  }

  void _onSearchChanged1() {
    searchResultsList1();
  }

  searchResultsList1() {
    _searchlist1.clear();
    if (searched1.text != "") {
      FirebaseFirestore.instance
          .collection(servicecollection)
          .orderBy('name')
          .get()
          .then((value) {
        _searchlist1 = [];
        value.docs.forEach((element) {
          if (element
              .get('name')
              .toLowerCase()
              .contains(searched1.text.toLowerCase())) {
            if (mounted) {
              setState(() {
                print('Searched ${element.get('name')}');

                _searchlist1.add(ServiceFeeModel(
                    id: element.get('id') ?? '',
                    name: element.get('name') ?? '',
                    description: element.get('description') ?? '',
                    installationfee: element.get('installationfee') ?? 0,
                    maintenancefee: element.get('maintenancefee') ?? 0,
                    transportfee: element.get('transportfee') ?? 0,
                    additionalfee: element.get('additionalfee') ?? 0));

                // result = LinkedHashSet<BatteriesModel>.from(_searchlist).toList();
              });
            }
            //result = LinkedHashSet<BatteriesModel>.from(_searchlist).toList();
            _searchlist1.toSet().toList();
            print('Search List1: ${_searchlist1.length}');
          }
        });
      });
    }
  }

  searchResultsList() {}

  @override
  void initState() {
    print(widget.Userid!);

    _searchlist.clear();
    _searchlist1.clear();

    //searched.addListener(_onSearchChanged);
    searched1.addListener(_onSearchChanged1);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const HeaderWidget(Routname: "Analysis"),
          Header(
            text: 'Equipment',
            backDisabled: false,
            forwardDisabled: false,
            onNavigate: (int index) {
              if (index == -1) {
                DatabaseService().deletetemcal('${widget.Userid}_itembattery');
                DatabaseService().deletetemcal('${widget.Userid}_itempanel');
                DatabaseService().deletetemcal('${widget.Userid}_iteminverter');
                //  DatabaseService().deletetemcal('${widget.Userid}_itemaccessories');
                DatabaseService()
                    .deletetemcal('${widget.Userid}_itemcontroller');
                // DatabaseService()
                //     .deletetempservicefee('${widget.Userid}_servicefee');

                tempbatteryreference
                    .doc(widget.Userid)
                    .collection('Battery_${widget.Userid}')
                    .get()
                    .then((snapshot) {
                  for (DocumentSnapshot doc in snapshot.docs) {
                    doc.reference.delete();
                  }
                });
                temppanelreference
                    .doc(widget.Userid)
                    .collection('Panel_${widget.Userid}')
                    .get()
                    .then((snapshot) {
                  for (DocumentSnapshot doc in snapshot.docs) {
                    doc.reference.delete();
                  }
                });
                tempinverterrefference
                    .doc(widget.Userid)
                    .collection('Inverter_${widget.Userid}')
                    .get()
                    .then((snapshot) {
                  for (DocumentSnapshot doc in snapshot.docs) {
                    doc.reference.delete();
                  }
                });
                tempcontrollerrefference
                    .doc(widget.Userid)
                    .collection('Controller_${widget.Userid}')
                    .get()
                    .then((snapshot) {
                  for (DocumentSnapshot doc in snapshot.docs) {
                    doc.reference.delete();
                  }
                });
              }
              if (index == 1) {
                setState(() {
                  Calculation().calG1(widget.appProvider!);
                  Calculation().calG2(widget.appProvider!);
                  Calculation().calG3(widget.appProvider!);
                  Calculation().calG4(widget.appProvider!);
                  widget.appProvider!.G5 = widget.appProvider!.G2 *
                      widget.appProvider!.electricityprice;
                  widget.appProvider!.G6 = widget.appProvider!.G3 *
                      widget.appProvider!.electricityprice;
                  Calculation().calG5(widget.appProvider!);
                  Calculation().calG6(widget.appProvider!);
                  Calculation().calG7(widget.appProvider!);
                  widget.appProvider!.G2 = widget.appProvider!.G1 * 30;
                  widget.appProvider!.G3 = widget.appProvider!.G1 * 365;
                  Calculation().callC12(widget.appProvider!);
                  Calculation().calG7(widget.appProvider!);
                  widget.appProvider!.G8 = widget.appProvider!.G7 * 30;
                  widget.appProvider!.G9 = widget.appProvider!.G7 * 365;
                  print("C12: ${widget.appProvider!.C12}");
                  widget.appProvider!.G13 =
                      widget.appProvider!.panelprice * widget.appProvider!.C12;
                  widget.appProvider!.updateG13(G13: widget.appProvider!.G13);
                  widget.appProvider!.G14 = widget.appProvider!.batteryprice *
                      widget.appProvider!.batteryquantity;
                  widget.appProvider!.updateG14(G14: widget.appProvider!.G14);
                  widget.appProvider!.updateG18(G18: widget.appProvider!.G18);
                  widget.appProvider!.G19 = (widget.appProvider!.batterytotal +
                          widget.appProvider!.paneltotal +
                          widget.appProvider!.invertertotal +
                          widget.appProvider!.accessoriestotal +
                          widget.appProvider!.controllertotal)
                      .toInt();
                  widget.appProvider!.G20 = (widget.appProvider!.G19 /
                          widget.appProvider!.system_life)
                      .round();
                  widget.appProvider!.G21 =
                      (widget.appProvider!.G20 / 12).round();
                  widget.appProvider!.G22 =
                      (widget.appProvider!.G20 / 365).round();
                  widget.appProvider!.G23 =
                      (widget.appProvider!.G26 * widget.appProvider!.G1)
                          .round();
                  widget.appProvider!.G24 =
                      (widget.appProvider!.G23 * 30).round();
                  widget.appProvider!.G25 =
                      (widget.appProvider!.G23 * 365).round();
                  widget.appProvider!.G26 = (widget
                              .appProvider!.electricityprice -
                          (widget.appProvider!.G22 / widget.appProvider!.G1))
                      .round();
                });
              }
              widget.appProvider!.screenindex =
                  widget.appProvider!.screenindex + index;
              widget.appProvider!
                  .incrementScreen(widget.appProvider!.screenindex);
            },
          ),

          if (widget.appProvider!.maxmimumACpower != 0) ...{
            (!AppResponsive.isMobile(context))
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.all(appPadding),
                        padding: EdgeInsets.all(appPadding),
                        height: 150,
                        width: 150,
                        child: SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(
                                showLabels: false,
                                showTicks: false,
                                startAngle: 270,
                                endAngle: 270,
                                radiusFactor: 1.2,
                                maximum: 3000,
                                axisLineStyle: const AxisLineStyle(
                                    thicknessUnit: GaugeSizeUnit.factor,
                                    thickness: 0.15),
                                annotations: <GaugeAnnotation>[
                                  GaugeAnnotation(
                                    angle: 180,
                                    widget: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Power',
                                          style: TextStyle(
                                            color: AppColor.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            '${widget.appProvider!.maxmimumACpower.toInt()} W',
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
                                      value: widget.appProvider!.maxmimumACpower
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
                        height: 150,
                        width: 150,
                        child: SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(
                                showLabels: false,
                                showTicks: false,
                                startAngle: 270,
                                endAngle: 270,
                                radiusFactor: 1.2,
                                maximum: 6000,
                                axisLineStyle: const AxisLineStyle(
                                    thicknessUnit: GaugeSizeUnit.factor,
                                    thickness: 0.15),
                                annotations: <GaugeAnnotation>[
                                  GaugeAnnotation(
                                    angle: 180,
                                    widget: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Energy',
                                          style: TextStyle(
                                            color: AppColor.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            '${widget.appProvider!.totalenergy} Wh',
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
                                      value: widget.appProvider!.totalenergy
                                          .toDouble(),
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
                      Container(
                        margin: EdgeInsets.all(appPadding),
                        padding: EdgeInsets.all(appPadding),
                        height: 150,
                        width: 150,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Battery Capacity',
                                          style: TextStyle(
                                            color: AppColor.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            '${widget.appProvider!.required_batteryc.round()} Ah',
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
                                      value: widget
                                          .appProvider!.required_batteryc
                                          .toDouble(),
                                      cornerStyle: CornerStyle.bothCurve,
                                      enableAnimation: true,
                                      animationDuration: 1200,
                                      sizeUnit: GaugeSizeUnit.factor,
                                      color: Colors.amber,
                                      width: 0.15),
                                ]),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(appPadding),
                        padding: EdgeInsets.all(appPadding),
                        height: 150,
                        width: 150,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Panel output',
                                          style: TextStyle(
                                            color: AppColor.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            '${widget.appProvider!.require_array_panel.toDouble().round().toDouble()} Wh',
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
                                      value: widget
                                          .appProvider!.require_array_panel
                                          .toDouble()
                                          .round()
                                          .toDouble(),
                                      cornerStyle: CornerStyle.bothCurve,
                                      enableAnimation: true,
                                      animationDuration: 1200,
                                      sizeUnit: GaugeSizeUnit.factor,
                                      color: Colors.orangeAccent,
                                      width: 0.15),
                                ]),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: EdgeInsets.all(appPadding),
                            padding: EdgeInsets.all(appPadding),
                            height: 120,
                            width: 120,
                            child: SfRadialGauge(
                              axes: <RadialAxis>[
                                RadialAxis(
                                    showLabels: false,
                                    showTicks: false,
                                    startAngle: 270,
                                    endAngle: 270,
                                    radiusFactor: 1.2,
                                    maximum: 3000,
                                    axisLineStyle: const AxisLineStyle(
                                        thicknessUnit: GaugeSizeUnit.factor,
                                        thickness: 0.15),
                                    annotations: <GaugeAnnotation>[
                                      GaugeAnnotation(
                                        angle: 180,
                                        widget: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Power',
                                              style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Center(
                                              child: Text(
                                                '${widget.appProvider!.maxmimumACpower.toInt()} W',
                                                style: TextStyle(
                                                  color: AppColor.black,
                                                  fontSize: 12,
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
                                          value: widget
                                              .appProvider!.maxmimumACpower
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
                            height: 120,
                            width: 120,
                            child: SfRadialGauge(
                              axes: <RadialAxis>[
                                RadialAxis(
                                    showLabels: false,
                                    showTicks: false,
                                    startAngle: 270,
                                    endAngle: 270,
                                    radiusFactor: 1.2,
                                    maximum: 6000,
                                    axisLineStyle: const AxisLineStyle(
                                        thicknessUnit: GaugeSizeUnit.factor,
                                        thickness: 0.15),
                                    annotations: <GaugeAnnotation>[
                                      GaugeAnnotation(
                                        angle: 180,
                                        widget: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Energy',
                                              style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Center(
                                              child: Text(
                                                '${widget.appProvider!.totalenergy} Wh',
                                                style: TextStyle(
                                                  color: AppColor.black,
                                                  fontSize: 12,
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
                                          value: widget.appProvider!.totalenergy
                                              .toDouble(),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: EdgeInsets.all(appPadding),
                            padding: EdgeInsets.all(appPadding),
                            height: 120,
                            width: 120,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Battery Capacity',
                                              style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Center(
                                              child: Text(
                                                '${widget.appProvider!.required_batteryc.round()} Ah',
                                                style: TextStyle(
                                                  color: AppColor.black,
                                                  fontSize: 12,
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
                                          value: widget
                                              .appProvider!.required_batteryc
                                              .toDouble(),
                                          cornerStyle: CornerStyle.bothCurve,
                                          enableAnimation: true,
                                          animationDuration: 1200,
                                          sizeUnit: GaugeSizeUnit.factor,
                                          color: Colors.amber,
                                          width: 0.15),
                                    ]),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(appPadding),
                            padding: EdgeInsets.all(appPadding),
                            height: 120,
                            width: 120,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Panel output',
                                              style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Center(
                                              child: Text(
                                                '${widget.appProvider!.require_array_panel.toDouble().round().toDouble()} Wh',
                                                style: TextStyle(
                                                  color: AppColor.black,
                                                  fontSize: 12,
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
                                          value: widget
                                              .appProvider!.require_array_panel
                                              .toDouble()
                                              .round()
                                              .toDouble(),
                                          cornerStyle: CornerStyle.bothCurve,
                                          enableAnimation: true,
                                          animationDuration: 1200,
                                          sizeUnit: GaugeSizeUnit.factor,
                                          color: Colors.orangeAccent,
                                          width: 0.15),
                                    ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
            StreamBuilder<List<BatteriesModel?>?>(
              stream: DatabaseService(doctoken: widget.Userid).tempbatteries,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                 // print("Data length is: ${snapshot.data!}");
                  if (snapshot.data!.length == 0) {
                    return Center(
                      child: Text("No Battery Recommended"),
                    );
                  } else {
                    return BatteryCard(
                      appProvider: widget.appProvider!,
                      batteriesModel: snapshot.data!.first,
                      Userid: widget.Userid,
                    );
                  }
                } else {
                  return const Center(
                    child: Loading(),
                  );
                }
              },
            ),
            StreamBuilder<List<PvModuleModel?>?>(
              stream: DatabaseService(doctoken: widget.Userid).temppanels,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.length == 0) {
                    return Center(
                      child: Text("No PV Module Recommended"),
                    );
                  } else {
                    return PanelCard(
                      appProvider: widget.appProvider!,
                      panelModel: snapshot.data!.first,
                      Userid: widget.Userid,
                    );
                  }
                } else {
                  return const Center(
                    child: Loading(),
                  );
                }
              },
            ),
            StreamBuilder<List<InverterModel?>?>(
              stream: DatabaseService(doctoken: widget.Userid).tempinverters,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.length == 0) {
                    return Center(
                      child: Text("No Inverter Recommended"),
                    );
                  } else {
                    return InverterCard(
                      appProvider: widget.appProvider!,
                      inverter_Model: snapshot.data!.first,
                      Userid: widget.Userid,
                    );
                  }
                } else {
                  return const Center(
                    child: Loading(),
                  );
                }
              },
            ),
            StreamBuilder<List<ChargeControllerModel?>?>(
              stream: DatabaseService(doctoken: widget.Userid).tempcontrollers,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.length == 0) {
                    return Center(
                      child: Text("No Controller Recommended"),
                    );
                  } else {
                    return Controllercard(
                      appProvider: widget.appProvider!,
                      controllerModel: snapshot.data!.first,
                      Userid: widget.Userid,
                    );
                  }
                } else {
                  return const Center(
                    child: Loading(),
                  );
                }
              },
            ),



          }
          else ...{
            const Center(
              child: yelloNoData(),
            )
          },
          SizedBox(
            height: 10,
          ),
          StreamBuilder<List<tempAccessoryModel?>?>(
            stream: DatabaseService().tempaccessories,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.length == 0) {
                  return Center(
                    child: Text("No Accessories"),
                  );
                } else {
                  return GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                     physics: PageScrollPhysics(),
                      gridDelegate:
                      SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:
                          (!AppResponsive
                              .isMobile(
                              context))
                              ? MediaQuery.of(
                              context)
                              .size
                              .width /
                              2
                              : 500,
                          childAspectRatio:
                          (!AppResponsive
                              .isMobile(
                              context))
                              ? 3 / 2
                              : 0.9,
                          crossAxisSpacing:
                          (!AppResponsive
                              .isMobile(
                              context))
                              ? 10
                              : 0,
                          mainAxisSpacing:
                          (!AppResponsive
                              .isMobile(
                              context))
                              ? 5
                              : 20),
                      itemBuilder: (context, index) {
                        return AccessoriesCard(
                          accessoriesModel:
                          snapshot.data![index]!,
                        );
                      });
                }
              } else {
                return Center(
                  child: Loading(),
                );
              }
            },
          ),
          /*StreamBuilder<List<ServiceFeeModel?>?>(
            stream: DatabaseService().tempservicefee,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.length == 0) {
                  return Center(
                    child: Text("No Service Fee Selected"),
                  );
                } else {
                  return ListView.builder(
                      physics: PageScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context,index){
                    return  Card(
                        elevation: 10,
                        shadowColor: AppColor.outlinecard,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColor.lightyellow,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Service Fee',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.normal),
                                    ),
                                  ],
                                ),
                                (!AppResponsive.isMobile(context))
                                    ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [


                                      Expanded(
                                        child: Container(
                                          // margin: const EdgeInsets.all(10),
                                          //  padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: AppColor.white,
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          // height: 200.0,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width,
                                                decoration: BoxDecoration(
                                                  color: AppColor.bgSideMenu,
                                                  borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(30),
                                                      topLeft: Radius.circular(30)),
                                                ),
                                                //padding: EdgeInsets.only(right: 20),

                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 20, top: 10, bottom: 10),
                                                  child: Text(
                                                    snapshot.data![index]!.name,
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: AppColor.white,
                                                        fontWeight: FontWeight.w800,
                                                        fontStyle: FontStyle.normal),
                                                  ),
                                                ),
                                              ),
                                              // SizedBox(
                                              //   height: 5,
                                              // ),
                                              Padding(
                                                padding: const EdgeInsets.all(15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Installation Fee ${snapshot.data![index]!.installationfee} CFA',
                                                      style: const TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight: FontWeight.w800,
                                                          fontStyle: FontStyle.normal),
                                                    ),
                                                    Text(
                                                      ' Maintenance Fee: ${snapshot.data![index]!.maintenancefee} CFA',
                                                      style: const TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight: FontWeight.w800,
                                                          fontStyle: FontStyle.normal),
                                                    ),
                                                    Text(
                                                      "Transport Fee:  ${snapshot.data![index]!.transportfee} CFA",
                                                      style: const TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight: FontWeight.w800,
                                                          fontStyle: FontStyle.normal),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Additional Fee: ${snapshot.data![index]!.additionalfee}",
                                                      style: const TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight: FontWeight.w800,
                                                          fontStyle: FontStyle.normal),
                                                    ),

                                                  ],
                                                ),
                                              ),



                                            ],
                                          ),
                                        ),
                                      ),
                                    ])
                                    : Column(
                                  children: [
                                    SizedBox(height: 20,),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              // margin: const EdgeInsets.all(10),
                                              //  padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: AppColor.white,
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              // height: 200.0,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width:
                                                    MediaQuery.of(context).size.width,
                                                    decoration: BoxDecoration(
                                                      color: AppColor.bgSideMenu,
                                                      borderRadius: BorderRadius.only(
                                                          topRight: Radius.circular(30),
                                                          topLeft: Radius.circular(30)),
                                                    ),
                                                    //padding: EdgeInsets.only(right: 20),

                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 20, top: 10, bottom: 10),
                                                      child: Text(
                                                        snapshot.data![index]!.name,
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            color: AppColor.white,
                                                            fontWeight: FontWeight.w800,
                                                            fontStyle: FontStyle.normal),
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   height: 5,
                                                  // ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Installation Fee:  ',
                                                              style: const TextStyle(
                                                                  fontSize: 12.0,
                                                                  fontWeight:
                                                                  FontWeight.w800,
                                                                  fontStyle:
                                                                  FontStyle.normal),
                                                            ),
                                                            Text(
                                                              '${snapshot.data![index]!.installationfee} CFA',
                                                              style: const TextStyle(
                                                                  fontSize: 12.0,
                                                                  fontWeight:
                                                                  FontWeight.w800,
                                                                  fontStyle:
                                                                  FontStyle.normal),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Text(
                                                              ' Maintenance Fee:  ',
                                                              style: const TextStyle(
                                                                  fontSize: 12.0,
                                                                  fontWeight:
                                                                  FontWeight.w800,
                                                                  fontStyle:
                                                                  FontStyle.normal),
                                                            ),
                                                            Text(
                                                              '  ${snapshot.data![index]!.maintenancefee} CFA',
                                                              style: const TextStyle(
                                                                  fontSize: 12.0,
                                                                  fontWeight:
                                                                  FontWeight.w800,
                                                                  fontStyle:
                                                                  FontStyle.normal),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Transport Fee ",
                                                              style: const TextStyle(
                                                                  fontSize: 12.0,
                                                                  fontWeight:
                                                                  FontWeight.w800,
                                                                  fontStyle:
                                                                  FontStyle.normal),
                                                            ),
                                                            Text(
                                                              "${snapshot.data![index]!.transportfee} CFA",
                                                              style: const TextStyle(
                                                                  fontSize: 12.0,
                                                                  fontWeight:
                                                                  FontWeight.w800,
                                                                  fontStyle:
                                                                  FontStyle.normal),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Additional Fee:  ",
                                                              style: const TextStyle(
                                                                  fontSize: 12.0,
                                                                  fontWeight:
                                                                  FontWeight.w800,
                                                                  fontStyle:
                                                                  FontStyle.normal),
                                                            ),
                                                            Text(
                                                              "${snapshot.data![index]!.additionalfee} CFA",
                                                              style: const TextStyle(
                                                                  fontSize: 12.0,
                                                                  fontWeight:
                                                                  FontWeight.w800,
                                                                  fontStyle:
                                                                  FontStyle.normal),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),

                                                      ],
                                                    ),
                                                  ),


                                                ],
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ));
                  });
                }
              } else {
                return const Center(
                  child: Loading(),
                );
              }
            },
          ),*/
          Container(
            decoration: BoxDecoration(
              color: AppColor.bgColor,
            ),
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  // temp.clear();
                  Future.delayed(Duration.zero, () async {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (dialogContext) {
                          return StatefulBuilder(builder: (context,setState){
                            return Center(
                                child: AlertDialog(
                                  title: const Center(
                                    child: Text("Add Accessories"),
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton.icon(
                                          icon: Icon(Icons.close,
                                              size: 16, color: AppColor.bgColor),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          onPressed: () {
                                            Navigator.of(dialogContext).pop();
                                          },
                                          label: Text("Cancel",
                                              style:
                                              TextStyle(color: AppColor.bgColor)),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ],
                                  content: Container(
                                    color: AppColor.white,
                                    width: (!AppResponsive.isMobile(context))
                                        ? 400
                                        : MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                          ),
                                          margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                          child: TextFormField(
                                            controller: searched,
                                            decoration: const InputDecoration(
                                              prefixIcon: Icon(Icons.search),
                                              hintText: 'Search Accessories',
                                            ),
                                            onChanged: (value) {
                                              _searchlist.clear();
                                              if (searched.text != "") {
                                                setState(() {
                                                  FirebaseFirestore.instance
                                                      .collection(equipmentCollection)
                                                      .where('Categoryname', isEqualTo: 'Accessories')
                                                      .orderBy('name')
                                                      .get()
                                                      .then((value) {
                                                    _searchlist = [];
                                                    value.docs.forEach((element) {
                                                      if (element
                                                          .get('name')
                                                          .toLowerCase()
                                                          .contains(searched.text
                                                          .toLowerCase())) {
                                                        setState(() {
                                                          print(
                                                              '${element.get('name')}');

                                                          _searchlist.add(AccessoriesModel(
                                                              id: element.get('id') ??
                                                                  '',
                                                              name: element.get('name') ??
                                                                  '',
                                                              type: element.get('type') ??
                                                                  '',
                                                              primary: element
                                                                  .get('primary') ??
                                                                  '',
                                                              secondary:
                                                              element.get('secondary') ??
                                                                  '',
                                                              quantity:
                                                              element.get('quantity') ??
                                                                  '',
                                                              buyingprice: element.get(
                                                                  'buyingprice') ??
                                                                  '',
                                                              sellingprice: element.get(
                                                                  'sellingprice') ??
                                                                  '',
                                                              image: element.get('image') ?? '',
                                                              description: element.get('description') ?? '',
                                                              Categoryname: element.get('Categoryname') ?? '',
                                                              addedday: element.get('addedday')));

                                                          // result = LinkedHashSet<BatteriesModel>.from(_searchlist).toList();
                                                        });
                                                        //result = LinkedHashSet<BatteriesModel>.from(_searchlist).toList();
                                                        _searchlist.toSet().toList();
                                                        print(
                                                            'Search List: ${_searchlist.length}');
                                                      }
                                                    });
                                                  });
                                                });

                                              }
                                              // setState(() {
                                              //   name = value;
                                              // });
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        (searched.text != '')
                                            ? (_searchlist.isNotEmpty)
                                            ? ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: _searchlist.length,
                                            itemBuilder:
                                                (dialogContext, index) {
                                              return GestureDetector(
                                                onTap: () async {
                                                  setState(() {
                                                    id = _searchlist[index]
                                                        .id!;
                                                    name = _searchlist[index]
                                                        .name!;
                                                    type = _searchlist[index]
                                                        .type!;
                                                    quantity =
                                                        _searchlist[index]
                                                            .quantity;
                                                    buyingprice =
                                                        _searchlist[index]
                                                            .buyingprice;
                                                    sellingprice =
                                                        _searchlist[index]
                                                            .sellingprice;
                                                    image = _searchlist[index]
                                                        .image!;

                                                    DatabaseService()
                                                        .updatetempaccessories(
                                                      '${widget.Userid}_itemaccessories',
                                                      id,
                                                      name,
                                                      type,
                                                      quantity,
                                                      sellingprice,
                                                      buyingprice,
                                                      image,
                                                      // stockquantity,
                                                    );
                                                    Navigator.pop(
                                                        dialogContext);
                                                  });
                                                },
                                                child: Card(
                                                  elevation: 10,
                                                  shadowColor:
                                                  AppColor.outlinecard,
                                                  child: Container(
                                                    margin:
                                                    const EdgeInsets.only(
                                                        top: appPadding),
                                                    padding:
                                                    const EdgeInsets.all(
                                                        10 / 2),
                                                    child: Row(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              40),
                                                          child: Image.asset(
                                                            "assets/accessories.png",
                                                            height: 70,
                                                            width: 70,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                              1),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text(
                                                                _searchlist[
                                                                index]
                                                                    .name!,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    16.0,
                                                                    color: AppColor
                                                                        .black,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                              ),
                                                              (!AppResponsive
                                                                  .isMobile(
                                                                  dialogContext))
                                                                  ? Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.spaceBetween,
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    'Type: ${_searchlist[index].type} ',
                                                                    style:
                                                                    TextStyle(
                                                                      color: AppColor.black.withOpacity(0.5),
                                                                      fontSize: 12,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                    20,
                                                                  ),
                                                                  Text(
                                                                    'Quantity: ${_searchlist[index].quantity} ',
                                                                    style:
                                                                    TextStyle(
                                                                      color: AppColor.black.withOpacity(0.5),
                                                                      fontSize: 12,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                                  : Column(
                                                                children: [
                                                                  Text(
                                                                    'Type: ${_searchlist[index].type} ',
                                                                    style:
                                                                    TextStyle(
                                                                      color: AppColor.black.withOpacity(0.5),
                                                                      fontSize: 12,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'Quantity: ${_searchlist[index].quantity} ',
                                                                    style:
                                                                    TextStyle(
                                                                      color: AppColor.black.withOpacity(0.5),
                                                                      fontSize: 12,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            })
                                            : const Text("No Accessories")
                                            : StreamBuilder<List<AccessoriesModel?>?>(
                                          stream: DatabaseService().accessories,
                                          builder: (context, snapshot) {
                                            print('Hello ${snapshot.hasData}');
                                            if (snapshot.hasData) {
                                              if (snapshot.data!.length == 0) {
                                                return Center(
                                                  child: yelloNoData(),
                                                );
                                              } else {
                                                return ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                    snapshot.data!.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return GestureDetector(
                                                        onTap: () async {},
                                                        child: StatefulBuilder(
                                                            builder: (context,
                                                                setState) {
                                                              return Container(
                                                                margin:
                                                                EdgeInsets.only(
                                                                    left: 15,
                                                                    right: 15),
                                                                height: 100,
                                                                width: double
                                                                    .maxFinite,
                                                                child: Card(
                                                                  elevation: 10,
                                                                  shadowColor: AppColor
                                                                      .outlinecard,
                                                                  child: Container(
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                        appPadding),
                                                                    padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10 / 2),
                                                                    child: Row(
                                                                      children: [
                                                                        Checkbox(
                                                                            value:
                                                                            checkbox,
                                                                            onChanged:
                                                                                (bool?
                                                                            value) {
                                                                              setState(
                                                                                      () {
                                                                                    id =
                                                                                    snapshot.data![index]!.id!;
                                                                                    name =
                                                                                    snapshot.data![index]!.name!;
                                                                                    type =
                                                                                    snapshot.data![index]!.type!;
                                                                                    quantity =
                                                                                        snapshot.data![index]!.quantity;
                                                                                    buyingprice =
                                                                                        snapshot.data![index]!.buyingprice;
                                                                                    sellingprice =
                                                                                        snapshot.data![index]!.sellingprice;
                                                                                    image =
                                                                                    snapshot.data![index]!.image!;

                                                                                    if (checkbox =
                                                                                    true) {
                                                                                      DatabaseService().updatetempaccessories(
                                                                                        '${widget.Userid}_itemaccessories_$id',
                                                                                        id,
                                                                                        name,
                                                                                        type,
                                                                                        quantity,
                                                                                        sellingprice,
                                                                                        buyingprice,
                                                                                        image,
                                                                                        // stockquantity,
                                                                                      );
                                                                                    } else if(checkbox=false) {
                                                                                      DatabaseService().deletetempaccess('${widget.Userid}_itemaccessories_$id');
                                                                                    }
                                                                                    checkbox =
                                                                                    value!;
                                                                                  });
                                                                            }),
                                                                        ClipRRect(
                                                                          borderRadius:
                                                                          BorderRadius.circular(
                                                                              40),
                                                                          child: Image
                                                                              .asset(
                                                                            "assets/accessories.png",
                                                                            height:
                                                                            70,
                                                                            width:
                                                                            70,
                                                                            fit: BoxFit
                                                                                .cover,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          width: 10,
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal:
                                                                              1),
                                                                          child:
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                            mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                snapshot.data![index]!.name!,
                                                                                style: TextStyle(
                                                                                    fontSize: 16.0,
                                                                                    color: AppColor.black,
                                                                                    fontWeight: FontWeight.w600),
                                                                              ),
                                                                              (!AppResponsive.isMobile(context))
                                                                                  ? Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    'Type: ${snapshot.data![index]!.type} ',
                                                                                    style: TextStyle(
                                                                                      color: AppColor.black.withOpacity(0.5),
                                                                                      fontSize: 12,
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 10,
                                                                                  ),
                                                                                  Text(
                                                                                    'Quantity: ${snapshot.data![index]!.quantity} ',
                                                                                    style: TextStyle(
                                                                                      color: AppColor.black.withOpacity(0.5),
                                                                                      fontSize: 12,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                                  : Column(
                                                                                children: [
                                                                                  Text(
                                                                                    'Type: ${snapshot.data![index]!.type} ',
                                                                                    style: TextStyle(
                                                                                      color: AppColor.black.withOpacity(0.5),
                                                                                      fontSize: 12,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    'Quantity: ${snapshot.data![index]!.quantity} ',
                                                                                    style: TextStyle(
                                                                                      color: AppColor.black.withOpacity(0.5),
                                                                                      fontSize: 12,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                      );
                                                    });
                                              }
                                            } else {
                                              return const Center(
                                                child: Loading(),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          });
                        });
                  });
                },
                child: const Text('Add Accessories'),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColor.bgColor,
            ),
            margin: EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async {
                  Future.delayed(Duration.zero, () async {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (dialogContext) {
                          return StatefulBuilder(builder: (context,setState){
                            return Center(
                                child: AlertDialog(
                                  title: const Center(
                                    child: Text("Add Service Fee"),
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton.icon(
                                          icon: Icon(Icons.close,
                                              size: 16, color: AppColor.bgColor),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          onPressed: () {
                                            Navigator.of(dialogContext).pop();
                                          },
                                          label: Text("Cancel",
                                              style:
                                              TextStyle(color: AppColor.bgColor)),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),

                                      ],
                                    ),
                                  ],
                                  content: Container(
                                    color: AppColor.white,
                                    width: (!AppResponsive.isMobile(context))
                                        ? 400
                                        : MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                          ),
                                          margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                          child: TextFormField(
                                            controller: searched1,
                                            decoration: const InputDecoration(
                                              prefixIcon: Icon(Icons.search),
                                              hintText: 'Search Service Fee',
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                name1 = value;
                                              });
                                            },
                                          ),
                                        ),
                                        (name1 != '')
                                            ? (_searchlist1.isNotEmpty)
                                            ? ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: _searchlist1.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                  onTap: () async {
                                                    if (mounted) {
                                                      setState(() {
                                                        serviceid = _searchlist1[index].id;
                                                        servicename = _searchlist1[index].name;
                                                        servicedescription = _searchlist1[index].description;
                                                        install = (_searchlist1[index].installationfee).toInt();
                                                        maintain = (_searchlist1[index].maintenancefee).toInt();
                                                        transport = (_searchlist1[index].transportfee).toInt();
                                                        additional = (_searchlist1[index].additionalfee).toInt();

                                                        DatabaseService()
                                                            .updatetempservicefee(
                                                          '${widget.Userid}_servicefee',
                                                          servicename,
                                                          servicedescription,
                                                          install,
                                                          maintain,
                                                          transport,
                                                          additional,
                                                        );
                                                      });
                                                    }
                                                    Navigator.of(dialogContext)
                                                        .pop();
                                                  },
                                                  child: StatefulBuilder(
                                                      builder: (context,setState){
                                                        return Card(
                                                          elevation: 10,
                                                          shadowColor:
                                                          AppColor.outlinecard,
                                                          child: Container(
                                                            margin:
                                                            const EdgeInsets.only(
                                                                top: appPadding),
                                                            padding:
                                                            const EdgeInsets.all(
                                                                10 / 2),
                                                            child: Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                      1),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      Text(
                                                                        _searchlist1[
                                                                        index]
                                                                            .name,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            16.0,
                                                                            color: AppColor
                                                                                .black,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w600),
                                                                      ),
                                                                      Column(
                                                                        children: [
                                                                          Text(
                                                                            'Installation Fee: ${NumberFormat("#,###").format(_searchlist1[index].installationfee)} CFA',
                                                                            style:
                                                                            TextStyle(
                                                                              color: AppColor.black.withOpacity(0.5),
                                                                              fontSize: 14,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            'Maintainenace Fee: ${NumberFormat("#,###").format(_searchlist1[index].maintenancefee)} CFA',
                                                                            style:
                                                                            TextStyle(
                                                                              color: AppColor.black.withOpacity(0.5),
                                                                              fontSize: 14,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                  )
                                              );
                                            })
                                            : const yelloNoData()
                                            : StreamBuilder<List<ServiceFeeModel?>?>(
                                          stream: DatabaseService().tempservicefee,
                                          builder: (context, snapshot) {
                                            print('Hello ${snapshot.hasData}');
                                            if (snapshot.hasData) {
                                              if (snapshot.data!.length == 0) {
                                                return Center(
                                                  child: yelloNoData(),
                                                );
                                              } else {
                                                return ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                    snapshot.data!.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return GestureDetector(
                                                        onTap: () async {


                                                          setState(() {
                                                            serviceid =
                                                                snapshot
                                                                    .data![
                                                                index]!
                                                                    .id;
                                                            servicename =
                                                                snapshot
                                                                    .data![
                                                                index]!
                                                                    .name;
                                                            servicedescription =
                                                                snapshot
                                                                    .data![
                                                                index]!
                                                                    .description;
                                                            install = (snapshot
                                                                .data![
                                                            index]!
                                                                .installationfee)
                                                                .toInt();
                                                            maintain = (snapshot
                                                                .data![
                                                            index]!
                                                                .maintenancefee)
                                                                .toInt();
                                                            transport = (snapshot
                                                                .data![
                                                            index]!
                                                                .transportfee)
                                                                .toInt();
                                                            additional = (snapshot
                                                                .data![
                                                            index]!
                                                                .additionalfee)
                                                                .toInt();

                                                            DatabaseService()
                                                                .updatetempservicefee(
                                                              '${widget.Userid}_servicefee',
                                                              servicename,
                                                              servicedescription,
                                                              install,
                                                              maintain,
                                                              transport,
                                                              additional,
                                                            );
                                                          });

                                                          Navigator.of(
                                                              dialogContext)
                                                              .pop();
                                                        },
                                                        child: Card(
                                                          elevation: 10,
                                                          shadowColor: AppColor
                                                              .outlinecard,
                                                          child: Container(
                                                            margin: const EdgeInsets
                                                                .only(
                                                                top:
                                                                appPadding),
                                                            padding:
                                                            const EdgeInsets
                                                                .all(
                                                                10 / 2),
                                                            child: Row(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                      1),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      Text(
                                                                        snapshot
                                                                            .data![index]!
                                                                            .name,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            16.0,
                                                                            color:
                                                                            AppColor.black,
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                      Column(
                                                                        children: [
                                                                          Text(
                                                                            'Installation Fee: ${NumberFormat("#,###").format(snapshot.data![index]!.installationfee)} CFA',
                                                                            style: TextStyle(
                                                                              color: AppColor.black.withOpacity(0.5),
                                                                              fontSize: 14,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            'Maintainenace Fee: ${NumberFormat("#,###").format(snapshot.data![index]!.maintenancefee)} CFA',
                                                                            style: TextStyle(
                                                                              color: AppColor.black.withOpacity(0.5),
                                                                              fontSize: 14,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              }
                                            } else {
                                              return const Center(
                                                child: Loading(),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          });
                        });
                  });
                },
                child: const Text('Add Service Fee'),
              ),
            ),
          ),

          // AccessoriesCard(
          //   appProvider: widget.appProvider!,
          // )
        ],
      ),
    );
  }
}
