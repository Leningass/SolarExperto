import 'package:SolarExperto/models/customers/customermodel.dart';
import 'package:SolarExperto/screen_widget/systemsettings/customerdata/updatecustomer.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_responsive.dart';
import '../../services/database/database_service.dart';
import '../../utilis/date.dart';

class CustomerDetails extends StatefulWidget {
  const CustomerDetails({Key? key, required this.customerModel})
      : super(key: key);
  final CustomerModel customerModel;

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
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
            widget.customerModel.name!,
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
                      return UpdateCustomers(
                        customerModel: widget.customerModel,
                      );
                    });
                Navigator.of(context).pop();
              },
              label: Text("", style: TextStyle(color: AppColor.bgSideMenu)),
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
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${widget.customerModel.name}',
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
                      "Phone No",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${widget.customerModel.phone}',
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
                      "Address",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      width: (!AppResponsive.isMobile(context))?MediaQuery.of(context).size.width/4.5:100,
                      child: Text(
                        ' ${widget.customerModel.address}',
                        style: TextStyle(
                          color: AppColor.black.withOpacity(0.5),
                          fontSize: 16,
                        ),
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
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      getFormattedDate(
                          widget.customerModel.addedday.toDate().toString()),
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
                      "Email",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      width: (!AppResponsive.isMobile(context))?MediaQuery.of(context).size.width/3.3:100,
                      child: Text(
                        ' ${widget.customerModel.email}',
                        style: TextStyle(
                          color: AppColor.black.withOpacity(0.5),
                          fontSize: 16,
                        ),
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
