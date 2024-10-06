import 'package:SolarExperto/screen_widget/systemsettings/additionalsettings/updateefficieny.dart';
import 'package:SolarExperto/services/database/database_service.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/constants.dart';
import '../../../models/othersettings/efficieny.dart';

class EfficienyTiles extends StatelessWidget {
  const EfficienyTiles({Key? key, required this.efficiencyModel})
      : super(key: key);
  final EfficiencyModel efficiencyModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: appPadding),
      padding: EdgeInsets.all(10 / 2),
      child: Row(
        children: [
          TextAvatar(
            size: 38,
            backgroundColor: Colors.white,
            textColor: Colors.white,
            fontSize: 16,
            numberLetters: 1,
            shape: Shape.Rectangle,
            text: 'E',
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${efficiencyModel.efficiency}',
                    style: TextStyle(
                        color: AppColor.black, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    DateFormat().format(DateTime.parse(
                        efficiencyModel.addedday.toDate().toString())),
                    style: TextStyle(
                      color: AppColor.black.withOpacity(0.5),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
              itemBuilder: (context) {
            return [
              PopupMenuItem<int>(
                value: 0,
                child: Text("Update"),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text("Delete"),
              ),
            ];
          }, onSelected: (value) async {
            if (value == 0) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (dialogContext) {
                    return UpdateEfficiency(efficiencyModel: efficiencyModel);
                  });
            } else if (value == 1) {
              await DatabaseService().deleteefficiencies(efficiencyModel.id);
            }
          }),
        ],
      ),
    );
  }
}
