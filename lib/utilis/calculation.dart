import 'package:SolarExperto/utilis/round-utils.dart';

import '../provider/app_provider.dart';

class Calculation {
  void caltotalamphour(AppProvider appProvider) {
    appProvider.totalamphour =
        appProvider.totalenergy / appProvider.batterybusvoltage;
    appProvider.updatetotalamphour(totalamphour: appProvider.totalamphour);
  }

  void addratedwattage(AppProvider appProvider, int wattage) {
    appProvider.ratedwattage += wattage;
    appProvider.updateratedwattage(ratedwattage: appProvider.ratedwattage);
  }

  void calrequiredbatterycapcity(AppProvider appProvider) {
    appProvider.required_batteryc =
        (appProvider.totalamphour * appProvider.autonomy_in_days) /
            appProvider.battery_dod;

    appProvider.updaterequired_batteryc(
        required_batteryc: appProvider.required_batteryc);
  }

  void subratedwattage(AppProvider appProvider, int wattage) {
    appProvider.ratedwattage -= wattage;
    appProvider.updateratedwattage(ratedwattage: appProvider.ratedwattage);
  }

  void addmaxmimumACpower(AppProvider appProvider, int power) {
    appProvider.maxmimumACpower += power;
    appProvider.updatemaxmimumACpower(
        maxmimumACpower: appProvider.maxmimumACpower);
  }

  void submaxmimumACpower(AppProvider appProvider, int power) {
    appProvider.maxmimumACpower -= power;
    appProvider.updatemaxmimumACpower(
        maxmimumACpower: appProvider.maxmimumACpower);
  }

  void addmaximumDCpower(AppProvider appProvider, double adjustedwattage) {
    appProvider.maxmimudcwattage += adjustedwattage;
    appProvider.updatemaximumdc(maxmimudcwattage: appProvider.adjustedwattage);
  }

  void submaximumDCpower(AppProvider appProvider, double adjustedwattage) {
    appProvider.maxmimudcwattage -= adjustedwattage;
    appProvider.updatemaximumdc(maxmimudcwattage: appProvider.adjustedwattage);
  }

  void subtotalenergy(AppProvider appProvider, int energy) {
    appProvider.totalenergy -= energy;

    appProvider.updatetotalenergy(totalenergy: appProvider.totalenergy);
  }

  void addtotalenergy(AppProvider appProvider, int energy) {
    appProvider.totalenergy += energy;

    appProvider.updatetotalenergy(totalenergy: appProvider.totalenergy);
  }

  void calbattereryparrallel(AppProvider appProvider, num batterycapacity) {
    appProvider.battereryparrallel =
        roundvalue((appProvider.required_batteryc / batterycapacity));
    appProvider.updatebattereryparrallel(
        battereryparrallel: appProvider.battereryparrallel);
  }

  void calbatteryseries(AppProvider appProvider, num voltage) {
    appProvider.batteryseries =
        roundvalue((appProvider.batterybusvoltage / voltage));
    appProvider.updatebatteryseries(batteryseries: appProvider.batteryseries);
  }

  void caltotalbattery(AppProvider appProvider) {
    appProvider.totalbattery =
        appProvider.battereryparrallel * appProvider.batteryseries;
    appProvider.updatetotalbattery(totalbattery: appProvider.totalbattery);
  }

  void calpanelseries(AppProvider appProvider) {
    appProvider.panelseries = roundvalue(
        (appProvider.batterybusvoltage / appProvider.max_power_voltage));
    appProvider.updatepanelseries(panelseries: appProvider.panelseries);
    print('C10 ${appProvider.panelseries}');
  }

  void caltotalpanels(AppProvider appProvider) {
    appProvider.totalpanels =
        appProvider.panelseries * appProvider.panelparrallel;

    appProvider.updatetotalpanels(totalpanels: appProvider.totalpanels);
  }

  void calpanelparrallel(AppProvider appProvider) {
    appProvider.panelparrallel =
        (appProvider.no_of_modules_c9 / appProvider.panelseries).round();
    appProvider.updatepanelparrallel(
        panelparrallel: appProvider.panelparrallel);
    print('C11 ${appProvider.panelparrallel}');
  }

  void callC12(AppProvider appProvider) {
    appProvider.C12 = (appProvider.panelseries * appProvider.panelparrallel).round();
    appProvider.updateC12(C12: appProvider.C12);
    print("G12: ${appProvider.C12}");
    print("G12: ${appProvider.panelseries}");
    print("G12: ${appProvider.panelparrallel}");
  }

  void calrequire_array_panel(AppProvider appProvider) {
    appProvider.require_array_panel =
        appProvider.totalenergy / appProvider.batery_round_trip;
    appProvider.updaterequire_array_panel(
        require_array_panel: appProvider.require_array_panel);
    print('${appProvider.totalenergy} / ${appProvider.batery_round_trip}');
  }

  void calmax_power_voltage(AppProvider appProvider, num V_oc) {
    appProvider.max_power_voltage = V_oc * 0.85;
    appProvider.updatemax_power_voltage(
        max_power_voltage: appProvider.max_power_voltage);
  }

  void calenergy_per_module(AppProvider appProvider, num power_output) {
    appProvider.energy_per_module = power_output * appProvider.peaksunhour;
    appProvider.updateenergy_per_module(
        energy_per_module: appProvider.energy_per_module);
  }

  void calpv_module_energy_output(AppProvider appProvider) {
    appProvider.pv_module_energy_output =
        appProvider.energy_per_module * appProvider.derating_factor;
    appProvider.updatepv_module_energy_output(
        pv_module_energy_output: appProvider.pv_module_energy_output);
  }

  void calG1(AppProvider appProvider) {
    appProvider.G1 = (appProvider.totalenergy / 1000).round();
    appProvider.updateG1(G1: appProvider.G1);
  }

  void calG2(AppProvider appProvider) {
    appProvider.G2 = appProvider.G1 * 30;

    appProvider.updateG2(G2: appProvider.G2);
  }

  void calG3(AppProvider appProvider) {
    appProvider.G3 = appProvider.G2 * 12;

    appProvider.updateG3(G3: appProvider.G3);
  }

  void calG4(AppProvider appProvider) {
    appProvider.G4 = (appProvider.G1 * appProvider.electricityprice).round();
    appProvider.updateG4(G4: appProvider.G4);
  }

  void calG5(AppProvider appProvider) {
    appProvider.G5 = appProvider.G2 * appProvider.electricityprice;
    appProvider.updateG5(G5: appProvider.G5);
  }

  void calG6(AppProvider appProvider) {
    appProvider.G6 = appProvider.G3 * appProvider.electricityprice;
    appProvider.updateG6(G6: appProvider.G6);
  }

  void calG7(AppProvider appProvider) {
    appProvider.G7 = roundvalue((appProvider.pv_module_energy_output*appProvider.C12)/1000);
    appProvider.updateG7(G7: appProvider.G7);
    print("G7: ${appProvider.G7}");
    print("G7: ${appProvider.pv_module_energy_output}");
    print("G7: ${appProvider.C12}");

  }
  void calG8(AppProvider appProvider) {
    appProvider.G8 = appProvider.G7*30;
    appProvider.updateG8(G8: appProvider.G8);

  }
  void calG9(AppProvider appProvider) {
    appProvider.G9 = appProvider.G8*12;
    appProvider.updateG9(G9: appProvider.G9);

  }



  void calno_of_modules_c9(AppProvider appProvider) {
    appProvider.no_of_modules_c9 =
        appProvider.require_array_panel / appProvider.pv_module_energy_output;
    appProvider.updateno_of_modules_c9(
        no_of_modules_c9: appProvider.no_of_modules_c9);
    print('A1 ${appProvider.inverter_efficiency}');
    print('A2 ${appProvider.batterybusvoltage}');
    print('A9 ${appProvider.totalenergy}');
    print('A10 ${appProvider.totalamphour}');
    print('A11 ${appProvider.maxmimumACpower}');
    print('A12 ${appProvider.maxmimudcwattage}');
    print('B1 ${appProvider.autonomy_in_days}');
    print('B2 ${appProvider.battery_dod}');
    print('B3 ${appProvider.required_batteryc}');
    print('B5 ${appProvider.battereryparrallel}');
    print('B6 ${appProvider.batteryseries}');
    print('C1 ${appProvider.totalenergy}');
    print('C2 ${appProvider.batery_round_trip}');
    print('C3 ${appProvider.require_array_panel}');
    print('C4 ${appProvider.max_power_voltage}');
    print('C6 ${appProvider.peaksunhour}');
    print('C7 ${appProvider.energy_per_module}');
    print('C8 ${appProvider.pv_module_energy_output}');
    print('DF ${appProvider.derating_factor}');
    print('C9 ${appProvider.no_of_modules_c9}');
  }
}
