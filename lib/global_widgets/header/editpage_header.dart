import 'package:SolarExperto/constants/app_colors.dart';
import 'package:SolarExperto/constants/app_responsive.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../controllers/menu_controller.dart';
import '../../navbar/locator.dart';
import '../../navbar/navigation_service.dart';

class HeaderEdidPage extends StatefulWidget {
  final String label;
  final String routname;

  const HeaderEdidPage({Key? key, required this.label, required this.routname})
      : super(key: key);
  @override
  _HeaderEdidPageState createState() => _HeaderEdidPageState();
}

class _HeaderEdidPageState extends State<HeaderEdidPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          if (AppResponsive.isMobile(context))
            IconButton(
              icon: Icon(
                Icons.menu,
                color: AppColor.black,
              ),
              onPressed: Provider.of<MenuControllers>(context, listen: true)
                  .controlMenu,
            ),
          Text(
            widget.label,
            style: TextStyle(
              fontSize: (!AppResponsive.isMobile(context)) ? 24 : 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    locator<NavigationService>().navigateTo(widget.routname);
                  },
                  icon: Icon(Icons.close))
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
