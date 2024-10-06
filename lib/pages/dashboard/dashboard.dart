import 'dart:io';

import 'package:SolarExperto/constants/app_colors.dart';
import 'package:SolarExperto/constants/app_responsive.dart';
import 'package:SolarExperto/global_widgets/header/header_widget.dart';
import 'package:SolarExperto/widget/discussions.dart';
import 'package:SolarExperto/widget/users.dart';
import 'package:SolarExperto/widget/users_by_device.dart';
import 'package:flutter/material.dart';
import 'package:SolarExperto/widget/calender_widget.dart';
import 'package:SolarExperto/widget/notification_card_widget.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../widget/notification_card_widget.dart';
import '../../widget/notification_card_widget.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {




  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            /// Header Part
            HeaderWidget(Routname: "Dashboard"),
           /* ElevatedButton(
              onPressed: ()async {
                final pdf = pw.Document();
                final text = pw.Text('Hello, world!');
                pdf.addPage(pw.Page(
                  build: (pw.Context context) {
                    return pw.Center(
                      child: pw.Row(
                        children: [
                          pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              child: pw.Column(
                                children: [
                                  pw.Text("abc"),
                                  pw.SizedBox(
                                    height: 20,
                                  ),

                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    );
                  },
                ));
                final directory = await getApplicationDocumentsDirectory();


                final file = File('${directory.path}/invoice.pdf');
                await file.writeAsBytes(await pdf.save());
                print("Output: $directory");
                print("Output File: $file");

                await OpenFile.open(file.path);
               // await FlutterShareFile.share(file.path);
              },
              child: const Text('Export to pdf'),
            ),*/
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                   flex: 2,
                      child: Container(
                        child: Column(
                          children: [
                            NotificationCardWidget(),
                            SizedBox(
                              height: 20,
                            ),
                            if (AppResponsive.isMobile(context)) ...{
                              CalendarWidget(),
                              SizedBox(
                                height: 20,
                              ),
                               Discussions(),
                              SizedBox(
                                height: 20,
                              ),

                            },
                            Users(),
                            UsersByDevice(),
                          ],
                        ),
                      ),
                    ),
                    if (!AppResponsive.isMobile(context))
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              CalendarWidget(),
                              SizedBox(
                                height: 20,
                              ),
                              Discussions(),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
