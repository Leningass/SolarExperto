import 'package:SolarExperto/models/customers/customermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_responsive.dart';
import '../../services/database/database_service.dart';
import 'customerdetail.dart';

class CustomerTiles extends StatefulWidget {
  const CustomerTiles({Key? key, required this.customerModel}) : super(key: key);
final CustomerModel customerModel;
  @override
  State<CustomerTiles> createState() => _CustomerTilesState();
}

class _CustomerTilesState extends State<CustomerTiles> {
  final adminform = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  bool _obscureText = true;

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
                  '${widget.customerModel.name}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ((!AppResponsive.isMobile(context)) ? 24 : 14),
                      color: AppColor.bgSideMenu),
                ),
                Text(
                  '${widget.customerModel.phone}',
                  style: TextStyle(
                     // fontWeight: FontWeight.bold,
                      fontSize: ((!AppResponsive.isMobile(context)) ? 18 : 12),
                      color: AppColor.bgSideMenu),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${widget.customerModel.email} ',
                  style: TextStyle(
                      fontSize: ((!AppResponsive.isMobile(context)) ? 12 : 10),
                      color: AppColor.bgSideMenu),
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
                      onPressed: () async {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                            title: Text("Are you sure you want to delete this"),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: Text(
                                  "No",
                                  style: TextStyle(color: AppColor.bgSideMenu),
                                ),
                                onPressed: () => Navigator.of(context).pop(false),
                              ),
                              CupertinoDialogAction(
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(color: AppColor.bgSideMenu),
                                  ),
                                  onPressed: () async {
                                     Navigator.of(context).pop();
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (dialogContext) {
                                          return StatefulBuilder(
                                              builder: (dialogContext, setState) {
                                                return AlertDialog(
                                                  title: const Center(
                                                    child: Text("Passcode"),
                                                  ),
                                                  content: Form(
                                                      key: adminform,
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          TextFormField(
                                                            obscureText: _obscureText,
                                                            decoration: InputDecoration(
                                                              hintText: "Enter passcode",
                                                              border: OutlineInputBorder(),
                                                              suffixIcon: IconButton(
                                                                color: Colors.grey,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    _obscureText =
                                                                    !_obscureText;
                                                                  });
                                                                },
                                                                icon: Icon(
                                                                  _obscureText
                                                                      ? Icons.visibility
                                                                      : Icons
                                                                      .visibility_off,
                                                                ),
                                                              ),
                                                            ),
                                                            controller: controller,
                                                            validator: (value) {
                                                              if (controller.text != null) {
                                                                if (value!.isEmpty) {
                                                                  return 'Please enter passcode';
                                                                }
                                                              }
                                                            },
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                            children: [
                                                              ElevatedButton(
                                                                  onPressed: () {
                                                                    Navigator.of(
                                                                        dialogContext)
                                                                        .pop();
                                                                    controller.clear();
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                      backgroundColor:
                                                                      Colors.red),
                                                                  child: Text(
                                                                    "Cancel",
                                                                    style: TextStyle(
                                                                        color:
                                                                        AppColor.white),
                                                                  )),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              ElevatedButton(
                                                                  onPressed: () {
                                                                    if (!adminform
                                                                        .currentState!
                                                                        .validate()) {
                                                                    } else {
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                          'passcode')
                                                                          .doc(
                                                                          'rKSpvQYw1CLpCekmqnFo')
                                                                          .get()
                                                                          .then(
                                                                              (DocumentSnapshot) async {
                                                                            if (controller.value
                                                                                .text ==
                                                                                DocumentSnapshot[
                                                                                'passcode']) {
                                                                              Navigator.of(
                                                                                  dialogContext)
                                                                                  .pop(true);
                                                                              ScaffoldMessenger.of(
                                                                                  dialogContext)
                                                                                  .showSnackBar(
                                                                                  SnackBar(
                                                                                      content:
                                                                                      Text("Deleted!")));

                                                                              await DatabaseService()
                                                                                  .deletecustomer(
                                                                                  widget
                                                                                      .customerModel
                                                                                      .id);
                                                                              controller
                                                                                  .clear();

                                                                              Navigator.of(
                                                                                  dialogContext)
                                                                                  .pop();
                                                                            } else {
                                                                              ScaffoldMessenger.of(
                                                                                  dialogContext)
                                                                                  .showSnackBar(
                                                                                  SnackBar(
                                                                                      content:
                                                                                      Text("Just super admin can delete this!")));
                                                                              Navigator.of(
                                                                                  dialogContext)
                                                                                  .pop();
                                                                              controller
                                                                                  .clear();
                                                                            }

                                                                            controller.clear();
                                                                          });
                                                                    }
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                      backgroundColor:
                                                                      AppColor
                                                                          .bgSideMenu),
                                                                  child: Text(
                                                                    "Delete",
                                                                    style: TextStyle(
                                                                        color:
                                                                        AppColor.white),
                                                                  )),
                                                            ],
                                                          )
                                                        ],
                                                      )),
                                                );
                                              });
                                        });

                                    // Navigator.pushReplacement(context,
                                    //     MaterialPageRoute(builder: (context) {
                                    //       return ServiceFee();
                                    //     }));
                                  }),
                            ],
                          ),
                        );

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
                                    CustomerDetails(
                                      customerModel:
                                      widget.customerModel,
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
    );
  }
}
