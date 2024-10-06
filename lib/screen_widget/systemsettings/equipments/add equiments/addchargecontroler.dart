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

class AddChargeController extends StatefulWidget {
  const AddChargeController({Key? key}) : super(key: key);

  @override
  State<AddChargeController> createState() => _AddChargeControllerState();
}

class _AddChargeControllerState extends State<AddChargeController> {
  TextEditingController name = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController voltage = TextEditingController();
  TextEditingController current = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController buyingprice = TextEditingController();
  TextEditingController saleprice = TextEditingController();
  TextEditingController description = TextEditingController();
  final form = GlobalKey<FormState>();
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
        child: Text("Add Charge Controller"),
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
              key: form,
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
                    controller: name,
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
                    controller: type,
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
                        value!.isEmpty ? 'Please enter rated voltage' : null,
                    decoration: InputDecoration(
                      suffixText: 'V',
                      labelText: "Rated Voltage",
                      hintText: "Rated Voltage",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: voltage,
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
                        value!.isEmpty ? 'Please enter input current' : null,
                    decoration: InputDecoration(
                      suffixText: 'A',
                      labelText: "Input Current",
                      hintText: "Input Current",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: current,
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
                        value!.isEmpty ? 'Please enter quantity' : null,
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
                    controller: quantity,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter buying price ' : null,
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
                    controller: buyingprice,
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
                    controller: saleprice,
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
                    controller: description,
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

/*
                      ElevatedButton.icon(
                          icon:
                          Icon(Icons.image, size: 16, color: AppColor.bgColor),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                          onPressed: () =>
                              getfilepath().then((value) =>
                                  setState(() {
                                    file = value!;
                                  })),
                          label: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("Pick Icon",
                                style: TextStyle(color: AppColor.bgColor)),
                          )),
*/
                  SizedBox(
                    height: 10,
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
                          if (form.currentState!.validate()) {
                            setState(() {
                              isadded = true;
                            });
                            file ??= await getImageFileFromAssets(
                                'assets/controller.png');
                            await uploadImage('Equipment/controler#$id', file!)
                                .then((value) => setState(() {
                                      if (value != null) {
                                        ImageUrl = value;
                                      } else {
                                        print('not found');
                                      }
                                    }));
                            var date = Timestamp.now();
                            if (ImageUrl != null) {
                              DatabaseService().updatecontroller(
                                  'controler#$id',
                                  name.text.toString(),
                                  type.text.toString(),
                                  int.parse(quantity.text.toString()),
                                  double.parse(
                                    voltage.text.toString(),
                                  ),
                                  double.parse(current.text.toString()),
                                  double.parse(
                                    buyingprice.text.toString(),
                                  ),
                                  double.parse(
                                    saleprice.text.toString(),
                                  ),
                                  ImageUrl,
                                  description.text.toString(),
                                  'Controler',
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
