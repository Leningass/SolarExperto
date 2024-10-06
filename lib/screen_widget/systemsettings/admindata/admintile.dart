import 'package:SolarExperto/constants/constants.dart';
import 'package:SolarExperto/models/user/user.dart';
import 'package:SolarExperto/services/database/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_responsive.dart';
import 'editadmin.dart';

class AdminTile extends StatefulWidget {
  const AdminTile({Key? key, required this.userModel}) : super(key: key);
  final UserModel userModel;

  @override
  State<AdminTile> createState() => _AdminTileState();
}

class _AdminTileState extends State<AdminTile> {

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  ))
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
                  '${widget.userModel.name}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ((!AppResponsive.isMobile(context)) ? 24 : 14),
                      color: AppColor.bgSideMenu),
                ),
                Text(
                  '${widget.userModel.email}',
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: ((!AppResponsive.isMobile(context)) ? 18 : 10),
                      color: AppColor.bgSideMenu),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextButton(
                          style: TextButton.styleFrom(
                            side:
                                BorderSide(width: 2, color: AppColor.bgSideMenu),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (dialogContext) {
                                  return EditAdmins(userModel: widget.userModel);
                                });
                          },
                          child: Text("Edit",style: TextStyle(color: AppColor.bgSideMenu),)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: AppColor.bgSideMenu),
                      onPressed: ()async {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                            title: Text("Are you sure you want to delete this"),

                            actions: <Widget>[

                              CupertinoDialogAction(
                                child: Text("No",style: TextStyle(color: AppColor.bgSideMenu),),
                                onPressed: () => Navigator.of(context).pop(false),
                              ),
                              CupertinoDialogAction(
                                  child: Text("Yes",style: TextStyle(color: AppColor.bgSideMenu),),
                                  onPressed: ()async {
                                    if(mounted){
                                      setState(() {
                                        Navigator.of(context).pop(true);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("Deleted!")));
                                         DatabaseService()
                                            .deleteadmin(widget
                                            .userModel.id);
                                      });
                                    }

                                    // Navigator.pushReplacement(context,
                                    //     MaterialPageRoute(builder: (context) {
                                    //       return ServiceFee();
                                    //     }));
                                  }
                              ),
                            ],
                          ),
                        );
                        Navigator.of(context).pop();



                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(color: AppColor.white),
                      ),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
