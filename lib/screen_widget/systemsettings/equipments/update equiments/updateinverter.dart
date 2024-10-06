import 'dart:io';

import 'package:SolarExperto/models/equipments/inverter_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_responsive.dart';
import '../../../../global_widgets/Loading/saveloading.dart';
import '../../../../services/database/database_service.dart';
import '../../../../utilis/UplaodImages.dart';

class UpdateInverter extends StatefulWidget {
  const UpdateInverter({Key? key, required this.inverter_converterModel})
      : super(key: key);
  final InverterModel inverter_converterModel;
  @override
  State<UpdateInverter> createState() => _UpdateInverterState();
}

class _UpdateInverterState extends State<UpdateInverter> {
  TextEditingController invertername = TextEditingController();
  TextEditingController invertertype = TextEditingController();
  TextEditingController inverterratedpower = TextEditingController();
  TextEditingController inverterquantity = TextEditingController();
  TextEditingController inverternominalvoltage = TextEditingController();
  TextEditingController inverteracvoltage = TextEditingController();
  TextEditingController inverterefficiency = TextEditingController();
  TextEditingController inverterpurchaseprice = TextEditingController();
  TextEditingController invertersaleprice = TextEditingController();
  TextEditingController inverterdescription = TextEditingController();
  final equipmentform = GlobalKey<FormState>();
  bool isadded = false;
  String? ImageUrl;
  File? file;
  @override
  void initState() {
    invertername.text = widget.inverter_converterModel.name.toString();
    invertertype.text = widget.inverter_converterModel.type.toString();
    inverterratedpower.text =
        widget.inverter_converterModel.ratedpower.toString();
    inverterquantity.text = widget.inverter_converterModel.quantity.toString();
    inverteracvoltage.text =
        widget.inverter_converterModel.nominalvoltage.toString();
    inverternominalvoltage.text =
        widget.inverter_converterModel.acvoltage.toString();
    inverterefficiency.text =
        widget.inverter_converterModel.efficiency.toString();
    inverterpurchaseprice.text =
        widget.inverter_converterModel.buyingprice.toString();
    invertersaleprice.text =
        widget.inverter_converterModel.sellingprice.toString();
    inverterdescription.text =
        widget.inverter_converterModel.description.toString();

    ImageUrl = widget.inverter_converterModel.image.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AlertDialog(
      title: const Center(
        child: Text("Update Inverter"),
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
                      labelText: 'Inverter Name',
                      hintText: "Inverter Name",
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
                   // maxLength: 3,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      var efficiency = int.parse(value);
                      if (efficiency >= 100) {
                        inverterefficiency.text = '100';
                      }
                    },
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter efficiency' : null,
                    decoration: InputDecoration(
                      suffixText: '%',
                      labelText: "Efficieny",
                      hintText: "Efficieny",
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
                    controller: inverterpurchaseprice,
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
                    controller: invertersaleprice,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
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
                          if (equipmentform.currentState!.validate()) {
                            setState(() {
                              isadded = true;
                            });
                            if (file != null) {
                              await uploadImage(
                                      'Equipment/${widget.inverter_converterModel.id}',
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
                              await DatabaseService().updateinverter(
                                  widget.inverter_converterModel.id,
                                  invertername.text.toString(),
                                  invertertype.text.toString(),
                                  int.parse(inverterratedpower.text.toString()),
                                  int.parse(inverterquantity.text.toString()),
                                  double.parse(
                                      inverternominalvoltage.text.toString()),
                                  double.parse(
                                      inverteracvoltage.text.toString()),
                                  double.parse(
                                    inverterefficiency.text.toString(),
                                  ),
                                  double.parse(
                                      inverterpurchaseprice.text.toString()),
                                  double.parse(
                                      invertersaleprice.text.toString()),
                                  ImageUrl,
                                  inverterdescription.text.toString(),
                                  'Inverter',
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
