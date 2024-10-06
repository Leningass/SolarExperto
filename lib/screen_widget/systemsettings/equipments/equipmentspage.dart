
import 'package:SolarExperto/models/equipments/batteriesmodel.dart';

import 'package:SolarExperto/pages/settings/manage_equiments/managepvmodeule.dat.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_responsive.dart';
import '../../../constants/constants.dart';
import '../../../global_widgets/header/editpage_header.dart';
import '../../../pages/settings/manage_equiments/manageaccessories.dart';
import '../../../pages/settings/manage_equiments/managebattries.dart';
import '../../../pages/settings/manage_equiments/managechargecontroler.dart';
import '../../../pages/settings/manage_equiments/manageinverter.dart';

class Equipmentslist extends StatefulWidget {
  const Equipmentslist({Key? key,
  }) : super(key: key);

  @override
  State<Equipmentslist> createState() => _EquipmentslistState();
}

class _EquipmentslistState extends State<Equipmentslist> {
  String? _category;
  @override
  void initState() {
    _category = 'PV Module ';
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColor.bgColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(

          children: [
            /// Header Part
            HeaderEdidPage(
              label: "Equipments",
              routname: SettingsRoute,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 30,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>ManageBattries()));

                            },
                            child: Container(
                              padding: const EdgeInsets.all(appPadding * 0.75),

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),

                                  color: Colors.white
                              ),
                              child: Column(
                                children: [

                                  Container(

                                    child: Image.asset('assets/accumulator.png',
                                      height: ((!AppResponsive.isMobile(context)) ? 150 : 80),
                                      width: ((!AppResponsive.isMobile(context)) ? 150 : 80),
                                    ),
                                  ),

                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        "Batteries",
                                        style: TextStyle(
                                          color: AppColor.bgSideMenu,
                                          fontSize:   ((!AppResponsive.isMobile(context)) ? 24 : 16),

                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: appPadding),

                      Expanded(
                        child: Card(
                          elevation: 30,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>ManagePvmodule()));

                            },
                            child: Container(
                              padding: const EdgeInsets.all(appPadding * 0.75),

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),

                                  color: Colors.white
                              ),
                              child: Column(
                                children: [

                                  Container(

                                    child: Image.asset('assets/solar-cell.png',
                                      height: ((!AppResponsive.isMobile(context)) ? 150 : 80),
                                      width: ((!AppResponsive.isMobile(context)) ? 150 : 80),
                                    ),
                                  ),

                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        "PV Module",
                                        style: TextStyle(
                                          color: AppColor.bgSideMenu,
                                          fontSize: ((!AppResponsive.isMobile(context)) ? 24 : 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 30,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder:
                                      (context)=>ManageInverter()));

                            },
                            child: Container(
                              padding: const EdgeInsets.all(appPadding * 0.75),

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),

                                  color: Colors.white
                              ),
                              child: Column(
                                children: [
                                  Image.asset('assets/inverter.png',
                              height: ((!AppResponsive.isMobile(context)) ? 150 : 80),
                    width: ((!AppResponsive.isMobile(context)) ? 150 : 80),
                                  ),

                                  Center(
                                    child: Text(
                                      "Inverter",
                                      style: TextStyle(
                                        color: AppColor.bgSideMenu,
                                        fontSize: ((!AppResponsive.isMobile(context)) ? 24 : 16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: appPadding,),
                      Expanded(
                        child: Card(
                          elevation: 30,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder:
                                  (context)=>ManageChargeControler())
                              );
                            },
                            child: Container(
                              padding:  EdgeInsets.all(appPadding * 0.75),
                              width: 450,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),

                                  color: Colors.white
                              ),
                              child: Column(
                                children: [
                                  Image.asset('assets/controller.png',
                                    height: ((!AppResponsive.isMobile(context)) ? 150 : 80),
                                    width: ((!AppResponsive.isMobile(context)) ? 150 : 80),),

                                  SizedBox(
                                    height: appPadding,
                                  ),
                                  Center(
                                    child: Text(
                                      "Charge Controllers",
                                      style: TextStyle(
                                        color: AppColor.bgSideMenu,
                                        fontSize: ((!AppResponsive.isMobile(context)) ? 24 : 16),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 30,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder:
                                (context)=>ManageAccessories()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(appPadding * 0.75),

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),

                            color: Colors.white
                        ),
                        width: 450,
                        child: Column(
                          children: [
                            Image.asset('assets/accessories.png',
                              height: ((!AppResponsive.isMobile(context)) ? 150 : 80),
                              width: ((!AppResponsive.isMobile(context)) ? 150 : 80), ),

                            Center(
                              child: Text(
                                "Accessories",
                                style: TextStyle(
                                  color: AppColor.bgSideMenu,
                                  fontSize: ((!AppResponsive.isMobile(context)) ? 24 : 16),
                                ),
                              ),

                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );



  }
}
