import 'package:SolarExperto/global_widgets/header/header_widget.dart';
import 'package:SolarExperto/models/city/city.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/constants.dart';
import '../../../../global_widgets/Loading/loading.dart';
import '../../../../global_widgets/Loading/saveloading.dart';
import '../../../../global_widgets/nodata/noitems.dart';
import '../../../../navbar/locator.dart';
import '../../../../navbar/navigation_service.dart';
import '../../../../provider/app_provider.dart';
import '../../../../services/database/database_service.dart';
import '../../../header/header.dart';

class Globals extends StatefulWidget {
  Globals(
      {Key? key, this.onNext, required this.appProvider, required this.userid})
      : super(key: key);
  final Function? onNext;
  final AppProvider appProvider;
  final String userid;

  @override
  State<Globals> createState() => _GlobalsState();
}

class _GlobalsState extends State<Globals> {
  TextEditingController autonomy_in_days = TextEditingController();
  TextEditingController controller_safety = TextEditingController();
  TextEditingController batterydod = TextEditingController();
  TextEditingController batteryroundtrip = TextEditingController();
  TextEditingController inverterefficiency = TextEditingController();
  TextEditingController deratingfactor = TextEditingController();
  TextEditingController systemlifetime = TextEditingController();
  String? cityname;
  String? categoryid;

  @override
  void initState() {
    get_tempglobal();
    super.initState();
  }

  void get_tempglobal() {
    print('${widget.userid}_global');
    FirebaseFirestore.instance
        .collection(tempglobalCollection)
        .doc('${widget.userid}_global')
        .get()
        .then((DocumentSnapshot) {
      if (mounted) {
        setState(() {
          if (DocumentSnapshot.exists) {
            cityname = DocumentSnapshot['cityname'].toString();
            widget.appProvider.inverterac_voltage =
                DocumentSnapshot['inverterac_voltage'];
            widget.appProvider.updateinverteracvoltage(
                inverterac_voltage: widget.appProvider.inverterac_voltage);
            widget.appProvider.electricityprice=DocumentSnapshot['electricityprice'];
            widget.appProvider.updateelectricityprice(electricityprice:widget.appProvider.electricityprice );

            widget.appProvider.peaksunhour = DocumentSnapshot['peaksunhour'];
            widget.appProvider
                .updatepeaksunhour(peaksunhour: widget.appProvider.peaksunhour);
            if (widget.appProvider.autonomy_in_days == 0) {
              print(
                  "Autonomy: ${DocumentSnapshot['batteryAutonomy'].toString()}");
              widget.appProvider.autonomy_in_days =
                  int.parse(DocumentSnapshot['batteryAutonomy'].toString());
              widget.appProvider.updateautonomy_in_days(
                  autonomy_in_days: widget.appProvider.autonomy_in_days);
            }
            autonomy_in_days.text =
                widget.appProvider.autonomy_in_days.toString();

            if (widget.appProvider.controller_safety == 0) {
              widget.appProvider.controller_safety =
                  double.parse(DocumentSnapshot['contSafetyFactor'].toString());
              widget.appProvider.updatecontrollersafety(
                  controller_safety: widget.appProvider.controller_safety);
            }
            controller_safety.text =
                widget.appProvider.controller_safety.toString();

            if (widget.appProvider.inverter_efficiency == 0) {
              widget.appProvider.inverter_efficiency = double.parse(
                  DocumentSnapshot['inverterEfficiency'].toString());
              widget.appProvider.updateinverterefficeiency(
                  inverter_efficiency: widget.appProvider.inverter_efficiency);
            }
            inverterefficiency.text =
                widget.appProvider.inverter_efficiency.toString();
            if (widget.appProvider.battery_dod == 0.0) {
              widget.appProvider.battery_dod =
                  double.parse(DocumentSnapshot['batteryDod'].toString());
              widget.appProvider.updatebatterydod(
                  battery_dod: widget.appProvider.battery_dod);
            }
            batterydod.text = widget.appProvider.battery_dod.toString();

            if (widget.appProvider.batery_round_trip == 0) {
              widget.appProvider.batery_round_trip = double.parse(
                  DocumentSnapshot['roundTripEfficiency'].toString());
              widget.appProvider.updatebatteryroundtrip(
                  batery_round_trip: widget.appProvider.batery_round_trip);
            }
            batteryroundtrip.text =
                widget.appProvider.batery_round_trip.toString();

            if (widget.appProvider.derating_factor == 0) {
              widget.appProvider.derating_factor =
                  double.parse(DocumentSnapshot['deRatingFactor'].toString());
              widget.appProvider.updatederatingfactor(
                  derating_factor: widget.appProvider.derating_factor);
            }
            deratingfactor.text = widget.appProvider.derating_factor.toString();
            if (widget.appProvider.system_life == 0) {
              widget.appProvider.system_life =
                  double.parse(DocumentSnapshot['lifeTime'].toString());
              widget.appProvider.updatesystemlife(
                  system_life: widget.appProvider.system_life);
            }
            systemlifetime.text = widget.appProvider.system_life.toString();
          } else {
            FirebaseFirestore.instance
                .collection(globalCollection)
                .doc('globalparam')
                .get()
                .then((DocumentSnapshot) {
              if (mounted) {
                setState(() {
                  if (DocumentSnapshot.exists) {
                    if (widget.appProvider.autonomy_in_days == 0) {
                      //print("Autonomy: ${widget.appProvider.autonomy_in_days}");
                      widget.appProvider.autonomy_in_days = int.parse(
                          DocumentSnapshot['batteryAutonomy'].toString());
                      widget.appProvider.updateautonomy_in_days(
                          autonomy_in_days:
                              widget.appProvider.autonomy_in_days);
                    }
                    autonomy_in_days.text =
                        widget.appProvider.autonomy_in_days.toString();

                    if (widget.appProvider.controller_safety == 0) {
                      widget.appProvider.controller_safety = double.parse(
                          DocumentSnapshot['contSafetyFactor'].toString());
                      widget.appProvider.updatecontrollersafety(
                          controller_safety:
                              widget.appProvider.controller_safety);
                    }
                    controller_safety.text =
                        widget.appProvider.controller_safety.toString();

                    if (widget.appProvider.inverter_efficiency == 0) {
                      widget.appProvider.inverter_efficiency = double.parse(
                          DocumentSnapshot['inverterEfficiency'].toString());
                      widget.appProvider.updateinverterefficeiency(
                          inverter_efficiency:
                              widget.appProvider.inverter_efficiency);
                    }
                    inverterefficiency.text =
                        widget.appProvider.inverter_efficiency.toString();
                    if (widget.appProvider.battery_dod == 0.0) {
                      widget.appProvider.battery_dod = double.parse(
                          DocumentSnapshot['batteryDod'].toString());
                      widget.appProvider.updatebatterydod(
                          battery_dod: widget.appProvider.battery_dod);
                    }
                    batterydod.text = widget.appProvider.battery_dod.toString();

                    if (widget.appProvider.batery_round_trip == 0) {
                      widget.appProvider.batery_round_trip = double.parse(
                          DocumentSnapshot['roundTripEfficiency'].toString());
                      widget.appProvider.updatebatteryroundtrip(
                          batery_round_trip:
                              widget.appProvider.batery_round_trip);
                    }
                    batteryroundtrip.text =
                        widget.appProvider.batery_round_trip.toString();

                    if (widget.appProvider.derating_factor == 0) {
                      widget.appProvider.derating_factor = double.parse(
                          DocumentSnapshot['deRatingFactor'].toString());
                      widget.appProvider.updatederatingfactor(
                          derating_factor: widget.appProvider.derating_factor);
                    }
                    deratingfactor.text =
                        widget.appProvider.derating_factor.toString();
                    if (widget.appProvider.system_life == 0) {
                      widget.appProvider.system_life =
                          double.parse(DocumentSnapshot['lifeTime'].toString());
                      widget.appProvider.updatesystemlife(
                          system_life: widget.appProvider.system_life);
                    }
                    systemlifetime.text =
                        widget.appProvider.system_life.toString();
                  }
                });
              }
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);

    return ListView(

      children: [
        HeaderWidget(Routname: "Analysis"),
        Header(
          text: 'Global',
          backDisabled: false,
          forwardDisabled: (cityname != null) ? false : true,
          onNavigate: (int index) async {
            //if (cityname != null) {
            appProvider.screenindex = appProvider.screenindex + index;
            appProvider.incrementScreen(appProvider.screenindex);
            if (cityname != null) {
              await DatabaseService().updatetempglobals(
                  '${widget.userid}_global',
                  widget.appProvider.controller_safety,
                  widget.appProvider.inverter_efficiency,
                  widget.appProvider.battery_dod,
                  widget.appProvider.batery_round_trip,
                  widget.appProvider.derating_factor,
                  widget.appProvider.system_life,
                  widget.appProvider.autonomy_in_days,
                  widget.appProvider.inverterac_voltage,
                  widget.appProvider.peaksunhour,
                  widget.appProvider.electricityprice,
                  cityname);
            }
            // else {
            //   ScaffoldMessenger.of(context)
            //       .showSnackBar(const SnackBar(content: Text("Select City")));
            // }
          },
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColor.bgColor,
          ),
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Align(
            alignment: Alignment.topRight,
            child: ElevatedButton(
              onPressed: () {
                DatabaseService().deletetempglobal('${widget.userid}_global');
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Reseting..")));
                widget.appProvider.controller_safety = 0;
                widget.appProvider.inverter_efficiency = 0;
                widget.appProvider.battery_dod = 0;
                widget.appProvider.batery_round_trip = 0;
                widget.appProvider.derating_factor = 0;
                widget.appProvider.system_life = 0;
                widget.appProvider.autonomy_in_days = 0;
                widget.appProvider.inverterac_voltage = 0;
                widget.appProvider.peaksunhour = 0;
                widget.appProvider.updatecontrollersafety(
                    controller_safety: widget.appProvider.controller_safety);

                widget.appProvider.updateinverterefficeiency(
                    inverter_efficiency:
                        widget.appProvider.inverter_efficiency);
                widget.appProvider.updatebatterydod(
                    battery_dod: widget.appProvider.battery_dod);
                widget.appProvider.updatebatteryroundtrip(
                    batery_round_trip: widget.appProvider.batery_round_trip);
                widget.appProvider.updatederatingfactor(
                    derating_factor: widget.appProvider.derating_factor);
                widget.appProvider.updatesystemlife(
                    system_life: widget.appProvider.system_life);
                widget.appProvider.updateautonomy_in_days(
                    autonomy_in_days: widget.appProvider.autonomy_in_days);
                widget.appProvider.updateinverteracvoltage(
                    inverterac_voltage: widget.appProvider.inverterac_voltage);
                widget.appProvider.updatepeaksunhour(
                    peaksunhour: widget.appProvider.peaksunhour);
                locator<NavigationService>().navigateTo(AnalysisRoute);
              },
              child: const Text('Reset'),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 40, left: 30),
          child: Text(
            'City',
            style: TextStyle(fontSize: 17),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
            stream:
                firebaseFiretore.collection(city).orderBy('name').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: SaveLoading(),
                );
              }
              return Container(
                margin: EdgeInsets.only(top: 7, left: 30, right: 30),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                child: DropdownButton(
                    isExpanded: true,
                    hint: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Select City',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    value: cityname,
                    items: snapshot.data?.docs.map((DocumentSnapshot document) {
                      return DropdownMenuItem<String>(
                        onTap: () {
                          setState(() {

                            widget.appProvider.inverterac_voltage =
                                document['inverterac_voltage'];
                            widget.appProvider.updateinverteracvoltage(
                                inverterac_voltage:
                                    widget.appProvider.inverterac_voltage);
                            widget.appProvider.peaksunhour =
                                document['peaksunhours'];
                            widget.appProvider.updatepeaksunhour(
                                peaksunhour: widget.appProvider.peaksunhour);
                           widget.appProvider.electricityprice=document['electricity_price'];
                           widget.appProvider.updateelectricityprice(electricityprice:widget.appProvider.electricityprice );

                            categoryid = document['id'];
                            cityname = document['name'];
                          });
                        },
                        value: document['name'],
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(document['name']),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        cityname = newValue.toString();
                        //dropDown = false;
                        print(cityname);
                      });
                    }),
              );
            }),
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
            //controller: contSafetyFactor,
            onChanged: (value) {
              var contsafety = double.parse(value);

              //autonomy_in_days.text = autonomy;
              widget.appProvider.controller_safety = contsafety;
              widget.appProvider.updatecontrollersafety(
                  controller_safety: widget.appProvider.controller_safety);
            },
            controller: controller_safety,
            keyboardType: TextInputType.number,
            // initialValue: appProvider.global.contSafetyFactor,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
            onChanged: (value) {
              var inverter = double.parse(value);

              //autonomy_in_days.text = autonomy;
              widget.appProvider.inverter_efficiency = inverter;
              widget.appProvider.updateinverterefficeiency(
                  inverter_efficiency: widget.appProvider.inverter_efficiency);
            },
            controller: inverterefficiency,
            keyboardType: TextInputType.number,
            // initialValue: appProvider.global.inverterEfficiency,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
            onChanged: (value) {
              //autonomy_in_days.text = autonomy;
              widget.appProvider.battery_dod = double.parse(value);
              widget.appProvider.updatebatterydod(
                  battery_dod: widget.appProvider.battery_dod);
            },
            controller: batterydod,
            keyboardType: TextInputType.number,
            // initialValue: appProvider.global.batteryDod,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
            onChanged: (value) {
              var batteryround = double.parse(value);

              //autonomy_in_days.text = autonomy;
              widget.appProvider.batery_round_trip = batteryround;
              widget.appProvider.updatebatteryroundtrip(
                  batery_round_trip: widget.appProvider.batery_round_trip);
            },
            controller: batteryroundtrip,
            keyboardType: TextInputType.number,
            //initialValue: appProvider.global.roundTripEfficiency,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
            onChanged: (value) {
              var derating = double.parse(value);

              //autonomy_in_days.text = autonomy;
              widget.appProvider.derating_factor = derating;
              widget.appProvider.updatederatingfactor(
                  derating_factor: widget.appProvider.derating_factor);
            },
            controller: deratingfactor,
            keyboardType: TextInputType.number,
            //  initialValue: appProvider.global.deRatingFactor,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
            onChanged: (value) {
              //autonomy_in_days.text = autonomy;
              widget.appProvider.system_life = double.parse(value);
              widget.appProvider.updatesystemlife(
                  system_life: widget.appProvider.system_life);
            },
            controller: systemlifetime,
            keyboardType: TextInputType.number,
            // initialValue: appProvider.global.lifeTime,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
            onChanged: (value) {
              //autonomy_in_days.text = autonomy;
              widget.appProvider.autonomy_in_days = int.parse(value);
              widget.appProvider.updateautonomy_in_days(
                  autonomy_in_days: widget.appProvider.autonomy_in_days);
            },
            controller: autonomy_in_days,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              // border: InputBorder.none,
              hintText: 'Enter Battery Autonomy (days)',
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),

        /*   Padding(
            padding: EdgeInsets.only(top: 40, left: 30),
            child: Text(
              'City',
              style: TextStyle(fontSize: 17),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 7, left: 30, right: 30),
            // padding: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey[400]!,
                  width: 2.0,
                ),
              ),
              color: Colors.grey[200],
            ),
            child: ListTile(
              title: Text(
"                appProvider.global.city==null?'Select a City': appProvider.global.city!.name",
 style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              trailing: Icon(Icons.arrow_drop_down),
              onTap: () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: true, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: appProvider.cities.length > 0
                              ? appProvider.cities
                                  .map(
                                    (city) => ListTile(
                                      title: Text(city.name),
                                      onTap: () {
                                        appProvider.cities;
                                        appProvider.selectCity(city);
                                        appProvider.notifyTheListener();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  )
                                  .toList()
                              : [
                                  Center(
                                    child: Text('No City Found'),
                                  ),
                                ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
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
               //controller: contSafetyFactor,
              onChanged: (value) {
                contSafetyFactor = value;
              },
              keyboardType: TextInputType.number,
            //  initialValue: appProvider.global.contSafetyFactor,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
              onChanged: (value) {
                inverterEfficiency = value;
              },
              keyboardType: TextInputType.number,
              //initialValue: appProvider.global.inverterEfficiency,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
              onChanged: (value) {
                batteryDod = value;
              },
              keyboardType: TextInputType.number,
              //initialValue: appProvider.global.batteryDod,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
              onChanged: (value) {
                roundTripEfficiency = value;
              },
              keyboardType: TextInputType.number,
             // initialValue: appProvider.global.roundTripEfficiency,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
              onChanged: (value) {
                deRatingFactor = value;
              },
              keyboardType: TextInputType.number,
             // initialValue: appProvider.global.deRatingFactor,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
              onChanged: (value) {
                lifeTime = value;
              },
              keyboardType: TextInputType.number,
             // initialValue: appProvider.global.lifeTime,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
              onChanged: (value) {
                batteryAutonomy = value;
              },
              keyboardType: TextInputType.number,
             // initialValue: appProvider.global.batteryAutonomy,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                // border: InputBorder.none,
                hintText: 'Enter Battery Autonomy (days)',
              ),
            ),
          ),*/
      ],
    );
  }
}
