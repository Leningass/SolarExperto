import 'package:SolarExperto/models/user/user.dart';
import 'package:SolarExperto/services/database/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_responsive.dart';
import '../../../global_widgets/Loading/saveloading.dart';
import '../../../services/auth/auth.dart';

class EditAdmins extends StatefulWidget {
  const EditAdmins({Key? key, required this.userModel}) : super(key: key);
final UserModel userModel;
  @override
  State<EditAdmins> createState() => _EditAdminsState();
}

class _EditAdminsState extends State<EditAdmins> {
  final adminform = GlobalKey<FormState>();
  TextEditingController namecontroller=TextEditingController();
  bool isadded = false;

  @override
  void initState() {
    namecontroller.text=widget.userModel.name.toString();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Center(
        child: AlertDialog(
          title: Center(
            child: Text("Edit Admin"),
          ),
          content: Container(
            color: AppColor.white,

            child: Stack(
              children: [
                Form(
                  key: adminform,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter a name ' : null,
                        decoration: InputDecoration(
                          hintText: "Name",
                          fillColor: AppColor.bgColor,
                          iconColor: AppColor.bgSideMenu,
                          icon: Icon(
                            Icons.account_box_rounded,
                            color: AppColor.bgSideMenu,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber, width: 0.8),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        controller: namecontroller,
                      ),
                      SizedBox(
                        height: 30,
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
                              if (adminform.currentState!.validate()) {
                                setState(() {
                                  isadded = true;
                                });
                                DatabaseService().updateadmin(widget.userModel.id!, namecontroller.text.toString());
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
                      SizedBox(
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
