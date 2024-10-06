import 'package:SolarExperto/constants/app_colors.dart';
import 'package:SolarExperto/constants/app_responsive.dart';
import 'package:SolarExperto/global_widgets/Loading/saveloading.dart';
import 'package:SolarExperto/services/database/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddApplianceCategories extends StatefulWidget {
  const AddApplianceCategories({Key? key}) : super(key: key);

  @override
  State<AddApplianceCategories> createState() => _AddApplianceCategoriesState();
}

class _AddApplianceCategoriesState extends State<AddApplianceCategories> {
  TextEditingController catnameController = TextEditingController();
  final _cateform = GlobalKey<FormState>();
  bool isadded = false;
  @override
  Widget build(BuildContext context) {
    String id = UniqueKey().toString();
    return Center(
        child: AlertDialog(
      title: Center(
        child: Text("Add Appliance Categories"),
      ),
      content: SingleChildScrollView(
        child: Container(
          color: AppColor.white,
          width: (!AppResponsive.isMobile(context))
              ? 300
              : MediaQuery.of(context).size.width,
          height: 180,
          child: Form(
            key: _cateform,
            child: Column(
              children: [
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a name ' : null,
                  decoration: InputDecoration(
                    hintText: "Name",
                    fillColor: AppColor.bgColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 0.8),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  controller: catnameController,
                ),
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
                        if (_cateform.currentState!.validate()) {
                          var date = Timestamp.now();
                          if (catnameController.value.text.isNotEmpty) {
                            setState(() {
                              isadded = true;
                            });
                            await DatabaseService(
                                    doctoken: 'categoryappliances#$id')
                                .updateappliancescategory(
                                    catnameController.text,
                                    'categoryappliances#$id',
                                    date);

                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Added!")));

                            Navigator.of(context).pop();
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
