import 'package:SolarExperto/models/equipments/inverter_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_responsive.dart';
import '../../../../constants/constants.dart';
import '../../../../global_widgets/Loading/loading.dart';
import '../../../../global_widgets/nodata/noitems.dart';
import '../../../../provider/app_provider.dart';
import '../../../../services/database/database_service.dart';

class InverterCard extends StatefulWidget {
  const InverterCard(
      {Key? key, this.inverter_Model, this.Userid, required this.appProvider})
      : super(key: key);
  final InverterModel? inverter_Model;
  final AppProvider appProvider;

  final String? Userid;

  @override
  State<InverterCard> createState() => _InverterCardState();
}

class _InverterCardState extends State<InverterCard> {
  String itemid = '';
  String inverterid = '';
  String invertername = '';
  String invertertype = '';
  dynamic inverterquantity = 0;
  dynamic inverterratedpower = 0;
  dynamic inverternominalvoltage = 0.0;
  dynamic inverterpeek_power = 0;
  dynamic inverteracvoltage = 0;
  dynamic invertersaleprice = 0.0;
  dynamic inverterpurchaseprice = 0.0;
  dynamic inverterefficiency = 0;
  String invertericon = '';

  @override
  void initState() {
    getTempdata();
    super.initState();
  }

  void getTempdata() {
    FirebaseFirestore.instance
        .collection(tempcalculation)
        .doc('${widget.Userid}_iteminverter')
        .get()
        .then((DocumentSnapshot) {
      if (mounted) {
        setState(() {
          if (DocumentSnapshot.exists) {
            itemid = DocumentSnapshot['itemid'] ?? '';
            inverterid = DocumentSnapshot['id'] ?? '';
            invertername = DocumentSnapshot['name'] ?? '';
            invertertype = DocumentSnapshot['type'] ?? '';
            inverterquantity = DocumentSnapshot['quantity'] ?? 0;
            inverterratedpower = DocumentSnapshot['ratedpower'] ?? 0;
            inverternominalvoltage = DocumentSnapshot['nominalvoltage'] ?? 0.0;
            inverteracvoltage = DocumentSnapshot['acvoltage'] ?? 0;
            invertersaleprice = DocumentSnapshot['sellingprice'] ?? 0.0;
            inverterpurchaseprice = DocumentSnapshot['buyingprice'] ?? 0.0;
            inverterefficiency = DocumentSnapshot['efficiency'] ?? 0;
            invertericon = DocumentSnapshot['image'] ?? '';
          } else {
            inverterid = widget.inverter_Model!.id!;
            invertername = widget.inverter_Model!.name!;
            invertertype = widget.inverter_Model!.type!;
            inverterratedpower = widget.inverter_Model!.ratedpower;
            inverternominalvoltage = widget.inverter_Model!.nominalvoltage;
            inverterquantity = widget.inverter_Model!.quantity;
            inverteracvoltage = widget.inverter_Model!.acvoltage;
            invertersaleprice = widget.inverter_Model!.sellingprice;
            inverterpurchaseprice = widget.inverter_Model!.buyingprice;
            inverterefficiency = widget.inverter_Model!.efficiency;
            invertericon = widget.inverter_Model!.image!;
            DatabaseService().updatetempcalculationinverter(
                '${widget.Userid}_iteminverter',
                inverterid,
                invertername,
                invertertype,
                inverterquantity,
                inverterratedpower,
                inverternominalvoltage,
                inverteracvoltage,
                invertersaleprice,
                inverterpurchaseprice,
                inverterefficiency,
                invertericon);
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
                    'Inverter',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w900,
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
                 // padding: EdgeInsets.symmetric(horizontal: 5.0),
                 height: 120,
                 width: 120,
                 child: IconButton(
                   icon: Image.asset(
                     "assets/inverter.png",
width: 70,height: 70,
                     fit: BoxFit.cover,
                   ),
                   onPressed: () {
/*
                     Future.delayed(Duration.zero, () async {
                       showDialog(
                           context: context,
                           barrierDismissible: false,
                           builder: (dialogContextbattery) {
                             return Center(
                                 child: AlertDialog(
                                     title: const Center(
                                       child: Text("Edit Inverter"),
                                     ),
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
                                               InverterModel?>?>(
                                         stream: DatabaseService(
                                                 doctoken: widget
                                                     .inverter_Model
                                                     .inverterid)
                                             .inverters,
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
                                                           inverterid = snapshot
                                                               .data![
                                                                   index]!
                                                               .inverterid!;
                                                           invertername = snapshot
                                                               .data![
                                                                   index]!
                                                               .invertername!;
                                                           invertertype = snapshot
                                                               .data![
                                                                   index]!
                                                               .invertertype!;
                                                           inverterquantity =
                                                               snapshot
                                                                   .data![
                                                                       index]!
                                                                   .inverterquantity;
                                                           inverterpower =
                                                               snapshot
                                                                   .data![
                                                                       index]!
                                                                   .inverterratedpower;
                                                           invertervoltage =
                                                               snapshot
                                                                   .data![
                                                                       index]!
                                                                   .inverternominalvoltage;

                                                           inverteroutputvoltage =
                                                               snapshot
                                                                   .data![
                                                                       index]!
                                                                   .inverteracvoltage;
                                                           invertersaleprice =
                                                               snapshot
                                                                   .data![
                                                                       index]!
                                                                   .invertersaleprice;
                                                           inverterefficiency =
                                                               snapshot
                                                                   .data![
                                                                       index]!
                                                                   .inverterefficiency;
                                                           invertericon = snapshot
                                                               .data![
                                                                   index]!
                                                               .invertericon!;
                                                         });

                                                         DatabaseService().updatetempinverter(
                                                             '${widget.Userid}_iteminverter',
                                                             inverterid,
                                                             invertername,
                                                             invertertype,
                                                             inverterquantity,
                                                             inverterpower,
                                                             invertervoltage,
                                                             inverteroutputvoltage,
                                                             invertersaleprice,
                                                             inverterefficiency,
                                                             invertericon);

                                                         Navigator.of(
                                                                 dialogContextbattery)
                                                             .pop();
                                                         // getTempdata();
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
                                                               ClipRRect(
                                                                 borderRadius:
                                                                     BorderRadius.circular(
                                                                         40),
                                                                 child: Image
                                                                     .network(
                                                                   snapshot
                                                                       .data![index]!
                                                                       .invertericon!,
                                                                   loadingBuilder: (BuildContext context,
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
                                                                         value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                                                       ),
                                                                     );
                                                                   },
                                                                   errorBuilder: (BuildContext context,
                                                                       Object
                                                                           exception,
                                                                       StackTrace?
                                                                           stackTrace) {
                                                                     return const CircularProgressIndicator();
                                                                   },
                                                                   height:
                                                                       38,
                                                                   width:
                                                                       38,
                                                                   fit: BoxFit
                                                                       .cover,
                                                                 ),
                                                               ),
                                                               const SizedBox(
                                                                 width: 10,
                                                               ),
                                                               Expanded(
                                                                 child:
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
                                                                         snapshot.data![index]!.invertername!,
                                                                         style: TextStyle(fontSize: 16.0, color: AppColor.black, fontWeight: FontWeight.w600),
                                                                       ),
                                                                       Row(
                                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                                         children: [
                                                                           Text(
                                                                             'type: ${snapshot.data![index]!.invertertype}',
                                                                             style: TextStyle(
                                                                               color: AppColor.black.withOpacity(0.5),
                                                                               fontSize: 14,
                                                                             ),
                                                                           ),
                                                                           Text(
                                                                             'U: ${snapshot.data![index]!.inverternominalvoltage} V',
                                                                             style: TextStyle(
                                                                               color: AppColor.black.withOpacity(0.5),
                                                                               fontSize: 14,
                                                                             ),
                                                                           ),
                                                                           Text(
                                                                             'UO: ${snapshot.data![index]!.inverteracvoltage}V',
                                                                             style: TextStyle(
                                                                               color: AppColor.black.withOpacity(0.5),
                                                                               fontSize: 14,
                                                                             ),
                                                                           ),
                                                                         ],
                                                                       ),
                                                                       Row(
                                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                                         children: [
                                                                           Text(
                                                                             'P: ${snapshot.data![index]!.inverterratedpower}W',
                                                                             style: TextStyle(
                                                                               color: AppColor.black.withOpacity(0.5),
                                                                               fontSize: 14,
                                                                             ),
                                                                           ),

                                                                           Text(
                                                                             'e: ${snapshot.data![index]!.inverterefficiency}%',
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
                     });
*/
                   },
                 ),
               ),
               Expanded(
                 child: Container(
                   //margin: const EdgeInsets.all(10),
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
                             invertername,
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
                               'Nominal Voltage: $inverternominalvoltage V',
                               style: TextStyle(
                                   fontSize: 14.0,
                                   fontWeight: FontWeight.w800,
                                   fontStyle: FontStyle.normal),
                             ),
                             Text(
                               'Power:  ${NumberFormat('#,###').format(inverterratedpower)} W',
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
                               'Stock Quantity: $inverterquantity',
                               style: const TextStyle(
                                   fontSize: 14.0,
                                   fontWeight: FontWeight.w800,
                                   fontStyle: FontStyle.normal),
                             ),
                             Text(
                               'Price: ${NumberFormat('#,###').format(invertersaleprice)} CFA',
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
                :Column(
                 // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: 5.0),
                      height: 120,
                      width: 120,
                      child: IconButton(
                        icon: Image.asset(
                          "assets/inverter.png",

                          fit: BoxFit.cover,
                        ),
                        onPressed: () {
/*
                          Future.delayed(Duration.zero, () async {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (dialogContextbattery) {
                                  return Center(
                                      child: AlertDialog(
                                          title: const Center(
                                            child: Text("Edit Inverter"),
                                          ),
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
                                                    InverterModel?>?>(
                                              stream: DatabaseService(
                                                      doctoken: widget
                                                          .inverter_Model
                                                          .inverterid)
                                                  .inverters,
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
                                                                inverterid = snapshot
                                                                    .data![
                                                                        index]!
                                                                    .inverterid!;
                                                                invertername = snapshot
                                                                    .data![
                                                                        index]!
                                                                    .invertername!;
                                                                invertertype = snapshot
                                                                    .data![
                                                                        index]!
                                                                    .invertertype!;
                                                                inverterquantity =
                                                                    snapshot
                                                                        .data![
                                                                            index]!
                                                                        .inverterquantity;
                                                                inverterpower =
                                                                    snapshot
                                                                        .data![
                                                                            index]!
                                                                        .inverterratedpower;
                                                                invertervoltage =
                                                                    snapshot
                                                                        .data![
                                                                            index]!
                                                                        .inverternominalvoltage;

                                                                inverteroutputvoltage =
                                                                    snapshot
                                                                        .data![
                                                                            index]!
                                                                        .inverteracvoltage;
                                                                invertersaleprice =
                                                                    snapshot
                                                                        .data![
                                                                            index]!
                                                                        .invertersaleprice;
                                                                inverterefficiency =
                                                                    snapshot
                                                                        .data![
                                                                            index]!
                                                                        .inverterefficiency;
                                                                invertericon = snapshot
                                                                    .data![
                                                                        index]!
                                                                    .invertericon!;
                                                              });

                                                              DatabaseService().updatetempinverter(
                                                                  '${widget.Userid}_iteminverter',
                                                                  inverterid,
                                                                  invertername,
                                                                  invertertype,
                                                                  inverterquantity,
                                                                  inverterpower,
                                                                  invertervoltage,
                                                                  inverteroutputvoltage,
                                                                  invertersaleprice,
                                                                  inverterefficiency,
                                                                  invertericon);

                                                              Navigator.of(
                                                                      dialogContextbattery)
                                                                  .pop();
                                                              // getTempdata();
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
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              40),
                                                                      child: Image
                                                                          .network(
                                                                        snapshot
                                                                            .data![index]!
                                                                            .invertericon!,
                                                                        loadingBuilder: (BuildContext context,
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
                                                                              value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                                                            ),
                                                                          );
                                                                        },
                                                                        errorBuilder: (BuildContext context,
                                                                            Object
                                                                                exception,
                                                                            StackTrace?
                                                                                stackTrace) {
                                                                          return const CircularProgressIndicator();
                                                                        },
                                                                        height:
                                                                            38,
                                                                        width:
                                                                            38,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Expanded(
                                                                      child:
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
                                                                              snapshot.data![index]!.invertername!,
                                                                              style: TextStyle(fontSize: 16.0, color: AppColor.black, fontWeight: FontWeight.w600),
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  'type: ${snapshot.data![index]!.invertertype}',
                                                                                  style: TextStyle(
                                                                                    color: AppColor.black.withOpacity(0.5),
                                                                                    fontSize: 14,
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  'U: ${snapshot.data![index]!.inverternominalvoltage} V',
                                                                                  style: TextStyle(
                                                                                    color: AppColor.black.withOpacity(0.5),
                                                                                    fontSize: 14,
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  'UO: ${snapshot.data![index]!.inverteracvoltage}V',
                                                                                  style: TextStyle(
                                                                                    color: AppColor.black.withOpacity(0.5),
                                                                                    fontSize: 14,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  'P: ${snapshot.data![index]!.inverterratedpower}W',
                                                                                  style: TextStyle(
                                                                                    color: AppColor.black.withOpacity(0.5),
                                                                                    fontSize: 14,
                                                                                  ),
                                                                                ),

                                                                                Text(
                                                                                  'e: ${snapshot.data![index]!.inverterefficiency}%',
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
                          });
*/
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              //margin: const EdgeInsets.all(10),
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
                                        invertername,
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
                                     crossAxisAlignment: CrossAxisAlignment.start,

                                     children: [
                                       const  SizedBox(
                                         height: 10,
                                       ),
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                         children: [
                                           Text(
                                             'Nominal Voltage: ',
                                             style: TextStyle(
                                                 fontSize: 12.0,
                                                 fontWeight: FontWeight.w800,
                                                 fontStyle: FontStyle.normal),
                                           ),
                                           Text(
                                             ' $inverternominalvoltage V',
                                             style: TextStyle(
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
                                             ' ${NumberFormat('#,###').format(inverterratedpower)} W',
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
                                             '$inverterquantity',
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
                                             ' ${NumberFormat('#,###').format(invertersaleprice)} CFA',
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
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
