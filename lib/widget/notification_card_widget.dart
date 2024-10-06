import 'package:flutter/material.dart';
import 'package:SolarExperto/constants/app_colors.dart';
import 'package:SolarExperto/constants/app_responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global_widgets/Loading/loading.dart';
import '../models/appointments/appointmentmodel.dart';
import '../services/database/database_service.dart';

class NotificationCardWidget extends StatefulWidget {
  @override
  State<NotificationCardWidget> createState() => _NotificationCardWidgetState();
}

class _NotificationCardWidgetState extends State<NotificationCardWidget> {
  String? name;

  void getname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = (prefs.getString('name') ?? '');

    });
  }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getname();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.yellow, borderRadius: BorderRadius.circular(20)),
      padding: (!AppResponsive.isMobile(context))
          ? EdgeInsets.all(20)
          : EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 16, color: AppColor.black),
              children: [
                TextSpan(text: "Good Morning "),
                TextSpan(
                  text: "$name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: StreamBuilder<List<ApointmentsModel?>?>(
                  stream: DatabaseService().appointments,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.length == 0) {
                        return Text("No New Appointments Today");
                      } else {
                        return SingleChildScrollView(
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return StreamBuilder<List<ApointmentsModel?>?>(
                                  stream: DatabaseService(
                                          doctoken: snapshot.data![index]!.id)
                                      .appointments,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        "Today you have ${snapshot.data!.length} New Appointments.",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: AppColor.black,
                                          // height: 1.5,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        "No New Appointments Today.",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: AppColor.black,
                                          // height: 1.5,
                                        ),
                                      );
                                    }
                                  },
                                );
                              }),
                        );
                      }
                    } else {
                      return const Center(
                          // child: Loading(),
                          );
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Read More",
            style: TextStyle(
                fontSize: 14,
                color: AppColor.black,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          )
        ],
      ),
    );
  }
}
