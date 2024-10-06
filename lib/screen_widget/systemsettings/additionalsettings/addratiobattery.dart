import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_responsive.dart';
import '../../../global_widgets/Loading/saveloading.dart';
import '../../../services/database/database_service.dart';
import '../../../utilis/UplaodImages.dart';

class AddBatteryRationIcon extends StatefulWidget {
  const AddBatteryRationIcon({Key? key}) : super(key: key);

  @override
  State<AddBatteryRationIcon> createState() => _AddBatteryRationIconState();
}

class _AddBatteryRationIconState extends State<AddBatteryRationIcon> {
  TextEditingController numberseries = TextEditingController();
  TextEditingController numberparallel = TextEditingController();

  final _batteryiconform = GlobalKey<FormState>();
  bool isadded = false;
  String? ImageUrl;
  File? file;
  @override
  Widget build(BuildContext context) {
    String id = UniqueKey().toString();
    return Center(
        child: AlertDialog(
      title: Center(
        child: Text("Battery Icon"),
      ),
      content: SingleChildScrollView(
        child: Container(
          color: AppColor.white,
          width: (!AppResponsive.isMobile(context))
              ? 300
              : MediaQuery.of(context).size.width,
          height: 350,
          child: Form(
            key: _batteryiconform,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (value) {},
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter value' : null,
                  decoration: InputDecoration(
                    suffixText: 'NS',
                    labelText: "Series",
                    hintText: "Series",
                    fillColor: AppColor.bgColor,
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 0.8),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  controller: numberseries,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter value' : null,
                  decoration: InputDecoration(
                    suffixText: 'NP',
                    labelText: "Parallel",
                    hintText: "Parallel",
                    fillColor: AppColor.bgColor,
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 0.8),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  controller: numberparallel,
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                    icon: Icon(Icons.image, size: 16, color: AppColor.bgColor),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                    onPressed: () => getfilepath().then((value) => setState(() {
                          file = value!;
                        })),
                    label: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Pick Icon",
                          style: TextStyle(color: AppColor.bgColor)),
                    )),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      icon:
                          Icon(Icons.close, size: 16, color: AppColor.bgColor),
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
                      icon: Icon(Icons.add, size: 16, color: AppColor.bgColor),
                      style: ElevatedButton.styleFrom(
                          primary: AppColor.bgSideMenu),
                      onPressed: () async {
                        if (_batteryiconform.currentState!.validate()) {
                          if (file != null) {
                            setState(() {
                              isadded = true;
                            });
                            await uploadImage(
                                    'BatterierRatio/batteryratio#$id', file!)
                                .then((value) => setState(() {
                                      if (value != null) {
                                        ImageUrl = value;
                                      } else {
                                        print('not found');
                                      }
                                    }));
                            int total =
                                int.parse(numberseries.text.toString()) *
                                    int.parse(numberparallel.text.toString());

                            await DatabaseService().updatebatteryratio(
                                'batteryratio#$id',
                                total,
                                int.parse(numberseries.text.toString()),
                                int.parse(numberparallel.text.toString()),
                                ImageUrl!);

                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Added!")));
                            Navigator.of(context).pop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Add File")));
                          }
                        }
                      },
                      label: Text(
                        "Add",
                        style:
                            TextStyle(color: AppColor.bgColor, fontSize: 16.0),
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
        ),
        //child: const AddCategories(),
      ),
    ));
  }
}
