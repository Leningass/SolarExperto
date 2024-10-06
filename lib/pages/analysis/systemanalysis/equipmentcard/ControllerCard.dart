import 'package:SolarExperto/models/equipments/controllermodel.dart';
import 'package:SolarExperto/pages/analysis/systemanalysis/equipmentcard/panelcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_responsive.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/enumerators.dart';
import '../../../../constants/size_config.dart';
import '../../../../global_widgets/Loading/loading.dart';
import '../../../../global_widgets/nodata/noitems.dart';
import '../../../../navbar/locator.dart';
import '../../../../navbar/navigation_service.dart';
import '../../../../provider/app_provider.dart';
import '../../../../services/database/database_service.dart';
import '../../../../utilis/calculation.dart';

class Controllercard extends StatefulWidget {
  const Controllercard(
      {Key? key, this.controllerModel, required this.appProvider, this.Userid})
      : super(key: key);
  final ChargeControllerModel? controllerModel;
  final AppProvider appProvider;
  final String? Userid;

  @override
  State<Controllercard> createState() => _ControllercardState();
}

class _ControllercardState extends State<Controllercard> {
  String itemid = '';
  String controllerid = '';
  String controllername = '';
  String controllertype = '';
  dynamic controllerquantity = 0;
  dynamic controllervoltage = 0;
  dynamic controllercurrent = 0;
  dynamic controllersaleprice = 0.0;
  dynamic controllerpurchaseprice = 0.0;
  String controllericon = '';

  @override
  void initState() {
    //Future.delayed(const Duration(seconds: 2), () async {
    getTempdata();
    // });

    super.initState();
  }

  void getTempdata() {
    // FirebaseFirestore.instance
    //     .collection(tempcalculation)
    //     .doc('${widget.Userid}_itemcontroller')
    //     .get()
    //     .then((DocumentSnapshot) {
    //   if (mounted) {
    //     setState(() {
    //       if (DocumentSnapshot.exists) {
    //         itemid = DocumentSnapshot['itemid'] ?? '';
    //         controllerid = DocumentSnapshot['id'] ?? '';
    //         controllername = DocumentSnapshot['name'] ?? '';
    //         controllertype = DocumentSnapshot['type'] ?? '';
    //         controllerquantity = DocumentSnapshot['quantity'] ?? 0;
    //         controllervoltage = DocumentSnapshot['ratedVoltage'] ?? 0.0;
    //         controllercurrent = DocumentSnapshot['current'] ?? 0.0;
    //         controllersaleprice = DocumentSnapshot['sellingprice'] ?? 0.0;
    //         controllerpurchaseprice = DocumentSnapshot['buyingprice'] ?? 0.0;
    //         controllericon = DocumentSnapshot['image'] ?? '';
    //         DatabaseService().updatetempcalculationcontroller(
    //             '${widget.Userid}_itemcontroller',
    //             controllerid,
    //             controllername,
    //             controllertype,
    //             controllerquantity,
    //             controllervoltage,
    //             controllercurrent,
    //             controllersaleprice,
    //             controllerpurchaseprice,
    //             controllericon);
    //       } else {
    controllerid = widget.controllerModel!.id!;
    controllername = widget.controllerModel!.name!;
    controllertype = widget.controllerModel!.type!;
    // controllerquantity = widget.controllerModel.c;
    controllerquantity = widget.controllerModel!.quantity;
    controllervoltage = widget.controllerModel!.ratedVoltage;
    controllercurrent = widget.controllerModel!.current;
    controllersaleprice = widget.controllerModel!.sellingprice;
    controllerpurchaseprice = widget.controllerModel!.buyingprice;
    controllericon = widget.controllerModel!.image!;

    DatabaseService().updatetempcalculationcontroller(
        '${widget.Userid}_itemcontroller',
        controllerid,
        controllername,
        controllertype,
        controllerquantity,
        controllervoltage,
        controllercurrent,
        controllersaleprice,
        controllerpurchaseprice,
        controllericon);
    //       }
    //     });
    //   }
    // });
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
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(3),
                vertical: getProportionateScreenHeight(3),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Charge Controller',
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
                              Container(
                                height: 120,
                                width: 120,
                                child: IconButton(
                                  icon: Image.asset(
                                    "assets/controller.png",
                                   height: 70,
                                    width: 70,
                                    fit: BoxFit.cover,
                                  ),
                                  onPressed: () {
                                    /*Future.delayed(Duration.zero, () async {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (dialogContextbattery) {
                                      final AppProvider appProvider =
                                          Provider.of<AppProvider>(
                                              dialogContextbattery);
                                      return Center(
                                          child: AlertDialog(
                                              title: const Center(
                                                child: Text("Edit Controller"),
                                              ),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton.icon(
                                                      icon: Icon(Icons.close,
                                                          size: 16,
                                                          color: AppColor.bgColor),
                                                      style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                          Colors.red),
                                                      onPressed: () {
                                                        Navigator.of(
                                                            dialogContextbattery)
                                                            .pop();
                                                      },
                                                      label: Text("Cancel",
                                                          style: TextStyle(
                                                              color:
                                                              AppColor.bgColor)),
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
                                                child: StreamBuilder<
                                                    List<
                                                        ChargeControllerModel?>?>(
                                                  stream: DatabaseService(
                                                          doctoken: widget
                                                              .controllerModel!
                                                              .id)
                                                      .controllers,
                                                  builder: (context, snapshot) {
                                                    print(
                                                        'Hello ${snapshot.hasData}');
                                                    if (snapshot.hasData) {
                                                      if (snapshot
                                                              .data!.length ==
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
                                                                (context,
                                                                    index) {
                                                              return GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  setState(() {
                                                                    controllerid =
                                                                        snapshot
                                                                            .data![index]!
                                                                            .id!;
                                                                    controllername = snapshot
                                                                        .data![
                                                                            index]!
                                                                        .name!;
                                                                    controllertype = snapshot
                                                                        .data![
                                                                            index]!
                                                                        .type!;

                                                                    controllervoltage = snapshot
                                                                        .data![
                                                                            index]!
                                                                        .ratedVoltage;
                                                                    controllercurrent = snapshot
                                                                        .data![
                                                                            index]!
                                                                        .current;

                                                                    controllericon = snapshot
                                                                        .data![
                                                                            index]!
                                                                        .image!;
                                                                    controllersaleprice = snapshot
                                                                        .data![
                                                                            index]!
                                                                        .sellingprice;
                                                                  });

                                                                  // DatabaseService().updatetempcontroller(
                                                                  //     '${widget.Userid}_itemcontroller',
                                                                  //     controllerid,
                                                                  //     controllername,
                                                                  //     controllertype,
                                                                  //     controllerquantity,
                                                                  //     controllervoltage,
                                                                  //     controllercurrent,
                                                                  //     controllersaleprice,
                                                                  //     controllericon);

                                                                  Navigator.of(
                                                                          dialogContextbattery)
                                                                      .pop();
                                                                  widget
                                                                      .appProvider
                                                                      .changevalue = true;
                                                                  widget.appProvider.updatechangevalue(
                                                                      changevalue: widget
                                                                          .appProvider
                                                                          .changevalue);
                                                                  getTempdata();
                                                                  appProvider.changeCurrentPage(
                                                                      DisplayedPage
                                                                          .ANALYSIS);
                                                                  locator<NavigationService>()
                                                                      .navigateTo(
                                                                          AnalysisRoute);
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
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        10 / 2),
                                                                    child: Row(
                                                                      children: [
                                                                        ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(40),
                                                                          child:
                                                                              Image.network(
                                                                            snapshot.data![index]!.image!,
                                                                            loadingBuilder: (BuildContext context,
                                                                                Widget child,
                                                                                ImageChunkEvent? loadingProgress) {
                                                                              if (loadingProgress == null)
                                                                                return child;
                                                                              return Center(
                                                                                child: CircularProgressIndicator(
                                                                                  value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                                                                ),
                                                                              );
                                                                            },
                                                                            errorBuilder: (BuildContext context,
                                                                                Object exception,
                                                                                StackTrace? stackTrace) {
                                                                              return const CircularProgressIndicator();
                                                                            },
                                                                            height:
                                                                                38,
                                                                            width:
                                                                                38,
                                                                            fit:
                                                                                BoxFit.cover,
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
                                                                                  Text(
                                                                                    'type: ${snapshot.data![index]!.type}',
                                                                                    style: TextStyle(
                                                                                      color: AppColor.black.withOpacity(0.5),
                                                                                      fontSize: 14,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    'U: ${snapshot.data![index]!.ratedVoltage} V',
                                                                                    style: TextStyle(
                                                                                      color: AppColor.black.withOpacity(0.5),
                                                                                      fontSize: 14,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    'I: ${snapshot.data![index]!.current} A',
                                                                                    style: TextStyle(
                                                                                      color: AppColor.black.withOpacity(0.5),
                                                                                      fontSize: 14,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    'price : ${snapshot.data![index]!.sellingprice} CFA',
                                                                                    style: TextStyle(
                                                                                      color: AppColor.black.withOpacity(0.5),
                                                                                      fontSize: 14,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
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
                                              )));
                                    });
                              });*/
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
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
                                            controllername,
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
                                              'Rated Voltage:  $controllervoltage V',
                                              style: const TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w800,
                                                  fontStyle: FontStyle.normal),
                                            ),
                                            Text(
                                              'Current: $controllercurrent A',
                                              style: const TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w800,
                                                  fontStyle: FontStyle.normal),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Stock Quantity: $controllerquantity',
                                              style: const TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w800,
                                                  fontStyle: FontStyle.normal),
                                            ),
                                            Text(
                                              'Price:  ${NumberFormat('#,###').format(controllersaleprice)} CFA',
                                              style: const TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w800,
                                                  fontStyle: FontStyle.normal),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ])
                      : Column(
                          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              Container(
                                height: 120,
                                width: 120,
                                child: IconButton(
                                  icon: Image.asset(
                                    "assets/controller.png",

                                    fit: BoxFit.cover,
                                  ),
                                  onPressed: () {
                                    /*Future.delayed(Duration.zero, () async {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (dialogContextbattery) {
                                      final AppProvider appProvider =
                                          Provider.of<AppProvider>(
                                              dialogContextbattery);
                                      return Center(
                                          child: AlertDialog(
                                              title: const Center(
                                                child: Text("Edit Controller"),
                                              ),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton.icon(
                                                      icon: Icon(Icons.close,
                                                          size: 16,
                                                          color: AppColor.bgColor),
                                                      style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                          Colors.red),
                                                      onPressed: () {
                                                        Navigator.of(
                                                            dialogContextbattery)
                                                            .pop();
                                                      },
                                                      label: Text("Cancel",
                                                          style: TextStyle(
                                                              color:
                                                              AppColor.bgColor)),
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
                                                child: StreamBuilder<
                                                    List<
                                                        ChargeControllerModel?>?>(
                                                  stream: DatabaseService(
                                                          doctoken: widget
                                                              .controllerModel!
                                                              .id)
                                                      .controllers,
                                                  builder: (context, snapshot) {
                                                    print(
                                                        'Hello ${snapshot.hasData}');
                                                    if (snapshot.hasData) {
                                                      if (snapshot
                                                              .data!.length ==
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
                                                                (context,
                                                                    index) {
                                                              return GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  setState(() {
                                                                    controllerid =
                                                                        snapshot
                                                                            .data![index]!
                                                                            .id!;
                                                                    controllername = snapshot
                                                                        .data![
                                                                            index]!
                                                                        .name!;
                                                                    controllertype = snapshot
                                                                        .data![
                                                                            index]!
                                                                        .type!;

                                                                    controllervoltage = snapshot
                                                                        .data![
                                                                            index]!
                                                                        .ratedVoltage;
                                                                    controllercurrent = snapshot
                                                                        .data![
                                                                            index]!
                                                                        .current;

                                                                    controllericon = snapshot
                                                                        .data![
                                                                            index]!
                                                                        .image!;
                                                                    controllersaleprice = snapshot
                                                                        .data![
                                                                            index]!
                                                                        .sellingprice;
                                                                  });

                                                                  // DatabaseService().updatetempcontroller(
                                                                  //     '${widget.Userid}_itemcontroller',
                                                                  //     controllerid,
                                                                  //     controllername,
                                                                  //     controllertype,
                                                                  //     controllerquantity,
                                                                  //     controllervoltage,
                                                                  //     controllercurrent,
                                                                  //     controllersaleprice,
                                                                  //     controllericon);

                                                                  Navigator.of(
                                                                          dialogContextbattery)
                                                                      .pop();
                                                                  widget
                                                                      .appProvider
                                                                      .changevalue = true;
                                                                  widget.appProvider.updatechangevalue(
                                                                      changevalue: widget
                                                                          .appProvider
                                                                          .changevalue);
                                                                  getTempdata();
                                                                  appProvider.changeCurrentPage(
                                                                      DisplayedPage
                                                                          .ANALYSIS);
                                                                  locator<NavigationService>()
                                                                      .navigateTo(
                                                                          AnalysisRoute);
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
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        10 / 2),
                                                                    child: Row(
                                                                      children: [
                                                                        ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(40),
                                                                          child:
                                                                              Image.network(
                                                                            snapshot.data![index]!.image!,
                                                                            loadingBuilder: (BuildContext context,
                                                                                Widget child,
                                                                                ImageChunkEvent? loadingProgress) {
                                                                              if (loadingProgress == null)
                                                                                return child;
                                                                              return Center(
                                                                                child: CircularProgressIndicator(
                                                                                  value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                                                                ),
                                                                              );
                                                                            },
                                                                            errorBuilder: (BuildContext context,
                                                                                Object exception,
                                                                                StackTrace? stackTrace) {
                                                                              return const CircularProgressIndicator();
                                                                            },
                                                                            height:
                                                                                38,
                                                                            width:
                                                                                38,
                                                                            fit:
                                                                                BoxFit.cover,
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
                                                                                  Text(
                                                                                    'type: ${snapshot.data![index]!.type}',
                                                                                    style: TextStyle(
                                                                                      color: AppColor.black.withOpacity(0.5),
                                                                                      fontSize: 14,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    'U: ${snapshot.data![index]!.ratedVoltage} V',
                                                                                    style: TextStyle(
                                                                                      color: AppColor.black.withOpacity(0.5),
                                                                                      fontSize: 14,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    'I: ${snapshot.data![index]!.current} A',
                                                                                    style: TextStyle(
                                                                                      color: AppColor.black.withOpacity(0.5),
                                                                                      fontSize: 14,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    'price : ${snapshot.data![index]!.sellingprice} CFA',
                                                                                    style: TextStyle(
                                                                                      color: AppColor.black.withOpacity(0.5),
                                                                                      fontSize: 14,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
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
                                              )));
                                    });
                              });*/
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
                                                  controllername,
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
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Rated Voltage:  ',
                                                        style: const TextStyle(
                                                            fontSize: 12.0,
                                                            fontWeight: FontWeight.w800,
                                                            fontStyle: FontStyle.normal),
                                                      ),
                                                      Text(
                                                        ' $controllervoltage V',
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
                                                        'Current: ',
                                                        style: const TextStyle(
                                                            fontSize: 12.0,
                                                            fontWeight: FontWeight.w800,
                                                            fontStyle: FontStyle.normal),
                                                      ),
                                                      Text(
                                                        '$controllercurrent A',
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
                                                        '$controllerquantity',
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
                                                        '${NumberFormat('#,###').format(controllersaleprice)} CFA',
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
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                ],
              ),
            ),
          ),
        ));
  }
}
