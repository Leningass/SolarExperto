import 'package:SolarExperto/constants/enumerators.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  DisplayedPage? currentPage;
  int maxmimumACpower = 0;
  int ratedwattage = 0;
  double maxmimuacwattage = 0.0;
  double maxmimudcwattage = 0.0;
  double irradiation_value = 0.0;
  int household = 0;
  int energy_cost = 0;
  int screenindex = 0;
  int totalenergy = 0;
  int PC = 0;
  int autonomy_in_days = 0;
  double controller_safety = 0;
  double inverter_efficiency = 0;
  double battery_dod = 0.0;
  double batery_round_trip = 0;
  double derating_factor = 0;
  double system_life = 0;
  int batterycapacity = 0;
  int batteryseries = 0;
  int battereryparrallel = 0;
  int totalbattery = 0;
  int tabindex = 0;
  double panelno_load_voltage = 0.0;
  int controllervoltage = 0;
  int panelseries = 0;
  int panelparrallel = 0;
  int totalpanels = 0;
  int panelpower = 0;
  bool changevalue = false;
  double appliancetypevalue = 0.0;

  //.........

  double load_expansion = 0.0;
  double efficiency = 0.0;
  double wire_loss_factor = 0.0;
  double battery_efficiency = 0.0;
  double aging_factor = 0.0;
  double depth_of_discharge = 0.0;
  double panel_efficiency = 0.0;
  double controller_current_factor = 0.0;
  double controller_power_factor = 0.0;
  double power_factor = 0.0;
  double load_factor = 0.0;
  int size_inverter = 0;
  int inverterac_voltage = 0;
  double adjustedwattage = 0.0;
  String? type;
  double batterybusvoltage = 0.0;
  double totalamphour = 0.0;
  double required_batteryc = 0.0;
  num peaksunhour = 0;
  num require_array_panel = 0.0;
  num max_power_voltage = 0.0;
  num energy_per_module = 0.0;
  num pv_module_energy_output = 0.0;
  num no_of_modules_c9 = 0.0;
  num panelshort_circuit_current = 0.0;
  num G1 = 0.0;
  num G2 = 0.0;
  num G3 = 0.0;
  num G4 = 0.0;
  num G5 = 0.0;
  num G6 = 0.0;
  num G7 = 0.0;
  num G8 = 0.0;
  num G9 = 0.0;
  num G13 = 0;
  num G14 = 0.0;
  num G15 = 0.0;
  num G16 = 0.0;
  num G17 = 0.0;
  num G18 = 0.0;
  num G19 = 0.0;
  num G20 = 0.0;
  num G21 = 0.0;
  num G22 = 0.0;
  num G23 = 0.0;
  num G24 = 0.0;
  num G25 = 0.0;
  num G26 = 0.0;
  num C10 = 0.0;
  num C11 = 0.0;
  num C12 = 0;
  num electricityprice = 0.0;
  num install = 0.0;
  num maintain = 0.0;
  num additional = 0.0;
  num transport = 0.0;
  num batterytotal = 0.0;
  num batteryprice = 0.0;
  num batteryquantity = 0.0;
  num paneltotal = 0.0;
  num panelprice = 0.0;
  num controllertotal = 0.0;
  num invertertotal = 0.0;
  num accessoriestotal = 0.0;

  AppProvider.init() {
    changeCurrentPage(DisplayedPage.HOME);
    updatetabindex(index: 0);
  }
  void updatebatterytotal({required num batterytotal}) {
    batterytotal = batterytotal;
    notifyListeners();
  }
  void updatepaneltotal({required num paneltotal}) {
    paneltotal = paneltotal;
    notifyListeners();
  }
  void updatecontrollertotal({required num controllertotal}) {
    controllertotal = controllertotal;
    notifyListeners();
  }
  void updateinvertertotal({required num invertertotal}) {
    invertertotal = invertertotal;
    notifyListeners();
  }
  void updateaccessoriestotal({required num accessoriestotal}) {
    accessoriestotal = accessoriestotal;
    notifyListeners();
  }
  void updateinstall({required num install}) {
    install = install;
    notifyListeners();
  }
  void updatemaintain({required num maintain}) {
    maintain = maintain;
    notifyListeners();
  }
  void updateadditional({required num additional}) {
    additional = additional;
    notifyListeners();
  }
  void updatetransport({required num transport}) {
    transport = transport;
    notifyListeners();
  }
  void updateC10({required num C10}) {
    C10 = C10;
    notifyListeners();
  }

  void updateC11({required num C11}) {
    C11 = C11;
    notifyListeners();
  }

  void updateC12({required num C12}) {
    C12 = C12;
    notifyListeners();
  }

  void updateG1({required num G1}) {
    G1 = G1;
    notifyListeners();
  }

  void updateelectricityprice({required num electricityprice}) {
    electricityprice = electricityprice;
    notifyListeners();
  }

  void updateG2({required num G2}) {
    G2 = G2;
    notifyListeners();
  }

  void updateG3({required num G3}) {
    G3 = G3;
    notifyListeners();
  }

  void updateG4({required num G4}) {
    G4 = G4;
    notifyListeners();
  }

  void updateG5({required num G5}) {
    G5 = G5;
    notifyListeners();
  }

  void updateG6({required num G6}) {
    G6 = G6;
    notifyListeners();
  }

  void updateG7({required num G7}) {
    G7 = G7;
    notifyListeners();
  }

  void updateG8({required num G8}) {
    G8 = G8;
    notifyListeners();
  }

  void updateG9({required num G9}) {
    G9 = G9;
    notifyListeners();
  }

  void updateG13({required num G13}) {
    G13 = G13;
    notifyListeners();
  }

  void updateG14({required num G14}) {
    G14 = G14;
    notifyListeners();
  }

  void updateG15({required num G15}) {
    G15 = G15;
    notifyListeners();
  }

  void updateG16({required num G16}) {
    G16 = G16;
    notifyListeners();
  }

  void updateG17({required num G17}) {
    G17 = G17;
    notifyListeners();
  }
  void updateG18({required num G18}) {
    G18 = G18;
    notifyListeners();
  }
  void updateG19({required num G19}) {
    G19 = G19;
    notifyListeners();
  }
  void updateratedwattage({required int ratedwattage}) {
    ratedwattage = ratedwattage;
    notifyListeners();
  }

  void updatepanelshort_circuit_current(
      {required num panelshort_circuit_current}) {
    panelshort_circuit_current = panelshort_circuit_current;
    notifyListeners();
  }

  void updaterequire_array_panel({required num require_array_panel}) {
    require_array_panel = require_array_panel;
    notifyListeners();
  }

  void updateenergy_per_module({required num energy_per_module}) {
    energy_per_module = energy_per_module;
    notifyListeners();
  }

  void updateno_of_modules_c9({required num no_of_modules_c9}) {
    no_of_modules_c9 = no_of_modules_c9;
    notifyListeners();
  }

  void updatepv_module_energy_output({required num pv_module_energy_output}) {
    pv_module_energy_output = pv_module_energy_output;
    notifyListeners();
  }

  void updatemax_power_voltage({required num max_power_voltage}) {
    max_power_voltage = max_power_voltage;
    notifyListeners();
  }

  void updatepeaksunhour({required num peaksunhour}) {
    peaksunhour = peaksunhour;
    notifyListeners();
  }

  void updaterequired_batteryc({required double required_batteryc}) {
    required_batteryc = required_batteryc;
    notifyListeners();
  }

  void updatetotalamphour({required double totalamphour}) {
    totalamphour = totalamphour;
    notifyListeners();
  }

  void updatebatterybusvoltage({required double batterybusvoltage}) {
    batterybusvoltage = batterybusvoltage;
    notifyListeners();
  }

  void updatesize_inverter({required int size_inverter}) {
    size_inverter = size_inverter;
    notifyListeners();
  }

  void incrementScreen(int index) {
    screenindex = index;
    notifyListeners();
  }

  void updateload_expansion({required double load_expansion}) {
    load_expansion = load_expansion;
    notifyListeners();
  }

  void updatewire_loss_factor({required double wire_loss_factor}) {
    wire_loss_factor = wire_loss_factor;
    notifyListeners();
  }

  void updatebattery_efficiency({required double battery_efficiency}) {
    battery_efficiency = battery_efficiency;
    notifyListeners();
  }

  void updateaging_factor({required double aging_factor}) {
    aging_factor = aging_factor;
    notifyListeners();
  }

  void updatedepth_of_discharge({required double depth_of_discharge}) {
    depth_of_discharge = depth_of_discharge;
    notifyListeners();
  }

  void updatepanel_efficiency({required double panel_efficiency}) {
    panel_efficiency = panel_efficiency;
    notifyListeners();
  }

  void updatecontroller_current_factor(
      {required double controller_current_factor}) {
    controller_current_factor = controller_current_factor;
    notifyListeners();
  }

  void updatecontroller_power_factor({required controller_power_factor}) {
    controller_power_factor = controller_power_factor;
    notifyListeners();
  }

  void updatepower_factor({required double power_factor}) {
    power_factor = power_factor;
    notifyListeners();
  }

  void updateload_factor({required double load_factor}) {
    load_factor = load_factor;
    notifyListeners();
  }

  void updatetabindex({required int index}) {
    tabindex = index;
    notifyListeners();
  }

  void updatemaxmimumACpower({required int maxmimumACpower}) {
    maxmimumACpower = maxmimumACpower;
    notifyListeners();
  }

  void updatemaximumac({required double maxmimuacwattage}) {
    maxmimuacwattage = maxmimuacwattage;
    notifyListeners();
  }

  void updatemaximumdc({required double maxmimudcwattage}) {
    maxmimudcwattage = maxmimudcwattage;
    notifyListeners();
  }

  void updateadjusted({required double adjustedwattage}) {
    adjustedwattage = adjustedwattage;
    notifyListeners();
  }

  void updateEC({required int EC}) {
    EC = EC;
    notifyListeners();
  }

  void updateirradiation_value({required double irradiation_value}) {
    irradiation_value = irradiation_value;
    notifyListeners();
  }

  void updatehousehold({required int household}) {
    household = household;
    notifyListeners();
  }

  void updateenergy_cost({required int energy_cost}) {
    energy_cost = energy_cost;
    notifyListeners();
  }

  void updateefficiency({required double efficiency}) {
    efficiency = efficiency;
    notifyListeners();
  }

  void updatetotalenergy({required int totalenergy}) {
    totalenergy = totalenergy;
    notifyListeners();
  }

  void updatePC({required int PC}) {
    PC = PC;
    notifyListeners();
  }

  void updateinverteracvoltage({required int inverterac_voltage}) {
    inverterac_voltage = inverterac_voltage;
    notifyListeners();
  }

  void updateautonomy_in_days({required dynamic autonomy_in_days}) {
    autonomy_in_days = autonomy_in_days;
    notifyListeners();
  }

  void updatecontrollersafety({required dynamic controller_safety}) {
    controller_safety = controller_safety;
    notifyListeners();
  }

  void updateinverterefficeiency({required dynamic inverter_efficiency}) {
    inverter_efficiency = inverter_efficiency;
    notifyListeners();
  }

  void updatebatterydod({required dynamic battery_dod}) {
    battery_dod = battery_dod;
    notifyListeners();
  }

  void updatebatteryroundtrip({required dynamic batery_round_trip}) {
    batery_round_trip = batery_round_trip;
    notifyListeners();
  }

  void updatederatingfactor({required dynamic derating_factor}) {
    derating_factor = derating_factor;
    notifyListeners();
  }

  void updatesystemlife({required dynamic system_life}) {
    system_life = system_life;
    notifyListeners();
  }

  void updatebatterycapacity({required int batterycapacity}) {
    batterycapacity = batterycapacity;
    notifyListeners();
  }

  void updatebatteryseries({required int batteryseries}) {
    batteryseries = batteryseries;
    notifyListeners();
  }

  void updatebattereryparrallel({required int battereryparrallel}) {
    battereryparrallel = battereryparrallel;
    notifyListeners();
  }

  void updatetotalbattery({required int totalbattery}) {
    totalbattery = totalbattery;
    notifyListeners();
  }

  void updatecontrollervoltage({required int controllervoltage}) {
    controllervoltage = controllervoltage;
    notifyListeners();
  }

  void updatepanelseries({required int panelseries}) {
    panelseries = panelseries;
    notifyListeners();
  }

  void updatepanelparrallel({required int panelparrallel}) {
    panelparrallel = panelparrallel;
    notifyListeners();
  }

  void updatetotalpanels({required totalpanels}) {
    totalpanels = totalpanels;
    notifyListeners();
  }

  void updatepanelpower({required panelpower}) {
    panelpower = panelpower;
    notifyListeners();
  }

  void updatepanelno_load_voltage({required panelno_load_voltage}) {
    panelno_load_voltage = panelno_load_voltage;
    notifyListeners();
  }

  void updatechangevalue({required changevalue}) {
    changevalue = changevalue;
    notifyListeners();
  }

  void changeCurrentPage(DisplayedPage newPage) {
    currentPage = newPage;
    notifyListeners();
  }
}

