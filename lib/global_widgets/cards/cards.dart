import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_responsive.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {Key? key,
      required this.widget,
      required this.label,
      required this.shadowColor,
      required this.color})
      : super(key: key);
  final Widget widget;
  final String label;
  final Color shadowColor;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Card(
        shadowColor: shadowColor,
        // color: color,
        elevation: 10,
        // margin: (!AppResponsive.isMobile(context))
        //     ? EdgeInsets.fromLTRB(32, 32, 64, 32)
        //     : EdgeInsets.fromLTRB(32, 32, 32, 32),
        child: Padding(
          padding: (!AppResponsive.isMobile(context))
              ? EdgeInsets.all(10.0)
              : EdgeInsets.all(0.0),
          child: Container(
              child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    widget,
                    const SizedBox(
                      height: 5.0,
                    ),
                    Center(
                      child: Text(
                        label,
                        style: TextStyle(
                            color: AppColor.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              //SelectionSection(),
            ],
          )),
          // ),
        ));
  }
}
