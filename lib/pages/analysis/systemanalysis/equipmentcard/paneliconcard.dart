import 'package:SolarExperto/models/othersettings/paneliconratio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PanelIconCard extends StatelessWidget {
  const PanelIconCard({Key? key, required this.panelIconratioModel})
      : super(key: key);
  final PanelIconratioModel panelIconratioModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Image.network(
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
