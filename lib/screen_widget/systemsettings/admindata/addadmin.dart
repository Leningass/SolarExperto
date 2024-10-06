import 'dart:io';

import 'package:SolarExperto/constants/app_colors.dart';
import 'package:SolarExperto/constants/app_responsive.dart';
import 'package:SolarExperto/global_widgets/Loading/saveloading.dart';
import 'package:SolarExperto/services/auth/auth.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SolarExperto/utilis/UplaodImages.dart';

class AddAdmin extends StatefulWidget {
  const AddAdmin({Key? key}) : super(key: key);

  @override
  State<AddAdmin> createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  final adminform = GlobalKey<FormState>();
  bool isadded = false;
  String? ImageUrl;
  File? file;
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Center(
        child: AlertDialog(
      title: Center(
        child: Text("Add Admin"),
      ),
      content: Container(
        color: AppColor.white,

        child: Stack(
          children: [
            Form(
              key: adminform,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a name ' : null,
                    decoration: InputDecoration(
                      hintText: "Name",
                      fillColor: AppColor.bgColor,
                      iconColor: AppColor.bgSideMenu,
                      icon: Icon(
                        Icons.account_box_rounded,
                        color: AppColor.bgSideMenu,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: authProvider.name,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) =>
                        authProvider.validateEmail(value.toString()),
                    decoration: InputDecoration(
                      hintText: "Email",
                      fillColor: AppColor.bgColor,
                      iconColor: AppColor.bgSideMenu,
                      icon: Icon(
                        Icons.email_outlined,
                        color: AppColor.bgSideMenu,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: authProvider.email,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a password ' : null,
                    decoration: InputDecoration(
                      hintText: "Password",
                      fillColor: AppColor.bgColor,
                      iconColor: AppColor.bgSideMenu,
                      icon: Icon(
                        Icons.password,
                        color: AppColor.bgSideMenu,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: authProvider.password,
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(Icons.close,
                            size: 16, color: AppColor.bgColor),
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        label: Text("Cancel",
                            style: TextStyle(color: AppColor.bgColor)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton.icon(
                        icon:
                            Icon(Icons.add, size: 16, color: AppColor.bgColor),
                        style: ElevatedButton.styleFrom(
                            primary: AppColor.bgSideMenu),
                        onPressed: () async {
                          if (adminform.currentState!.validate()) {
                            setState(() {
                              isadded = true;
                            });
                            if (await authProvider.signUp(context)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Added!")));

                              Navigator.of(context).pop();
                              authProvider.clearController();
                            } else {
                              setState(() {
                                isadded = false;
                              });
                            }
                          }
                        },
                        label: Text(
                          "Add",
                          style: TextStyle(
                              color: AppColor.bgColor, fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  (isadded == true) ? const SaveLoading() : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
      //child: const AddCategories(),
    ));
  }
}
