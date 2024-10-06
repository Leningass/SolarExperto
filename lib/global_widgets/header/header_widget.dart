import 'package:SolarExperto/constants/app_colors.dart';
import 'package:SolarExperto/constants/app_responsive.dart';
import 'package:SolarExperto/controllers/menu_controller.dart';
import 'package:SolarExperto/global_widgets/header/profile_info.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HeaderWidget extends StatefulWidget {
  final String Routname;

  const HeaderWidget({Key? key, required this.Routname}) : super(key: key);
  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          if (AppResponsive.isMobile(context) ||
              AppResponsive.isTablet(context))
            IconButton(
              icon: Icon(
                Icons.menu,
                color: AppColor.black,
              ),
              onPressed: Provider.of<MenuControllers>(context, listen: true)
                  .controlMenu,
            ),
          Text(
            widget.Routname,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              ProfileInfo(),
            ],
          )
        ],
      ),
    );
  }

  Widget navigationIcon({icon}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        icon,
        color: AppColor.black,
      ),
    );
  }
}
