import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_responsive.dart';
import '../../../../global_widgets/Loading/saveloading.dart';
import '../../../../models/equipments/pvmodulemodel.dart';
import '../../../../models/equipments/pvmodulemodel.dart';
import '../../../../services/database/database_service.dart';
import '../../../../utilis/UplaodImages.dart';

class UpdatePvModule extends StatefulWidget {
  const UpdatePvModule({Key? key, required this.pvModuleModel})
      : super(key: key);
  final PvModuleModel pvModuleModel;
  @override
  State<UpdatePvModule> createState() => _UpdatePvModuleState();
}

class _UpdatePvModuleState extends State<UpdatePvModule> {
  TextEditingController panelname = TextEditingController();
  TextEditingController paneltype = TextEditingController();
  TextEditingController panelpower = TextEditingController();
  TextEditingController panelquantity = TextEditingController();
  TextEditingController panelsystemvoltage = TextEditingController();
  TextEditingController panelshort_circuit_current = TextEditingController();
  TextEditingController panelpurchaseprice = TextEditingController();
  TextEditingController panelsaleprice = TextEditingController();
  TextEditingController paneldescription = TextEditingController();
  TextEditingController panelcurrent = TextEditingController();
  TextEditingController panelopen_circuit_voltage = TextEditingController();
  final equipmentform = GlobalKey<FormState>();
  bool isadded = false;
  String? ImageUrl;
  File? file;
  @override
  void initState() {
    panelname.text = widget.pvModuleModel.name!;
    paneltype.text = widget.pvModuleModel.type!;
    panelpower.text = widget.pvModuleModel.power.toString();
    panelquantity.text = widget.pvModuleModel.quantity.toString();
    panelsystemvoltage.text = widget.pvModuleModel.voltage.toString();
    panelshort_circuit_current.text =
        widget.pvModuleModel.short_circuit_current.toString();
    panelcurrent.text = widget.pvModuleModel.current.toString();
    panelopen_circuit_voltage.text =
        widget.pvModuleModel.open_circuit_voltage.toString();
    panelpurchaseprice.text = widget.pvModuleModel.buyingprice.toString();
    panelsaleprice.text = widget.pvModuleModel.sellingprice.toString();
    ImageUrl = widget.pvModuleModel.image;
    paneldescription.text = widget.pvModuleModel.description!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AlertDialog(
      title: const Center(
        child: Text("Update PvModule"),
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
                      labelText: 'Name',
                      hintText: "Name",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: panelname,
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
                    controller: paneltype,
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
                      suffixText: 'QTY',
                      labelText: "Quantity",
                      hintText: "Quantity",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: panelquantity,
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
                        value!.isEmpty ? 'Please enter watts' : null,
                    decoration: InputDecoration(
                      suffixText: 'W',
                      labelText: "Power",
                      hintText: "power",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: panelpower,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter voltage ' : null,
                    decoration: InputDecoration(
                      suffixText: 'V',
                      labelText: "Voltage",
                      hintText: "Voltage",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: panelsystemvoltage,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter ' : null,
                    decoration: InputDecoration(
                      suffixText: 'A',
                      labelText: "Short Circuit Current",
                      hintText: "Short Circuit Current",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: panelshort_circuit_current,
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
                    controller: panelpurchaseprice,
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
                    controller: panelsaleprice,
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
                          if (equipmentform.currentState!.validate()) {
                            setState(() {
                              isadded = true;
                            });
                            if (file != null) {
                              await uploadImage(
                                      'Equipment/${widget.pvModuleModel.id}',
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
                              DatabaseService().updatepanel(
                                  widget.pvModuleModel.id,
                                  panelname.text.toString(),
                                  paneltype.text.toString(),
                                  int.parse(panelpower.text.toString()),
                                  int.parse(panelquantity.text.toString()),
                                  double.parse(
                                      panelsystemvoltage.text.toString()),
                                  double.parse(panelshort_circuit_current.text
                                      .toString()),
                                  double.parse(panelcurrent.text.toString()),
                                  double.parse(panelopen_circuit_voltage.text
                                      .toString()),
                                  double.parse(
                                      panelpurchaseprice.text.toString()),
                                  double.parse(panelsaleprice.text.toString()),
                                  ImageUrl,
                                  '',
                                  'Panels',
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
