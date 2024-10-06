import 'package:SolarExperto/models/equipments/controllermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../screen_widget/systemsettings/equipments/update equiments/updatecontroller.dart';
import '../../../services/database/database_service.dart';
import '../../../utilis/UplaodImages.dart';

class ManageChargeDetails extends StatefulWidget {
  const ManageChargeDetails({Key? key, required this.chargeControllerModel})
      : super(key: key);
  final ChargeControllerModel chargeControllerModel;
  @override
  State<ManageChargeDetails> createState() => _ManageChargeDetailsState();
}

class _ManageChargeDetailsState extends State<ManageChargeDetails> {
  final adminform = GlobalKey<FormState>();
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
            widget.chargeControllerModel.name!,
          ),
          actions: [
            TextButton.icon(
              icon: Icon(
                Icons.edit,
                color: AppColor.bgSideMenu,
              ),
              style: ElevatedButton.styleFrom(primary: AppColor.bgColor),
              onPressed: () {
                // Navigator.of(context).pop();
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (dialogContext) {
                      return UpdateController(
                          controllerModel: widget.chargeControllerModel);
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
              style: ElevatedButton.styleFrom(primary: AppColor.bgColor),
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
                                              key: adminform,
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
                                                            if (!adminform
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
                                                                      await deleteImage(
                                                                          widget.chargeControllerModel.image!);
                                                                      await DatabaseService()
                                                                          .deleteaccessories(
                                                                          widget
                                                                              .chargeControllerModel
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
                child: Image.asset(
                  "assets/controller.png",

                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
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
                      "Name",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${widget.chargeControllerModel.name}',
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
                      "Type",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${widget.chargeControllerModel.type}',
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
                      "Quantity",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '${NumberFormat("#,###").format(widget.chargeControllerModel.quantity)}',
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
                      "Voltage",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${widget.chargeControllerModel.ratedVoltage} V',
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
                      "Current",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${widget.chargeControllerModel.current} A',
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
                      "Sale Price",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${NumberFormat("#,###").format(widget.chargeControllerModel.sellingprice)} CFA',
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
                      "Purchase Price",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${NumberFormat("#,###").format(widget.chargeControllerModel.buyingprice)} CFA',
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
            ],
          ),
        ),
      ),
    );
  }
}
