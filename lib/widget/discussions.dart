import 'package:flutter/material.dart';
import 'package:SolarExperto/constants/app_colors.dart';
import 'package:SolarExperto/constants/constants.dart';
import 'package:SolarExperto/data/data.dart';

import '../global_widgets/Loading/loading.dart';
import '../global_widgets/nodata/noitems.dart';
import '../models/appointments/appointmentmodel.dart';
import '../pages/agenda/agenda.dart';
import '../pages/agenda/apointmentdetail.dart';
import '../pages/agenda/appointtile.dart';
import '../services/database/database_service.dart';
import 'discussion_info_detail.dart';

class Discussions extends StatelessWidget {
  const Discussions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 480,
      padding: EdgeInsets.all(appPadding),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Appointments',
                style: TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Agenda()));
                },
                child: Text(
                  'View All',
                  style: TextStyle(
                    color: AppColor.black.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: appPadding,
          ),
          StreamBuilder<List<ApointmentsModel?>?>(
            stream: DatabaseService().appointments,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.length == 0) {
                  return Center(
                    child: Text("No Appointments"),
                  );
                } else {
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: (snapshot.data!.length <= 10)
                          ? snapshot.data!.length
                          : 10,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ManageAppointmentDetails(
                                          apointmentsModel:
                                              snapshot.data![index]!,
                                        )));
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: AppointmentTiles(
                              apointmentsModel: snapshot.data![index]!,
                            ),
                          ),
                        );
                      });
                }
              } else {
                return const Center(
                  child: Loading(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
