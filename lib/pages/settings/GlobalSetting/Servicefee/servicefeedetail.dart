import 'package:SolarExperto/models/Service%20Fee/servicefeemodel.dart';
import 'package:SolarExperto/pages/settings/GlobalSetting/Servicefee/updateservicefee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constants/app_colors.dart';
import '../../../../services/database/database_service.dart';

class ServiceFeeDetail extends StatefulWidget {
  const ServiceFeeDetail({Key? key, required this.serviceFeeModel}) : super(key: key);
final ServiceFeeModel serviceFeeModel;
  @override
  State<ServiceFeeDetail> createState() => _ServiceFeeDetailState();
}

class _ServiceFeeDetailState extends State<ServiceFeeDetail> {
  final form = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.bgColor,
          elevation: 0,
          title: Text(
            widget.serviceFeeModel.name,
          ),
          actions: [
            TextButton.icon(
              icon: Icon(
                Icons.edit,
                color: AppColor.bgSideMenu,
              ),
              style: ElevatedButton.styleFrom(primary: AppColor.bgColor),
              onPressed: () {

                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (dialogContext) {
                      return UpdateServiceFee(
                        serviceFeeModel: widget.serviceFeeModel,
                      );
                    });
                Navigator.of(context).pop();
              },
              label: Text("", style: TextStyle(color: AppColor.bgSideMenu)),
            ),
            TextButton.icon(
              icon: Icon(
                Icons.delete,
                color: AppColor.bgSideMenu,
              ),
              style: TextButton.styleFrom(primary: AppColor.bgSideMenu),
              onPressed: () async {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: Text("Are you sure you want to delete this"),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: Text(
                          "No",
                          style: TextStyle(color: AppColor.bgSideMenu),
                        ),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      CupertinoDialogAction(
                          child: Text(
                            "Yes",
                            style: TextStyle(color: AppColor.bgSideMenu),
                          ),
                          onPressed: () async {
                            Navigator.of(context).pop();
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (dialogContext) {
                                  return StatefulBuilder(
                                      builder: (dialogContext, setState) {
                                        return AlertDialog(
                                          title: const Center(
                                            child: Text("Passcode"),
                                          ),
                                          content: Form(
                                              key: form,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    obscureText: _obscureText,
                                                    decoration: InputDecoration(
                                                      hintText: "Enter passcode",
                                                      border: OutlineInputBorder(),
                                                      suffixIcon: IconButton(
                                                        color: Colors.grey,
                                                        onPressed: () {
                                                          setState(() {
                                                            _obscureText =
                                                            !_obscureText;
                                                          });
                                                        },
                                                        icon: Icon(
                                                          _obscureText
                                                              ? Icons.visibility
                                                              : Icons
                                                              .visibility_off,
                                                        ),
                                                      ),
                                                    ),
                                                    controller: controller,
                                                    validator: (value) {
                                                      if (controller.text != null) {
                                                        if (value!.isEmpty) {
                                                          return 'Please enter passcode';
                                                        }
                                                      }
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                dialogContext)
                                                                .pop();
                                                            controller.clear();
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                              backgroundColor:
                                                              Colors.red),
                                                          child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                color:
                                                                AppColor.white),
                                                          )),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            if (!form
                                                                .currentState!
                                                                .validate()) {
                                                            } else {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                  'passcode')
                                                                  .doc(
                                                                  'rKSpvQYw1CLpCekmqnFo')
                                                                  .get()
                                                                  .then(
                                                                      (DocumentSnapshot) async {
                                                                    if (controller.value
                                                                        .text ==
                                                                        DocumentSnapshot[
                                                                        'passcode']) {
                                                                      Navigator.of(
                                                                          dialogContext)
                                                                          .pop(true);
                                                                      ScaffoldMessenger.of(
                                                                          dialogContext)
                                                                          .showSnackBar(
                                                                          SnackBar(
                                                                              content:
                                                                              Text("Deleted!")));

                                                                      await DatabaseService()
                                                                          .deleteservicefee(
                                                                          widget
                                                                              .serviceFeeModel
                                                                              .id);
                                                                      controller
                                                                          .clear();

                                                                      Navigator.of(
                                                                          dialogContext)
                                                                          .pop();
                                                                    } else {
                                                                      ScaffoldMessenger.of(
                                                                          dialogContext)
                                                                          .showSnackBar(
                                                                          SnackBar(
                                                                              content:
                                                                              Text("Just super admin can delete this!")));
                                                                      Navigator.of(
                                                                          dialogContext)
                                                                          .pop();
                                                                      controller
                                                                          .clear();
                                                                    }

                                                                    controller.clear();
                                                                  });
                                                            }
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                              backgroundColor:
                                                              AppColor
                                                                  .bgSideMenu),
                                                          child: Text(
                                                            "Delete",
                                                            style: TextStyle(
                                                                color:
                                                                AppColor.white),
                                                          )),
                                                    ],
                                                  )
                                                ],
                                              )),
                                        );
                                      });
                                });

                            // Navigator.pushReplacement(context,
                            //     MaterialPageRoute(builder: (context) {
                            //       return ServiceFee();
                            //     }));
                          }),
                    ],
                  ),
                );
                Navigator.of(context).pop();
              },

              label: Text(
                "",
                style: TextStyle(
                  color: AppColor.bgSideMenu,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${widget.serviceFeeModel.name}',
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${widget.serviceFeeModel.description} ',
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Installation Fee",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${NumberFormat("#,###").format(widget.serviceFeeModel.installationfee)} CFA',
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Maintenance Fee",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${NumberFormat("#,###").format(widget.serviceFeeModel.maintenancefee)} CFA',
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Transport Fee",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${NumberFormat("#,###").format(widget.serviceFeeModel.transportfee)} CFA',
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Additional Fee",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${NumberFormat("#,###").format(widget.serviceFeeModel.additionalfee)} CFA',
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
