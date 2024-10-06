import 'package:SolarExperto/provider/app_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/constants.dart';
import '../../../global_widgets/Loading/loading.dart';
import '../../../models/global/global.dart';
import '../../../services/database/database_service.dart';

class GlobalPage extends StatefulWidget {
  GlobalPage({Key? key, required this.appProvider}) : super(key: key);
  AppProvider appProvider;

  @override
  State<GlobalPage> createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {
  TextEditingController autonomy_in_days = TextEditingController();
  TextEditingController controller_safety = TextEditingController();
  TextEditingController batterydod = TextEditingController();
  TextEditingController inverterefficeiency = TextEditingController();
  TextEditingController batteryroundtrip = TextEditingController();
  TextEditingController inverterefficiency = TextEditingController();
  TextEditingController deratingfactor = TextEditingController();
  TextEditingController systemlifetime = TextEditingController();
  final form = GlobalKey<FormState>();
  bool isadded = false;
  @override
  void initState() {
    get_global();
    super.initState();
  }

  void get_global() {
    FirebaseFirestore.instance
        .collection(globalCollection)
        .doc('globalparam')
        .get()
        .then((DocumentSnapshot) {
      if (mounted) {
        setState(() {
          if (DocumentSnapshot.exists) {
            autonomy_in_days.text =
                DocumentSnapshot['batteryAutonomy'].toString();
            controller_safety.text =
                DocumentSnapshot['contSafetyFactor'].toString();
            batterydod.text = DocumentSnapshot['batteryDod'].toString();
            inverterefficeiency.text =
                DocumentSnapshot['inverterEfficiency'].toString();
            batteryroundtrip.text =
                DocumentSnapshot['roundTripEfficiency'].toString();
            deratingfactor.text = DocumentSnapshot['deRatingFactor'].toString();
            systemlifetime.text = DocumentSnapshot['lifeTime'].toString();
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
          title: const Text("Globals"),
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
                            'Controller Safety Factor',
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
                                ? 'Please enter safety factor '
                                : null,

                            controller: controller_safety,
                            keyboardType: TextInputType.number,
                            // initialValue: appProvider.global.contSafetyFactor,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              // border: InputBorder.none,
                              hintText: 'Enter Safety Factor',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 30),
                          child: Text(
                            'Inverter Efficiency',
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
                                ? 'Please enter inverter efficiency '
                                : null,

                            controller: inverterefficeiency,
                            keyboardType: TextInputType.number,
                            // initialValue: appProvider.global.inverterEfficiency,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              // border: InputBorder.none,
                              hintText: 'Enter Inverter Efficiency',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 30),
                          child: Text(
                            'Battery DoD',
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
                                ? 'Please enter battery dod '
                                : null,

                            controller: batterydod,
                            keyboardType: TextInputType.number,
                            // initialValue: appProvider.global.batteryDod,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              // border: InputBorder.none,
                              hintText: 'Enter Battery DoD',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 30),
                          child: Text(
                            'Battery Round Trip Efficiency',
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
                                ? 'Please enter round trip efficiency '
                                : null,

                            controller: batteryroundtrip,
                            keyboardType: TextInputType.number,
                            //initialValue: appProvider.global.roundTripEfficiency,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              // border: InputBorder.none,
                              hintText: 'Enter Round Trip Efficiency',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 30),
                          child: Text(
                            'De-rating Factor',
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
                                ? 'Please enter de rating factor '
                                : null,

                            controller: deratingfactor,
                            keyboardType: TextInputType.number,
                            //  initialValue: appProvider.global.deRatingFactor,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              // border: InputBorder.none,
                              hintText: 'Enter De-rating Factor',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 30),
                          child: Text(
                            'System Life Time (years)',
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
                                ? 'Please enter system lifetime '
                                : null,

                            controller: systemlifetime,
                            keyboardType: TextInputType.number,
                            // initialValue: appProvider.global.lifeTime,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              // border: InputBorder.none,
                              hintText: 'Enter System Life Time',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 30),
                          child: Text(
                            'Battery Autonomy (Days)',
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
                                ? 'Please enter battery autonomy '
                                : null,
                            controller: autonomy_in_days,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              // border: InputBorder.none,
                              hintText: 'Enter Battery Autonomy (days)',
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
                                      await DatabaseService().updateglobals(
                                        'globalparam',
                                        double.parse(
                                            controller_safety.text.toString()),
                                        double.parse(inverterefficeiency.text
                                            .toString()),
                                        double.parse(
                                            batterydod.text.toString()),
                                        double.parse(
                                            batteryroundtrip.text.toString()),
                                        double.parse(
                                            deratingfactor.text.toString()),
                                        double.parse(
                                            systemlifetime.text.toString()),
                                        int.parse(
                                            autonomy_in_days.text.toString()),
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
