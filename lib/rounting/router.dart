import 'package:SolarExperto/layout/layout.dart';
import 'package:SolarExperto/main.dart';
import 'package:SolarExperto/constants/constants.dart';
import 'package:SolarExperto/models/equipments/batteriesmodel.dart';
import 'package:SolarExperto/pages/analysis/analysis.dart';
import 'package:SolarExperto/pages/analysis/systemanalysis/equipments/equipment.dart';
import 'package:SolarExperto/pages/dashboard/dashboard.dart';
import 'package:SolarExperto/pages/finance/finance.dart';
import 'package:SolarExperto/pages/invoice/invoice.dart';
import 'package:SolarExperto/pages/login/login.dart';
import 'package:SolarExperto/pages/customers/customer.dart';
import 'package:SolarExperto/pages/agenda/agenda.dart';
import 'package:SolarExperto/pages/settings/setting.dart';
import 'package:SolarExperto/screen_widget/systemsettings/additionalsettings/additionalsettinglist.dart';
import 'package:SolarExperto/screen_widget/systemsettings/admindata/adminlist.dart';
import 'package:SolarExperto/screen_widget/systemsettings/appliancesdata/appliancespage.dart';
import 'package:flutter/material.dart';

import '../screen_widget/systemsettings/equipments/equipmentspage.dart';

Route<dynamic> generateRoute(RouteSettings settings) {

  print('generateRoute: ${settings.name}');
  switch (settings.name) {
    // case EditPvModule:
    //   return _getPageRoute(Equipment());
    case HomeRoute:
      return _getPageRoute(Dashboard());
    case MainRoute:
      return _getPageRoute(MainPage());
    case AnalysisRoute:
      return _getPageRoute( Analysis());
    case PageControllerRoute:
      return _getPageRoute(AppPagesController());
    case CustomerRoute:
      return _getPageRoute(Customers());
    case AgendaRoute:
      return _getPageRoute(Agenda());
    case FinanceRoute:
      return _getPageRoute(Finance());
    case InvoiceRoute:
      return _getPageRoute(Invoice());
    case SettingsRoute:
       return _getPageRoute(AppSetting());

    case EditAppliance:
      return _getPageRoute(Applianceslist());
    case EditAdmin:
      return _getPageRoute(AdminList());

    case EditEquipments:
      return _getPageRoute(Equipmentslist());
    case AdditionaSettings:
      return _getPageRoute(AdditionalSettings());
    default:
      return _getPageRoute(LoginPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  // return MaterialPageRoute(
  //   builder: (context) => child,
  // );
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
  );
}
