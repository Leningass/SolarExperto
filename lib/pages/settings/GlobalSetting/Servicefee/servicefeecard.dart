import 'package:SolarExperto/models/Service%20Fee/servicefeemodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_responsive.dart';
import '../../../../constants/constants.dart';

class ServiceFeeCard extends StatefulWidget {
  const ServiceFeeCard({Key? key, required this.serviceFeeModel}) : super(key: key);
final ServiceFeeModel serviceFeeModel;
  @override
  State<ServiceFeeCard> createState() => _ServiceFeeCardState();
}

class _ServiceFeeCardState extends State<ServiceFeeCard> {



  String description = '';
  String name='';
  num install = 0;
  num maintain = 0;
  num transport = 0;
  num additional = 0;


  void getTempdata() {
    FirebaseFirestore.instance
        .collection(tempcalculation)
        .doc(widget.serviceFeeModel.id)
        .get()
        .then((DocumentSnapshot) {
      if (mounted) {
        setState(() {
          if (DocumentSnapshot.exists) {
            name = DocumentSnapshot['name'].toString();
            description = DocumentSnapshot['description'].toString();
            install = DocumentSnapshot['installationfee'];


            maintain = DocumentSnapshot['maintenancefee'];
            transport = DocumentSnapshot['transportfee'];
            additional = DocumentSnapshot['additionalfee'];


          } else {
            name = '';
            description = '';
            install = 0;


            maintain = 0;
            transport = 0;
            additional = 0;
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
                                    widget.serviceFeeModel.name,
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
                                      'Installation Fee ${widget.serviceFeeModel.installationfee} CFA',
                                      style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal),
                                    ),
                                    Text(
                                      ' Maintenance Fee: ${widget.serviceFeeModel.maintenancefee} CFA',
                                      style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal),
                                    ),
                                    Text(
                                      "Transport ${widget.serviceFeeModel.installationfee} CFA",
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
                                      "Additional Fee: ${widget.serviceFeeModel.additionalfee}",
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
                                        name,
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
                                              '$install CFA',
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
                                              '  $maintain CFA',
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
                                              "$transport CFA",
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
                                              "$additional CFA",
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
