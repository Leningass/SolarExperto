import 'dart:io';
import 'package:SolarExperto/constants/app_colors.dart';
import 'package:SolarExperto/constants/app_responsive.dart';
import 'package:SolarExperto/global_widgets/Loading/saveloading.dart';
import 'package:SolarExperto/services/database/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddCustomers extends StatefulWidget {
  const AddCustomers({Key? key}) : super(key: key);

  @override
  State<AddCustomers> createState() => _AddCustomersState();
}

class _AddCustomersState extends State<AddCustomers> {
  TextEditingController customernameController = TextEditingController();
  TextEditingController customerphoneController = TextEditingController();
  TextEditingController customeremailController = TextEditingController();
  TextEditingController customeraddressController = TextEditingController();
  final customerform = GlobalKey<FormState>();
  bool isadded = false;
  String? ImageUrl;
  File? file;

  @override
  Widget build(BuildContext context) {
    String id = UniqueKey().toString();
    return Center(
        child: AlertDialog(
      title: const Center(
        child: Text("Add Customer"),
      ),
      content: SingleChildScrollView(
        child: Container(
          color: AppColor.white,
          width: (!AppResponsive.isMobile(context))
              ? 350
              : MediaQuery.of(context).size.width,
          height: 450,
          child: Form(
            key: customerform,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a name ' : null,
                  decoration: InputDecoration(
                    hintText: "Name",
                    fillColor: AppColor.bgColor,
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 0.8),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  controller: customernameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLength: 12,
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a number ' : null,
                  decoration: InputDecoration(
                    hintText: "Phone",
                    fillColor: AppColor.bgColor,
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 0.8),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  controller: customerphoneController,
                ),
                //phone
                SizedBox(
                  height: 10,
                ),
                TextFormField(

                  decoration: InputDecoration(
                    hintText: "Email",
                    fillColor: AppColor.bgColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 0.8),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  controller: customeremailController,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: ((value) {
                    if (customeremailController.text != null) {
                      if (value!.trim().isEmpty) {
                        return 'Address can\'t be empty';
                      }
                    }
                  }),
                  decoration: InputDecoration(
                    hintText: "Address",
                    fillColor: AppColor.bgColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 0.8),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  controller: customeraddressController,
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
                        if (customerform.currentState!.validate()) {
                          var date = Timestamp.now();
                          setState(() {
                            isadded = true;
                          });

                          await DatabaseService().updatecustomers(
                              'customer#$id',
                              customernameController.text.toString(),
                              customerphoneController.text.toString(),
                              customeremailController.text.toString(),
                              customeraddressController.text.toString(),
                            date);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Added!")));
                          Navigator.of(context).pop();
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
                const SizedBox(
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
