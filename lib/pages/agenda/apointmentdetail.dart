import 'package:SolarExperto/constants/app_responsive.dart';
import 'package:SolarExperto/models/appointments/appointmentmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../services/database/database_service.dart';
import '../../utilis/date.dart';
import 'UpdateAppointment.dart';

class ManageAppointmentDetails extends StatefulWidget {
  const ManageAppointmentDetails({Key? key, required this.apointmentsModel})
      : super(key: key);
  final ApointmentsModel apointmentsModel;
  @override
  State<ManageAppointmentDetails> createState() =>
      _ManageAppointmentDetailsState();
}

class _ManageAppointmentDetailsState extends State<ManageAppointmentDetails> {
  final adminform = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.bgColor,
          elevation: 0,
          title: Text(
            widget.apointmentsModel.customername,
          ),
          actions: [
            TextButton.icon(
              icon: Icon(
                Icons.edit,
                color: AppColor.bgSideMenu,
              ),
              style: ElevatedButton.styleFrom(backgroundColor: AppColor.bgColor),
              onPressed: () {
                // Navigator.of(context).pop();
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (dialogContext) {
                      return UpdateAppointment(
                        apointmentsModel: widget.apointmentsModel,
                      );
                    });
                Navigator.of(context).pop();
              },
              label: Text("", style: TextStyle(color: AppColor.bgSideMenu)),
            ),
            TextButton.icon(
              icon: Icon(
                Icons.delete,
                color: AppColor.bgSideMenu,
              ),
              style: TextButton.styleFrom(backgroundColor: AppColor.bgSideMenu),
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
                                                                          .deleteapointment(
                                                                          widget
                                                                              .apointmentsModel
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
                Navigator.of(context).pop();
              },


              label: Text(
                "",
                style: TextStyle(
                  color: AppColor.bgSideMenu,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize:(!AppResponsive.isMobile(context))? 18:12,
                      ),
                    ),
                    Text(
                      ' ${widget.apointmentsModel.customername}',
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize:(!AppResponsive.isMobile(context))? 16:12,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Phone No",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize:(!AppResponsive.isMobile(context))? 18:12,
                      ),
                    ),
                    Text(
                      ' ${widget.apointmentsModel.customerphone}',
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize:(!AppResponsive.isMobile(context))? 16:12,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize:(!AppResponsive.isMobile(context))? 18:12,
                      ),
                    ),
                    Text(
                      ' ${widget.apointmentsModel.customeremail}',
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize:(!AppResponsive.isMobile(context))? 16:12,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Address",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize:(!AppResponsive.isMobile(context))? 18:12,
                      ),
                    ),
                    Text(
                      ' ${widget.apointmentsModel.customeraddress}',
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize:(!AppResponsive.isMobile(context))? 16:12,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Date",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize:(!AppResponsive.isMobile(context))? 18:12,
                      ),
                    ),
                    Text(
                        getFormattedDate(
                            widget.apointmentsModel.date.toDate().toString()),
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize:(!AppResponsive.isMobile(context))? 16:12,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Time From",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize:(!AppResponsive.isMobile(context))? 18:12,
                      ),
                    ),
                    Text(
                      ' ${widget.apointmentsModel.from_time}',
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize:(!AppResponsive.isMobile(context))? 16:12,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Time To",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize:(!AppResponsive.isMobile(context))? 18:12,
                      ),
                    ),
                    Text(
                      ' ${widget.apointmentsModel.to_time}',
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize:(!AppResponsive.isMobile(context))? 16:12,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Details",
                        style: TextStyle(
                          color: AppColor.black.withOpacity(0.5),
                          fontSize:(!AppResponsive.isMobile(context))? 18:12,
                        ),
                      ),
                    ),
                    Text(
                      ' ${widget.apointmentsModel.detail}',
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize:(!AppResponsive.isMobile(context))? 16:12,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
