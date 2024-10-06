import 'dart:io';

import 'package:SolarExperto/services/database/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_responsive.dart';
import '../../../../constants/constants.dart';
import '../../../../global_widgets/Loading/saveloading.dart';
import '../../../../utilis/UplaodImages.dart';

class AddEquipments extends StatefulWidget {
  const AddEquipments({Key? key}) : super(key: key);

  @override
  State<AddEquipments> createState() => _AddEquipmentsState();
}

class _AddEquipmentsState extends State<AddEquipments> {
  //panels...
  TextEditingController panelname = TextEditingController();
  TextEditingController paneltype = TextEditingController();
  TextEditingController panelpower = TextEditingController();
  TextEditingController panelquantity = TextEditingController();
  TextEditingController panelsystemvoltage = TextEditingController();
  TextEditingController panelno_load_voltage = TextEditingController();
  TextEditingController panelshort_circuit_current = TextEditingController();
  TextEditingController panelcurrent = TextEditingController();
  TextEditingController panelopen_circuit_voltage = TextEditingController();
  TextEditingController panelpurchaseprice = TextEditingController();
  TextEditingController panelsaleprice = TextEditingController();
  TextEditingController paneldescription = TextEditingController();
  //Batteries...

  TextEditingController batteryname = TextEditingController();
  TextEditingController batterytype = TextEditingController();
  TextEditingController batteryquantity = TextEditingController();
  TextEditingController batteryvoltage = TextEditingController();
  TextEditingController batterycapacity = TextEditingController();
  TextEditingController batterydeep_of_discharge = TextEditingController();
  TextEditingController batterypurchaseprice = TextEditingController();
  TextEditingController batterysaleprice = TextEditingController();
  TextEditingController batterydescription = TextEditingController();

  //controller...
  TextEditingController controllername = TextEditingController();
  TextEditingController controllertype = TextEditingController();
  TextEditingController controllerquantity = TextEditingController();
  TextEditingController controllerratedVoltage = TextEditingController();
  TextEditingController controllermax_voltage = TextEditingController();
  TextEditingController controllercurrent = TextEditingController();
  TextEditingController controllerpower = TextEditingController();
  TextEditingController controllerpurchaseprice = TextEditingController();
  TextEditingController controllersaleprice = TextEditingController();
  TextEditingController controllerdescription = TextEditingController();

  //inverter...

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
  String? _category;
  String? categoryid;
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
        child: Text("Add Equipments"),
      ),
      content: Container(
        color: AppColor.white,
        width: (!AppResponsive.isMobile(context))
            ? 400
            : MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
/*
        child: Stack(
          children: [
            Form(
              key: equipmentform,
              child: ListView(
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: firebaseFiretore
                          .collection(equipmentscategoryCollection)
                          .orderBy(
                            'categoryname',
                          )
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: SaveLoading(),
                          );
                        }
                        return DropdownButton(
                          isExpanded: true,
                          hint: const Text(
                            'Choose an category',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          value: _category,

                          //isExpanded: true,
                          //isDense: true,
                          onChanged: (newValue) {
                            setState(() {
                              _category = newValue.toString();
                              //dropDown = false;
                              print(_category);
                            });
                          },
                          items: snapshot.data?.docs
                              .map((DocumentSnapshot document) {
                            return DropdownMenuItem<String>(
                              onTap: () {
                                setState(() {
                                  categoryid = document['categoryid'];
                                });
                              },
                              value: document['categoryname'],
                              child: Text(document['categoryname']),
                            );
                          }).toList(),
                        );
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  if (_category == 'PV Module ') ...{
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a name ' : null,
                      decoration: InputDecoration(
                        labelText: 'Panel Name',
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
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
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
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
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
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
                        labelText: "RatedPower",
                        prefixText: "Pmpp: ",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
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
                      validator: (value) => value!.isEmpty
                          ? 'Please enter system voltage '
                          : null,
                      decoration: InputDecoration(
                        suffixText: 'V',
                        labelText: "RatedVoltage",
                        prefixText: "U: ",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
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
                          value!.isEmpty ? 'Please enter load voltage ' : null,
                      decoration: InputDecoration(
                        suffixText: 'V',
                        labelText: "Voltage",
                        prefixText: "Umpp: ",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: panelno_load_voltage,
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
                        prefixText: "Isc: ",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
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
                          value!.isEmpty ? 'Please enter ' : null,
                      decoration: InputDecoration(
                        suffixText: 'A',
                        labelText: "Circuit",
                        prefixText: "impp: ",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: panelcurrent,
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
                        suffixText: '%',
                        labelText: "Open Circuit Voltage",
                        prefixText: "Uoc: ",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: panelopen_circuit_voltage,
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
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
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
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: panelsaleprice,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: paneldescription,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                        icon: Icon(Icons.image,
                            size: 16, color: AppColor.bgColor),
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
                          icon: Icon(Icons.add,
                              size: 16, color: AppColor.bgColor),
                          style: ElevatedButton.styleFrom(
                              primary: AppColor.bgSideMenu),
                          onPressed: () async {
                            if (equipmentform.currentState!.validate()) {
                              setState(() {
                                isadded = true;
                              });
                              file ??= await getImageFileFromAssets(
                                  'assets/panels.png');
                              await uploadImage('Equipment/panels#$id', file!)
                                  .then((value) => setState(() {
                                        if (value != null) {
                                          ImageUrl = value;
                                        } else {
                                          print('not found');
                                        }
                                      }));
                              var date = Timestamp.now();
*/
/*
                              if (ImageUrl != null) {
                                DatabaseService().updatepanel(
                                    'panels#$id',
                                    panelname.text.toString(),
                                    paneltype.text.toString(),
                                    int.parse(panelpower.text.toString()),
                                    int.parse(panelquantity.text.toString()),
                                    double.parse(
                                        panelsystemvoltage.text.toString()),
                                    double.parse(
                                        panelno_load_voltage.text.toString()),
                                    double.parse(panelshort_circuit_current.text
                                        .toString()),
                                    double.parse(panelcurrent.text.toString()),
                                    double.parse(panelopen_circuit_voltage.text
                                        .toString()),
                                    double.parse(
                                        panelpurchaseprice.text.toString()),
                                    double.parse(
                                        panelsaleprice.text.toString()),
                                    ImageUrl,
                                  //  paneldescription.text.toString(),
                                    date);
                              }
*/ /*

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
                  }
                  else if (_category == 'Battery') ...{
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a name ' : null,
                      decoration: InputDecoration(
                        labelText: 'Battery Name',
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: batteryname,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a type ' : null,
                      decoration: InputDecoration(
                        labelText: 'Type',
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: batterytype,
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
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: batteryquantity,
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
                        prefixText: 'Ub: ',
                        suffixText: 'V',
                        labelText: "Voltage",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: batteryvoltage,
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
                      validator: (value) => value!.isEmpty
                          ? 'Please enter system voltage '
                          : null,
                      decoration: InputDecoration(
                        prefixText: 'C: ',
                        suffixText: 'AH',
                        labelText: "Capacity",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: batterycapacity,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLength: 3,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter load voltage ' : null,
                      onChanged: (value) {
                        var deep_of_discharge = int.parse(value);
                        if (deep_of_discharge >= 100) {
                          batterydeep_of_discharge.text = '100';
                        }
                      },
                      decoration: InputDecoration(
                        suffixText: '%',
                        labelText: "DOD",
                        prefixText: "DOD: ",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: batterydeep_of_discharge,
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
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: batterypurchaseprice,
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
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: batterysaleprice,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: batterydescription,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                        icon: Icon(Icons.image,
                            size: 16, color: AppColor.bgColor),
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
                          icon: Icon(Icons.add,
                              size: 16, color: AppColor.bgColor),
                          style: ElevatedButton.styleFrom(
                              primary: AppColor.bgSideMenu),
                          onPressed: () async {
                            if (equipmentform.currentState!.validate()) {
                              setState(() {
                                isadded = true;
                              });
                              file ??= await getImageFileFromAssets(
                                  'assets/batteries.png');
                              await uploadImage(
                                      'Equipment/batteries#$id', file!)
                                  .then((value) => setState(() {
                                        if (value != null) {
                                          ImageUrl = value;
                                        } else {
                                          print('not found');
                                        }
                                      }));
                              var date = Timestamp.now();
*/
/*
                              if (ImageUrl != null) {
                                DatabaseService().updatebattery(
                                    categoryid!,
                                    _category!,
                                    'batteries#$id',
                                    batteryname.text.toString(),
                                    batterytype.text.toString(),
                                    int.parse(batteryquantity.text.toString()),
                                    double.parse(
                                        batteryvoltage.text.toString()),
                                    int.parse(batterycapacity.text.toString()),
                                    int.parse(batterydeep_of_discharge.text
                                        .toString()),
                                    double.parse(
                                        batterypurchaseprice.text.toString()),
                                    double.parse(
                                        batterysaleprice.text.toString()),
                                    ImageUrl,
                                    batterydescription.text.toString(),
                                    date);
                              }
*/ /*

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
                  }
                  else if (_category == 'Charge Controllers') ...{
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a name ' : null,
                      decoration: InputDecoration(
                        labelText: 'Controller Name',
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
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
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: controllertype,
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
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
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
                          value!.isEmpty ? 'Please enter voltage' : null,
                      decoration: InputDecoration(
                        suffixText: 'V',
                        labelText: "RatedVoltage",
                        prefixText: 'Uc: ',
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: controllerratedVoltage,
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
                        labelText: "Max Voltage",
                        prefixText: 'Umax: ',
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: controllermax_voltage,
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
                        prefixText: 'Ic: ',
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
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
                          value!.isEmpty ? 'Please enter ' : null,
                      decoration: InputDecoration(
                        suffixText: 'W',
                        labelText: "Power",
                        prefixText: 'Pc: ',
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: controllerpower,
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
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
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
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
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
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: controllerdescription,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                        icon: Icon(Icons.image,
                            size: 16, color: AppColor.bgColor),
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
                          icon: Icon(Icons.add,
                              size: 16, color: AppColor.bgColor),
                          style: ElevatedButton.styleFrom(
                              primary: AppColor.bgSideMenu),
                          onPressed: () async {
                            if (equipmentform.currentState!.validate()) {
                              setState(() {
                                isadded = true;
                              });
                              file ??= await getImageFileFromAssets(
                                  'assets/controller.png');
                              await uploadImage(
                                      'Equipment/controller#$id', file!)
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
                                    categoryid!,
                                    _category!,
                                    'controller#$id',
                                    controllername.text.toString(),
                                    controllertype.text.toString(),
                                    int.parse(
                                        controllerquantity.text.toString()),
                                    double.parse(
                                        controllerratedVoltage.text.toString()),
                                    double.parse(
                                        controllermax_voltage.text.toString()),
                                    int.parse(
                                        controllercurrent.text.toString()),
                                    int.parse(controllerpower.text.toString()),
                                    double.parse(controllerpurchaseprice.text
                                        .toString()),
                                    double.parse(
                                        controllersaleprice.text.toString()),
                                    ImageUrl,
                                    controllerdescription.text.toString(),
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
                  }
                  else if (_category == 'Inverter') ...{
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a name ' : null,
                      decoration: InputDecoration(
                        labelText: 'Inverter Name',
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
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
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
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
                          value!.isEmpty ? 'Please enter quantity' : null,
                      decoration: InputDecoration(
                        suffixText: 'QTY',
                        labelText: "Quantity",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: inverterquantity,
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
                        prefixText: 'Pi: ',
                        suffixText: 'VA',
                        labelText: "RatedPower",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
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
                          value!.isEmpty ? 'Please enter nominal voltage ' : null,
                      decoration: InputDecoration(
                        prefixText: 'Uii: ',
                        suffixText: 'V',
                        labelText: "Input Nominal Voltage",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
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
                          value!.isEmpty ? 'Please enter ac voltage ' : null,
                      decoration: InputDecoration(
                        prefixText: 'Uoi: ',
                        suffixText: 'V',
                        labelText: "AC Voltage",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: inverteracvoltage,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLength: 3,
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
                        prefixText: 'ei: ',
                        suffixText: '%',
                        labelText: "Efficieny",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
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
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
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
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: invertersaleprice,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: inverterdescription,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                        icon: Icon(Icons.image,
                            size: 16, color: AppColor.bgColor),
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
                          icon: Icon(Icons.add,
                              size: 16, color: AppColor.bgColor),
                          style: ElevatedButton.styleFrom(
                              primary: AppColor.bgSideMenu),
                          onPressed: () async {
                            if (equipmentform.currentState!.validate()) {
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
                                await DatabaseService().updateinverter(
                                    categoryid!,
                                    _category!,
                                    'inverter#$id',
                                    invertername.text.toString(),
                                    invertertype.text.toString(),
                                    int.parse(inverterratedpower.text.toString()),
                                    int.parse(inverterquantity.text.toString()),

                                    double.parse(
                                        inverternominalvoltage.text.toString()),
                                    double.parse(
                                        inverteracvoltage.text.toString()),
                                    int.parse(
                                        inverterefficiency.text.toString()),
                                    double.parse(
                                        inverterpurchaseprice.text.toString()),
                                    double.parse(
                                        invertersaleprice.text.toString()),
                                    ImageUrl,
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
                  },
                ],
              ),
            ),
            //(isadded == true) ? const SaveLoading() : Container(),
          ],
        ),
*/
      ),
      //child: const AddCategories(),
    ));
  }
}
