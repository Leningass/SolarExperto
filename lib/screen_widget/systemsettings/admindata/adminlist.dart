import 'package:SolarExperto/models/user/user.dart';
import 'package:SolarExperto/screen_widget/systemsettings/admindata/addadmin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_responsive.dart';
import '../../../constants/constants.dart';
import '../../../data/data.dart';
import '../../../global_widgets/Loading/loading.dart';
import '../../../global_widgets/header/editpage_header.dart';
import '../../../global_widgets/nodata/noitems.dart';
import '../../../services/database/database_service.dart';
import '../../../widget/discussion_info_detail.dart';
import 'admintile.dart';

class AdminList extends StatefulWidget {
  const AdminList({Key? key}) : super(key: key);

  @override
  State<AdminList> createState() => _AdminListState();
}

class _AdminListState extends State<AdminList> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: SingleChildScrollView(child: Column(
        children: [
          /// Header Part
          HeaderEdidPage(
            label: "Edit Admin",
            routname: SettingsRoute,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Admins',
                style: TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
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
                        return AddAdmin();
                      });
                },
                child: Center(
                  child: Text(
                    'Add Admin',
                    style: TextStyle(
                      color: AppColor.bgColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: appPadding,
          ),
          StreamBuilder<List<UserModel?>?>(
            stream: DatabaseService().admins,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.length == 0) {
                  return Center(
                    child: yelloNoData(),
                  );
                } else {
                  return GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,

                        physics: PageScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:
                          (!AppResponsive.isMobile(context))
                              ? MediaQuery.of(context).size.width / 2
                              : 390,
                          childAspectRatio:
                          (!AppResponsive.isMobile(context)) ? 3 / 2 : 2,
                          crossAxisSpacing:
                          (!AppResponsive.isMobile(context)) ? 10 : 0,
                          mainAxisSpacing:
                          (!AppResponsive.isMobile(context)) ? 5 : 20),
                      itemBuilder: (context, index) {
                        return AdminTile(
                          userModel: snapshot.data![index]!,
                        );
                      });
                }
              } else {
                return const Center(
                  child: Loading(),
                );
              }
            },
          )
        ],
      ),)
    );
  }
}
