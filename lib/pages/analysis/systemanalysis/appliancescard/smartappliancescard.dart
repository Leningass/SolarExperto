import 'package:SolarExperto/constants/app_colors.dart';
import 'package:SolarExperto/models/appliances/appliancemodel.dart';
import 'package:SolarExperto/services/database/database_service.dart';
import 'package:SolarExperto/utilis/calculation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../constants/app_responsive.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/size_config.dart';
import '../../../../provider/app_provider.dart';

class SmartAppliancesCard extends StatefulWidget {
  SmartAppliancesCard({
    Key? key,
    required this.applianceModel,
    required this.appProvider,
    this.Userid,
    // this.onClick
  }) : super(key: key);
  final ApplianceModel applianceModel;
  final AppProvider appProvider;
  final String? Userid;

  // Function()? onClick;

  @override
  State<SmartAppliancesCard> createState() => _SmartAppliancesCardState();
}

class _SmartAppliancesCardState extends State<SmartAppliancesCard> {
  var isadded = false;
  var isfirsttime = false;
  var selected = false;
  late int energy;
  late double adjustedwattage;
  late int power;
  bool isMount = true;
  double adjustfactor = 0.0;

  TextEditingController quanity = TextEditingController();
  TextEditingController ratedwattage = TextEditingController();
  TextEditingController timeofusage = TextEditingController();
  // TextEditingController simultaneity = TextEditingController();
  final applianceform = GlobalKey<FormState>();
  String? type;
  @override
  void initState() {
    print('InverterAc: ${widget.appProvider.inverterac_voltage}');
    if (widget.appProvider.maxmimumACpower == 0) {
      DatabaseService()
          .deletetemp('${widget.Userid}_${widget.applianceModel.id}');
      DatabaseService().deletetemcal('${widget.Userid}_itembattery');
      DatabaseService().deletetemcal('${widget.Userid}_itempanel');
      DatabaseService().deletetemcal('${widget.Userid}_iteminverter');
      DatabaseService().deletetemcal('${widget.Userid}_itemcontroller');
      tempbatteryreference
          .doc(widget.Userid)
          .collection('Battery_${widget.Userid}')
          .get()
          .then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
      temppanelreference
          .doc(widget.Userid)
          .collection('Panel_${widget.Userid}')
          .get()
          .then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
      tempinverterrefference
          .doc(widget.Userid)
          .collection('Inverter_${widget.Userid}')
          .get()
          .then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
      tempcontrollerrefference
          .doc(widget.Userid)
          .collection('Controller_${widget.Userid}')
          .get()
          .then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
    }
    quanity.text = widget.applianceModel.quatity.toString();
    ratedwattage.text = widget.applianceModel.ratedwattage.toString();
    timeofusage.text = widget.applianceModel.timeofusage.toString();
    type = widget.applianceModel.type.toString();
    isfirsttime = true;
    power = 0;
    energy = 0;
    adjustedwattage = 0.0;
    if (isMount) {
      getTempdata();
    }
    super.initState();

    // getSwitchValues();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    isMount = false;
    super.dispose();
  }

  void getTempdata() {
    FirebaseFirestore.instance
        .collection(tempappliances)
        .doc('${widget.Userid}_${widget.applianceModel.id}')
        .get()
        .then((DocumentSnapshot) {
      if (mounted) {
        setState(() {
          if (DocumentSnapshot.exists) {
            quanity.text = DocumentSnapshot['quatity'].toString();
            ratedwattage.text = DocumentSnapshot['ratedwattage'].toString();
            timeofusage.text = DocumentSnapshot['timeofusage'].toString();
            type = DocumentSnapshot['type'].toString();
            isadded = DocumentSnapshot['isadded'];
            if (type == 'DC') {
              adjustfactor = 1.0;
            } else if (type == 'AC') {
              adjustfactor = 0.85;
            }
            power = int.parse(ratedwattage.text.toString()) *
                int.parse(quanity.text.toString());
            adjustedwattage = power / adjustfactor;
            print('Button_adjust: ${adjustedwattage}');
            energy = adjustedwattage.toInt() *
                int.parse(timeofusage.text.toString());
            // adjustedwattage=(int.parse(ratedwattage.text.toString())
            //     /);
            print('isadded: ${isadded}');
          } else {
            quanity.text = widget.applianceModel.quatity.toString();
            ratedwattage.text = widget.applianceModel.ratedwattage.toString();
            timeofusage.text = widget.applianceModel.timeofusage.toString();
            type = widget.applianceModel.type.toString();
            isadded = false;
          }
          selected = isadded;
          print('isadded1:$isadded');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);

    return Card(
      elevation: 10.0,
      shadowColor: AppColor.yellow,
      color: Colors.transparent,
      child: Container(
        width: getProportionateScreenWidth(100),
        height: getProportionateScreenHeight(100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isadded ? AppColor.bgSideMenu : AppColor.bgColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(3),
            vertical: getProportionateScreenHeight(3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // width: 50,
                    // height: 50,
                    decoration: BoxDecoration(
                      color: isadded
                          ? const Color.fromRGBO(45, 45, 45, 1)
                          : const Color(0xffdadada),
                      borderRadius:
                          const BorderRadius.all(Radius.elliptical(45, 45)),
                    ),
                    child: IconButton(
                      icon: Image.asset(
                        "assets/appliances.png",

                        // height: 48,
                        // width: 48,
                        fit: BoxFit.cover,
                      ),
                      iconSize: 48,
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (dialogContext) {
                              return Center(
                                  child: AlertDialog(
                                title: const Center(
                                  child: Text("Edit Appliances"),
                                ),
                                content: Container(
                                  color: AppColor.white,
                                  width: (!AppResponsive.isMobile(context))
                                      ? MediaQuery.of(context).size.width
                                      : MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: Stack(
                                    children: [
                                      Form(
                                        key: applianceform,
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
                                                      ? 'Please enter  quantity'
                                                      : null,
                                              decoration: InputDecoration(
                                                labelText: "Quantity",
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
                                              controller: quanity,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              keyboardType: TextInputType.phone,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              validator: (value) => value!
                                                      .isEmpty
                                                  ? 'Please enter rated wattage'
                                                  : null,
                                              decoration: InputDecoration(
                                                labelText: "Rated Power",
                                                hintText: "Rated Power",
                                                suffixText: "Watts",
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
                                              controller: ratedwattage,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      decimal: true),
                                              onChanged: (value) {
                                                var hours = int.parse(value);
                                                if (hours >= 24) {
                                                  timeofusage.text = '24';
                                                }
                                              },
                                              validator: (value) => value!
                                                      .isEmpty
                                                  ? 'Please enter hours Per day '
                                                  : null,
                                              decoration: InputDecoration(
                                                labelText: "Hours",
                                                hintText: "Hours",
                                                suffixText: "Hr",
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
                                              controller: timeofusage,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            DropdownButtonFormField(
                                              decoration: InputDecoration(
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
                                              isExpanded: true,
                                              hint: const Text(
                                                'Choose type',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              value: type,
                                              onChanged: (value) {
                                                setState(() {
                                                  type = value.toString();
                                                });
                                              },
                                              items: <String>[
                                                "DC",
                                                "AC"
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
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
                                                    Navigator.of(dialogContext)
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
                                                  onPressed: () async {
                                                    if (appProvider
                                                            .maxmimumACpower !=
                                                        0) {
                                                      print('print ptotal');
                                                      Calculation()
                                                          .submaxmimumACpower(
                                                              appProvider,
                                                              power);
                                                    }
                                                    if (appProvider
                                                            .maxmimudcwattage !=
                                                        0) {
                                                      Calculation()
                                                          .submaximumDCpower(
                                                              appProvider,
                                                              adjustedwattage);
                                                    }
                                                    if (appProvider
                                                            .totalenergy !=
                                                        0) {
                                                      print('print EP');
                                                      Calculation()
                                                          .subtotalenergy(
                                                              appProvider,
                                                              energy);
                                                    }

                                                    Navigator.of(dialogContext)
                                                        .pop();
                                                    print(
                                                        'User: ${widget.Userid}');
                                                    await DatabaseService()
                                                        .updatetempappliances(
                                                            widget
                                                                .applianceModel
                                                                .categoryid,
                                                            '${widget.Userid}_${widget.applianceModel.id}',
                                                            widget
                                                                .applianceModel
                                                                .name,
                                                            type.toString(),
                                                            int.parse(quanity
                                                                .text
                                                                .toString()),
                                                            int.parse(
                                                                ratedwattage
                                                                    .text
                                                                    .toString()),
                                                            int.parse(timeofusage
                                                                .text
                                                                .toString()),
                                                            // int.parse(
                                                            //     simultaneity
                                                            //         .text
                                                            //         .toString()),
                                                            widget
                                                                .applianceModel
                                                                .image,
                                                            // widget
                                                            //     .applianceModel
                                                            //     .description,
                                                            true);
                                                    getTempdata();
                                                    setState(() {
                                                      isadded = true;
                                                      if (type == 'DC') {
                                                        adjustfactor = 1.0;
                                                      }
                                                      if (type == 'AC') {
                                                        adjustfactor = 0.85;
                                                      }
                                                    });
                                                    if (isadded) {
                                                      print('print isadded');

                                                      power = int.parse(
                                                              ratedwattage.text
                                                                  .toString()) *
                                                          int.parse(quanity.text
                                                              .toString());
                                                      adjustedwattage =
                                                          power / adjustfactor;
                                                      print(
                                                          'Adjust: ${adjustfactor}');
                                                      energy = adjustedwattage
                                                              .toInt() *
                                                          int.parse(timeofusage
                                                              .text
                                                              .toString());
                                                      Calculation()
                                                          .addmaximumDCpower(
                                                              appProvider,
                                                              adjustedwattage);
                                                      Calculation()
                                                          .addmaxmimumACpower(
                                                              appProvider,
                                                              power);
                                                      // Calculation().addratedwattage(appProvider,
                                                      //     widget.applianceModel.ratedwattage);
                                                      Calculation()
                                                          .addtotalenergy(
                                                              appProvider,
                                                              energy);
                                                      // Calculation()
                                                      //     .calPC(appProvider);
                                                    }
                                                  },
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
                                    ],
                                  ),
                                ),
                              ));
                            });
                      },
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isadded
                          ? const Color.fromRGBO(45, 45, 45, 1)
                          : const Color(0xffdadada),
                      borderRadius:
                          const BorderRadius.all(Radius.elliptical(45, 45)),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${int.parse(quanity.text.toString())}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isadded
                              ? const Color(0xffdadada)
                              : const Color.fromRGBO(45, 45, 45, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.applianceModel.name,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isadded ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    '${int.parse(ratedwattage.text.toString())}W',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: isadded
                            ? const Color(0xffdadada)
                            : const Color.fromRGBO(45, 45, 45, 1),
                        fontSize: 13,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1.6),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${int.parse(timeofusage.text.toString())}h',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      color: isadded
                          ? const Color(0xffdadada)
                          : const Color.fromRGBO(45, 45, 45, 1),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Transform.scale(
                      scale: 0.6,
                      child: Transform.translate(
                        offset: Offset(18.6, -9.3),
                        child: CupertinoSwitch(
                          value: isadded,
                          onChanged: (value) async {
                            print(value);
                            setState(() {
                              isadded = value;
                            });
                            if (value) {
                              await DatabaseService().updatetempappliances(
                                  widget.applianceModel.categoryid,
                                  '${widget.Userid}_${widget.applianceModel.id}',
                                  widget.applianceModel.name,
                                  widget.applianceModel.type,
                                  int.parse(quanity.text.toString()),
                                  int.parse(ratedwattage.text.toString()),
                                  int.parse(timeofusage.text.toString()),
                                  widget.applianceModel.image,
                                  value);
                              if (widget.applianceModel.type == 'DC') {
                                adjustfactor = 1.0;
                              }
                              if (widget.applianceModel.type == 'AC') {
                                adjustfactor = 0.85;
                              }

                              power = int.parse(ratedwattage.text.toString()) *
                                  int.parse(quanity.text.toString());
                              adjustedwattage = power / adjustfactor;

                              energy = adjustedwattage.toInt() *
                                  int.parse(timeofusage.text.toString());
                              Calculation().addmaximumDCpower(
                                  appProvider, adjustedwattage);
                              Calculation()
                                  .addmaxmimumACpower(appProvider, power);
                              // Calculation().addratedwattage(appProvider,
                              //     widget.applianceModel.ratedwattage);
                              Calculation().addtotalenergy(appProvider, energy);
                            } else {
                              DatabaseService().deletetemp(
                                  '${widget.Userid}_${widget.applianceModel.id}');
                              print('Type: ${type}');
                              if (type == 'DC') {
                                adjustfactor = 1.0;
                              }
                              if (type == 'AC') {
                                adjustfactor = 0.85;
                              }
                              power = int.parse(ratedwattage.text.toString()) *
                                  int.parse(quanity.text.toString());
                              adjustedwattage = power / adjustfactor;

                              energy = adjustedwattage.toInt() *
                                  int.parse(timeofusage.text.toString());
                              if (appProvider.maxmimumACpower != 0) {
                                Calculation()
                                    .submaxmimumACpower(appProvider, power);
                              }
                              if (appProvider.totalenergy != 0) {
                                Calculation()
                                    .subtotalenergy(appProvider, energy);
                              }

                              if (appProvider.maxmimudcwattage != 0) {
                                Calculation().submaximumDCpower(
                                    appProvider, adjustedwattage);
                              }
                              // if (appProvider.ratedwattage != 0) {
                              //   Calculation().subratedwattage(appProvider,
                              //       widget.applianceModel.ratedwattage);
                              // }
                              setState(() {
                                quanity.text =
                                    widget.applianceModel.quatity.toString();
                                ratedwattage.text = widget
                                    .applianceModel.ratedwattage
                                    .toString();
                                timeofusage.text = widget
                                    .applianceModel.timeofusage
                                    .toString();
                                type = widget.applianceModel.type.toString();
                                isadded = value;
                              });
                            }
                          },
                          activeColor: AppColor.yellow,
                          thumbColor: AppColor.bgColor,
                          trackColor: AppColor.bgSideMenu,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
