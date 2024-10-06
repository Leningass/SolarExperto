import 'package:SolarExperto/models/city/city.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_responsive.dart';
import '../../../global_widgets/Loading/saveloading.dart';
import '../../../services/database/database_service.dart';

class UpdateCity extends StatefulWidget {
  const UpdateCity({Key? key, required this.cityModel}) : super(key: key);
  final CityModel cityModel;
  @override
  State<UpdateCity> createState() => _UpdateCityState();
}

class _UpdateCityState extends State<UpdateCity> {
  TextEditingController name = TextEditingController();
  TextEditingController peaksunhours = TextEditingController();
  TextEditingController inverterac_voltage = TextEditingController();
  TextEditingController electricity_price = TextEditingController();
  final _cityform = GlobalKey<FormState>();
  bool isadded = false;
  @override
  void initState() {
    name.text = widget.cityModel.name;
    peaksunhours.text = widget.cityModel.peaksunhours.toString();
    electricity_price.text = widget.cityModel.electricity_price.toString();
    inverterac_voltage.text=widget.cityModel.inverterac_voltage.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AlertDialog(
      title: Center(
        child: Text("Update City"),
      ),
      content: SingleChildScrollView(
        child: Container(
          color: AppColor.white,
          width: (!AppResponsive.isMobile(context))
              ? 350
              : MediaQuery.of(context).size.width,
          height: 400,
          child: Form(
            key: _cityform,
            child: Column(
              children: [
                TextFormField(
                  validator: (val) =>
                  val!.isEmpty ? 'Please enter name ' : null,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: "Name",
                    fillColor: AppColor.bgColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 0.8),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  controller: name,
                ),
                const SizedBox(
                  height: 10,
                ),

                TextFormField(
                  keyboardType: TextInputType.number,

                  validator: (value) =>
                  value!.isEmpty ? 'Please enter peak sun hours' : null,
                  decoration: InputDecoration(
                    suffixText: 'hrs',
                    labelText: "Peak Sun Hours",
                    hintText: "Peak Sun Hours",
                    fillColor: AppColor.bgColor,
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 0.8),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  controller: peaksunhours,
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
                  value!.isEmpty ? 'Please enter inverter ac voltage' : null,
                  decoration: InputDecoration(
                    suffixText: 'V',
                    labelText: "Inverter AC Voltage",
                    hintText: "Inverter AC Voltage",
                    fillColor: AppColor.bgColor,
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 0.8),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  controller: inverterac_voltage,
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
                  value!.isEmpty ? 'Please enter electricity cost' : null,
                  decoration: InputDecoration(
                    suffixText: 'CFA/kWh',
                    labelText: "Electricity Price",
                    hintText: "Energy Cost",
                    fillColor: AppColor.bgColor,
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 0.8),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  controller: electricity_price,
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
                        if (_cityform.currentState!.validate()) {
                          var date = Timestamp.now();
                          setState(() {
                            isadded = true;
                          });
                          await DatabaseService().updatecity(
                              widget.cityModel.id,
                              name.text.toString(),
                              double.parse(peaksunhours.text.toString()),
                              int.parse(inverterac_voltage.text.toString()),
                              int.parse(electricity_price.text.toString()),
                              date);

                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Updated!")));
                          Navigator.of(context).pop();
                        }
                      },
                      label: Text(
                        "Update",
                        style:
                            TextStyle(color: AppColor.bgColor, fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                SizedBox(
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
