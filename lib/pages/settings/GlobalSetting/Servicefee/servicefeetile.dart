import 'package:SolarExperto/models/Service%20Fee/servicefeemodel.dart';
import 'package:SolarExperto/pages/settings/GlobalSetting/Servicefee/servicefeedetail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/constants.dart';


class ServiceFeeTile extends StatefulWidget {
  const ServiceFeeTile({Key? key, required this.serviceFeeModel}) : super(key: key);
final ServiceFeeModel serviceFeeModel;
  @override
  State<ServiceFeeTile> createState() => _ServiceFeeTileState();
}

class _ServiceFeeTileState extends State<ServiceFeeTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.yellow.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.only(top: appPadding),
      padding: EdgeInsets.all(10 / 2),
      child: ListTile(
        onTap: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context)=>ServiceFeeDetail(serviceFeeModel: widget.serviceFeeModel)));
        },
        trailing: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Icon(Icons.arrow_forward_ios),
        ),
        title: Row(
          children: [

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
                    widget.serviceFeeModel.name,
                    style: TextStyle(
                        color: AppColor.black, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${NumberFormat("#,###").format(widget.serviceFeeModel.installationfee)} CFA',
                        style: TextStyle(
                          color: AppColor.black.withOpacity(0.5),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        width: appPadding,
                      ),
                      Text(
                        '${NumberFormat("#,###").format(widget.serviceFeeModel.maintenancefee)} CFA',
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
