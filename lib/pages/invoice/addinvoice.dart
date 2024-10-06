import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_responsive.dart';
import '../../global_widgets/Loading/saveloading.dart';
import '../../provider/app_provider.dart';
import '../../services/database/database_service.dart';

class AddInvoices extends StatefulWidget {
  const AddInvoices({Key? key}) : super(key: key);

  @override
  State<AddInvoices> createState() => _AddInvoicesState();
}

class _AddInvoicesState extends State<AddInvoices> {
  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController payment = TextEditingController();
  final form = GlobalKey<FormState>();
  bool isadded = false;





  @override
  Widget build(BuildContext context) {
    String id = UniqueKey().toString();
    final AppProvider appProvider = Provider.of<AppProvider>(context);

    return Center(
        child: AlertDialog(
          title: const Center(
            child: Text("Add Invoice"),
          ),
          content: Container(
            decoration: BoxDecoration(
                color: AppColor.white, borderRadius: BorderRadius.circular(30)),
            width: (!AppResponsive.isMobile(context))
                ? 400
                : MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(children: [
              Form(
                key: form,
                child: ListView(
                  children: [
                    TextFormField(
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter a name ' : null,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: "Name",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xff131e29), width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: name,
                    ),
                    const SizedBox(
                      height: 10,
                    ),



                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter payment ' : null,
                      decoration: InputDecoration(
                        labelText: "Payment",
                        hintText: "Payment",
                        suffixText: String.fromCharCodes(Runes('\u0024')),
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: payment,
                    ),
                    const SizedBox(
                      height: 10,
                    ),


                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          icon:
                          Icon(Icons.close, size: 16, color: AppColor.bgColor),
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          label: Text("Cancel",
                              style: TextStyle(color: AppColor.bgColor)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton.icon(
                          icon: Icon(Icons.add, size: 16, color: AppColor.bgColor),
                          style: ElevatedButton.styleFrom(
                              primary: AppColor.bgSideMenu),
                          onPressed: () async {
                            if (form.currentState!.validate()) {
                              setState(() {
                                isadded = true;
                              });

                              //appProvider.addAppliance(appliance);

                              var date = DateFormat.yMMMEd()
                                  .format(DateTime.now());

                            // await DatabaseService().updateinvoices(
                            //         'invoice#$id',
                            //         name.text.toString(),
                            //         '${date}',
                            //       '${payment.text.toString()}'
                            //     );

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Added!")));
                              Navigator.of(context).pop();
                            }
                          },
                          label: Text(
                            "Add",
                            style:
                            TextStyle(color: AppColor.bgColor, fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    (isadded == true) ? const SaveLoading() : Container(),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
