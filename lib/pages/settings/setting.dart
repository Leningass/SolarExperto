import 'package:SolarExperto/constants/app_colors.dart';
import 'package:SolarExperto/constants/constants.dart';
import 'package:SolarExperto/global_widgets/customtext/customtext.dart';
import 'package:SolarExperto/global_widgets/decoration/tab_decoration.dart';
import 'package:SolarExperto/global_widgets/header/header_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_responsive.dart';
import '../../provider/app_provider.dart';
import '../../screen_widget/systemsettings/admindata/adminlist.dart';
import '../../screen_widget/systemsettings/appliancesdata/appliancespage.dart';
import '../../screen_widget/systemsettings/equipments/equipmentspage.dart';

import 'GlobalSetting/globalsetting.dart';

class AppSetting extends StatefulWidget {
  const AppSetting({Key? key}) : super(key: key);

  @override
  State<AppSetting> createState() => _AppSettingState();
}

class _AppSettingState extends State<AppSetting> with TickerProviderStateMixin {
  final adminform = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);

    return SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor.bgColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child:
                // (!AppResponsive.isMobile(context)) ?
                Column(
              children: [
                HeaderWidget(Routname: "Settings"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Applianceslist()),
                          );
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            //  color: Colors.indigo[900],
                            elevation: 10,
                            // margin: (!AppResponsive.isMobile(context))
                            //     ? EdgeInsets.fromLTRB(32, 32, 64, 32)
                            //     : EdgeInsets.fromLTRB(32, 32, 32, 32),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Color.fromARGB(255, 38, 156, 235)!,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 16.0),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.devices,
                                                size: ((!AppResponsive.isMobile(
                                                        context))
                                                    ? 150
                                                    : 70),
                                                color: Colors.white,
                                              ),
                                              Center(
                                                child: Text(
                                                  'Appliances',
                                                  style: TextStyle(
                                                    color: AppColor.bgColor,
                                                    fontSize: ((!AppResponsive
                                                            .isMobile(context))
                                                        ? 24
                                                        : 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        //SelectionSection(),
                                      ],
                                    )),
                                // ),
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Equipmentslist()),
                          );
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 10,
                            // margin: (!AppResponsive.isMobile(context))
                            //     ? EdgeInsets.fromLTRB(32, 32, 64, 32)
                            //     : EdgeInsets.fromLTRB(32, 32, 32, 32),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Color.fromARGB(255, 38, 156, 235)!,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 16.0),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.device_hub,
                                                size: ((!AppResponsive.isMobile(
                                                        context))
                                                    ? 150
                                                    : 70),
                                                color: Colors.white,
                                              ),
                                              Center(
                                                child: Text(
                                                  'Equipments',
                                                  style: TextStyle(
                                                    color: AppColor.white,
                                                    fontSize: ((!AppResponsive
                                                            .isMobile(context))
                                                        ? 24
                                                        : 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        //SelectionSection(),
                                      ],
                                    )),
                                // ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (dialogContext) {
                                return StatefulBuilder(
                                    builder: (dialogContext, setState) {
                                  return AlertDialog(
                                    title: const Center(
                                      child: Text("Passcode"),
                                    ),
                                    content: Form(
                                        key: adminform,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextFormField(
                                              obscureText: _obscureText,
                                              decoration: InputDecoration(
                                                hintText: "Enter passcode",
                                                border: OutlineInputBorder(),
                                                suffixIcon: IconButton(
                                                  color: Colors.grey,
                                                  onPressed: () {
                                                    setState(() {
                                                      _obscureText =
                                                          !_obscureText;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    _obscureText
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                  ),
                                                ),
                                              ),
                                              controller: controller,
                                              validator: (value) {
                                                if (controller.text != null) {
                                                  if (value!.isEmpty) {
                                                    return 'Please enter passcode';
                                                  }
                                                }
                                              },
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(
                                                              dialogContext)
                                                          .pop();
                                                      controller.clear();
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.red),
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color:
                                                              AppColor.white),
                                                    )),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      if (!adminform
                                                          .currentState!
                                                          .validate()) {
                                                      } else {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'passcode')
                                                            .doc(
                                                                'rKSpvQYw1CLpCekmqnFo')
                                                            .get()
                                                            .then(
                                                                (DocumentSnapshot) async {
                                                          if (controller
                                                                  .value.text ==
                                                              DocumentSnapshot[
                                                                  'passcode']) {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          AdminList()),
                                                            );

                                                            controller.clear();
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                                        content:
                                                                            Text("You may proceed!")));
                                                            Navigator.of(
                                                                    dialogContext)
                                                                .pop();
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                                        content:
                                                                            Text("Just super admin can proceed!")));
                                                            Navigator.of(
                                                                    dialogContext)
                                                                .pop();
                                                            controller.clear();
                                                          }

                                                          controller.clear();
                                                        });
                                                      }
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                AppColor
                                                                    .bgSideMenu),
                                                    child: Text(
                                                      "Proceed",
                                                      style: TextStyle(
                                                          color:
                                                              AppColor.white),
                                                    )),
                                              ],
                                            )
                                          ],
                                        )),
                                  );
                                });
                              });
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            // color: AppColor.white,
                            elevation: 10,
                            // margin: (!AppResponsive.isMobile(context))
                            //     ? EdgeInsets.fromLTRB(32, 32, 64, 32)
                            //     : EdgeInsets.fromLTRB(32, 32, 32, 32),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Color.fromARGB(255, 38, 156, 235)!,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 16.0),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.people_outline,
                                                size: ((!AppResponsive.isMobile(
                                                        context))
                                                    ? 150
                                                    : 70),
                                                color: Colors.white,
                                              ),
                                              Center(
                                                child: Text(
                                                  'Users',
                                                  style: TextStyle(
                                                    color: AppColor.bgColor,
                                                    fontSize: ((!AppResponsive
                                                            .isMobile(context))
                                                        ? 24
                                                        : 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        //SelectionSection(),
                                      ],
                                    )),
                                // ),
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GlobalSetting(
                                      appProvider: appProvider,
                                    )),
                          );
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            // color: AppColor.white,
                            elevation: 10,
                            // margin: (!AppResponsive.isMobile(context))
                            //     ? EdgeInsets.fromLTRB(32, 32, 64, 32)
                            //     : EdgeInsets.fromLTRB(32, 32, 32, 32),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Color.fromARGB(255, 38, 156, 235)!,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 16.0),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.abc,
                                                size: ((!AppResponsive.isMobile(
                                                        context))
                                                    ? 150
                                                    : 70),
                                                color: Colors.white,
                                              ),
                                              Center(
                                                child: Text(
                                                  'Globals',
                                                  style: TextStyle(
                                                    color: AppColor.white,
                                                    fontSize: ((!AppResponsive
                                                            .isMobile(context))
                                                        ? 24
                                                        : 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        //SelectionSection(),
                                      ],
                                    )),
                                // ),
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ],
            )
            /*:Column(
          children: [

            HeaderWidget(Routname: "Settings"),

            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Applianceslist()),
                );
              },
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: AppColor.white,
                  elevation: 10,
                  // margin: (!AppResponsive.isMobile(context))
                  //     ? EdgeInsets.fromLTRB(32, 32, 64, 32)
                  //     : EdgeInsets.fromLTRB(32, 32, 32, 32),
                  child: Padding(
                    padding: (!AppResponsive.isMobile(context))
                        ? EdgeInsets.all(30.0)
                        : EdgeInsets.all(0.0),
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        child: Column(
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.devices,
                                    size: 70,
                                  ),
                                  const SizedBox(
                                    height: appPadding,
                                  ),
                                  ElevatedButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor:
                                        AppColor.bgSideMenu,
                                        padding: EdgeInsets.all(25.0),
                                        elevation: 5.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(20))),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Applianceslist()),
                                      );
                                      // showDialog(
                                      //     context: context,
                                      //     barrierDismissible: false,
                                      //     builder: (dialogContext) {
                                      //       return widget.pop_wiget;
                                      //     });
                                    },
                                    child: Center(
                                      child: Text(
                                        'Appliances',
                                        style: TextStyle(
                                          color: AppColor.bgColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //SelectionSection(),
                          ],
                        )),
                    // ),
                  )),
            ),

            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Equipmentslist()),
                );
              },
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: AppColor.white,
                  elevation: 10,
                  // margin: (!AppResponsive.isMobile(context))
                  //     ? EdgeInsets.fromLTRB(32, 32, 64, 32)
                  //     : EdgeInsets.fromLTRB(32, 32, 32, 32),
                  child: Padding(
                    padding: (!AppResponsive.isMobile(context))
                        ? EdgeInsets.all(30.0)
                        : EdgeInsets.all(0.0),
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        child: Column(
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.device_hub,
                                    size: 70,
                                  ),
                                  const SizedBox(
                                    height: appPadding,
                                  ),
                                  ElevatedButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor:
                                        AppColor.bgSideMenu,
                                        padding: EdgeInsets.all(25.0),
                                        elevation: 5.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(20))),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Equipmentslist()),
                                      );
                                      // showDialog(
                                      //     context: context,
                                      //     barrierDismissible: false,
                                      //     builder: (dialogContext) {
                                      //       return widget.pop_wiget;
                                      //     });
                                    },
                                    child: Center(
                                      child: Text(
                                        'Equipments',
                                        style: TextStyle(
                                          color: AppColor.bgColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //SelectionSection(),
                          ],
                        )),
                    // ),
                  )),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AdminList()),
                );
              },
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: AppColor.white,
                  elevation: 10,
                  // margin: (!AppResponsive.isMobile(context))
                  //     ? EdgeInsets.fromLTRB(32, 32, 64, 32)
                  //     : EdgeInsets.fromLTRB(32, 32, 32, 32),
                  child: Padding(
                    padding: (!AppResponsive.isMobile(context))
                        ? EdgeInsets.all(30.0)
                        : EdgeInsets.all(0.0),
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        child: Column(
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.people_outline,
                                    size: 70,
                                  ),
                                  const SizedBox(
                                    height: appPadding,
                                  ),
                                  ElevatedButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor:
                                        AppColor.bgSideMenu,
                                        padding: EdgeInsets.all(25.0),
                                        elevation: 5.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(20))),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdminList()),
                                      );
                                      // showDialog(
                                      //     context: context,
                                      //     barrierDismissible: false,
                                      //     builder: (dialogContext) {
                                      //       return widget.pop_wiget;
                                      //     });
                                    },
                                    child: Center(
                                      child: Text(
                                        'Users',
                                        style: TextStyle(
                                          color: AppColor.bgColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //SelectionSection(),
                          ],
                        )),
                    // ),
                  )),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          GlobalSetting(
                            appProvider: appProvider,
                          )),
                );
              },
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: AppColor.white,
                  elevation: 10,
                  // margin: (!AppResponsive.isMobile(context))
                  //     ? EdgeInsets.fromLTRB(32, 32, 64, 32)
                  //     : EdgeInsets.fromLTRB(32, 32, 32, 32),
                  child: Padding(
                    padding: (!AppResponsive.isMobile(context))
                        ? EdgeInsets.all(30.0)
                        : EdgeInsets.all(0.0),
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        child: Column(
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.abc,
                                    size: 70
                                  ),
                                  const SizedBox(
                                    height: appPadding,
                                  ),
                                  ElevatedButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor:
                                        AppColor.bgSideMenu,
                                        padding: EdgeInsets.all(25.0),
                                        elevation: 5.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(20))),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                GlobalSetting(
                                                  appProvider: appProvider,
                                                )),
                                      );
                                      // showDialog(
                                      //     context: context,
                                      //     barrierDismissible: false,
                                      //     builder: (dialogContext) {
                                      //       return widget.pop_wiget;
                                      //     });
                                    },
                                    child: Center(
                                      child: Text(
                                        'Global Parameters',
                                        style: TextStyle(
                                          color: AppColor.bgColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //SelectionSection(),
                          ],
                        )),
                    // ),
                  )),
            ),*/

            ));
  }
}
