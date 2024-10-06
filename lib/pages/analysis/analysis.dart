import 'package:SolarExperto/constants/app_colors.dart';
import 'package:SolarExperto/models/equipments/batteriesmodel.dart';
import 'package:SolarExperto/models/equipments/inverter_model.dart';
import 'package:SolarExperto/pages/analysis/systemanalysis/Analysispage/analysispage.dart';
import 'package:SolarExperto/pages/analysis/systemanalysis/Globals/globals.dart';
import 'package:SolarExperto/pages/analysis/systemanalysis/SimulationType/sim_types.dart';
import 'package:SolarExperto/pages/analysis/systemanalysis/appliancescard/smartapplianceadd.dart';
import 'package:SolarExperto/pages/analysis/systemanalysis/equipments/equipment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../provider/app_provider.dart';

class Analysis extends StatefulWidget {
  const Analysis(
      {Key? key, this.onNext, this.batteriesModel, this.inverterModel})
      : super(key: key);
  final Function? onNext;
  final BatteriesModel? batteriesModel;
  final InverterModel? inverterModel;

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> with TickerProviderStateMixin {
  String Userid = '';
  void getuerid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Userid = prefs.getString('id') ?? '';
    });
    print('User: ${Userid}');
  }

  @override
  void initState() {
    getuerid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    print('appProvider.screenindex ${appProvider.screenindex}');
    Widget _getScreen() {
      if (appProvider.screenindex == 0) {
        return SimType();
      } else if (appProvider.screenindex == 1) {
        return Globals(
          appProvider: appProvider,
          userid: Userid,
        );
      } else if (appProvider.screenindex == 2) {
        return SmartAppliancesAdd(
          appProvider: appProvider,
        );
      } else if (appProvider.screenindex == 3) {
        return Equipment(
          appProvider: appProvider,
          Userid: Userid,
        );
      }else if (appProvider.screenindex == 4) {
        return AnalysisPage(
          appProvider: appProvider,
          Userid: Userid,
        );
      }

      else {
        return Globals(
          appProvider: appProvider,
          userid: Userid,
        );
      }
    }

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Scaffold(
        body: _getScreen(),
      ),
    );
  }
}
