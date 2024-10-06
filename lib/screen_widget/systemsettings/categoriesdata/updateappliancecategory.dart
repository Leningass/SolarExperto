import 'package:SolarExperto/models/categories/categorymodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_responsive.dart';
import '../../../global_widgets/Loading/saveloading.dart';
import '../../../services/database/database_service.dart';

class UpdateApplianceCategory extends StatefulWidget {
  const UpdateApplianceCategory(
      {Key? key, required this.categoryAppliancesModel, required this.categoryname})
      : super(key: key);
  final CategoryAppliancesModel categoryAppliancesModel;
  final String categoryname;
  @override
  State<UpdateApplianceCategory> createState() =>
      _UpdateApplianceCategoryState();
}

class _UpdateApplianceCategoryState extends State<UpdateApplianceCategory> {
  TextEditingController catnameController = TextEditingController();
  final _cateform = GlobalKey<FormState>();
  bool isadded = false;
  @override
  void initState() {
    catnameController.text = widget.categoryAppliancesModel.name!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AlertDialog(
      title: Center(
        child: Text("Update Appliance Categories"),
      ),
      content: SingleChildScrollView(
        child: Container(
          color: AppColor.white,
          width: (!AppResponsive.isMobile(context))
              ? 300
              : MediaQuery.of(context).size.width,
          height: 180,
          child: Form(
            key: _cateform,
            child: Column(
              children: [
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a name ' : null,
                  decoration: InputDecoration(
                    hintText: "Name",
                    fillColor: AppColor.bgColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 0.8),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  controller: catnameController,
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
                        if (_cateform.currentState!.validate()) {
                          var date = widget.categoryAppliancesModel.addedday;
                          if (catnameController.value.text.isNotEmpty) {
                            setState(() {
                              isadded = true;
                            });
                            await DatabaseService(
                                    doctoken: widget
                                        .categoryname)
                                .updateappliancescategory(
                                    catnameController.text,
                                    widget.categoryAppliancesModel.id,
                                    date!);

                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Added!")));
                            Navigator.of(context).pop();
                          }
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
