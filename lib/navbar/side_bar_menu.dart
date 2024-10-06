import 'package:SolarExperto/constants/constants.dart';
import 'package:SolarExperto/constants/enumerators.dart';
import 'package:SolarExperto/controllers/menu_controller.dart';
import 'package:SolarExperto/navbar/locator.dart';
import 'package:SolarExperto/navbar/navigation_service.dart';
import 'package:SolarExperto/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:SolarExperto/constants/app_colors.dart';
import 'package:provider/provider.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      backgroundColor: AppColor.lightyellow?.withOpacity(0),
      width: 250.0,
      elevation: 0,
      child: Container(
        // color: AppColor.bgSideMenu,
        margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        decoration: BoxDecoration(
          color: AppColor.bgSideMenu,
          borderRadius: BorderRadius.circular(30),
        ),
        child: ListView(
          children: [
            const SizedBox(
              height: 25.0,
            ),
            Container(
              // margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: const Image(
                image: AssetImage('assets/images/main-logo.png'),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            DrawerListTile(
              title: "Dashboard",
              icon: "assets/menu_home.png",
              active: appProvider.currentPage == DisplayedPage.HOME,
              press: () {
                appProvider.changeCurrentPage(DisplayedPage.HOME);
                locator<NavigationService>().navigateTo(HomeRoute);
                Provider.of<MenuControllers>(context, listen: false)
                    .scaffoldKey
                    .currentState!
                    .closeDrawer();
              },
            ),
            DrawerListTile(
              title: "Analysis",
              icon: "assets/menu_onboarding.png",
              active: appProvider.currentPage == DisplayedPage.ANALYSIS,
              press: () {
                appProvider.changeCurrentPage(DisplayedPage.ANALYSIS);
                locator<NavigationService>().navigateTo(AnalysisRoute);
                Provider.of<MenuControllers>(context, listen: false)
                    .scaffoldKey
                    .currentState!
                    .closeDrawer();
              },
            ),
            DrawerListTile(
              title: "Monitor",
              icon: "assets/monitor.png",
              active: appProvider.currentPage == DisplayedPage.MONITOR,
              press: () {
                appProvider.changeCurrentPage(DisplayedPage.MONITOR);
              },
            ),
            DrawerListTile(
              title: "Customers",
              icon: "assets/menu_recruitment.png",
              active: appProvider.currentPage == DisplayedPage.CUSTOMERS,
              press: () {
                appProvider.changeCurrentPage(DisplayedPage.CUSTOMERS);
                locator<NavigationService>().navigateTo(CustomerRoute);
                Provider.of<MenuControllers>(context, listen: false)
                    .scaffoldKey
                    .currentState!
                    .closeDrawer();
              },
            ),
            DrawerListTile(
              title: "Agenda",
              icon: "assets/menu_calendar.png",
              active: appProvider.currentPage == DisplayedPage.AGENDA,
              press: () {
                appProvider.changeCurrentPage(DisplayedPage.AGENDA);
                locator<NavigationService>().navigateTo(AgendaRoute);
                Provider.of<MenuControllers>(context, listen: false)
                    .scaffoldKey
                    .currentState!
                    .closeDrawer();
              },
            ),
            DrawerListTile(
              title: "Invoices",
              icon: "assets/menu_report.png",
              active: appProvider.currentPage == DisplayedPage.INVOICES,
              press: () {
                appProvider.changeCurrentPage(DisplayedPage.INVOICES);
                locator<NavigationService>().navigateTo(InvoiceRoute);
                Provider.of<MenuControllers>(context, listen: false)
                    .scaffoldKey
                    .currentState!
                    .closeDrawer();
              },
            ),
            DrawerListTile(
              title: "Sale",
              icon: "assets/menu_report.png",
              active: appProvider.currentPage == DisplayedPage.SALE,
              press: () {
                appProvider.changeCurrentPage(DisplayedPage.SALE);
                locator<NavigationService>().navigateTo(FinanceRoute);
                Provider.of<MenuControllers>(context, listen: false)
                    .scaffoldKey
                    .currentState!
                    .closeDrawer();
              },
            ),
            DrawerListTile(
              title: "Settings",
              icon: "assets/menu_settings.png",
              active: appProvider.currentPage == DisplayedPage.SETTINGS,
              press: () {
                appProvider.changeCurrentPage(DisplayedPage.SETTINGS);
                locator<NavigationService>().navigateTo(SettingsRoute);
                Provider.of<MenuControllers>(context, listen: false)
                    .scaffoldKey
                    .currentState!
                    .closeDrawer();
              },
            ),

            //Image.asset("assets/sidebar_image.png")
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String title, icon;
  final VoidCallback press;
  final bool active;
  const DrawerListTile(
      {Key? key,
      required this.title,
      required this.icon,
      required this.press,
      required this.active})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.bgSideMenu,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(10.0),
            right: Radius.circular(10.0),
          ),
        ),
        onTap: press,
        tileColor: active ? AppColor.yellow : null,
        horizontalTitleGap: 10.0,
        minLeadingWidth: 30.0,
        minVerticalPadding: 10.0,
        leading: Image.asset(
          icon,
          color: active ? AppColor.bgSideMenu : AppColor.yellow,
          height: active ? 18 : 18,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: active ? AppColor.bgSideMenu : AppColor.white,
            fontSize: active ? 20 : 18,
            fontWeight: active ? FontWeight.bold : null,
          ),
        ),
      ),
    );
  }
}
