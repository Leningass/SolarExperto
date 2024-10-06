import 'package:SolarExperto/models/appointments/appointmentmodel.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_responsive.dart';
import '../../services/database/database_service.dart';
import 'apointmentdetail.dart';

class AppointmentTiles extends StatefulWidget {
   AppointmentTiles({Key? key, required this.apointmentsModel}) : super(key: key);
ApointmentsModel apointmentsModel;

  @override
  State<AppointmentTiles> createState() => _AppointmentTilesState();
}

class _AppointmentTilesState extends State<AppointmentTiles> {
  @override
  Widget build(BuildContext context) {
   /* return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(

        color: AppColor.yellow.withOpacity(0.8),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [


              ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(
                    'assets/images/customer.png',
                    height: (!AppResponsive.isMobile(context)) ? 200 : 100,
                    width: (!AppResponsive.isMobile(context)) ? 200 : 100,
                  )
              )
            ],
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${widget.apointmentsModel.customername}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ((!AppResponsive.isMobile(context)) ? 24 : 14),
                      color: AppColor.bgSideMenu),
                ),
                Text(
                  '${widget.apointmentsModel.customerphone}',
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                      fontSize: ((!AppResponsive.isMobile(context)) ? 24 : 12),
                      color: AppColor.bgSideMenu),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      '${widget.apointmentsModel.from_time} ',
                      style: TextStyle(
                          fontSize: ((!AppResponsive.isMobile(context)) ? 18 : 10),
                          color: AppColor.bgSideMenu),
                    ),
                    Text(
                      '${widget.apointmentsModel.to_time} ',
                      style: TextStyle(
                          fontSize: ((!AppResponsive.isMobile(context)) ? 18 : 10),
                          color: AppColor.bgSideMenu),
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: TextButton(
                      style: TextButton.styleFrom(
                        side:  BorderSide(width: 2, color: AppColor.bgSideMenu),
                      ),
                      onPressed: ()async{
                        await DatabaseService()
                            .deleteapointment(widget.apointmentsModel.id);
                      },
                      child: Text("Delete",style: TextStyle(color: AppColor.bgSideMenu),),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: AppColor.bgSideMenu
                      ),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ManageAppointmentDetails(
                                      apointmentsModel:
                                      widget.apointmentsModel,
                                    )));
                      },
                      child: Text("Details"
                        ,style: TextStyle(color: AppColor.white),),
                    ))
                  ],
                )

              ],
            ),
          ),
        ],
      ),
    );*/
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColor.yellow.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),

      child: ListTile(
        trailing: SizedBox(
          height: MediaQuery.of(context).size.height/2,
          child: Icon(Icons.arrow_forward_ios),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
       mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.apointmentsModel.customername,
              style: TextStyle(
                  fontSize: 16.0,
                  color: AppColor.black,
                  fontWeight: FontWeight.w600),
            ),
            Row(
              children: [
                Text(
                  '${ widget.apointmentsModel.from_time!} '
                      ,
                  style: TextStyle(
                    color: AppColor.black.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
                Text(
                  '  -  ',
                  style: TextStyle(
                    color: AppColor.black.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
                Text(
                  ' ${ widget.apointmentsModel.to_time!}',
                  style: TextStyle(
                    color: AppColor.black.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),

              ],
            )


          ],
        ),
      ),
    );
  }
}
