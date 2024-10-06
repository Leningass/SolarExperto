import 'dart:io';
import 'package:SolarExperto/models/appliances/appliancemodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_responsive.dart';
import '../../../constants/constants.dart';
import '../../../global_widgets/Loading/saveloading.dart';
import '../../../services/database/database_service.dart';
import '../../../utilis/UplaodImages.dart';

class UpdateAppliances extends StatefulWidget {
  const UpdateAppliances({Key? key, required this.applianceModel})
      : super(key: key);
  final ApplianceModel applianceModel;
  @override
  State<UpdateAppliances> createState() => _UpdateAppliancesState();
}

class _UpdateAppliancesState extends State<UpdateAppliances> {
  TextEditingController name = TextEditingController();
  TextEditingController quanity = TextEditingController();
  TextEditingController ratedwattage = TextEditingController();
  TextEditingController timeofusage = TextEditingController();
  final applianceform = GlobalKey<FormState>();
  bool isadded = false;
  String? ImageUrl;
  File? file;
  String? _category;
  String? type;
  @override
  void initState() {
    _category = widget.applianceModel.categoryid;
    name.text = widget.applianceModel.name;
    quanity.text = widget.applianceModel.quatity.toString();
    type = widget.applianceModel.type.toString();
    ratedwattage.text = widget.applianceModel.ratedwattage.toString();
    timeofusage.text = widget.applianceModel.timeofusage.toString();
    ImageUrl = widget.applianceModel.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String id = UniqueKey().toString();
    return Center(
        child: AlertDialog(
      title: const Center(
        child: Text("Update Appliances"),
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
              key: applianceform,
              child: ListView(
                children: [


                  TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a name ' : null,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: "Name",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff131e29), width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: name,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter quantity ' : null,
                    decoration: InputDecoration(
                      labelText: "Quantity",
                      hintText: "Quantity",
                      suffixText: "Qty",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: quanity,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'Choose type',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    value: type,
                    onChanged: (newValue) {
                      setState(() {
                        type = newValue.toString();
                        print(type);
                      });
                    },
                    items: <String>["DC", "AC"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
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
                        value!.isEmpty ? 'Please enter rated wattage' : null,
                    decoration: InputDecoration(
                      labelText: "Rated Wattage",
                      hintText: "Rated Wattage",
                      suffixText: "Watt",
                      fillColor: AppColor.bgColor,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    controller: ratedwattage,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: TextFormField(
                          maxLength: 2,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          onChanged: (value) {
                            var hours = int.parse(value);
                            if (hours >= 24) {
                              timeofusage.text = '24';
                            }
                          },
                          validator: (value) => value!.isEmpty
                              ? 'Please enter time of usage '
                              : null,
                          decoration: InputDecoration(
                            labelText: "Time of usage ",
                            hintText: "Time of usage ",
                            suffixText: "Hours",
                            fillColor: AppColor.bgColor,
                            filled: true,
                            border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amber, width: 0.8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          controller: timeofusage,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
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
                Upload(
                  initialValue: null,
                  onSelected: (path) {
                    appliance.image = path;
                    print("File:${appliance.image}");
                  },
                ),
*/
                  SizedBox(
                    height: 16,
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
                          if (applianceform.currentState!.validate()) {
                            setState(() {
                              isadded = true;
                            });
                            if (file != null) {
                              await uploadImage(
                                      'appliance/${widget.applianceModel.id}',
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
                              DatabaseService().updateappliances(
                                  widget.applianceModel.id,
                                  name.text.toString(),
                                  int.parse(quanity.text.toString()),
                                  type.toString(),
                                  _category.toString(),
                                  int.parse(ratedwattage.text.toString()),
                                  int.parse(timeofusage.text.toString()),
                                  ImageUrl!,
                                  date);
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
          ],
        ),
      ),
      //child: const AddCategories(),
    ));
  }
}
