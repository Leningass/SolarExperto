import 'package:SolarExperto/models/city/city.dart';
import 'package:SolarExperto/pages/settings/GlobalSetting/city/citydetail.dart';
import 'package:SolarExperto/screen_widget/systemsettings/additionalsettings/updatecity.dart';
import 'package:SolarExperto/services/database/database_service.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/constants.dart';

class CityTiles extends StatelessWidget {
  const CityTiles({Key? key, required this.cityModel}) : super(key: key);
  final CityModel cityModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.only(top: appPadding),
      padding: EdgeInsets.all(10 / 2),
      child: ListTile(
        onTap: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context)=>CityDetail(cityModel: cityModel)));
        },
        trailing: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Icon(Icons.arrow_forward_ios),
        ),
        title: Row(
          children: [
            TextAvatar(
              size: 38,
              backgroundColor: Colors.white,
              textColor: Colors.white,
              fontSize: 16,
              numberLetters: 1,
              shape: Shape.Rectangle,
              text: cityModel.name,
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    cityModel.name,
                    style: TextStyle(
                        color: AppColor.black, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${cityModel.peaksunhours} hrs',
                        style: TextStyle(
                          color: AppColor.black.withOpacity(0.5),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        width: appPadding,
                      ),
                      Text(
                        '${cityModel.electricity_price} CFA/kWh',
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
            /*Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      cityModel.name,
                      style: TextStyle(
                          color: AppColor.black, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${cityModel.peaksunhours} hrs',
                          style: TextStyle(
                            color: AppColor.black.withOpacity(0.5),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          width: appPadding,
                        ),
                        Text(
                          '${cityModel.electricity_price} CFA/kWh',
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
            ),*/
            /*PopupMenuButton(
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
                      return UpdateCity(cityModel: cityModel);
                    });
              } else if (value == 1) {
                await DatabaseService().deletecities(cityModel.id);
              }
            }),*/
          ],
        ),
      ),
    );
  }
}
