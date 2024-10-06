import 'dart:io';
import 'dart:ui';
import 'package:SolarExperto/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_responsive.dart';
import '../../../../global_widgets/Loading/loading.dart';
import '../../../../global_widgets/header/header_widget.dart';
import '../../../../global_widgets/nodata/noitems.dart';
import '../../../../models/customers/customermodel.dart';
import '../../../../services/database/database_service.dart';
import '../../../../utilis/date.dart';
import 'package:pdf/pdf.dart';
import 'package:open_file/open_file.dart';

import 'package:pdf/widgets.dart' as pw;

import '../../models/invoices/invoicemodel.dart';
class InvoiceDetails extends StatefulWidget {
   InvoiceDetails({Key? key, required this.invoiceModel}) : super(key: key);
final InvoiceModel invoiceModel;

  @override
  State<InvoiceDetails> createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends State<InvoiceDetails> {
 /* String batteryname='';
  String batterytype='';
  num
  batteryprice = 0;
  int {widget.invoiceModel.batteryquantity!} = 0;
  num batterytotal = 0;
  String panelname='';
  String paneltype='';
  num widget.invoiceModel.panelprice = 0;
  int panelquantity = 0;
  num widget.invoiceModel.paneltotal! = 0;
  String controllername='';
  String controllertype='';
  num controllerprice = 0;
  num controllerquantity = 0;
  num widget.invoiceModel.controllertotalprice! = 0;
  String? invertername;
  String? invertertype;
  num inverterprice = 0;
  int inverterquantity = 0;
  num invertertotal = 0;
  int install = 0;
  int maintain = 0;
  int transport = 0;
  int additional = 0;
  num widget.invoiceModel.G1 = 0.0;
  num CI3 = 0.0;
  num widget.invoiceModel.G2 = 0.0;
  num widget.invoiceModel.G3 = 0.0;
  num widget.invoiceModel.G4 = 0.0;
  num widget.invoiceModel.G5 = 0.0;
  num widget.invoiceModel.G6 = 0.0;
  num widget.invoiceModel.G7 = 0.0;
  num widget.invoiceModel.G8 = 0.0;
  num widget.invoiceModel.G9 = 0.0;
  num widget.invoiceModel.G13 = 0;
  num widget.invoiceModel.G14 = 0.0;
  num widget.invoiceModel.G15 = 0.0;
  num widget.invoiceModel.G16 = 0.0;
  num widget.invoiceModel.G17 = 0.0;
  num widget.invoiceModel.servicetotalprice = 0.0;
  num widget.invoiceModel.G19 = 0.0;
  num widget.invoiceModel.G20 = 0.0;
  num widget.invoiceModel.G21 = 0.0;
  num widget.invoiceModel.G22 = 0.0;
  num widget.invoiceModel.G23 = 0.0;
  num widget.invoiceModel.G24 = 0.0;
  num widget.invoiceModel.G25 = 0.0;
  num widget.invoiceModel.G26 = 0.0;
  num C10 = 0.0;
  num C11 = 0.0;
  num C12 = 0;
  num widget.invoiceModel.GE6 = 0;
  num widget.invoiceModel.GE7 = 0;


  int totalwidget.invoiceModel.G7 = 0;
  int totalwidget.invoiceModel.G8 = 0;
  int totalwidget.invoiceModel.G9 = 0;
  num totalwidget.invoiceModel.G20 = 0;
  num totalwidget.invoiceModel.G21 = 0;
  num totalwidget.invoiceModel.G22 = 0;
  num totalwidget.invoiceModel.G23 = 0;
  num totalwidget.invoiceModel.G24 = 0;
  num totalwidget.invoiceModel.G25 = 0;
  num totalwidget.invoiceModel.G26 = 0;
  String customername='';
  String customerid='';
  String customerphone='';
  String customercity='';
  String customeraddress='';
  String customeremail='';
  String accessoriesname='';
  String accessoriestype='';
  String serviceid='';
  String servicename='';
  String servicedescription='';
  int accessoriesquantity=0;
  int accessoriesprice=0;
  int accessoriestotal=0;*/

  String customername='';
  String customerid='';
  String customerphone='';
  String customercity='';
  String customeraddress='';
  String customeremail='';
  String formattedDate = DateFormat('yyyyMMdd').format(DateTime.now());
  String endudate = DateFormat('dd MMMM yyyy').format(DateTime.now());
  int rank = 0;
  String? name;
  void getname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = (prefs.getString('name') ?? '');

    });
  }

  @override
  Widget build(BuildContext context) {
    Timestamp date = Timestamp.now();
    final pdf = pw.Document();

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.bgColor,
          elevation: 0,
          title: Text(
            widget.invoiceModel.customername!,
          ),

        ),
        body: SingleChildScrollView(
          child: Column(
            children: [


              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Container(
                  decoration: BoxDecoration(
                    color: AppColor.bgColor,
                  ),
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: () async {

                        var assetImage = pw.MemoryImage(
                          (await rootBundle.load(
                            'assets/images/main-logo.png',
                          ))
                              .buffer
                              .asUint8List(),
                        );
                        pdf.addPage(pw.Page(
                          pageFormat: PdfPageFormat.a4,

                          build: (pw.Context context) {
                            return pw.Container(

                                decoration: pw.BoxDecoration(
                                  borderRadius:pw.BorderRadius.circular(1.9),

                                  border: pw.Border.all(
                                    color: PdfColor.fromInt(Colors.black.value), //color of border
                                    width: 1, //width of border
                                  ),
                                ),
                                child: pw.Column(
                                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Row(
                                        mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Image(assetImage, width: 1000, height: 110),
                                          pw.Column(
                                            mainAxisAlignment: pw.MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Container(
                                                decoration: pw.BoxDecoration(
                                                  color:
                                                  PdfColor.fromInt(Colors.indigoAccent[200]!.value),
                                                ),
                                                margin: pw.EdgeInsets.only(right: 20),
                                                width: 200,

                                                child: pw.Text(
                                                  "DEVIS ",
                                                  style: pw.TextStyle(
                                                      fontSize: 8,
                                                      color: PdfColor.fromInt(
                                                          AppColor.white.value)),
                                                ),
                                              ),
                                              pw.Row(
                                                mainAxisAlignment:
                                                pw.MainAxisAlignment.spaceBetween,
                                                children: [
                                                  pw.Text("Devis n° ",
                                                      style: pw.TextStyle(fontSize: 7,  fontWeight: pw.FontWeight.bold)),
                                                  pw.SizedBox(width:120),
                                                  pw.Text("D-$formattedDate-${widget.invoiceModel.rank} ",style: pw.TextStyle(
                                                    fontSize: 7,

                                                  ),),
                                                ],
                                              ),
                                              pw.Row(
                                                mainAxisAlignment:
                                                pw.MainAxisAlignment.spaceBetween,
                                                children: [
                                                  pw.Text("En date du ",
                                                      style: pw.TextStyle(fontSize: 7,fontWeight: pw.FontWeight.bold)),
                                                  pw.SizedBox(width:112),
                                                  pw.Text('$endudate',style: pw.TextStyle(
                                                    fontSize: 7,
                                                  ),)
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      pw.Container(
                                        margin:pw.EdgeInsets.only(left: 10),
                                        child:  pw.Row(
                                          mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Column(
                                              crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Text("Solar Experto",
                                                    style: pw.TextStyle(fontSize: 7)),
                                                pw.Text("Akwa, Douala ",
                                                    style: pw.TextStyle(fontSize: 7)),
                                                pw.Text("info.solarexperto@gmail.com",
                                                    style: pw.TextStyle(fontSize: 7)),
                                                pw.Text("+237 6 95 02 39 97 ",
                                                    style: pw.TextStyle(fontSize: 7)),
                                              ],
                                            ),
                                            pw.Column(
                                              children: [
                                                pw.Row(
                                                  children: [
                                                    pw.Container(
                                                      child: pw.Column(
                                                        crossAxisAlignment:
                                                        pw.CrossAxisAlignment.start,
                                                        children: [
                                                          pw.Text(
                                                            "Devis adressé à",
                                                            style: pw.TextStyle(
                                                                fontSize: 7,
                                                                fontWeight:
                                                                pw.FontWeight.bold),
                                                          ),
                                                          // pw.SizedBox(height:10),
                                                          pw.Text("Nom",
                                                              style: pw.TextStyle(
                                                                  fontSize: 7)),
                                                          pw.Text("Adresse",
                                                              style: pw.TextStyle(
                                                                  fontSize: 7)),
                                                          pw.Text("Ville",
                                                              style: pw.TextStyle(
                                                                  fontSize: 7)),
                                                          pw.Text("E-mail",
                                                              style: pw.TextStyle(
                                                                  fontSize: 7)),
                                                          pw.Text("Téléphone",
                                                              style: pw.TextStyle(
                                                                  fontSize: 7)),
                                                        ],
                                                      ),
                                                    ),
                                                    pw.Padding(
                                                      padding: pw.EdgeInsets.all(8.0),
                                                      child:pw.Container(

                                                        decoration: pw.BoxDecoration(
                                                            color: PdfColor.fromInt(Colors
                                                                .blueGrey[200]!.value)),
                                                        width: 150,
                                                        child: pw.Padding(
                                                          padding: pw.EdgeInsets.only(
                                                              top: 10, left: 10),
                                                          child: pw.Column(
                                                            crossAxisAlignment:
                                                            pw.CrossAxisAlignment.start,
                                                            children: [
                                                              pw.Text("$customername",
                                                                  style: pw.TextStyle(
                                                                      fontSize: 7)),
                                                              pw.Text("$customeraddress",
                                                                  style: pw.TextStyle(
                                                                      fontSize: 7)),
                                                              pw.Text("-",
                                                                  style: pw.TextStyle(
                                                                      fontSize: 7)),
                                                              pw.Text("$customeremail",
                                                                  style: pw.TextStyle(
                                                                      fontSize: 7)),
                                                              pw.Text("$customerphone",
                                                                  style: pw.TextStyle(
                                                                      fontSize: 7)),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.only(left: 20),
                                        child: pw.Row(
                                          mainAxisAlignment: pw.MainAxisAlignment.start,
                                          children: [
                                            pw.Text(
                                              "Durée de validité du présent devis 1 mois  ",
                                              style: pw.TextStyle(
                                                  fontSize: 5.5,
                                                  fontWeight: pw.FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),

                                      pw.Container(
                                        margin:pw.EdgeInsets.all(0.5),
                                        color: PdfColor.fromInt(Colors.indigoAccent[200]!.value),
                                        child: pw.Padding(
                                          padding: pw.EdgeInsets.all(10.0),
                                          child: pw.Row(
                                            mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                            children: [
                                              pw.Container(
                                                width: 70,
                                                child: pw.Text(
                                                  "Description  ",
                                                  style: pw.TextStyle(
                                                    fontSize: 7,
                                                    fontWeight:pw.FontWeight.bold,
                                                    color: PdfColor.fromInt(
                                                        Colors.white.value),
                                                  ),
                                                ),
                                              ),
                                              pw.Container(
                                                width: 70,
                                                child: pw.Text(
                                                  "Référence",
                                                  style: pw.TextStyle(
                                                    fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                    color: PdfColor.fromInt(
                                                        Colors.white.value),
                                                  ),
                                                ),
                                              ),
                                              pw.Container(
                                                width: 50,
                                                child: pw.Text(
                                                  "Qté.",
                                                  style: pw.TextStyle(
                                                    fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                    color: PdfColor.fromInt(
                                                        Colors.white.value),
                                                  ),
                                                ),
                                              ),
                                              pw.Container(
                                                width: 50,
                                                child: pw.Text(
                                                  "Prix u [CFA]",
                                                  style: pw.TextStyle(
                                                    fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                    color: PdfColor.fromInt(
                                                        Colors.white.value),
                                                  ),
                                                ),
                                              ),
                                              pw.Container(
                                                width: 50,
                                                child: pw.Text(
                                                  "Prix T [CFA] ",
                                                  style: pw.TextStyle(
                                                    fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                    color: PdfColor.fromInt(
                                                        Colors.white.value),
                                                  ),
                                                ),
                                              ),
                                              pw.Container(
                                                width: 50,
                                                child: pw.Text(
                                                  "/Jour ",
                                                  style: pw.TextStyle(
                                                    fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                    color: PdfColor.fromInt(
                                                        Colors.white.value),
                                                  ),
                                                ),
                                              ),
                                              pw.Container(
                                                width: 50,
                                                child: pw.Text(
                                                  "/Mois",
                                                  style: pw.TextStyle(
                                                    fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                    color: PdfColor.fromInt(
                                                        Colors.white.value),
                                                  ),
                                                ),
                                              ),
                                              pw.Container(
                                                width: 50,
                                                child: pw.Text(
                                                  "/Année",
                                                  style: pw.TextStyle(
                                                    fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                    color: PdfColor.fromInt(
                                                        Colors.white.value),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      pw.Container(
                                        margin:pw.EdgeInsets.all(0.5),
                                        color:
                                        PdfColor.fromInt(Colors.blueGrey[100]!.value),
                                        child: pw.Row(
                                          mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Padding(padding: pw.EdgeInsets.all(8),
                                              child:  pw.Text(
                                                "EQUIPEMENT NECESSAIRE ",
                                                style: pw.TextStyle(
                                                  color: PdfColor.fromInt(
                                                      Colors.black.value),
                                                  fontSize: 7,
                                                ),
                                              ),)
                                          ],
                                        ),
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.all(10.0),
                                        child: pw.Row(
                                          mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Container(
                                              width: 70,
                                              child: pw.Text(
                                                "Panneaux",
                                                style: pw.TextStyle(
                                                  fontSize: 7,

                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 80,
                                              child: pw.Text(
                                                widget.invoiceModel.panelname!,
                                                style: pw.TextStyle(
                                                  fontSize: 7,

                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "${widget.invoiceModel.panelquantity!}",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,

                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "${NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.panelprice!.toInt())}",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,

                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.paneltotalprice!.toInt()),
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,

                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "-",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,

                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "-",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,

                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "-",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,

                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.all(10.0),
                                        child: pw.Row(
                                          mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Container(
                                              width: 70,
                                              child: pw.Text(
                                                "Batteries ",
                                                style: pw.TextStyle(
                                                  fontSize: 7,

                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 80,
                                              child: pw.Text(
                                                "${widget.invoiceModel.batteryname}",
                                                style: pw.TextStyle(
                                                  fontSize: 7,

                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "${widget.invoiceModel.batteryquantity!}",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "${NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.batteryprice!.toInt())}",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.batterytotalprice!.toInt()),
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "-",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "-",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "-",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.all(10.0),
                                        child: pw.Row(
                                          mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Container(
                                              width: 70,
                                              child: pw.Text(
                                                "Convertisseur",
                                                style: pw.TextStyle(
                                                    fontSize: 7
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 80,
                                              child: pw.Text(
                                                "${widget.invoiceModel.invertername}",
                                                style: pw.TextStyle(
                                                  fontSize: 7,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "1",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.inverterprice!.toInt()),
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.invertertotalprice!.toInt()),
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "-",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "-",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "-",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.all(10.0),
                                        child: pw.Row(
                                          mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Container(
                                              width: 70,
                                              child: pw.Text(
                                                "Contrôleur de charge ",
                                                style: pw.TextStyle(
                                                    fontSize: 7
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 80,
                                              child: pw.Text(
                                                widget.invoiceModel.controllername!,
                                                style: pw.TextStyle(
                                                    fontSize: 7
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "1",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.controllerprice!.toInt()),
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.controllertotalprice!.toInt()),
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "-",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "-",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "-",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.only(top:8,left:10,right:10,bottom: 1),
                                        child: pw.Row(
                                          mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Container(
                                              width: 70,
                                              child: pw.Text(
                                                "Accessoires",
                                                style: pw.TextStyle(
                                                    fontSize: 7
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 80,
                                              child: pw.Text(
                                                "Câbles, Disjoncteurs,",
                                                style: pw.TextStyle(
                                                  fontSize: 7,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "-",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                NumberFormat("#,###").format(widget.invoiceModel.accessoriestotalprice),
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                NumberFormat("#,###").format(widget.invoiceModel.accessoriestotalprice),
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "-",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "-",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "-",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.only(left: 10,bottom: 5,top: 10,right: 10),
                                        child: pw.Row(
                                          mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Container(
                                              width: 70,
                                              child: pw.Text(
                                                "Frais de service ",
                                                style: const pw.TextStyle(
                                                    fontSize: 7
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 80,
                                              child: pw.Text(
                                                "Installation/Transport/",
                                                style: const pw.TextStyle(
                                                  fontSize: 7,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "-",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "$widget.invoiceModel.servicetotalprice",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "$widget.invoiceModel.servicetotalprice",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "-",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "-",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "-",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      pw.Container(
                                        margin:pw.EdgeInsets.all(0.5),
                                        color:
                                        PdfColor.fromInt(Colors.blueGrey[100]!.value),
                                        child: pw.Padding(
                                          padding: pw.EdgeInsets.all(8.0),
                                          child: pw.Row(
                                            mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                            children: [
                                              pw.Text(
                                                "VOTRE CONSOMMATION",
                                                style: pw.TextStyle(
                                                  color: PdfColor.fromInt(
                                                      Colors.black.value),
                                                  fontSize: 7,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Row(
                                          mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Container(
                                              width: 80,
                                              child: pw.Text(
                                                "Demande en énergie",
                                                style: pw.TextStyle(
                                                    fontSize: 7
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 80,
                                              child: pw.Text(
                                                "",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                NumberFormat("#,###").format(widget.invoiceModel.G1),
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                NumberFormat("#,###").format(widget.invoiceModel.G2),
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                NumberFormat("#,###").format(widget.invoiceModel.G3),
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.only(top:8,left:10,right:10,bottom: 1),
                                        child: pw.Row(
                                          mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Container(
                                              width: 90,
                                              child: pw.Text(
                                                "Prix fournisseur électrique",
                                                style: pw.TextStyle(
                                                    fontSize: 7
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 70,
                                              child: pw.Text(
                                                "",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "${widget.invoiceModel.CI3}",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                NumberFormat("#,###").format(widget.invoiceModel.G4),
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                NumberFormat("#,###").format(widget.invoiceModel.G5),
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                NumberFormat("#,###").format(widget.invoiceModel.G6),
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      pw.Container(
                                        margin:pw.EdgeInsets.all(0.5),
                                        color:
                                        PdfColor.fromInt(Colors.blueGrey[100]!.value),
                                        child:pw.Padding(
                                          padding: pw.EdgeInsets.all(8.0),
                                          child: pw.Row(
                                            mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                            children: [
                                              pw.Text(
                                                "PRODUCTION SOLAIRE",
                                                style: pw.TextStyle(
                                                  color: PdfColor.fromInt(
                                                      Colors.black.value),
                                                  fontSize: 7,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.only(left: 10,top:5,bottom: 5),
                                        child: pw.Row(
                                          mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Container(
                                              width: 80,
                                              child: pw.Text(
                                                "Energie produite",
                                                style: pw.TextStyle(
                                                    fontSize: 7
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 80,
                                              child: pw.Text(
                                                "",
                                                style: pw.TextStyle(
                                                    fontSize: 7
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                NumberFormat("#,###").format(widget.invoiceModel.G7),
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                NumberFormat("#,###").format(widget.invoiceModel.G8),
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                NumberFormat("#,###").format(widget.invoiceModel.G9),
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      pw.Padding(
                                        padding: pw.EdgeInsets.only(top:5,left:10,right:10,bottom: 1),
                                        child: pw.Row(
                                          mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,

                                          children: [
                                            pw.Container(
                                              width: 80,
                                              child: pw.Text(
                                                "Prix total système solaire",
                                                style: pw.TextStyle(
                                                    fontSize: 7
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 80,
                                              child: pw.Text(
                                                "",
                                                style: pw.TextStyle(
                                                    fontSize: 7
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "",
                                                style: pw.TextStyle(
                                                    fontSize: 7
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.G19),
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                NumberFormat("#,###").format(widget.invoiceModel.G22),
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                NumberFormat("#,###").format(widget.invoiceModel.G21),
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                NumberFormat("#,###").format(widget.invoiceModel.G20),                                      style: pw.TextStyle(
                                                fontSize: 7,fontWeight:pw.FontWeight.bold,
                                              ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      pw.Container(
                                        margin:pw.EdgeInsets.all(0.5),
                                        color: PdfColor.fromInt(
                                            Colors.blueGrey[100]!.value),
                                        child: pw.Padding(
                                          padding: pw.EdgeInsets.all(8.0),
                                          child: pw.Row(
                                            mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                            children: [
                                              pw.Text(
                                                "RENTABILITE ",
                                                style: pw.TextStyle(
                                                  color: PdfColor.fromInt(
                                                      Colors.black.value),
                                                  fontSize: 7,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.only(top:5,left:10,right:10,bottom: 1+6+0),
                                        child: pw.Row(
                                          mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Container(
                                              width: 80,
                                              child: pw.Text(
                                                "Total épargné ",
                                                style: pw.TextStyle(
                                                    fontSize: 7
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 80,
                                              child: pw.Text(
                                                "",
                                                style: pw.TextStyle(
                                                  fontSize: 7,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "",
                                                style: pw.TextStyle(
                                                  fontSize: 7,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                NumberFormat("#,###").format(widget.invoiceModel.G26),
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                "",
                                                style: pw.TextStyle(
                                                  fontSize: 7,fontWeight:pw.FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 50,
                                              child: pw.Text(
                                                NumberFormat("#,###").format(widget.invoiceModel.G23),                                      style: pw.TextStyle(
                                                fontSize: 7,fontWeight:pw.FontWeight.bold,
                                              ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 60,
                                              child: pw.Text(
                                                NumberFormat("#,###").format(widget.invoiceModel.G24),                                      style: pw.TextStyle(
                                                fontSize: 7,fontWeight:pw.FontWeight.bold,
                                              ),
                                              ),
                                            ),
                                            pw.Container(
                                              width: 55,
                                              child: pw.Text(
                                                NumberFormat("#,###").format(widget.invoiceModel.G25),                                      style: pw.TextStyle(
                                                fontSize: 7,fontWeight:pw.FontWeight.bold,
                                              ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      pw.Container(margin:pw.EdgeInsets.all(5),
                                          child:pw.Column(
                                              children: [
                                                pw.Row(
                                                  mainAxisAlignment:
                                                  pw.MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    pw.Expanded(
                                                      child: pw.Text(
                                                        "Détails de règlement & délais de livraison :",
                                                        style: pw.TextStyle(
                                                          fontSize: 7,
                                                        ),
                                                      ),
                                                    ),
                                                    pw.Row(
                                                      mainAxisAlignment: pw.MainAxisAlignment.end,
                                                      children: [
                                                        pw.Text(
                                                          "Total P: ",
                                                          style: pw.TextStyle(
                                                              fontSize: 7,
                                                              fontWeight: pw.FontWeight.bold
                                                          ),
                                                        ),
                                                        pw.SizedBox(width: 10),
                                                        pw.Text(
                                                          NumberFormat("#,###").format(widget.invoiceModel.G19),                                      style: pw.TextStyle(fontSize: 7,fontWeight:pw.FontWeight.bold,),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                pw.Row(
                                                  mainAxisAlignment: pw.MainAxisAlignment.end,
                                                  children: [
                                                    pw.Text(
                                                      "Remise ",
                                                      style: pw.TextStyle(
                                                          fontSize: 7,
                                                          fontWeight: pw.FontWeight.bold),
                                                    ),
                                                    pw.SizedBox(
                                                      width: 10,
                                                    ),
                                                    pw.Text(
                                                      "- CFA",
                                                      style: pw.TextStyle(fontSize: 7,fontWeight:pw.FontWeight.bold,),
                                                    ),
                                                  ],
                                                ),
                                                pw.Align(
                                                    alignment: pw.Alignment.topLeft,
                                                    child: pw.Text(
                                                      "Taux de paiement avant installation : XX %. ",
                                                      style: pw.TextStyle(
                                                        fontSize: 7,
                                                      ),
                                                    )),
                                                pw.Align(
                                                    alignment: pw.Alignment.topLeft,
                                                    child: pw.Text(
                                                      "Indemnité forfaitaire en cas de retard de paiement : XXXXXX CFA. ",
                                                      style: pw.TextStyle(
                                                        fontSize: 7,
                                                      ),
                                                    )),
                                                pw.Row(
                                                  mainAxisAlignment: pw.MainAxisAlignment.end,
                                                  children: [
                                                    pw.Text(
                                                      "Total TTC  ",
                                                      style: pw.TextStyle(
                                                          fontSize: 7,
                                                          fontWeight: pw.FontWeight.bold),
                                                    ),
                                                    pw.SizedBox(
                                                      width: 10,
                                                    ),
                                                    pw.Text(
                                                      NumberFormat("#,###").format(widget.invoiceModel.G19),                                  style: pw.TextStyle(
                                                        fontSize: 7,
                                                        fontWeight: pw.FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                pw.Align(
                                                    alignment: pw.Alignment.topLeft,
                                                    child: pw.Text(
                                                      "Garantie : XX mois. ",
                                                      style: pw.TextStyle(
                                                        fontSize: 7,
                                                      ),
                                                    )),
                                                pw.Align(
                                                    alignment: pw.Alignment.topLeft,
                                                    child: pw.Text(
                                                      "Durée de vie (prévisionnelle) du système : ${widget.invoiceModel.GE6}  ",
                                                      style: pw.TextStyle(
                                                        fontSize: 7,
                                                      ),)),
                                                pw.Align(
                                                    alignment: pw.Alignment.topLeft,
                                                    child: pw.Text(
                                                      "Autonomie du système :  ${widget.invoiceModel.GE7!.toInt()}  ",
                                                      style: pw.TextStyle(
                                                        fontSize: 7,
                                                      ),)),
                                                pw.SizedBox(
                                                  height: 5,
                                                ),
                                                pw.Row(
                                                  mainAxisAlignment: pw.MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                                  children: [
                                                    pw.Text("Nom du signataire ",style: pw.TextStyle(
                                                        fontSize: 7,
                                                        fontWeight: pw.FontWeight.bold),),
                                                    pw.SizedBox(
                                                      width: 20,
                                                    ),
                                                    pw.Column(
                                                        children: [
                                                          pw.Text("$name",
                                                            style: pw.TextStyle(
                                                              fontSize: 7,
                                                            ),),
                                                          pw.Text("_______________",
                                                            style: pw.TextStyle(
                                                                fontSize: 7,
                                                                fontWeight: pw.FontWeight.bold),),
                                                        ]
                                                    ),
                                                    pw.SizedBox(
                                                      width: 50,
                                                    ),
                                                    pw.Text("Date ",
                                                      style: pw.TextStyle(
                                                          fontSize: 7,
                                                          fontWeight: pw.FontWeight.bold),
                                                    ),
                                                    pw.SizedBox(
                                                      width: 20,
                                                    ),
                                                    pw.Column(children: [
                                                      pw.Text(getFormattedDate(
                                                          date.toDate().toString()),style: pw.TextStyle(
                                                        fontSize: 7,
                                                      ),),
                                                      pw.Text("_______________",
                                                        style: pw.TextStyle(
                                                            fontSize: 7,
                                                            fontWeight: pw.FontWeight.bold),),
                                                    ]
                                                    ),

                                                  ],
                                                ),
                                                pw.SizedBox(
                                                  height: 20,
                                                ),
                                                pw.Row(
                                                  mainAxisAlignment: pw.MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                                  children: [

                                                    pw.SizedBox(
                                                      width: 50,
                                                    ),
                                                    pw.Text("Signature  ",style: pw.TextStyle(
                                                        fontSize: 7,
                                                        fontWeight: pw.FontWeight.bold),),
                                                    pw.SizedBox(
                                                      width: 20,
                                                    ),
                                                    pw.Text("_______________",style: pw.TextStyle(
                                                        fontSize: 7,
                                                        fontWeight: pw.FontWeight.bold),),
                                                  ],
                                                ),
                                              ]
                                          )
                                      ),

                                      pw.Divider(color:  PdfColor.fromInt(Colors.indigoAccent[200]!.value),),
                                      pw.Text("Solar Experto : votre expert de autonomie solaire ",style: pw.TextStyle(
                                          fontSize: 7
                                      )),
                                      pw.Text("+237 6 95 02 39 97 ",style: pw.TextStyle(
                                          fontSize: 7
                                      )),
                                    ]
                                ));
                          },
                        ));

                        final directory = await getApplicationDocumentsDirectory();
                        String id=UniqueKey().toString();
                        final file = File('${directory.path}/invoice.pdf');
                        await file.writeAsBytes(await pdf.save());
                        print("Output: $directory");
                        print("Output File: $file");

                        await OpenFile.open(file.path);

                        //  await FlutterShare.shareFile(title: "Share Via", filePath: file.path);
                        rank++;
                      },
                      child: const Text('Save as pdf'),
                    ),
                  ),
                ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.bgColor,
                    ),
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        onPressed: () async {
                          Future.delayed(Duration.zero, () async {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (dialogContextbattery) {

                                  return Center(
                                      child: AlertDialog(
                                        title: const Center(
                                          child: Text("Add Customer"),
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
                                          child: StreamBuilder<
                                              List<CustomerModel?>?>(
                                            stream: DatabaseService(
                                            )
                                                .customers,
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
                                                            if(mounted) {
                                                              setState(() {
                                                                customerid =
                                                                    snapshot
                                                                        .data![
                                                                    index]!
                                                                        .id;
                                                                customername =
                                                                    snapshot
                                                                        .data![
                                                                    index]!
                                                                        .name;
                                                                customerphone =
                                                                    snapshot
                                                                        .data![
                                                                    index]!
                                                                        .phone;
                                                                customeremail =
                                                                snapshot
                                                                    .data![
                                                                index]!
                                                                    .email!;
                                                                customeraddress =
                                                                    snapshot
                                                                        .data![
                                                                    index]!
                                                                        .address;
                                                              });
                                                            }
                                                            Navigator.of(
                                                                dialogContextbattery)
                                                                .pop();

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
                                                                          snapshot.data![index]!.name,
                                                                          style: TextStyle(fontSize: 16.0, color: AppColor.black, fontWeight: FontWeight.w600),
                                                                        ),
                                                                        (!AppResponsive.isMobile(context))
                                                                            ? Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              'Phone: ${snapshot.data![index]!.phone} ',
                                                                              style: TextStyle(
                                                                                color: AppColor.black.withOpacity(0.5),
                                                                                fontSize: 14,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              'Address: ${snapshot.data![index]!.address} ',
                                                                              style: TextStyle(
                                                                                color: AppColor.black.withOpacity(0.5),
                                                                                fontSize: 14,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )
                                                                            :Column(children: [
                                                                          Text(
                                                                            'Phone: ${snapshot.data![index]!.phone} ',
                                                                            style: TextStyle(
                                                                              color: AppColor.black.withOpacity(0.5),
                                                                              fontSize: 14,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            'Address: ${snapshot.data![index]!.address} ',
                                                                            style: TextStyle(
                                                                              color: AppColor.black.withOpacity(0.5),
                                                                              fontSize: 14,
                                                                            ),
                                                                          ),
                                                                        ],)
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
                                        ),
                                      ));
                                });
                          });

                        },
                        child: const Text('Add Customer'),
                      ),
                    ),
                  ),

                ],
              ),
              const SizedBox(
                height: 10,
              ),
              (!AppResponsive.isMobile(context))
                  ? Card(
                elevation: 10,
                shadowColor: AppColor.outlinecard,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/main-logo.png',
                          height: 250,
                          width: 500,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.indigoAccent[200],
                              ),
                              margin: EdgeInsets.only(right: 20),
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: Text(
                                "DEVIS ",
                                style: TextStyle(
                                    fontSize: 16, color: AppColor.white),
                              ),
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children:  [
                                Text("Devis n° "
                                  ,style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(
                                  width: 50,
                                ),
                                Text("D-$formattedDate-$rank "),
                              ],
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("En date du "),
                                SizedBox(
                                  width: 40,
                                ),
                                Text('$endudate')
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Solar Experto"),
                              Text("Akwa, Douala "),
                              Text("info.solarexperto@gmail.com"),
                              Text("+237 6 95 02 39 97 "),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 150,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Devis adressé à",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text("Nom"),
                                        Text("Adresse"),
                                        Text("Ville"),
                                        Text("E-mail"),
                                        Text("Téléphone"),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey[200]),
                                      width: 150,
                                      height: 150,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text("$customername"),
                                            Text("$customeraddress"),
                                            Text("-"),
                                            Text("$customeremail"),
                                            Text("$customerphone"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Durée de validité du présent devis 1 mois  ",
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 2,
                      color: AppColor.bgSideMenu,
                    ),
                    Container(
                      color: Colors.indigoAccent[200],
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 90,
                              child: Text(
                                "Description  ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: 90,
                              child: Text(
                                "Référence",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: 90,
                              child: Text(
                                "Qté.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: 90,
                              child: Text(
                                "Prix u [CFA]",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: 90,
                              child: Text(
                                "Prix T [CFA] ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: 90,
                              child: Text(
                                "/Jour ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: 90,
                              child: Text(
                                "/Mois",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: 90,
                              child: Text(
                                "/Année",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                      color: AppColor.bgSideMenu,
                    ),
                    Container(
                      color: Colors.blueGrey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "EQUIPEMENT NECESSAIRE ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 90,
                            child: Text(
                              "Panneaux",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              widget.invoiceModel.panelname!,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "${widget.invoiceModel.panelquantity!}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "${NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.panelprice!.toInt())}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "${NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.paneltotalprice!.toInt())}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: const Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 90,
                            child: Text(
                              "Batteries ",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                            "${widget.invoiceModel.batteryname}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "${widget.invoiceModel.batteryquantity!}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "${NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.batteryprice!.toInt())}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "${NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.batterytotalprice!.toInt())}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: const Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 90,
                            child: Text(
                              "Convertisseur",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "${widget.invoiceModel.invertername}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "1",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "${NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.inverterprice!.toInt())}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "${NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.invertertotalprice!.toInt())}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: const Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 90,
                            child: Text(
                              "Contrôleur de charge ",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "${widget.invoiceModel.controllername!}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "1",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.controllerprice!.toInt()),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.controllertotalprice!.toInt()),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: const Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 90,
                            child: Text(
                              "Accessoires",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "Câbles, Disjoncteurs,",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "${widget.invoiceModel.accessoriestotalprice}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "${widget.invoiceModel.accessoriestotalprice}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: const Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 90,
                            child: Text(
                              "Frais de service ",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "Installation/Transport/… ",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "${widget.invoiceModel!.servicetotalprice}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "${widget.invoiceModel!.servicetotalprice}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: const Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.blueGrey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "VOTRE CONSOMMATION",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 90,
                            child: Text(
                              "Demande en énergie",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "${widget.invoiceModel.G1}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "${NumberFormat("#,###").format(widget.invoiceModel.G2)}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "${NumberFormat("#,###").format(widget.invoiceModel.G3)}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 90,
                            child: Text(
                              "Prix fournisseur électrique",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              NumberFormat.decimalPattern('en_us').format({widget.invoiceModel.CI3}),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "${NumberFormat("#,###").format(widget.invoiceModel.G4)}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "${NumberFormat("#,###").format(widget.invoiceModel.G5)}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "${NumberFormat("#,###").format(widget.invoiceModel.G6)}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.blueGrey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "PRODUCTION SOLAIRE",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 90,
                            child: Text(
                              "Energie produite",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              NumberFormat("#,###").format(widget.invoiceModel.G7),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              NumberFormat("#,###").format(widget.invoiceModel.G8),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              NumberFormat("#,###").format(widget.invoiceModel.G9),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 90,
                            child: Text(
                              "Prix total système solaire",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              NumberFormat("#,###").format(widget.invoiceModel.G19),                                style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              NumberFormat("#,###").format(widget.invoiceModel.G22),                                style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              NumberFormat("#,###").format(widget.invoiceModel.G21),                                style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "${NumberFormat("#,###").format(widget.invoiceModel.G20)}",                                style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.blueGrey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "RENTABILITE ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 90,
                            child: const Text(
                              "Total épargné ",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              NumberFormat("#,###").format(widget.invoiceModel.G26),                                style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: const Text(
                              "",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              NumberFormat("#,###").format(widget.invoiceModel.G23),                                style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Text(
                              NumberFormat("#,###").format(widget.invoiceModel.G24),                                style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 100,
                            child: Text(
                              NumberFormat("#,###").format(widget.invoiceModel.G25),                                style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
                  : Card(
                elevation: 10,
                shadowColor: AppColor.outlinecard,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/main-logo.png',
                      height: 250,
                      width: 500,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.indigoAccent[200],
                            ),
                            margin: EdgeInsets.only(right: 20),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "DEVIS ",
                              style: TextStyle(
                                  fontSize: 12, color: AppColor.white),
                            ),
                          ),
                          Row(
                            children:  [
                              Text("Devis n° ",style: TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(
                                width: 125,
                              ),
                              Text("D-$formattedDate-$rank "),
                            ],
                          ),
                          Row(
                            children: [
                              const Text("En date du ",style: TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(
                                width: 112,
                              ),
                              Text(endudate),
                            ],
                          ),
                          Text("Solar Experto"),
                          Text("Akwa, Douala "),
                          Text("info.solarexperto@gmail.com"),
                          Text("+237 6 95 02 39 97 "),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 150,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Devis adressé à",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("Nom"),
                                      Text("Adresse"),
                                      Text("Ville"),
                                      Text("E-mail"),
                                      Text("Téléphone"),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blueGrey[200]),
                                    width: 150,
                                    height: 150,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text("$customername"),
                                          Text("$customeraddress"),
                                          Text("-"),
                                          Text("$customeremail"),
                                          Text("$customerphone"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Durée de validité du présent devis 1 mois  ",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 2,
                      color: AppColor.bgSideMenu,
                    ),
                    Container(
                      color: Colors.indigoAccent[200],
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 30,
                              child: Text(
                                "Description  ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: 30,
                              child: Text(
                                "Référence",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: 30,
                              child: Text(
                                "Qté.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: 30,
                              child: Text(
                                "Prix u [CFA]",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: 30,
                              child: Text(
                                "Prix T [CFA] ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: 30,
                              child: Text(
                                "/Jour ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: 30,
                              child: Text(
                                "/Mois",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: 30,
                              child: Text(
                                "/Année",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                      color: AppColor.bgSideMenu,
                    ),
                    Container(
                      color: Colors.blueGrey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "EQUIPEMENT NECESSAIRE ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 30,
                            child: const Text(
                              "Panneaux",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              widget.invoiceModel.panelname!,
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${widget.invoiceModel.panelquantity!}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.panelprice!.toInt()),
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.paneltotalprice!.toInt()),
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: const Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 30,
                            child: Text(
                              "Batteries ",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${widget.invoiceModel.batteryname}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${widget.invoiceModel.batteryquantity!}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.batteryprice!.toInt())}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.batterytotalprice!.toInt()),
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: const Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 30,
                            child: Text(
                              "Convertisseur",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${widget.invoiceModel.invertername}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "1",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.inverterprice!.toInt())}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.invertertotalprice!.toInt())}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: const Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 30,
                            child: Text(
                              "Contrôleur de charge ",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${widget.invoiceModel.controllername!}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "1",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.controllerprice!.toInt())}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.controllertotalprice!.toInt())}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: const Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 30,
                            child: Text(
                              "Accessoires",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "Câbles, Disjoncteurs,",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${widget.invoiceModel.accessoriestotalprice}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${widget.invoiceModel.accessoriestotalprice}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: const Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 30,
                            child: Text(
                              "Frais de service ",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "Installation/Transport/… ",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${widget.invoiceModel.servicetotalprice}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${widget.invoiceModel.servicetotalprice}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: const Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.blueGrey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "VOTRE CONSOMMATION",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 30,
                            child: Text(
                              "Demande en énergie",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${widget.invoiceModel.G1}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${widget.invoiceModel.G2}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${widget.invoiceModel.G3}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 30,
                            child: Text(
                              "Prix fournisseur électrique",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.CI3)}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${widget.invoiceModel.G4}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${widget.invoiceModel.G5}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${widget.invoiceModel.G6}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.blueGrey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "PRODUCTION SOLAIRE",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 30,
                            child: Text(
                              "Energie produite",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${widget.invoiceModel.G7}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${widget.invoiceModel.G8}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${widget.invoiceModel.G9}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 30,
                            child: Text(
                              "Prix total système solaire",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.G19)}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.G22)}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.G21)}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.G20)}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.blueGrey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "RENTABILITE ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 30,
                            child: Text(
                              "Total épargné ",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.G26)}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.G23)}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              "${NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.G24)}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 40,
                            child: Text(
                              "${NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.G25
                              )}",
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              (!AppResponsive.isMobile(context))
                  ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Détails de règlement & délais de livraison :",
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Total P: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "   ${NumberFormat.decimalPattern('en_us').format(
                                widget.invoiceModel.G19)} CFA",
                            style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Remise ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "- CFA",
                        style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),
                      ),
                    ],
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Taux de paiement avant l’installation : 100 %. ",
                      )),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          "Indemnité forfaitaire en cas de retard de paiement : 10.000 CFA. ")),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Total TTC  ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "   ${NumberFormat.decimalPattern('en_us').format(
                            widget.invoiceModel.G19)} CFA",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Garantie : 1an(s). ",
                      )),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          "Durée de vie (prévisionnelle) du système : ${widget.invoiceModel.GE6}  ")),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          "Autonomie du système :  ${widget.invoiceModel.GE7!.toInt()}  ")),
                  SizedBox(
                    height: 30,
                  ),

                ],
              )
                  : Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Détails de règlement & délais de livraison :",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Total P: ",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "   ${NumberFormat.decimalPattern('en_us').format(widget.invoiceModel.G19)} CFA",
                          style: TextStyle(fontSize: 12,fontWeight:FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Remise ",
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "- CFA",
                      style: TextStyle(fontSize: 12,fontWeight:FontWeight.bold),
                    ),
                  ],
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Taux de paiement avant l’installation : 100 %. ",
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        "Indemnité forfaitaire en cas de retard de paiement : 10.000 CFA. ")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Total TTC  ",
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "   ${NumberFormat.decimalPattern('en_us').format(
                          widget.invoiceModel.G19)} CFA",                        style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Garantie : 1an(s). ",
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        "Durée de vie (prévisionnelle) du système : ${widget.invoiceModel.GE6}  ")),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        "Autonomie du système :  ${widget.invoiceModel.GE7!.toInt()}  ")),


                SizedBox(
                  height: 30,
                ),
              ])
            ],
          ),
        ),
      ),
    );
    /* child: Column(
        children: [
          /// Header Part
          const HeaderWidget(Routname: "Invoices"),
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Invoices',
                                style: TextStyle(
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              ElevatedButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: AppColor.bgSideMenu,
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
                                        return AddInvoices();
                                      });
                                },
                                child: Center(
                                  child: Text(
                                    'Add Invoices',
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
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                            ),
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: TextField(
                              controller: searched,
                              textInputAction: TextInputAction.search,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                hintText: 'Search Invoices',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  name = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          (name != '')
                              ? (_searchlist.isNotEmpty)
                              ? GridView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: _searchlist.length,
                              physics: PageScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent:
                                  (!AppResponsive.isMobile(
                                      context))
                                      ? MediaQuery.of(context)
                                      .size
                                      .width /
                                      2
                                      : 390,
                                  childAspectRatio:
                                  (!AppResponsive.isMobile(
                                      context))
                                      ? 3 / 2
                                      : 2,
                                  crossAxisSpacing:
                                  (!AppResponsive.isMobile(
                                      context))
                                      ? 10
                                      : 0,
                                  mainAxisSpacing:
                                  (!AppResponsive.isMobile(
                                      context))
                                      ? 5
                                      : 20),
                              itemBuilder: (context, index) {
                                return InvoiceTile(
                                  invoiceModel: _searchlist[index],
                                );
                              })
                              : const yelloNoData()
                              : StreamBuilder<List<InvoiceModel?>?>(
                            stream: DatabaseService().invoices,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.length == 0) {
                                  return Center(
                                    child: yelloNoData(),
                                  );
                                } else {
                                  return GridView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: snapshot.data!.length,
                                      shrinkWrap: true,
                                      //physics: PageScrollPhysics(),
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
                                              : 390,
                                          childAspectRatio:
                                          (!AppResponsive
                                              .isMobile(
                                              context))
                                              ? 3 / 2
                                              : 2,
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
                                        return InvoiceTile(
                                          invoiceModel:
                                          snapshot.data![index]!,

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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),*/

  }
}
