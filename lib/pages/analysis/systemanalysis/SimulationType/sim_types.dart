import 'package:SolarExperto/global_widgets/header/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/size_config.dart';
import '../../../../navbar/tab_item.dart';
import '../../../../navbar/tab_option.dart';
import '../../../../provider/app_provider.dart';
import '../../../header/header.dart';
import '../Globals/globals.dart';

class SimType extends StatefulWidget {
  SimType({Key? key, this.onNext}) : super(key: key);
  final Function? onNext;

  @override
  State<SimType> createState() => _SimTypeState();
}

class _SimTypeState extends State<SimType> {
  int tabIndex = 0;
  int optionIndex = 0;

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    SizeConfig().init(context);

    return ListView(
    children: [
      HeaderWidget(Routname: "Anaylsis"),
      Header(
        text: 'Simulation Type',
        backDisabled: true,
        forwardDisabled: false,
        onNavigate: (int index){
          appProvider.screenindex=appProvider.screenindex+index;
          appProvider.incrementScreen(appProvider.screenindex);
         // Navigator.push(context, MaterialPageRoute(builder: (context)=>Globals()));
        },
      ),
      Container(
        margin: EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TabItem(
              active: tabIndex == 0,
              text: 'Home',
              onClick: () {
                setState(() {
                  tabIndex = 0;
                });
              },
            ),
            TabItem(
              active: tabIndex == 1,
              text: 'Pumping',
              onClick: () {
                setState(() {
                  tabIndex = 1;
                });
              },
            ),
          ],
        ),
      ),
      TabOption(
        type: tabIndex == 0 ? 'home' : 'pumping',
        activeIndex: optionIndex,
        onSelect: (index) {
          setState(() {
            optionIndex = index;
          });
        },
      ),
    ],
    );

  }
}
