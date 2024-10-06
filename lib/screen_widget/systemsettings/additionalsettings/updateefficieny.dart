import 'package:SolarExperto/models/othersettings/efficieny.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_responsive.dart';
import '../../../global_widgets/Loading/saveloading.dart';
import '../../../services/database/database_service.dart';

class UpdateEfficiency extends StatefulWidget {
  const UpdateEfficiency({Key? key, required this.efficiencyModel})
      : super(key: key);
  final EfficiencyModel efficiencyModel;
  @override
  State<UpdateEfficiency> createState() => _UpdateEfficiencyState();
}

class _UpdateEfficiencyState extends State<UpdateEfficiency> {
  TextEditingController efficiency = TextEditingController();
  final _efficienyform = GlobalKey<FormState>();
  bool isadded = false;
  @override
  void initState() {
    efficiency.text = widget.efficiencyModel.efficiency.toString();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AlertDialog(
      title: Center(
        child: Text("Update System Efficiency"),
      ),
      content: SingleChildScrollView(
        child: Container(
          color: AppColor.white,
          width: (!AppResponsive.isMobile(context))
              ? 300
              : MediaQuery.of(context).size.width,
          height: 180,
          child: Form(
            key: _efficienyform,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter value' : null,
                  decoration: InputDecoration(
                    suffixText: 'E',
                    labelText: "Efficiency",
                    hintText: "Efficiency",
                    fillColor: AppColor.bgColor,
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 0.8),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  controller: efficiency,
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
                        if (_efficienyform.currentState!.validate()) {
                          var date = Timestamp.now();
                          setState(() {
                            isadded = true;
                          });
                          await DatabaseService().updateefficiency(
                              widget.efficiencyModel.id,
                              double.parse(efficiency.text.toString()),
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
