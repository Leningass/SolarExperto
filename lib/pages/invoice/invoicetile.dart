import 'package:SolarExperto/constants/constants.dart';
import 'package:SolarExperto/pages/invoice/invoicedetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_responsive.dart';
import '../../models/invoices/invoicemodel.dart';
import '../../services/database/database_service.dart';

class InvoiceTile extends StatefulWidget {
   InvoiceTile({Key? key, required this.invoiceModel}) : super(key: key);
  InvoiceModel invoiceModel;

  @override
  State<InvoiceTile> createState() => _InvoiceTileState();
}

class _InvoiceTileState extends State<InvoiceTile> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(

        color: AppColor.yellow.withOpacity(0.8),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [


          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.invoiceModel.customername!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ((!AppResponsive.isMobile(context)) ? 24 : 14),
                      color: AppColor.bgSideMenu),
                ),
                Text(
                  widget.invoiceModel.customerphone!,
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                      fontSize: ((!AppResponsive.isMobile(context)) ? 24 : 14),
                      color: AppColor.bgSideMenu),
                ),



                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child:
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: AppColor.bgSideMenu
                      ),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    InvoiceDetails(
                                      invoiceModel:
                                      widget.invoiceModel,
                                    )));
                      },
                      child: Text("Details"
                        ,style: TextStyle(color: AppColor.white),),
                    )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}

