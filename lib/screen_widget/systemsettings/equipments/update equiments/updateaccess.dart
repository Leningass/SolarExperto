import 'dart:io';

import 'package:SolarExperto/models/accessories/accessoriesmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_responsive.dart';
import '../../../../global_widgets/Loading/saveloading.dart';
import '../../../../services/database/database_service.dart';
import '../../../../utilis/UplaodImages.dart';

class UpdateAccessories extends StatefulWidget {
  const UpdateAccessories({Key? key, required this.accessoriesModel})
      : super(key: key);
  final AccessoriesModel accessoriesModel;
  @override
  State<UpdateAccessories> createState() => _UpdateAccessoriesState();
}

class _UpdateAccessoriesState extends State<UpdateAccessories> {
  TextEditingController name = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController primarychar = TextEditingController();
  TextEditingController secondarychar = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController purchaseprice = TextEditingController();
  TextEditingController saleprice = TextEditingController();
  TextEditingController description = TextEditingController();
  final form = GlobalKey<FormState>();
  bool isadded = false;
  String? ImageUrl;
  File? file;
  @override
  void initState() {
    name.text = widget.accessoriesModel.name.toString();
    type.text = widget.accessoriesModel.type.toString();
     primarychar.text =
         widget.accessoriesModel.primary.toString();

    secondarychar.text =
        widget.accessoriesModel.secondary.toString();
    quantity.text = widget.accessoriesModel.quantity.toString();
    purchaseprice.text = widget.accessoriesModel.buyingprice.toString();
    saleprice.text = widget.accessoriesModel.sellingprice.toString();
    description.text = widget.accessoriesModel.description.toString();
    ImageUrl = widget.accessoriesModel.image.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AlertDialog(
      title: const Center(
        child: Text("Update Batteries"),
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
                      labelText: ' Name',
                      hintText: "Battery Name",
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
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
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
                    controller: primarychar,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) => value!.isEmpty
                        ? 'Please enter secondary  '
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
                    controller: secondarychar,
                  ),
                  SizedBox(
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
                        value!.isEmpty ? 'Please enter' : null,
                    decoration: InputDecoration(
                      suffixText: 'CFA',
                      labelText: "Purchase Price",
                      hintText: "Purchase Price",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: purchaseprice,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter' : null,
                    decoration: InputDecoration(
                      suffixText: 'CFA',
                      labelText: "Sale Price",
                      hintText: "Sale Price",
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
                    decoration: InputDecoration(
                      labelText: 'Description',
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
                              getfilepath().then((value) => setState(() {
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
                          if (form.currentState!.validate()) {
                            setState(() {
                              isadded = true;
                            });
                            if (file != null) {
                              await uploadImage(
                                      'Equipment/${widget.accessoriesModel.id}',
                                      file!)
                                  .then((value) => setState(() {
                                        if (value != null) {
                                          ImageUrl = value;
                                        } else {
                                          print('not found');
                                        }
                                      }));
                            }
                            var date = Timestamp.now();
                            if (ImageUrl != null) {
                              DatabaseService().updateaccessories(
                                widget.accessoriesModel.id,
                                name.text.toString(),
                                type.text.toString(),
                                primarychar.text.toString(),
                                secondarychar.text.toString(),
                                int.parse(
                                  quantity.text.toString(),
                                ),
                                int.parse(
                                  purchaseprice.text.toString(),
                                ),
                                int.parse(
                                  saleprice.text.toString(),
                                ),
                                ImageUrl,
                                description.text.toString(),
                                'Accessories',
                                date,
                              );
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Updated!")));
                            Navigator.of(context).pop();
                          }
                        },
                        label: Text(
                          "Update",
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
