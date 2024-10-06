import 'package:SolarExperto/models/equipments/pvmodulemodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_responsive.dart';
import '../../../../constants/constants.dart';
import '../../../../global_widgets/Loading/loading.dart';
import '../../../../global_widgets/nodata/noitems.dart';

import '../../../../provider/app_provider.dart';
import '../../../../services/database/database_service.dart';
import '../../../../utilis/calculation.dart';

class PanelCard extends StatefulWidget {
  const PanelCard(
      {Key? key, this.panelModel, required this.appProvider, this.Userid})
      : super(key: key);
  final PvModuleModel? panelModel;
  final AppProvider appProvider;
  final String? Userid;
  @override
  State<PanelCard> createState() => _PanelCardState();
}

class _PanelCardState extends State<PanelCard> {
  String itemid = '';
  String panelid = '';
  String panelname = '';
  String paneltype = '';
  dynamic panelquantity = 0;
  dynamic panelpower = 0;
  dynamic panelvoltage = 0.0;
  dynamic panelshort_circuit_current = 0.0;
  dynamic panelopen_circuit_voltage = 0.0;
  dynamic panelsaleprice = 0.0;
  dynamic panelpurchaseprice = 0.0;
  String panelicon = '';
  dynamic panelseries = 0;
  dynamic panelparrellel = 0;
  dynamic panelsystemvoltage = 0;
  dynamic totalsaleprice = 0.0;
  dynamic stockquantity = 0;
  String name='';
  TextEditingController searched=TextEditingController();

  @override
  void initState() {
    getTempdata();
    super.initState();
  }

  void getTempdata() {
    FirebaseFirestore.instance
        .collection(tempcalculation)
        .doc('${widget.Userid}_itempanel')
        .get()
        .then((DocumentSnapshots) {
      if (mounted) {
        print('Here');
        setState(() {
          if (DocumentSnapshots.exists) {
            itemid = DocumentSnapshots['itemid'] ?? '';
            panelid = DocumentSnapshots['id'] ?? '';
            panelname = DocumentSnapshots['name'] ?? '';
            paneltype = DocumentSnapshots['type'] ?? '';
            panelquantity = DocumentSnapshots['quantity'] ?? '';
            panelpower = DocumentSnapshots['power'] ?? '';
            panelsystemvoltage = DocumentSnapshots['systemvoltage'] ?? 0;
            panelshort_circuit_current =
                DocumentSnapshots['short_circuit_current'] ?? 0;
            widget.appProvider.panelshort_circuit_current =
                panelshort_circuit_current;
            widget.appProvider.updatepanelshort_circuit_current(
                panelshort_circuit_current:
                    widget.appProvider.panelshort_circuit_current);
            panelopen_circuit_voltage =
                DocumentSnapshots['open_circuit_voltage'] ?? 0;
            panelsaleprice = DocumentSnapshots['sellingprice'] ?? 0;
            totalsaleprice = DocumentSnapshots['totalsellingprice'] ?? 0;
            stockquantity = DocumentSnapshots['stockquantiy'] ?? 0;
            panelpurchaseprice = DocumentSnapshots['buyingprice'] ?? 0;
            panelseries = DocumentSnapshots['series'] ?? 0;
            panelparrellel = DocumentSnapshots['parrellel'] ?? 0;
            DatabaseService().updatecalculationtemppanel(
                '${widget.Userid}_itempanel',
                panelid,
                panelname,
                paneltype,
                panelquantity,
                panelpower,
                panelsystemvoltage,
                panelshort_circuit_current,
                panelopen_circuit_voltage,
                panelsaleprice,
                panelpurchaseprice,
                panelicon,
                panelseries,
                panelparrellel,
                stockquantity,
                totalsaleprice);
            tempcontrollerrefference
                .doc(widget.Userid)
                .collection('Controller_${widget.Userid}')
                .get()
                .then((snapshot) {
              for (DocumentSnapshot doc in snapshot.docs) {
                doc.reference.delete();
              }
            }).whenComplete(() {
              if (widget.appProvider.maxmimumACpower != 0) {
                Future.delayed(Duration.zero, () async {
                  FirebaseFirestore.instance
                      .collection(equipmentCollection)
                      .where('Categoryname', isEqualTo: 'Controler')
                      .get()
                      .then((value) {
                    value.docs.forEach((element) {
                      String id = UniqueKey().toString();
                      if (element.data()['ratedVoltage'] >=
                              widget.appProvider.batterybusvoltage &&
                          element.data()['current'] >=
                              (panelshort_circuit_current *
                                      widget.appProvider.panelparrallel) *
                                  1.25 &&
                          (widget.appProvider.batterybusvoltage *
                                  element.data()['current'] *
                                  1.2) >=
                              (widget.appProvider.require_array_panel /
                                  (widget.appProvider.inverter_efficiency *
                                      widget.appProvider.peaksunhour))) {
                        DatabaseService().updatetempcontroller(
                            widget.Userid!,
                            element.data()['id'],
                            element.data()['id'],
                            element.data()['name'],
                            element.data()['type'],
                            element.data()['quantity'],
                            element.data()['ratedVoltage'],
                            element.data()['current'],
                            element.data()['sellingprice'],
                            element.data()['buyingprice'],
                            element.data()['image']);
                      }
                      // if (element.data()['current'] >=
                      //     (panelshort_circuit_current *
                      //             widget.appProvider.panelparrallel) *
                      //         1.25) {
                      //   DatabaseService().updatetempcontroller(
                      //       widget.Userid!,
                      //       element.data()['id'],
                      //       element.data()['id'],
                      //       element.data()['name'],
                      //       element.data()['type'],
                      //       element.data()['quantity'],
                      //       element.data()['ratedVoltage'],
                      //       element.data()['current'],
                      //       element.data()['sellingprice'],
                      //       element.data()['buyingprice'],
                      //       element.data()['image']);
                      // }
                      // if ((widget.appProvider.batterybusvoltage *
                      //         element.data()['current'] *
                      //         1.2) >=
                      //     (widget.appProvider.require_array_panel /
                      //         (widget.appProvider.inverter_efficiency *
                      //             widget.appProvider.peaksunhour))) {
                      //   DatabaseService().updatetempcontroller(
                      //       widget.Userid!,
                      //       element.data()['id'],
                      //       element.data()['id'],
                      //       element.data()['name'],
                      //       element.data()['type'],
                      //       element.data()['quantity'],
                      //       element.data()['ratedVoltage'],
                      //       element.data()['current'],
                      //       element.data()['sellingprice'],
                      //       element.data()['buyingprice'],
                      //       element.data()['image']);
                      // }
                    });
                  });
                });
              }
            });
          } else {
            panelid = widget.panelModel!.id!;
            panelname = widget.panelModel!.name!;
            paneltype = widget.panelModel!.type!;

            panelpower = widget.panelModel!.power;
            panelsystemvoltage = widget.panelModel!.voltage;
            panelshort_circuit_current =
                widget.panelModel!.short_circuit_current;
            widget.appProvider.panelshort_circuit_current =
                panelshort_circuit_current;
            widget.appProvider.updatepanelshort_circuit_current(
                panelshort_circuit_current:
                    widget.appProvider.panelshort_circuit_current);
            panelopen_circuit_voltage = widget.panelModel!.open_circuit_voltage;
            panelsaleprice = widget.panelModel!.sellingprice;
            totalsaleprice = widget.panelModel!.totalsellingprice;
            stockquantity = widget.panelModel!.stockquantiy;
            panelpurchaseprice = widget.panelModel!.buyingprice;
            Calculation().calmax_power_voltage(
                widget.appProvider, panelopen_circuit_voltage);
            Calculation().calenergy_per_module(widget.appProvider, panelpower);
            Calculation().calpv_module_energy_output(widget.appProvider);
            Calculation().calno_of_modules_c9(widget.appProvider);
            Calculation().calpanelseries(widget.appProvider);
            Calculation().calpanelparrallel(widget.appProvider);
            panelseries = widget.appProvider.panelseries;
            panelparrellel = widget.appProvider.panelparrallel;
            panelquantity = widget.appProvider.panelseries *
                widget.appProvider.panelparrallel;
            panelicon = widget.panelModel!.image!;

            DatabaseService().updatecalculationtemppanel(
                '${widget.Userid}_itempanel',
                panelid,
                panelname,
                paneltype,
                panelquantity,
                panelpower,
                panelsystemvoltage,
                panelshort_circuit_current,
                panelopen_circuit_voltage,
                panelsaleprice,
                panelpurchaseprice,
                panelicon,
                panelseries,
                panelparrellel,
                stockquantity,
                totalsaleprice);

            tempcontrollerrefference
                .doc(widget.Userid)
                .collection('Controller_${widget.Userid}')
                .get()
                .then((snapshot) {
              for (DocumentSnapshot doc in snapshot.docs) {
                doc.reference.delete();
              }
            }).whenComplete(() {
              if (widget.appProvider.maxmimumACpower != 0) {
                Future.delayed(Duration.zero, () async {
                  FirebaseFirestore.instance
                      .collection(equipmentCollection)
                      .where('Categoryname', isEqualTo: 'Controler')
                      .get()
                      .then((value) {
                    value.docs.forEach((element) {
                      String id = UniqueKey().toString();
                      if (element.data()['ratedVoltage'] >=
                              widget.appProvider.batterybusvoltage &&
                          element.data()['current'] >=
                              (panelshort_circuit_current *
                                      widget.appProvider.panelparrallel) *
                                  1.25 &&
                          (widget.appProvider.batterybusvoltage *
                                  element.data()['current'] *
                                  1.2) >=
                              (widget.appProvider.require_array_panel /
                                  (widget.appProvider.inverter_efficiency *
                                      widget.appProvider.peaksunhour))) {
                        DatabaseService().updatetempcontroller(
                            widget.Userid!,
                            element.data()['id'],
                            element.data()['id'],
                            element.data()['name'],
                            element.data()['type'],
                            element.data()['quantity'],
                            element.data()['ratedVoltage'],
                            element.data()['current'],
                            element.data()['sellingprice'],
                            element.data()['buyingprice'],
                            element.data()['image']);
                      }
                      // if (element.data()['current'] >=
                      //     (panelshort_circuit_current *
                      //             widget.appProvider.panelparrallel) *
                      //         1.25) {
                      //   DatabaseService().updatetempcontroller(
                      //       widget.Userid!,
                      //       element.data()['id'],
                      //       element.data()['id'],
                      //       element.data()['name'],
                      //       element.data()['type'],
                      //       element.data()['quantity'],
                      //       element.data()['ratedVoltage'],
                      //       element.data()['current'],
                      //       element.data()['sellingprice'],
                      //       element.data()['buyingprice'],
                      //       element.data()['image']);
                      // }
                      // if ((widget.appProvider.batterybusvoltage *
                      //         element.data()['current'] *
                      //         1.2) >=
                      //     (widget.appProvider.require_array_panel /
                      //         (widget.appProvider.inverter_efficiency *
                      //             widget.appProvider.peaksunhour))) {
                      //   DatabaseService().updatetempcontroller(
                      //       widget.Userid!,
                      //       element.data()['id'],
                      //       element.data()['id'],
                      //       element.data()['name'],
                      //       element.data()['type'],
                      //       element.data()['quantity'],
                      //       element.data()['ratedVoltage'],
                      //       element.data()['current'],
                      //       element.data()['sellingprice'],
                      //       element.data()['buyingprice'],
                      //       element.data()['image']);
                      // }
                    });
                  });
                });
              }
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: AppColor.outlinecard,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColor.lightyellow,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'PV Module',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.normal),
                  ),

                ],
              ),
            ),
            (!AppResponsive.isMobile(context))
           ? Row(
             // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  height: 200,
                  width: 100,
                  child: IconButton(
                    icon: Image.asset(
                      "assets/solar-cell.png",

                      fit: BoxFit.cover,
                    ),
                    onPressed: () {
                      Future.delayed(Duration.zero, () async {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (dialogContextpanel) {
                              final AppProvider appProvider =
                                  Provider.of<AppProvider>(
                                      dialogContextpanel);
                              return Center(
                                  child: AlertDialog(
                                      title: const Center(
                                        child: Text("Edit PV Module"),
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton.icon(
                                              icon: Icon(Icons.close,
                                                  size: 16,
                                                  color:
                                                      AppColor.bgColor),
                                              style: ElevatedButton
                                                  .styleFrom(
                                                      backgroundColor:
                                                          Colors.red),
                                              onPressed: () {
                                                Navigator.of(
                                                        dialogContextpanel)
                                                    .pop();
                                              },
                                              label: Text("Cancel",
                                                  style: TextStyle(
                                                      color: AppColor
                                                          .bgColor)),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      ],
                                      content: Container(
                                        color: AppColor.white,
                                        width: (!AppResponsive.isMobile(
                                                context))
                                            ? 400
                                            : MediaQuery.of(context)
                                                .size
                                                .width,
                                        height: MediaQuery.of(context)
                                            .size
                                            .height,
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                              ),
                                              margin: EdgeInsets.only(left: 10, right: 10),
                                              child: TextFormField(
                                                controller: searched,
                                                decoration: const InputDecoration(
                                                  prefixIcon: Icon(Icons.search),
                                                  hintText: 'Search Accessories',
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    name = value;
                                                  });
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            StreamBuilder<
                                                List<PvModuleModel?>?>(
                                              stream: DatabaseService(
                                                      doctoken: widget.Userid)
                                                  .temppanels,
                                              builder: (context, snapshot) {
                                                print(
                                                    'Hello ${snapshot.hasData}');
                                                if (snapshot.hasData) {
                                                  if (snapshot.data!.length ==
                                                      0) {
                                                    return Center(
                                                      child: NoData(),
                                                    );
                                                  } else {
                                                    return ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: snapshot
                                                            .data!.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return GestureDetector(
                                                            onTap: () async {
                                                              setState(() {
                                                                panelid = snapshot
                                                                    .data![
                                                                        index]!
                                                                    .id!;
                                                                panelname = snapshot
                                                                    .data![
                                                                        index]!
                                                                    .name!;
                                                                paneltype = snapshot
                                                                    .data![
                                                                        index]!
                                                                    .type!;
                                                                panelopen_circuit_voltage = snapshot
                                                                    .data![
                                                                        index]!
                                                                    .open_circuit_voltage;
                                                                panelpower =
                                                                    snapshot
                                                                        .data![
                                                                            index]!
                                                                        .power;
                                                                panelshort_circuit_current = snapshot
                                                                    .data![
                                                                        index]!
                                                                    .short_circuit_current;

                                                                widget.appProvider
                                                                        .panelshort_circuit_current =
                                                                    panelshort_circuit_current;
                                                                widget.appProvider.updatepanelshort_circuit_current(
                                                                    panelshort_circuit_current: widget
                                                                        .appProvider
                                                                        .panelshort_circuit_current);
                                                                panelvoltage =
                                                                    snapshot
                                                                        .data![
                                                                            index]!
                                                                        .voltage;
                                                                panelsaleprice = snapshot
                                                                    .data![
                                                                        index]!
                                                                    .sellingprice;
                                                                panelicon = snapshot
                                                                    .data![
                                                                        index]!
                                                                    .image!;
                                                                panelpurchaseprice = snapshot
                                                                    .data![
                                                                        index]!
                                                                    .buyingprice!;
                                                                stockquantity -
                                                                    snapshot
                                                                        .data![
                                                                            index]!
                                                                        .stockquantiy!;
                                                                totalsaleprice = snapshot
                                                                    .data![
                                                                        index]!
                                                                    .totalsellingprice!;
                                                              });

                                                              Calculation()
                                                                  .calmax_power_voltage(
                                                                      widget
                                                                          .appProvider,
                                                                      panelopen_circuit_voltage);
                                                              Calculation()
                                                                  .calenergy_per_module(
                                                                      widget
                                                                          .appProvider,
                                                                      panelpower);
                                                              Calculation()
                                                                  .calpv_module_energy_output(
                                                                      widget
                                                                          .appProvider);
                                                              Calculation()
                                                                  .calno_of_modules_c9(
                                                                      widget
                                                                          .appProvider);
                                                              Calculation()
                                                                  .calpanelseries(
                                                                      widget
                                                                          .appProvider);
                                                              Calculation()
                                                                  .calpanelparrallel(
                                                                      widget
                                                                          .appProvider);
                                                              panelseries = widget
                                                                  .appProvider
                                                                  .panelseries;
                                                              panelparrellel = widget
                                                                  .appProvider
                                                                  .panelparrallel;
                                                              panelquantity = widget
                                                                      .appProvider
                                                                      .panelseries *
                                                                  widget
                                                                      .appProvider
                                                                      .panelparrallel;
                                                              panelicon = widget
                                                                  .panelModel!
                                                                  .image!;
                                                              DatabaseService().updatecalculationtemppanel(
                                                                  '${widget.Userid}_itempanel',
                                                                  panelid,
                                                                  panelname,
                                                                  paneltype,
                                                                  panelquantity,
                                                                  panelpower,
                                                                  panelsystemvoltage,
                                                                  panelshort_circuit_current,
                                                                  panelopen_circuit_voltage,
                                                                  panelsaleprice,
                                                                  panelpurchaseprice,
                                                                  panelicon,
                                                                  panelseries,
                                                                  panelparrellel,
                                                                  stockquantity,
                                                                  totalsaleprice);

                                                              tempcontrollerrefference
                                                                  .doc(widget
                                                                      .Userid)
                                                                  .collection(
                                                                      'Controller_${widget.Userid}')
                                                                  .get()
                                                                  .then(
                                                                      (snapshot) {
                                                                for (DocumentSnapshot doc
                                                                    in snapshot
                                                                        .docs) {
                                                                  doc.reference
                                                                      .delete();
                                                                }
                                                              }).whenComplete(
                                                                      () {
                                                                if (widget
                                                                        .appProvider
                                                                        .maxmimumACpower !=
                                                                    0) {
                                                                  Future.delayed(
                                                                      Duration
                                                                          .zero,
                                                                      () async {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            equipmentCollection)
                                                                        .where(
                                                                            'Categoryname',
                                                                            isEqualTo:
                                                                                'Controler')
                                                                        .get()
                                                                        .then(
                                                                            (value) {
                                                                      value
                                                                          .docs
                                                                          .forEach((element) {
                                                                        String
                                                                            id =
                                                                            UniqueKey().toString();
                                                                        if (element.data()['ratedVoltage'] >= widget.appProvider.batterybusvoltage &&
                                                                            element.data()['current'] >= (panelshort_circuit_current * widget.appProvider.panelparrallel) * 1.25 &&
                                                                            (widget.appProvider.batterybusvoltage * element.data()['current'] * 1.2) >= (widget.appProvider.require_array_panel / (widget.appProvider.inverter_efficiency * widget.appProvider.peaksunhour))) {
                                                                          DatabaseService().updatetempcontroller(
                                                                              widget.Userid!,
                                                                              element.data()['id'],
                                                                              element.data()['id'],
                                                                              element.data()['name'],
                                                                              element.data()['type'],
                                                                              element.data()['quantity'],
                                                                              element.data()['ratedVoltage'],
                                                                              element.data()['current'],
                                                                              element.data()['sellingprice'],
                                                                              element.data()['buyingprice'],
                                                                              element.data()['image']);
                                                                        }
                                                                        // if (element.data()['current'] >=
                                                                        //     (panelshort_circuit_current *
                                                                        //             widget.appProvider.panelparrallel) *
                                                                        //         1.25) {
                                                                        //   DatabaseService().updatetempcontroller(
                                                                        //       widget.Userid!,
                                                                        //       element.data()['id'],
                                                                        //       element.data()['id'],
                                                                        //       element.data()['name'],
                                                                        //       element.data()['type'],
                                                                        //       element.data()['quantity'],
                                                                        //       element.data()['ratedVoltage'],
                                                                        //       element.data()['current'],
                                                                        //       element.data()['sellingprice'],
                                                                        //       element.data()['buyingprice'],
                                                                        //       element.data()['image']);
                                                                        // }
                                                                        // if ((widget.appProvider.batterybusvoltage *
                                                                        //         element.data()['current'] *
                                                                        //         1.2) >=
                                                                        //     (widget.appProvider.require_array_panel /
                                                                        //         (widget.appProvider.inverter_efficiency *
                                                                        //             widget.appProvider.peaksunhour))) {
                                                                        //   DatabaseService().updatetempcontroller(
                                                                        //       widget.Userid!,
                                                                        //       element.data()['id'],
                                                                        //       element.data()['id'],
                                                                        //       element.data()['name'],
                                                                        //       element.data()['type'],
                                                                        //       element.data()['quantity'],
                                                                        //       element.data()['ratedVoltage'],
                                                                        //       element.data()['current'],
                                                                        //       element.data()['sellingprice'],
                                                                        //       element.data()['buyingprice'],
                                                                        //       element.data()['image']);
                                                                        // }
                                                                      });
                                                                    });
                                                                  });
                                                                }
                                                              });
                                                              Navigator.of(
                                                                      dialogContextpanel)
                                                                  .pop();
                                                              // getTempdata();
                                                            },
                                                            child: Card(
                                                              elevation: 10,
                                                              shadowColor:
                                                                  AppColor
                                                                      .outlinecard,
                                                              child:
                                                                  Container(
                                                                margin: const EdgeInsets
                                                                        .only(
                                                                    top:
                                                                        appPadding),
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        10 /
                                                                            2),
                                                                child: (!AppResponsive.isMobile(context))
                                                                      ?Row(
                                                                  children: [
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                      BorderRadius.circular(40),
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/solar-cell.png",height: 70,width: 70,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width:
                                                                      10,
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                      const EdgeInsets.symmetric(horizontal: 1),
                                                                      child:
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            snapshot.data![index]!.name!,
                                                                            style: TextStyle(fontSize: 16.0, color: AppColor.black, fontWeight: FontWeight.w600),
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              // Text(
                                                                              //   'type: ${snapshot.data![index]!.type}',
                                                                              //   style: TextStyle(
                                                                              //     color: AppColor.black.withOpacity(0.5),
                                                                              //     fontSize: 14,
                                                                              //   ),
                                                                              // ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              // Text(
                                                                              //   'Open Circuit Voltage ${snapshot.data![index]!.open_circuit_voltage} V',
                                                                              //   style: TextStyle(
                                                                              //     color: AppColor.black.withOpacity(0.5),
                                                                              //     fontSize: 14,
                                                                              //   ),
                                                                              // ),
                                                                              // Text(
                                                                              //   'Power ${snapshot.data![index]!.power} W',
                                                                              //   style: TextStyle(
                                                                              //     color: AppColor.black.withOpacity(0.5),
                                                                              //     fontSize: 14,
                                                                              //   ),
                                                                              // ),
                                                                              Text(
                                                                                'Voltage ${snapshot.data![index]!.voltage} V',
                                                                                style: TextStyle(
                                                                                  color: AppColor.black.withOpacity(0.5),
                                                                                  fontSize: 14,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                'Price ${NumberFormat('#,###').format(snapshot.data![index]!.totalsellingprice)} CFA',
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
                                                                )

                                                                    :Row(
                                                                  children: [
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                      BorderRadius.circular(40),
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/solar-cell.png",height: 70,width: 70,

                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width:
                                                                      10,
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                      const EdgeInsets.symmetric(horizontal: 1),
                                                                      child:
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            snapshot.data![index]!.name!,
                                                                            style: TextStyle(fontSize: 16.0, color: AppColor.black, fontWeight: FontWeight.w600),
                                                                          ),

                                                                          Text(
                                                                            'Voltage ${snapshot.data![index]!.voltage} V',
                                                                            style: TextStyle(
                                                                              color: AppColor.black.withOpacity(0.5),
                                                                              fontSize: 14,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            'Price ${NumberFormat('#,###').format(snapshot.data![index]!.totalsellingprice)} CFA',
                                                                            style: TextStyle(
                                                                              color: AppColor.black.withOpacity(0.5),
                                                                              fontSize: 14,
                                                                            ),
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
                                      )));
                            });
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Expanded(
                  child: Container(
                    // margin: const EdgeInsets.all(10),
                    // padding: const EdgeInsets.all(10),
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
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 10, bottom: 10),
                            child: Text(
                              panelname,
                              style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: 16.0,
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
                                'Voltage: ${panelsystemvoltage}V',
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.normal),
                              ),
                              Text(
                                'Power: $panelpower W',
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.normal),
                              ),
                              Text(
                                'Energy: ${widget.appProvider.pv_module_energy_output * panelquantity} W',
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
                                'Quantity: $panelquantity',
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.normal),
                              ),
                              Text(
                                'Series: $panelseries',
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.normal),
                              ),
                              Text(
                                'Parallel: $panelparrellel',
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
                                'Price: ${NumberFormat('#,###').format(panelsaleprice)} CFA',
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.normal),
                              ),
                              Text(
                                'Total Price: ${NumberFormat('#,###').format(totalsaleprice)} CFA',
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.normal),
                              ),
                              Text(
                                'Stock Quantity: ${NumberFormat('#,###').format(stockquantity)}',
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
              ],
            )
                : Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  height: 150,
                  width: 120,
                  child: IconButton(
                    icon: Image.asset(
                      "assets/solar-cell.png",

                      fit: BoxFit.cover,
                    ),
                    onPressed: () {
                      Future.delayed(Duration.zero, () async {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (dialogContextpanel) {
                              final AppProvider appProvider =
                              Provider.of<AppProvider>(
                                  dialogContextpanel);
                              return Center(
                                  child: AlertDialog(
                                      title: const Center(
                                        child: Text("Edit PV Module"),
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton.icon(
                                              icon: Icon(Icons.close,
                                                  size: 16,
                                                  color:
                                                  AppColor.bgColor),
                                              style: ElevatedButton
                                                  .styleFrom(
                                                  backgroundColor:
                                                  Colors.red),
                                              onPressed: () {
                                                Navigator.of(
                                                    dialogContextpanel)
                                                    .pop();
                                              },
                                              label: Text("Cancel",
                                                  style: TextStyle(
                                                      color: AppColor
                                                          .bgColor)),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      ],
                                      content: Container(
                                        color: AppColor.white,
                                        width: (!AppResponsive.isMobile(
                                            context))
                                            ? 400
                                            : MediaQuery.of(context)
                                            .size
                                            .width,
                                        height: MediaQuery.of(context)
                                            .size
                                            .height,
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                              ),
                                              margin: EdgeInsets.only(left: 10, right: 10),
                                              child: TextFormField(
                                                controller: searched,
                                                decoration: const InputDecoration(
                                                  prefixIcon: Icon(Icons.search),
                                                  hintText: 'Search Accessories',
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    name = value;
                                                  });
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            StreamBuilder<
                                                List<PvModuleModel?>?>(
                                              stream: DatabaseService(
                                                  doctoken: widget.Userid)
                                                  .temppanels,
                                              builder: (context, snapshot) {
                                                print(
                                                    'Hello ${snapshot.hasData}');
                                                if (snapshot.hasData) {
                                                  if (snapshot.data!.length ==
                                                      0) {
                                                    return Center(
                                                      child: NoData(),
                                                    );
                                                  } else {
                                                    return ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: snapshot
                                                            .data!.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return GestureDetector(
                                                            onTap: () async {
                                                              setState(() {
                                                                panelid = snapshot
                                                                    .data![
                                                                index]!
                                                                    .id!;
                                                                panelname = snapshot
                                                                    .data![
                                                                index]!
                                                                    .name!;
                                                                paneltype = snapshot
                                                                    .data![
                                                                index]!
                                                                    .type!;
                                                                panelopen_circuit_voltage = snapshot
                                                                    .data![
                                                                index]!
                                                                    .open_circuit_voltage;
                                                                panelpower =
                                                                    snapshot
                                                                        .data![
                                                                    index]!
                                                                        .power;
                                                                panelshort_circuit_current = snapshot
                                                                    .data![
                                                                index]!
                                                                    .short_circuit_current;

                                                                widget.appProvider
                                                                    .panelshort_circuit_current =
                                                                    panelshort_circuit_current;
                                                                widget.appProvider.updatepanelshort_circuit_current(
                                                                    panelshort_circuit_current: widget
                                                                        .appProvider
                                                                        .panelshort_circuit_current);
                                                                panelvoltage =
                                                                    snapshot
                                                                        .data![
                                                                    index]!
                                                                        .voltage;
                                                                panelsaleprice = snapshot
                                                                    .data![
                                                                index]!
                                                                    .sellingprice;
                                                                panelicon = snapshot
                                                                    .data![
                                                                index]!
                                                                    .image!;
                                                                panelpurchaseprice = snapshot
                                                                    .data![
                                                                index]!
                                                                    .buyingprice!;
                                                                stockquantity -
                                                                    snapshot
                                                                        .data![
                                                                    index]!
                                                                        .stockquantiy!;
                                                                totalsaleprice = snapshot
                                                                    .data![
                                                                index]!
                                                                    .totalsellingprice!;
                                                              });

                                                              Calculation()
                                                                  .calmax_power_voltage(
                                                                  widget
                                                                      .appProvider,
                                                                  panelopen_circuit_voltage);
                                                              Calculation()
                                                                  .calenergy_per_module(
                                                                  widget
                                                                      .appProvider,
                                                                  panelpower);
                                                              Calculation()
                                                                  .calpv_module_energy_output(
                                                                  widget
                                                                      .appProvider);
                                                              Calculation()
                                                                  .calno_of_modules_c9(
                                                                  widget
                                                                      .appProvider);
                                                              Calculation()
                                                                  .calpanelseries(
                                                                  widget
                                                                      .appProvider);
                                                              Calculation()
                                                                  .calpanelparrallel(
                                                                  widget
                                                                      .appProvider);
                                                              panelseries = widget
                                                                  .appProvider
                                                                  .panelseries;
                                                              panelparrellel = widget
                                                                  .appProvider
                                                                  .panelparrallel;
                                                              panelquantity = widget
                                                                  .appProvider
                                                                  .panelseries *
                                                                  widget
                                                                      .appProvider
                                                                      .panelparrallel;
                                                              panelicon = widget
                                                                  .panelModel!
                                                                  .image!;
                                                              DatabaseService().updatecalculationtemppanel(
                                                                  '${widget.Userid}_itempanel',
                                                                  panelid,
                                                                  panelname,
                                                                  paneltype,
                                                                  panelquantity,
                                                                  panelpower,
                                                                  panelsystemvoltage,
                                                                  panelshort_circuit_current,
                                                                  panelopen_circuit_voltage,
                                                                  panelsaleprice,
                                                                  panelpurchaseprice,
                                                                  panelicon,
                                                                  panelseries,
                                                                  panelparrellel,
                                                                  stockquantity,
                                                                  totalsaleprice);

                                                              tempcontrollerrefference
                                                                  .doc(widget
                                                                  .Userid)
                                                                  .collection(
                                                                  'Controller_${widget.Userid}')
                                                                  .get()
                                                                  .then(
                                                                      (snapshot) {
                                                                    for (DocumentSnapshot doc
                                                                    in snapshot
                                                                        .docs) {
                                                                      doc.reference
                                                                          .delete();
                                                                    }
                                                                  }).whenComplete(
                                                                      () {
                                                                    if (widget
                                                                        .appProvider
                                                                        .maxmimumACpower !=
                                                                        0) {
                                                                      Future.delayed(
                                                                          Duration
                                                                              .zero,
                                                                              () async {
                                                                            FirebaseFirestore
                                                                                .instance
                                                                                .collection(
                                                                                equipmentCollection)
                                                                                .where(
                                                                                'Categoryname',
                                                                                isEqualTo:
                                                                                'Controler')
                                                                                .get()
                                                                                .then(
                                                                                    (value) {
                                                                                  value
                                                                                      .docs
                                                                                      .forEach((element) {
                                                                                    String
                                                                                    id =
                                                                                    UniqueKey().toString();
                                                                                    if (element.data()['ratedVoltage'] >= widget.appProvider.batterybusvoltage &&
                                                                                        element.data()['current'] >= (panelshort_circuit_current * widget.appProvider.panelparrallel) * 1.25 &&
                                                                                        (widget.appProvider.batterybusvoltage * element.data()['current'] * 1.2) >= (widget.appProvider.require_array_panel / (widget.appProvider.inverter_efficiency * widget.appProvider.peaksunhour))) {
                                                                                      DatabaseService().updatetempcontroller(
                                                                                          widget.Userid!,
                                                                                          element.data()['id'],
                                                                                          element.data()['id'],
                                                                                          element.data()['name'],
                                                                                          element.data()['type'],
                                                                                          element.data()['quantity'],
                                                                                          element.data()['ratedVoltage'],
                                                                                          element.data()['current'],
                                                                                          element.data()['sellingprice'],
                                                                                          element.data()['buyingprice'],
                                                                                          element.data()['image']);
                                                                                    }
                                                                                    // if (element.data()['current'] >=
                                                                                    //     (panelshort_circuit_current *
                                                                                    //             widget.appProvider.panelparrallel) *
                                                                                    //         1.25) {
                                                                                    //   DatabaseService().updatetempcontroller(
                                                                                    //       widget.Userid!,
                                                                                    //       element.data()['id'],
                                                                                    //       element.data()['id'],
                                                                                    //       element.data()['name'],
                                                                                    //       element.data()['type'],
                                                                                    //       element.data()['quantity'],
                                                                                    //       element.data()['ratedVoltage'],
                                                                                    //       element.data()['current'],
                                                                                    //       element.data()['sellingprice'],
                                                                                    //       element.data()['buyingprice'],
                                                                                    //       element.data()['image']);
                                                                                    // }
                                                                                    // if ((widget.appProvider.batterybusvoltage *
                                                                                    //         element.data()['current'] *
                                                                                    //         1.2) >=
                                                                                    //     (widget.appProvider.require_array_panel /
                                                                                    //         (widget.appProvider.inverter_efficiency *
                                                                                    //             widget.appProvider.peaksunhour))) {
                                                                                    //   DatabaseService().updatetempcontroller(
                                                                                    //       widget.Userid!,
                                                                                    //       element.data()['id'],
                                                                                    //       element.data()['id'],
                                                                                    //       element.data()['name'],
                                                                                    //       element.data()['type'],
                                                                                    //       element.data()['quantity'],
                                                                                    //       element.data()['ratedVoltage'],
                                                                                    //       element.data()['current'],
                                                                                    //       element.data()['sellingprice'],
                                                                                    //       element.data()['buyingprice'],
                                                                                    //       element.data()['image']);
                                                                                    // }
                                                                                  });
                                                                                });
                                                                          });
                                                                    }
                                                                  });
                                                              Navigator.of(
                                                                  dialogContextpanel)
                                                                  .pop();
                                                              // getTempdata();
                                                            },
                                                            child: Card(
                                                              elevation: 10,
                                                              shadowColor:
                                                              AppColor
                                                                  .outlinecard,
                                                              child:
                                                              Container(
                                                                margin: const EdgeInsets
                                                                    .only(
                                                                    top:
                                                                    appPadding),
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    10 /
                                                                        2),
                                                                child: (!AppResponsive.isMobile(context))
                                                                    ?Row(
                                                                  children: [
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                      BorderRadius.circular(40),
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/solar-cell.png",
width: 70,height: 70,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width:
                                                                      10,
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                      const EdgeInsets.symmetric(horizontal: 1),
                                                                      child:
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            snapshot.data![index]!.name!,
                                                                            style: TextStyle(fontSize: 16.0, color: AppColor.black, fontWeight: FontWeight.w600),
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              // Text(
                                                                              //   'type: ${snapshot.data![index]!.type}',
                                                                              //   style: TextStyle(
                                                                              //     color: AppColor.black.withOpacity(0.5),
                                                                              //     fontSize: 14,
                                                                              //   ),
                                                                              // ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              // Text(
                                                                              //   'Open Circuit Voltage ${snapshot.data![index]!.open_circuit_voltage} V',
                                                                              //   style: TextStyle(
                                                                              //     color: AppColor.black.withOpacity(0.5),
                                                                              //     fontSize: 14,
                                                                              //   ),
                                                                              // ),
                                                                              // Text(
                                                                              //   'Power ${snapshot.data![index]!.power} W',
                                                                              //   style: TextStyle(
                                                                              //     color: AppColor.black.withOpacity(0.5),
                                                                              //     fontSize: 14,
                                                                              //   ),
                                                                              // ),
                                                                              Text(
                                                                                'Voltage: ${snapshot.data![index]!.voltage} V',
                                                                                style: TextStyle(
                                                                                  color: AppColor.black.withOpacity(0.5),
                                                                                  fontSize: 14,
                                                                                ),
                                                                              ),
                                                                              Text(

                                                                                'Price: ${NumberFormat('#,###').format(snapshot.data![index]!.totalsellingprice)} CFA',
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
                                                                )

                                                                    :Row(
                                                                  children: [
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                      BorderRadius.circular(40),
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/solar-cell.png",

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
                                                                      padding:
                                                                      const EdgeInsets.symmetric(horizontal: 1),
                                                                      child:
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            snapshot.data![index]!.name!,
                                                                            style: TextStyle(fontSize: 16.0, color: AppColor.black, fontWeight: FontWeight.w600),
                                                                          ),

                                                                          Text(
                                                                            'Voltage ${snapshot.data![index]!.voltage} V',
                                                                            style: TextStyle(
                                                                              color: AppColor.black.withOpacity(0.5),
                                                                              fontSize: 14,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            'Price ${NumberFormat('#,###').format(snapshot.data![index]!.totalsellingprice)} CFA',
                                                                            style: TextStyle(
                                                                              color: AppColor.black.withOpacity(0.5),
                                                                              fontSize: 14,
                                                                            ),
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
                                      )));
                            });
                      });
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          // margin: const EdgeInsets.all(10),
                          // padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          // height: 200.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 10, bottom: 10),
                                    child: Text(
                                      panelname,
                                      style: TextStyle(
                                          color: AppColor.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal),
                                    ),
                                  ),
                                ),
                              const  SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Voltage: ',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal),
                                    ),
                                    Text(
                                      ' ${panelsystemvoltage} V',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal),
                                    ),
                                  ],
                                ),
                                const  SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Power: ',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal),
                                    ),
                                    Text(
                                      ' $panelpower W',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal),
                                    ),
                                  ],
                                ),
                                const  SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Energy: ',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal),
                                    ),

                                    Text(
                                      ' ${NumberFormat('#,###').format(widget.appProvider.pv_module_energy_output * panelquantity)} W',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal),
                                    ),
                                  ],
                                ),
                                const  SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Quantity: ',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal),
                                    ),
                                    Text(
                                      ' ${NumberFormat('#,###').format( panelquantity)}',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal),
                                    ),
                                  ],
                                ),
                                const  SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Series: ',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal),
                                    ),
                                    Text(
                                      '$panelseries',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal),
                                    ),
                                  ],
                                ),
                                const  SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Parallel: ',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal),
                                    ),
                                    Text(
                                      '$panelparrellel',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal),
                                    ),
                                  ],
                                ),
                                const  SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Price: ',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal),
                                    ),
                                    Text(
                                      '${NumberFormat('#,###').format(panelsaleprice)} CFA',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal),
                                    ),
                                  ],
                                ),
                                const  SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total Price: ',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal),
                                    ),
                                    Text(
                                      '${NumberFormat('#,###').format(totalsaleprice)} CFA',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal),
                                    ),
                                  ],
                                ),
                                const  SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Stock Quantity: ',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal),
                                    ),
                                    Text(
                                      ' $stockquantity',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal),
                                    ),
                                  ],
                                ),
                                const  SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
