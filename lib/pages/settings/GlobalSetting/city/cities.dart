import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_responsive.dart';
import '../../../../constants/constants.dart';
import '../../../../global_widgets/Loading/loading.dart';
import '../../../../models/city/city.dart';
import '../../../../screen_widget/systemsettings/additionalsettings/addcity.dart';
import '../../../../screen_widget/systemsettings/additionalsettings/citytiles.dart';
import '../../../../services/database/database_service.dart';

class Cities extends StatefulWidget {
  const Cities({Key? key}) : super(key: key);

  @override
  State<Cities> createState() => _CitiesState();
}

class _CitiesState extends State<Cities> {
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
                                  'Cities',
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
                                            return AddCity();
                                          });
                                    },
                                    child: Center(
                                      child: Text(
                                        'Add City',
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
                            StreamBuilder<List<CityModel?>?>(
                              stream: DatabaseService().cities,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data!.length == 0) {
                                    return const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('No Cities'),
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
                                              CityTiles(
                                            cityModel: snapshot.data![index]!,
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

                /*Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      if (!AppResponsive.isMobile(context)) ...{
                        ElevatedButton(
                          style: TextButton.styleFrom(
                              backgroundColor: AppColor.bgSideMenu,
                              padding: EdgeInsets.all(20.0),
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          onPressed: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (dialogContext) {
                                  return AddCity();
                                });
                          },
                          child: Center(
                            child: Text(
                              'Add City',
                              style: TextStyle(
                                color: AppColor.bgColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                      }
                    ],
                  ),
                ),*/
            ],
          ),
        ),
      ),
    );
  }
}
