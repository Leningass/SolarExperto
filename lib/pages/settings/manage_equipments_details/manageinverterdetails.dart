import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../models/equipments/inverter_model.dart';
import '../../../screen_widget/systemsettings/equipments/update equiments/updateinverter.dart';
import '../../../services/database/database_service.dart';
import '../../../utilis/UplaodImages.dart';

class ManageInverterDetails extends StatefulWidget {
  const ManageInverterDetails({Key? key, required this.inverter_converterModel})
      : super(key: key);
  final InverterModel inverter_converterModel;

  @override
  State<ManageInverterDetails> createState() => _ManageInverterDetailsState();
}

class _ManageInverterDetailsState extends State<ManageInverterDetails> {
  final adminform = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return
        //(!AppResponsive.isMobile(context))?
        Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            widget.inverter_converterModel.name!,
          ),
          actions: [
            TextButton.icon(
              icon: Icon(
                Icons.edit,
                color: AppColor.bgSideMenu,
              ),
              style: ElevatedButton.styleFrom(primary: AppColor.bgColor),
              onPressed: () {
                // Navigator.of(context).pop();
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (dialogContext) {
                      return UpdateInverter(
                          inverter_converterModel:
                              widget.inverter_converterModel);
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
              style: ElevatedButton.styleFrom(primary: AppColor.bgColor),
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
                                                                      await deleteImage(
                                                                          widget.inverter_converterModel.image!);
                                                                      await DatabaseService()
                                                                          .deleteaccessories(
                                                                          widget
                                                                              .inverter_converterModel
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
                child: Image.asset(
                  "assets/inverter.png",

                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
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
                      "Name",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${widget.inverter_converterModel!.name}',
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 16,
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
                      "Type",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${widget.inverter_converterModel!.type}',
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 16,
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
                      "Quantity",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${NumberFormat("#,###").format(widget.inverter_converterModel.quantity)}',
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 16,
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
                      "Rated Power",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${widget.inverter_converterModel!.ratedpower} W',
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 16,
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
                      "AC Voltage",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${widget.inverter_converterModel!.acvoltage} V',
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 16,
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
                      "Nominal Voltage",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${widget.inverter_converterModel!.nominalvoltage} V',
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 16,
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
                      "Efficiency",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${widget.inverter_converterModel!.efficiency} %',
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 16,
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
                      "Sale Price",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${NumberFormat("#,###").format(widget.inverter_converterModel.sellingprice)} CFA',
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 16,
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
                      "Purchase Price",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${NumberFormat("#,###").format(widget.inverter_converterModel.buyingprice)} CFA',
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
    /* : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'type: ${widget.inverter_converterModel!.invertertype}',
                    style: TextStyle(
                      color: AppColor.black.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'P: ${widget.inverter_converterModel!.inverterpower} W',
                    style: TextStyle(
                      color: AppColor.black.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pmax: ${widget.inverter_converterModel!.inverterpeek_power} kW',
                    style: TextStyle(
                      color: AppColor.black.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'QTY: ${widget.inverter_converterModel!.inverterquantity}',
                    style: TextStyle(
                      color: AppColor.black.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'U: ${widget.inverter_converterModel!.invertervoltage} V',
                    style: TextStyle(
                      color: AppColor.black.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Uo_s: ${widget.inverter_converterModel!.inverteroutputvoltage} V',
                    style: TextStyle(
                      color: AppColor.black.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'E: ${widget.inverter_converterModel!.inverterefficiency} %',
                    style: TextStyle(
                      color: AppColor.black.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'SELL: ${widget.inverter_converterModel!.invertersaleprice} CFA',
                    style: TextStyle(
                      color: AppColor.black.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'BUY: ${widget.inverter_converterModel!.inverterpurchaseprice} CFA',
                    style: TextStyle(
                      color: AppColor.black.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          );*/
  }
}
