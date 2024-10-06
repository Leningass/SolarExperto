import 'package:SolarExperto/models/Service%20Fee/servicefeemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_responsive.dart';
import '../../../../global_widgets/Loading/saveloading.dart';
import '../../../../services/database/database_service.dart';

class UpdateServiceFee extends StatefulWidget {
  const UpdateServiceFee({Key? key, required this.serviceFeeModel}) : super(key: key);
final ServiceFeeModel serviceFeeModel;
  @override
  State<UpdateServiceFee> createState() => _UpdateServiceFeeState();
}

class _UpdateServiceFeeState extends State<UpdateServiceFee> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController installation = TextEditingController();
  TextEditingController maintenance = TextEditingController();
  TextEditingController transport = TextEditingController();
  TextEditingController additional = TextEditingController();

  final form = GlobalKey<FormState>();
  bool isadded = false;

  @override
  void initState() {
    name.text=widget.serviceFeeModel.name;
    description.text=widget.serviceFeeModel.description;
    installation.text=widget.serviceFeeModel.installationfee.toString();
    maintenance.text=widget.serviceFeeModel.maintenancefee.toString();
    transport.text=widget.serviceFeeModel.transportfee.toString();
    additional.text=widget.serviceFeeModel.additionalfee.toString();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AlertDialog(
          title: Center(
            child: Text("Update Service Fee"),
          ),
          content: SingleChildScrollView(
            child: Container(
              color: AppColor.white,
              width: (!AppResponsive.isMobile(context))
                  ? 350
                  : MediaQuery.of(context).size.width,
              height: (!AppResponsive.isMobile(context))
                  ? 450
                  : MediaQuery.of(context).size.height,
              child: Form(
                key: form,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) =>
                      val!.isEmpty ? 'Please enter name ' : null,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: "Name",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: name,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      keyboardType: TextInputType.number,

                      validator: (value) =>
                      value!.isEmpty ? 'Please enter description' : null,
                      decoration: InputDecoration(

                        labelText: "Description",
                        hintText: "Description",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: description,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,

                      validator: (value) =>
                      value!.isEmpty ? 'Please enter installation fee' : null,
                      decoration: InputDecoration(
                        suffixText: 'CFA',
                        labelText: "Installation Fee",
                        hintText: "Installation Fee",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: installation,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,

                      validator: (value) =>
                      value!.isEmpty ? 'Please enter maintenance fee' : null,
                      decoration: InputDecoration(
                        suffixText: 'CFA',
                        labelText: "Maintenance Fee",
                        hintText: "Maintenance Fee",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: maintenance,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,

                      validator: (value) =>
                      value!.isEmpty ? 'Please enter transport fee' : null,
                      decoration: InputDecoration(
                        suffixText: 'CFA',
                        labelText: "Transport Fee",
                        hintText: "Transport Fee",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: transport,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,

                      validator: (value) =>
                      value!.isEmpty ? 'Please enter additional fee' : null,
                      decoration: InputDecoration(
                        suffixText: 'CFA',
                        labelText: "Additional Fee",
                        hintText: "Additional Fee",
                        fillColor: AppColor.bgColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber, width: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: additional,
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
                              await DatabaseService().updateservicefee(
                                  widget.serviceFeeModel.id,
                                  name.text.toString(),
                                  description.text.toString(),
                                  double.parse(installation.text.toString()),
                                  double.parse(maintenance.text.toString()),
                                  double.parse(transport.text.toString()),
                                  double.parse(additional.text.toString()),
                                  );

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Updated!")));
                              Navigator.of(context).pop();
                            }
                          },
                          label: Text(
                            "Update",
                            style:
                            TextStyle(color: AppColor.bgColor, fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    (isadded == true) ? const SaveLoading() : Container(),
                  ],
                ),
              ),
            ),
            //child: const AddCategories(),
          ),

        ));
  }
}
