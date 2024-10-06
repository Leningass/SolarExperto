import 'package:SolarExperto/models/categories/categorymodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_responsive.dart';
import '../../../global_widgets/Loading/saveloading.dart';
import '../../../services/database/database_service.dart';

class UpdateEquipmentCategory extends StatefulWidget {
  const UpdateEquipmentCategory(
      {Key? key, required this.categoryEquipmentModel})
      : super(key: key);
  final CategoryEquipmentModel categoryEquipmentModel;
  @override
  State<UpdateEquipmentCategory> createState() =>
      _UpdateEquipmentCategoryState();
}

class _UpdateEquipmentCategoryState extends State<UpdateEquipmentCategory> {
  TextEditingController catnameController = TextEditingController();
  final _cateform = GlobalKey<FormState>();
  bool isadded = false;
  @override
  void initState() {
    catnameController.text = widget.categoryEquipmentModel.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AlertDialog(
      title: Center(
        child: Text("Update Equipment Categories"),
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
                          var date = widget.categoryEquipmentModel.addedday;
                          if (catnameController.value.text.isNotEmpty) {
                            setState(() {
                              isadded = true;
                            });
                            await DatabaseService(
                                    doctoken: widget
                                        .categoryEquipmentModel.id)
                                .updateequipmentscategory(
                                    catnameController.text,
                                    widget.categoryEquipmentModel.id,
                                    date);

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
