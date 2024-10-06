import 'package:SolarExperto/constants/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../constants/constants.dart';
import '../../../../services/database/database_service.dart';
class AccessorySelection extends StatefulWidget {
  const AccessorySelection({Key? key}) : super(key: key);

  @override
  State<AccessorySelection> createState() => _AccessorySelectionState();
}

class _AccessorySelectionState extends State<AccessorySelection> {
  TextEditingController pvquanity = TextEditingController();
  TextEditingController systemquanity = TextEditingController();
  TextEditingController otherquantity = TextEditingController();
  final form = GlobalKey<FormState>();
  @override
  void initState() {
    get_access();
    super.initState();
  }
  void get_access() {
    FirebaseFirestore.instance
        .collection(servicecollection)
        .doc('tempaccess')
        .get()
        .then((DocumentSnapshot) {
      if (mounted) {
        setState(() {
          if (DocumentSnapshot.exists) {

            pvquanity.text =
                DocumentSnapshot['pvquanity'];
            systemquanity.text =
                DocumentSnapshot['systemquanity'];
            otherquantity.text = DocumentSnapshot['otherquantity'];

          }
        });
      }
    });
  }
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
          title: const Text("Service Fee"),
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(appPadding),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Form(
                  key: form,
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      TextFormField(
                        keyboardType:
                        TextInputType.number,
                        inputFormatters: <
                            TextInputFormatter>[
                          FilteringTextInputFormatter
                              .allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter
                              .digitsOnly
                        ],
                        validator: (value) =>
                        value!.isEmpty
                            ? 'Please enter pv cable quantity'
                            : null,
                        decoration: InputDecoration(
                          labelText: "PV Cable Quantity",
                          hintText: "Quantity",
                          suffixText: "QTY",
                          fillColor: AppColor.bgColor,
                          filled: true,
                          border:
                          const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.amber,
                                width: 0.8),
                            borderRadius:
                            BorderRadius.all(
                                Radius.circular(10)),
                          ),
                        ),
                        controller: pvquanity,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType:
                        TextInputType.number,
                        inputFormatters: <
                            TextInputFormatter>[
                          FilteringTextInputFormatter
                              .allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter
                              .digitsOnly
                        ],
                        validator: (value) => value!
                            .isEmpty
                            ? 'Please enter system cable'
                            : null,
                        decoration: InputDecoration(
                          labelText: "System Cable Quantity",
                          hintText: "System Cable Quantity",
                          suffixText: "Qty",
                          fillColor: AppColor.bgColor,
                          filled: true,
                          border:
                          const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.amber,
                                width: 0.8),
                            borderRadius:
                            BorderRadius.all(
                                Radius.circular(10)),
                          ),
                        ),
                        controller: systemquanity,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType:
                        TextInputType.number,
                        inputFormatters: <
                            TextInputFormatter>[
                          FilteringTextInputFormatter
                              .allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter
                              .digitsOnly
                        ],
                        validator: (value) => value!
                            .isEmpty
                            ? 'Please enter other accessories quantity'
                            : null,
                        decoration: InputDecoration(
                          labelText: "Other Accessories Quantity",
                          hintText: "Other Accessories Quantity",
                          suffixText: "Qty",
                          fillColor: AppColor.bgColor,
                          filled: true,
                          border:
                          const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.amber,
                                width: 0.8),
                            borderRadius:
                            BorderRadius.all(
                                Radius.circular(10)),
                          ),
                        ),
                        controller: otherquantity,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            icon: Icon(Icons.close,
                                size: 16,
                                color: AppColor.bgColor),
                            style:
                            ElevatedButton.styleFrom(
                                backgroundColor:
                                Colors.red),
                            onPressed: () {
                              Navigator.of(context)
                                  .pop();
                            },
                            label: Text("Cancel",
                                style: TextStyle(
                                    color: AppColor
                                        .bgColor)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton.icon(
                            icon: Icon(Icons.add,
                                size: 16,
                                color: AppColor.bgColor),
                            style:
                            ElevatedButton.styleFrom(
                                primary: AppColor
                                    .bgSideMenu),
                            onPressed: (){},
                            label: Text(
                              "Add",
                              style: TextStyle(
                                  color: AppColor.bgColor,
                                  fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
