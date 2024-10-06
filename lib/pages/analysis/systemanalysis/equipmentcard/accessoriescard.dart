import 'package:SolarExperto/models/accessories/accessoriesmodel.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_responsive.dart';
import '../../../../constants/size_config.dart';


class AccessoriesCard extends StatefulWidget {
  const AccessoriesCard(
      {Key? key,  this.accessoriesModel})
      : super(key: key);

  final tempAccessoryModel? accessoriesModel;


  @override
  State<AccessoriesCard> createState() => _AccessoriesCardState();
}

class _AccessoriesCardState extends State<AccessoriesCard> {


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
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Accessories',
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
                      height: 100,
                      width: 100,
                      child:  Image.asset(
                          "assets/accessories.png",
                          fit: BoxFit.cover,
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
                                  widget.accessoriesModel!.name!,
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
                              padding: const EdgeInsets.only(left: 15.0,top: 10,right: 10,),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Type: ',
                                    style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w800,
                                        fontStyle: FontStyle.normal),
                                  ),
                                  Text(
                                    '${widget.accessoriesModel!.type!} ',
                                    style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w800,
                                        fontStyle: FontStyle.normal),
                                  ),

                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 15.0,top: 10,right: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ' Stock Quantity: ',
                                    style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w800,
                                        fontStyle: FontStyle.normal),
                                  ),
                                  Text(
                                    ' ${widget.accessoriesModel!.quantity!} ',
                                    style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w800,
                                        fontStyle: FontStyle.normal),
                                  ),

                                ],
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 15.0,top: 10,right: 10,bottom: 10),

                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Price: ",
                                      style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal),
                                    ),
                                    Text(
                                      "${NumberFormat("#,###").format(widget.accessoriesModel!.sellingprice!)}",
                                      style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w800,
                                          fontStyle: FontStyle.normal),
                                    ),
                                  ],)
                            ),



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
                    child:  Image.asset(
                        "assets/accessories.png",
                        fit: BoxFit.cover,
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
                                      widget.accessoriesModel!.name!,
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
                                            'Type:  ',
                                            style: const TextStyle(
                                                fontSize: 12.0,
                                                fontWeight:
                                                FontWeight.w800,
                                                fontStyle:
                                                FontStyle.normal),
                                          ),
                                          Text(
                                            '${widget.accessoriesModel!.type!} ',
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
                                            'Stock Quantity:  ',
                                            style: const TextStyle(
                                                fontSize: 12.0,
                                                fontWeight:
                                                FontWeight.w800,
                                                fontStyle:
                                                FontStyle.normal),
                                          ),
                                          Text(
                                            '  ${widget.accessoriesModel!.quantity!} ',
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
                                            "${NumberFormat("#,###").format(widget.accessoriesModel!.sellingprice!)} ",
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
        ));
  }
}
