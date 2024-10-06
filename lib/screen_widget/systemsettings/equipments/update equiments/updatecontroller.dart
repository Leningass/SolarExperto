import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_responsive.dart';
import '../../../../global_widgets/Loading/saveloading.dart';
import '../../../../models/equipments/controllermodel.dart';
import '../../../../services/database/database_service.dart';
import '../../../../utilis/UplaodImages.dart';

class UpdateController extends StatefulWidget {
  const UpdateController({Key? key, required this.controllerModel})
      : super(key: key);
  final ChargeControllerModel controllerModel;
  @override
  State<UpdateController> createState() => _UpdateControllerState();
}

class _UpdateControllerState extends State<UpdateController> {
  TextEditingController controllername = TextEditingController();
  TextEditingController controllertype = TextEditingController();
  TextEditingController controllerratedVoltage = TextEditingController();
  TextEditingController controllercurrent = TextEditingController();
  TextEditingController controllerpurchaseprice = TextEditingController();
  TextEditingController controllersaleprice = TextEditingController();
  TextEditingController controllerdescription = TextEditingController();
  TextEditingController controllerquantity = TextEditingController();

  final equipmentform = GlobalKey<FormState>();
  bool isadded = false;
  String? ImageUrl;
  File? file;
  @override
  void initState() {
    controllername.text = widget.controllerModel.name.toString();
    controllertype.text = widget.controllerModel.type.toString();

    controllerratedVoltage.text =
        widget.controllerModel.ratedVoltage.toString();
    controllerquantity.text = widget.controllerModel.quantity.toString();
    controllercurrent.text = widget.controllerModel.current.toString();
    controllerpurchaseprice.text =
        widget.controllerModel.buyingprice.toString();
    controllersaleprice.text = widget.controllerModel.sellingprice.toString();
    controllerdescription.text = widget.controllerModel.description.toString();
    ImageUrl = widget.controllerModel.image.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AlertDialog(
      title: const Center(
        child: Text("Update Charge Controller"),
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
              key: equipmentform,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a name ' : null,
                    decoration: InputDecoration(
                      labelText: 'Controller Name',
                      hintText: 'Controller Name',
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: controllername,
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
                    controller: controllertype,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter voltage' : null,
                    decoration: InputDecoration(
                      suffixText: 'V',
                      labelText: "Rated Voltage",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: controllerratedVoltage,
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
                        value!.isEmpty ? 'Please enter ' : null,
                    decoration: InputDecoration(
                      suffixText: 'A',
                      labelText: "Current",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: controllercurrent,
                  ),
                  SizedBox(
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
                    controller: controllerquantity,
                  ),
                  const SizedBox(
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
                    controller: controllerpurchaseprice,
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
                    controller: controllersaleprice,
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
                    controller: controllerdescription,
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
                          if (equipmentform.currentState!.validate()) {
                            setState(() {
                              isadded = true;
                            });
                            if (file != null) {
                              await uploadImage(
                                      'Equipment/${widget.controllerModel.id}',
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
                              DatabaseService().updatecontroller(
                                  widget.controllerModel.id,
                                  controllername.text.toString(),
                                  controllertype.text.toString(),
                                  int.parse(controllerquantity.text.toString()),
                                  double.parse(
                                    controllerratedVoltage.text.toString(),
                                  ),
                                  double.parse(
                                      controllercurrent.text.toString()),
                                  double.parse(
                                    controllerpurchaseprice.text.toString(),
                                  ),
                                  double.parse(
                                    controllersaleprice.text.toString(),
                                  ),
                                  ImageUrl,
                                  controllerdescription.text.toString(),
                                  'Controler',
                                  date);
                            }
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Updated!")));
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
