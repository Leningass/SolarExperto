import 'package:SolarExperto/models/othersettings/batteryiconratio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

class BatteryIcon extends StatelessWidget {
  const BatteryIcon({Key? key, required this.batteryIconratioModel})
      : super(key: key);
  final BatteryIconratioModel batteryIconratioModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Image.network(
          batteryIconratioModel.icon,
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
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return const CircularProgressIndicator();
          },
          height: 200,
          width: 200,
          fit: BoxFit.cover,
          //fit: BoxFit.cover,
        ),
        onPressed: () {},
      ),
    );
  }
}
