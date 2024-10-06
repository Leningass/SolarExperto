import 'package:SolarExperto/constants/constants.dart';
import 'package:SolarExperto/provider/app_provider.dart';
import 'package:SolarExperto/utilis/calculation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_responsive.dart';
import '../../../../constants/size_config.dart';
import '../../../../global_widgets/Loading/loading.dart';
import '../../../../global_widgets/nodata/noitems.dart';
import '../../../../models/equipments/batteriesmodel.dart';
import '../../../../services/database/database_service.dart';

class BatteryCard extends StatefulWidget {
  const BatteryCard({
    Key? key,
    this.batteriesModel,
    required this.appProvider,
    this.Userid,
  }) : super(key: key);
  final BatteriesModel? batteriesModel;
  final AppProvider appProvider;
  final String? Userid;

  @override
  State<BatteryCard> createState() => _BatteryCardState();
}

class _BatteryCardState extends State<BatteryCard> {
  String itemid = '';
  String batteryid = '';
  String batteryname = '';
  String batterytype = '';
  dynamic batteryquantity = 0;
  dynamic batteryvoltage = 0;
  dynamic batterycapacity = 0.0;
  dynamic batterydeep_of_discharge = 0;
  dynamic batterysaleprice = 0.0;
  dynamic batterypurchaseprice = 0.0;
  String batteryicon = '';
  dynamic batteryseries = 0;
  dynamic batteryparrellel = 0;
  num totalbatteryamp = 0.0;
  dynamic batterytotalsaleprice = 0.0;
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
        .doc('${widget.Userid}_itembattery')
        .get()
        .then((DocumentSnapshot) {
      if (mounted) {
        setState(() {
          if (DocumentSnapshot.exists) {
            itemid = DocumentSnapshot['itemid'] ?? '';
            batteryid = DocumentSnapshot['id'].toString();
            batteryname = DocumentSnapshot['name'].toString();
            batterytype = DocumentSnapshot['type'].toString();
            batteryquantity = DocumentSnapshot['quantity'];
            batteryvoltage = DocumentSnapshot['voltage'];
            batterycapacity = DocumentSnapshot['capacity'];
            batterydeep_of_discharge = DocumentSnapshot['deep_of_discharge'];
            batterysaleprice = DocumentSnapshot['sellingprice'];
            batterypurchaseprice = DocumentSnapshot['buyingprice'];
            batterytotalsaleprice = DocumentSnapshot['totalsellingprice'];
            stockquantity = DocumentSnapshot['stockquantiy'];
            //  batteryicon = DocumentSnapshot['image'].toString();
            batteryseries = DocumentSnapshot['series'];
            batteryparrellel = DocumentSnapshot['parrellel'];
            totalbatteryamp = batteryparrellel * batterycapacity;
            //Calculation().caltotalbattery(widget.appProvider);
            DatabaseService().updatetempcalculationbattery(
                '${widget.Userid}_itembattery',
                batteryid,
                batteryname,
                batterytype,
                batteryquantity,
                batteryvoltage,
                batterycapacity,
                batterydeep_of_discharge,
                batterysaleprice,
                batterypurchaseprice,
                batteryicon,
                batteryseries,
                batteryparrellel,
                stockquantity,
                batterytotalsaleprice);
          } else {
            batteryid = widget.batteriesModel!.id!;
            batteryname = widget.batteriesModel!.name!;
            batterytype = widget.batteriesModel!.type!;

            batteryvoltage = widget.batteriesModel!.voltage;
            batterycapacity = widget.batteriesModel!.capacity;
            batterydeep_of_discharge = widget.batteriesModel!.deep_of_discharge;
            batterysaleprice = widget.batteriesModel!.sellingprice;
            batterypurchaseprice = widget.batteriesModel!.buyingprice;
            batterytotalsaleprice = widget.batteriesModel!.totalsellingprice;
            stockquantity = widget.batteriesModel!.stockquantiy;
            //  batteryicon = widget.batteriesModel!.image!;
            Calculation()
                .calbattereryparrallel(widget.appProvider, batterycapacity);
            Calculation().calbatteryseries(widget.appProvider, batteryvoltage);
            // Calculation().caltotalbattery(widget.appProvider);
            batteryseries = widget.appProvider.batteryseries;
            batteryparrellel = widget.appProvider.battereryparrallel;
            batteryquantity = batteryseries * batteryparrellel;
            totalbatteryamp = batteryparrellel * batterycapacity;
            DatabaseService().updatetempcalculationbattery(
                '${widget.Userid}_itembattery',
                batteryid,
                batteryname,
                batterytype,
                batteryquantity,
                batteryvoltage,
                batterycapacity,
                batterydeep_of_discharge,
                batterysaleprice,
                batterypurchaseprice,
                batteryicon,
                batteryseries,
                batteryparrellel,
                stockquantity,
                batterytotalsaleprice);
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Battery',
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
                              // padding: EdgeInsets.symmetric(horizontal: 5.0),
                              height: 200,
                              width: 100,
                              child: IconButton(
                                icon: Image.asset(
                                  "assets/battery.png",
                                  fit: BoxFit.cover,
                                ),
                                onPressed: () {
                                  Future.delayed(Duration.zero, () async {
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
                                              child: Text("Edit Battery"),
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
                                                              dialogContextbattery)
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
                                                      List<BatteriesModel?>?>(
                                                    stream: DatabaseService(
                                                            doctoken:
                                                                widget.Userid)
                                                        .tempbatteries,
                                                    builder:
                                                        (context, snapshot) {
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
                                                          return ListView
                                                              .builder(

                                                                  shrinkWrap:
                                                                      true,
                                                                  itemCount:
                                                                      snapshot
                                                                          .data!
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        setState(
                                                                            () {
                                                                          batteryid = snapshot
                                                                              .data![index]!
                                                                              .id!;
                                                                          batteryname = snapshot
                                                                              .data![index]!
                                                                              .name!;
                                                                          batterytype = snapshot
                                                                              .data![index]!
                                                                              .type!;

                                                                          batteryvoltage = snapshot
                                                                              .data![index]!
                                                                              .voltage;
                                                                          batterycapacity = snapshot
                                                                              .data![index]!
                                                                              .capacity;
                                                                          batterydeep_of_discharge = snapshot
                                                                              .data![index]!
                                                                              .deep_of_discharge;
                                                                          batterysaleprice = snapshot
                                                                              .data![index]!
                                                                              .sellingprice;
                                                                          batterypurchaseprice = snapshot
                                                                              .data![index]!
                                                                              .buyingprice;
                                                                          batterytotalsaleprice = snapshot
                                                                              .data![index]!
                                                                              .totalsellingprice;
                                                                          stockquantity = snapshot
                                                                              .data![index]!
                                                                              .stockquantiy;
                                                                        });
                                                                        Calculation().calbattereryparrallel(
                                                                            widget.appProvider,
                                                                            batterycapacity);
                                                                        Calculation().calbatteryseries(
                                                                            widget.appProvider,
                                                                            batteryvoltage);
                                                                        // Calculation().caltotalbattery(widget.appProvider);
                                                                        batteryseries = widget
                                                                            .appProvider
                                                                            .batteryseries;
                                                                        batteryparrellel = widget
                                                                            .appProvider
                                                                            .battereryparrallel;
                                                                        batteryquantity =
                                                                            batteryseries *
                                                                                batteryparrellel;
                                                                        totalbatteryamp =
                                                                            batteryparrellel *
                                                                                batterycapacity;

                                                                        DatabaseService().updatetempcalculationbattery(
                                                                            '${widget.Userid}_itembattery',
                                                                            batteryid,
                                                                            batteryname,
                                                                            batterytype,
                                                                            batteryquantity,
                                                                            batteryvoltage,
                                                                            batterycapacity,
                                                                            batterydeep_of_discharge,
                                                                            batterysaleprice,
                                                                            batterypurchaseprice,
                                                                            batteryicon,
                                                                            batteryseries,
                                                                            batteryparrellel,
                                                                            stockquantity,
                                                                            batterytotalsaleprice);

                                                                        Navigator.of(dialogContextbattery)
                                                                            .pop();
                                                                        getTempdata();
                                                                      },
                                                                      child:
                                                                          Card(
                                                                        elevation:
                                                                            10,
                                                                        shadowColor:
                                                                            AppColor.outlinecard,
                                                                        child:
                                                                            Container(
                                                                          margin:
                                                                              const EdgeInsets.only(top: appPadding),
                                                                          padding:
                                                                              const EdgeInsets.all(10 / 2),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              ClipRRect(
                                                                                borderRadius: BorderRadius.circular(40),
                                                                                child: Image.asset(
                                                                                  "assets/battery.png",
                                                                                  width: 70,
                                                                                  height: 70,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 1),
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                                                                          'Voltage: ${snapshot.data![index]!.voltage} V',
                                                                                          style: TextStyle(
                                                                                            color: AppColor.black.withOpacity(0.5),
                                                                                            fontSize: 14,
                                                                                          ),
                                                                                        ),
                                                                                        Text(
                                                                                          'Price: ${NumberFormat.decimalPattern('en_us').format(snapshot.data![index]!.totalsellingprice)} CFA',
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
                                                ],
                                              ),
                                            ),
                                          ));
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
                                          batteryname,
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
                                            'Voltage: $batteryvoltage V',
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w800,
                                                fontStyle: FontStyle.normal),
                                          ),
                                          Text(
                                            ' Capacity: $batterycapacity Ah',
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w800,
                                                fontStyle: FontStyle.normal),
                                          ),
                                          Text(
                                            "Amp-hour Capacity: $totalbatteryamp Ah",
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
                                            "Quantity: $batteryquantity",
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w800,
                                                fontStyle: FontStyle.normal),
                                          ),
                                          Text(
                                            "Series:  $batteryseries",
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w800,
                                                fontStyle: FontStyle.normal),
                                          ),
                                          Text(
                                            "Parallel: $batteryparrellel",
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
                                            "Price: ${NumberFormat('#,###').format(batterysaleprice)} CFA",
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w800,
                                                fontStyle: FontStyle.normal),
                                          ),
                                          Text(
                                            "Total Price: ${NumberFormat('#,###').format(batterytotalsaleprice)}  CFA",
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w800,
                                                fontStyle: FontStyle.normal),
                                          ),
                                          Text(
                                            "Stock Quantity: $stockquantity",
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w800,
                                                fontStyle: FontStyle.normal),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // SizedBox(
                                    //   height: 5,
                                    // ),

                                    // SizedBox(
                                    //   height: 5,
                                    // ),
                                    /*    Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'DoD ',
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.normal),
                              ),
                              // Text(
                              //   '${widget.appProvider.battery_dod}',
                              //   style: const TextStyle(
                              //       fontSize: 14.0,
                              //       fontWeight: FontWeight.w800,
                              //       fontStyle: FontStyle.normal),
                              // ),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Quantity ',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.normal),
                              ),
                              // Text(
                              //   "${batteryquantity}",
                              //   style: const TextStyle(
                              //       fontSize: 14.0,
                              //       fontWeight: FontWeight.w800,
                              //       fontStyle: FontStyle.normal),
                              // ),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Sale Price ',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.normal),
                              ),
                              // Text(
                              //   "${batterysaleprice}",
                              //   style: const TextStyle(
                              //       fontSize: 14.0,
                              //       fontWeight: FontWeight.w800,
                              //       fontStyle: FontStyle.normal),
                              // ),
                            ],
                          ),
                        ),*/
                                  ],
                                ),
                              ),
                            ),
                          ])
                    : Column(
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            child: IconButton(
                              icon: Image.asset(
                                "assets/battery.png",
                                fit: BoxFit.cover,
                              ),
                              onPressed: () {
                                Future.delayed(Duration.zero, () async {
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
                                            child: Text("Edit Battery"),
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
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.red),
                                                  onPressed: () {
                                                    Navigator.of(
                                                            dialogContextbattery)
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
                                                    List<BatteriesModel?>?>(
                                                  stream: DatabaseService(
                                                          doctoken: widget.Userid)
                                                      .tempbatteries,
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
                                                                    batteryid =
                                                                        snapshot
                                                                            .data![
                                                                                index]!
                                                                            .id!;
                                                                    batteryname =
                                                                        snapshot
                                                                            .data![
                                                                                index]!
                                                                            .name!;
                                                                    batterytype =
                                                                        snapshot
                                                                            .data![
                                                                                index]!
                                                                            .type!;

                                                                    batteryvoltage =
                                                                        snapshot
                                                                            .data![
                                                                                index]!
                                                                            .voltage;
                                                                    batterycapacity = snapshot
                                                                        .data![
                                                                            index]!
                                                                        .capacity;
                                                                    batterydeep_of_discharge = snapshot
                                                                        .data![
                                                                            index]!
                                                                        .deep_of_discharge;
                                                                    batterysaleprice = snapshot
                                                                        .data![
                                                                            index]!
                                                                        .sellingprice;
                                                                    batterypurchaseprice = snapshot
                                                                        .data![
                                                                            index]!
                                                                        .buyingprice;
                                                                    batterytotalsaleprice = snapshot
                                                                        .data![
                                                                            index]!
                                                                        .totalsellingprice;
                                                                    stockquantity = snapshot
                                                                        .data![
                                                                            index]!
                                                                        .stockquantiy;
                                                                  });
                                                                  Calculation()
                                                                      .calbattereryparrallel(
                                                                          widget
                                                                              .appProvider,
                                                                          batterycapacity);
                                                                  Calculation()
                                                                      .calbatteryseries(
                                                                          widget
                                                                              .appProvider,
                                                                          batteryvoltage);
                                                                  // Calculation().caltotalbattery(widget.appProvider);
                                                                  batteryseries = widget
                                                                      .appProvider
                                                                      .batteryseries;
                                                                  batteryparrellel = widget
                                                                      .appProvider
                                                                      .battereryparrallel;
                                                                  batteryquantity =
                                                                      batteryseries *
                                                                          batteryparrellel;
                                                                  totalbatteryamp =
                                                                      batteryparrellel *
                                                                          batterycapacity;

                                                                  DatabaseService().updatetempcalculationbattery(
                                                                      '${widget.Userid}_itembattery',
                                                                      batteryid,
                                                                      batteryname,
                                                                      batterytype,
                                                                      batteryquantity,
                                                                      batteryvoltage,
                                                                      batterycapacity,
                                                                      batterydeep_of_discharge,
                                                                      batterysaleprice,
                                                                      batterypurchaseprice,
                                                                      batteryicon,
                                                                      batteryseries,
                                                                      batteryparrellel,
                                                                      stockquantity,
                                                                      batterytotalsaleprice);

                                                                  Navigator.of(
                                                                          dialogContextbattery)
                                                                      .pop();
                                                                  getTempdata();
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
                                                                    child: Row(
                                                                      children: [
                                                                        ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(40),
                                                                          child: Image
                                                                              .asset(
                                                                            "assets/battery.png",
                                                                            width:
                                                                                70,
                                                                            height:
                                                                                70,
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
                                                                                'Voltage: ${snapshot.data![index]!.voltage} V',
                                                                                style: TextStyle(
                                                                                  color: AppColor.black.withOpacity(0.5),
                                                                                  fontSize: 14,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                'Price: ${snapshot.data![index]!.totalsellingprice} CFA',
                                                                                style: TextStyle(
                                                                                  color: AppColor.black.withOpacity(0.5),
                                                                                  fontSize: 14,
                                                                                ),
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
                                              ],
                                            ),
                                          ),
                                        ));
                                      });
                                });
                              },
                            ),
                          ),
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
                                              batteryname,
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
                                                    'Voltage:  ',
                                                    style: const TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontStyle:
                                                            FontStyle.normal),
                                                  ),
                                                  Text(
                                                    '$batteryvoltage V',
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
                                                    ' Capacity:  ',
                                                    style: const TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontStyle:
                                                            FontStyle.normal),
                                                  ),
                                                  Text(
                                                    '  $batterycapacity Ah',
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
                                                    "Amp-hour Capacity: ",
                                                    style: const TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontStyle:
                                                            FontStyle.normal),
                                                  ),
                                                  Text(
                                                    "$totalbatteryamp Ah",
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
                                                    "Quantity:  ",
                                                    style: const TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontStyle:
                                                            FontStyle.normal),
                                                  ),
                                                  Text(
                                                    "$batteryquantity",
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
                                                    "Series:  ",
                                                    style: const TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontStyle:
                                                            FontStyle.normal),
                                                  ),
                                                  Text(
                                                    "$batteryseries",
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
                                                    "Parallel:  ",
                                                    style: const TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontStyle:
                                                            FontStyle.normal),
                                                  ),
                                                  Text(
                                                    "$batteryparrellel",
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
                                                    "Price: ",
                                                    style: const TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontStyle:
                                                            FontStyle.normal),
                                                  ),
                                                  Text(
                                                    "${NumberFormat('#,###').format(batterysaleprice)} CFA",
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
                                                    "Total Price:  ",
                                                    style: const TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontStyle:
                                                            FontStyle.normal),
                                                  ),
                                                  Text(
                                                    "${NumberFormat('#,###').format(batterytotalsaleprice)} CFA",
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
                                                    "Stock Quantity: ",
                                                    style: const TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontStyle:
                                                            FontStyle.normal),
                                                  ),
                                                  Text(
                                                    "$stockquantity",
                                                    style: const TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontStyle:
                                                            FontStyle.normal),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),

                                        // SizedBox(
                                        //   height: 5,
                                        // ),

                                        // SizedBox(
                                        //   height: 5,
                                        // ),
                                        /*    Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'DoD ',
                                    style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w800,
                                        fontStyle: FontStyle.normal),
                                  ),
                                  // Text(
                                  //   '${widget.appProvider.battery_dod}',
                                  //   style: const TextStyle(
                                  //       fontSize: 14.0,
                                  //       fontWeight: FontWeight.w800,
                                  //       fontStyle: FontStyle.normal),
                                  // ),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Quantity ',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w800,
                                        fontStyle: FontStyle.normal),
                                  ),
                                  // Text(
                                  //   "${batteryquantity}",
                                  //   style: const TextStyle(
                                  //       fontSize: 14.0,
                                  //       fontWeight: FontWeight.w800,
                                  //       fontStyle: FontStyle.normal),
                                  // ),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Sale Price ',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w800,
                                        fontStyle: FontStyle.normal),
                                  ),
                                  // Text(
                                  //   "${batterysaleprice}",
                                  //   style: const TextStyle(
                                  //       fontSize: 14.0,
                                  //       fontWeight: FontWeight.w800,
                                  //       fontStyle: FontStyle.normal),
                                  // ),
                                ],
                              ),
                            ),*/
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
  }
}
