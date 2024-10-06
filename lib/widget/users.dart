import 'package:flutter/material.dart';
import 'package:SolarExperto/constants/constants.dart';
import 'bar_chart_users.dart';
import 'package:SolarExperto/constants/app_colors.dart';

class Users extends StatelessWidget {
  const Users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      padding: EdgeInsets.all(appPadding),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customers",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: AppColor.black,
            ),
          ),
          Expanded(
            child: BarChartUsers(),
          )
        ],
      ),
    );
  }
}
