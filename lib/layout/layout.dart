import 'package:SolarExperto/constants/app_colors.dart';
import 'package:SolarExperto/constants/app_responsive.dart';
import 'package:SolarExperto/constants/constants.dart';
import 'package:SolarExperto/controllers/menu_controller.dart';
import 'package:SolarExperto/navbar/locator.dart';
import 'package:SolarExperto/navbar/navigation_service.dart';
import 'package:SolarExperto/navbar/side_bar_menu.dart';
import 'package:SolarExperto/rounting/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      key: Provider.of<MenuControllers>(context, listen: false).scaffoldKey,
      backgroundColor: AppColor.bgSideMenu,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // /// Side Navigation Menu
              // /// Only show in desktop
              if (AppResponsive.isDesktop(context)) SideBar(),

              /// Main Body Part
              Expanded(
                  child: Navigator(
                key: locator<NavigationService>().navigatorKey,
                onGenerateRoute: generateRoute,
                initialRoute: HomeRoute,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
