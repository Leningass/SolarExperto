
import 'package:SolarExperto/constants/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../services/database/database_service.dart';




class AddServiceFee extends StatefulWidget {
  const AddServiceFee({Key? key}) : super(key: key);

  @override
  State<AddServiceFee> createState() => _AddServiceFeeState();
}

class _AddServiceFeeState extends State<AddServiceFee> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController installation = TextEditingController();
  TextEditingController maintenance = TextEditingController();
  TextEditingController transport = TextEditingController();
  TextEditingController additional = TextEditingController();

  final form = GlobalKey<FormState>();
  bool isadded = false;


  @override
  Widget build(BuildContext context) {
    String id = UniqueKey().toString();
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 30),
                          child: Text(
                            'Name',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 7, left: 30, right: 30),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                          child: TextFormField(
                            validator: (val) => val!.isEmpty
                                ? 'Please enter name '
                                : null,

                            controller: name,
                            keyboardType: TextInputType.name,
                            // initialValue: appProvider.global.contSafetyFactor,
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 10),
                              // border: InputBorder.none,
                              hintText: 'Enter Name',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 30),
                          child: Text(
                            'Description',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 7, left: 30, right: 30),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                          child: TextFormField(
                            validator: (val) => val!.isEmpty
                                ? 'Please enter description '
                                : null,

                            controller: description,
                            keyboardType: TextInputType.text,
                            // initialValue: appProvider.global.inverterEfficiency,
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 10),
                              // border: InputBorder.none,
                              hintText: 'Enter Description',
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20, left: 30),
                          child: Text(
                            'Installation Fee',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 7, left: 30, right: 30),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                          child: TextFormField(
                            validator: (val) => val!.isEmpty
                                ? 'Please enter installation fee '
                                : null,

                            controller: installation,
                            keyboardType: TextInputType.number,
                            // initialValue: appProvider.global.batteryDod,
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 10),
                              // border: InputBorder.none,
                              hintText: 'Enter Installation Fee',
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20, left: 30),
                          child: Text(
                            'Maintenance Fee',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 7, left: 30, right: 30),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                          child: TextFormField(
                            validator: (val) => val!.isEmpty
                                ? 'Please enter maintenance fee '
                                : null,

                            controller: maintenance,
                            keyboardType: TextInputType.number,
                            //initialValue: appProvider.global.roundTripEfficiency,
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 10),
                              // border: InputBorder.none,
                              hintText: 'Enter Maintenance Fee',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 30),
                          child: Text(
                            'Transport Fee',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 7, left: 30, right: 30),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                          child: TextFormField(
                            validator: (val) => val!.isEmpty
                                ? 'Please enter transport fee '
                                : null,

                            controller: transport,
                            keyboardType: TextInputType.number,
                            //  initialValue: appProvider.global.deRatingFactor,
                            decoration: const InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 10),
                              // border: InputBorder.none,
                              hintText: 'Enter Maintenance Fee',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 30),
                          child: Text(
                            'Additional Fee',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 7, left: 30, right: 30),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                          child: TextFormField(
                            validator: (val) => val!.isEmpty
                                ? 'Please enter additional fee '
                                : null,

                            controller: additional,
                            keyboardType: TextInputType.number,
                            // initialValue: appProvider.global.lifeTime,
                            decoration: const InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 10),
                              // border: InputBorder.none,
                              hintText: 'Enter Additional Fee',
                            ),
                          ),
                        ),

                       
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 20, left: 30, right: 30),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (form.currentState!.validate()) {
                                      setState(() {
                                        isadded = true;
                                      });
                                      await DatabaseService().updateservicefee(
                                          'servicefee#$id',
                                          name.text.toString(),
                                          description.text.toString(),
                                          double.parse(installation.text.toString()),
                                          double.parse(maintenance.text.toString()),
                                          double.parse(transport.text.toString()),
                                        double.parse(additional.text.toString()),
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                          content: Text("Added!")));
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.bgSideMenu),
                                  child: Text(
                                    "Save",
                                    style: TextStyle(color: AppColor.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
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
