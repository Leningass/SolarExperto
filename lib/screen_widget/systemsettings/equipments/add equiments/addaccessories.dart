import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_responsive.dart';
import '../../../../global_widgets/Loading/saveloading.dart';
import '../../../../services/database/database_service.dart';
import '../../../../utilis/UplaodImages.dart';

class AddAccessories extends StatefulWidget {
  const AddAccessories({Key? key}) : super(key: key);

  @override
  State<AddAccessories> createState() => _AddAccessoriesState();
}

class _AddAccessoriesState extends State<AddAccessories> {
  TextEditingController name = TextEditingController();
  TextEditingController type = TextEditingController();
 TextEditingController primary = TextEditingController();
  TextEditingController secondary = TextEditingController();
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
        child: Text("Add Accessories"),
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
                        value!.isEmpty ? 'Please enter  name ' : null,
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
                    validator: (value) => value!.isEmpty
                        ? 'Please enter primary '
                        : null,
                    decoration: InputDecoration(
                      labelText: "Primary ",
                      hintText: "Primary ",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: primary,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) => value!.isEmpty
                        ? 'Please enter secondary '
                        : null,
                    decoration: InputDecoration(
                      labelText: "Secondary ",
                      hintText: "Secondary ",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: secondary,
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
                                'assets/accessories.png');
                            await uploadImage(
                                    'Equipment/accessories#$id', file!)
                                .then((value) => setState(() {
                                      if (value != null) {
                                        ImageUrl = value;
                                      } else {
                                        print('not found');
                                      }
                                    }));
                            var date = Timestamp.now();
                            if (ImageUrl != null) {
                              DatabaseService().updateaccessories(
                                  'accessories#$id',
                                  name.text.toString(),
                                  type.text.toString(),
                                  primary.text.toString(),
                                  secondary.text.toString(),
                                  int.parse(quantity.text.toString()),
                                  int.parse(buyingprice.text.toString()),
                                  int.parse(
                                    saleprice.text.toString(),
                                  ),
                                  ImageUrl,
                                  description.text.toString(),
                                  'Accessories',
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
