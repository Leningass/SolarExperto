import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_responsive.dart';
import '../../../../global_widgets/Loading/saveloading.dart';
import '../../../../services/database/database_service.dart';
import '../../../../utilis/UplaodImages.dart';

class AddInverter extends StatefulWidget {
  const AddInverter({Key? key}) : super(key: key);

  @override
  State<AddInverter> createState() => _AddInverterState();
}

class _AddInverterState extends State<AddInverter> {
  TextEditingController invertername = TextEditingController();
  TextEditingController invertertype = TextEditingController();
  TextEditingController inverterratedpower = TextEditingController();
  TextEditingController inverterquantity = TextEditingController();
  TextEditingController inverternominalvoltage = TextEditingController();
  TextEditingController inverteracvoltage = TextEditingController();
  TextEditingController inverterefficiency = TextEditingController();
  TextEditingController inverterbuyingprice = TextEditingController();
  TextEditingController invertersellingprice = TextEditingController();
  TextEditingController inverterdescription = TextEditingController();
  final inverterform = GlobalKey<FormState>();
  bool isadded = false;
  String? ImageUrl;
  File? file;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String id = UniqueKey().toString();
    return Center(
        child: AlertDialog(
      title: const Center(
        child: Text("Add Inverter"),
      ),
      content: Container(
        color: AppColor.white,
        width: (!AppResponsive.isMobile(context))
            ? 400
            : MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Form(
              key: inverterform,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a name ' : null,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: "Name",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: invertername,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a type ' : null,
                    decoration: InputDecoration(
                      labelText: 'Type',
                      hintText: "Type",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: invertertype,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter rated power' : null,
                    decoration: InputDecoration(
                      suffixText: 'W',
                      labelText: "Rated Power",
                      hintText: "Rated Power",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: inverterratedpower,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter quantity ' : null,
                    decoration: InputDecoration(
                      suffixText: 'Qty',
                      labelText: "Quantity",
                      hintText: "Quantity",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: inverterquantity,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType:
                    TextInputType.numberWithOptions(decimal: true),
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter ac voltage ' : null,
                    decoration: InputDecoration(
                      suffixText: 'V',
                      labelText: "AC Voltage",
                      hintText: "AC Voltage",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: inverteracvoltage,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter nominal voltage ' : null,
                    decoration: InputDecoration(
                      suffixText: 'V',
                      labelText: "Nominal Voltage",
                      hintText: "Nominal Voltage",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: inverternominalvoltage,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter efficiency' : null,
                    decoration: InputDecoration(
                      labelText: "Efficiency",
                      hintText: "Efficiency",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: inverterefficiency,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter buying price' : null,
                    decoration: InputDecoration(
                      suffixText: 'CFA',
                      labelText: "Buying Price",
                      hintText: "Buying Price",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: inverterbuyingprice,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter selling price' : null,
                    decoration: InputDecoration(
                      suffixText: 'CFA',
                      labelText: "Selling Price",
                      hintText: "Selling Price",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: invertersellingprice,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLines: 5,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter description' : null,
                    decoration: InputDecoration(
                      labelText: "Description",
                      hintText: "Description",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: inverterdescription,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () => getfilepath().then((value) => setState(() {
                          file = value;
                          print("File: $file");
                        })),
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      height: 60,
                      child: DottedBorder(
                        color: Colors.grey,
                        strokeWidth: 2,
                        dashPattern: [5, 5, 5, 5],
                        radius: Radius.circular(12),
                        child: Center(
                          child: file == null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.photo,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      'Image',
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 15),
                                    ),
                                  ],
                                )
                              : Image.file(file!),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(Icons.close,
                            size: 16, color: AppColor.bgColor),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
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
                            backgroundColor: AppColor.bgSideMenu),
                        onPressed: () async {
                          if (inverterform.currentState!.validate()) {
                            setState(() {
                              isadded = true;
                            });
                            file ??= await getImageFileFromAssets(
                                'assets/inverter.png');
                            await uploadImage('Equipment/inverter#$id', file!)
                                .then((value) => setState(() {
                                      if (value != null) {
                                        ImageUrl = value;
                                      } else {
                                        print('not found');
                                      }
                                    }));
                            var date = Timestamp.now();
                            if (ImageUrl != null) {
                              DatabaseService().updateinverter(
                                  'inverter#$id',
                                  invertername.text.toString(),
                                  invertertype.text.toString(),
                                  int.parse(
                                    inverterratedpower.text.toString(),
                                  ),
                                  int.parse(inverterquantity.text.toString()),
                                  int.parse(
                                      inverternominalvoltage.text.toString()),
                                  int.parse(inverteracvoltage.text.toString()),
                                  int.parse(inverterefficiency.text.toString()),
                                  double.parse(
                                      inverterbuyingprice.text.toString()),
                                  double.parse(
                                      invertersellingprice.text.toString()),
                                  ImageUrl,
                                  inverterdescription.text.toString(),
                                  'Inverter',
                                  date);
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Added!")));
                            Navigator.of(context).pop();
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
                  const SizedBox(
                    height: 5.0,
                  ),
                  (isadded == true) ? const SaveLoading() : Container(),
                ],
              ),
            ),
            //(isadded == true) ? const SaveLoading() : Container(),
          ],
        ),
      ),
      //child: const AddCategories(),
    ));
  }
}
