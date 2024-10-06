import 'package:SolarExperto/models/Service%20Fee/servicefeemodel.dart';
import 'package:SolarExperto/pages/settings/GlobalSetting/Servicefee/addservicefee.dart';
import 'package:SolarExperto/pages/settings/GlobalSetting/Servicefee/servicefeetile.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/constants.dart';
import '../../../../global_widgets/Loading/loading.dart';
import '../../../../services/database/database_service.dart';

class ServiceFee extends StatefulWidget {
  const ServiceFee({Key? key}) : super(key: key);

  @override
  State<ServiceFee> createState() => _ServiceFeeState();
}

class _ServiceFeeState extends State<ServiceFee> {
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
        ),
        body: SingleChildScrollView(
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    children: [
                      //NotificationCardWidget(),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 480,
                        padding: EdgeInsets.all(appPadding),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Service Fee',
                                  style: TextStyle(
                                    color: AppColor.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                                //  if (AppResponsive.isMobile(context)) ...{
                                ElevatedButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: AppColor.bgSideMenu,
                                      padding: EdgeInsets.all(20.0),
                                      elevation: 5.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(5))),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (dialogContext) {
                                          return AddServiceFee();
                                        });
                                  },
                                  child: Center(
                                    child: Text(
                                      'Add Service Fee',
                                      style: TextStyle(
                                        color: AppColor.bgColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                // },
                              ],
                            ),
                            SizedBox(
                              height: appPadding,
                            ),
                            StreamBuilder<List<ServiceFeeModel?>?>(
                              stream: DatabaseService().servicefee,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data!.length == 0) {
                                    return const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('No service fee'),
                                      ),
                                    );
                                  } else {
                                    return Expanded(
                                      child: SingleChildScrollView(
                                        child: ListView.builder(
                                          physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) =>
                                              ServiceFeeTile(
                                                serviceFeeModel: snapshot.data![index]!,
                                              ),
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  return const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Loading(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
