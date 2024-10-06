import 'dart:math';

import 'package:flutter/material.dart';
import 'package:SolarExperto/constants/constants.dart';
import 'package:SolarExperto/constants/app_responsive.dart';
import 'package:SolarExperto/constants/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({Key? key}) : super(key: key);

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  String? name;
  String pic = '';
  void getname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = (prefs.getString('name') ?? '');
      pic = (prefs.getString('pic') ?? '');
    });
  }

  @override
  void initState() {
    getname();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: appPadding),
          padding: const EdgeInsets.symmetric(
            horizontal: appPadding,
            vertical: appPadding / 2,
          ),
          child: Row(
            children: [
              ClipRRect(
                child: Image.asset(
                 "assets/images/admin.png",
                  height: 36,
                  width: 36,
                  fit: BoxFit.cover,
                ),

                // child: Image.network(
                //   pic,
                //   height: 36,
                //   width: 36,
                //   fit: BoxFit.cover,
                // ),
                borderRadius: BorderRadius.circular(30),
              ),
              if (!AppResponsive.isMobile(context))
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: appPadding / 2),
                  child: Text(
                    'Hi, $name',
                    style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                )
            ],
          ),
        )
      ],
    );
  }
}
