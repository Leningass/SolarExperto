import 'package:SolarExperto/screen_widget/systemsettings/additionalsettings/updateratiopanel.dart';
import 'package:SolarExperto/services/database/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/constants.dart';
import '../../../models/othersettings/paneliconratio.dart';
import '../../../utilis/UplaodImages.dart';

class PanelRatioTiles extends StatelessWidget {
  const PanelRatioTiles({Key? key, required this.panelIconratioModel})
      : super(key: key);
  final PanelIconratioModel panelIconratioModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: appPadding),
      padding: EdgeInsets.all(10 / 2),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.network(
              panelIconratioModel.icon,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return const CircularProgressIndicator();
              },
              height: 38,
              width: 38,
              fit: BoxFit.cover,
            ),
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
                    '${panelIconratioModel.numberparallel} : ${panelIconratioModel.numberseries}',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: AppColor.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'N: ${panelIconratioModel.total}',
                        style: TextStyle(
                          color: AppColor.black.withOpacity(0.5),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        width: appPadding,
                      ),
                      Text(
                        'NP: ${panelIconratioModel.numberparallel}',
                        style: TextStyle(
                          color: AppColor.black.withOpacity(0.5),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        width: appPadding,
                      ),
                      Text(
                        'NS: ${panelIconratioModel.numberseries}',
                        style: TextStyle(
                          color: AppColor.black.withOpacity(0.5),
                          fontSize: 14,
                        ),
                      ),
                    ],
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
                    return UpdatePanelRatio(
                        panelIconratioModel: panelIconratioModel);
                  });
            } else if (value == 1) {
              await deleteImage(panelIconratioModel.icon);
              await DatabaseService().deleteratiopanels(panelIconratioModel.id);
            }
          }),
        ],
      ),
    );
  }
}
