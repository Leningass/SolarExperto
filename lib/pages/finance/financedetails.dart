import 'package:SolarExperto/models/finance/financemodel.dart';
import 'package:SolarExperto/pages/finance/updatefinance.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../services/database/database_service.dart';

class FinanceDetails extends StatefulWidget {
  const FinanceDetails({Key? key, required this.financeModel}) : super(key: key);
final FinanceModel financeModel;
  @override
  State<FinanceDetails> createState() => _FinanceDetailsState();
}

class _FinanceDetailsState extends State<FinanceDetails> {
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
            widget.financeModel.name!,
          ),
          actions: [
            TextButton.icon(
              icon: Icon(Icons.edit,color: AppColor.bgSideMenu,),
              style: ElevatedButton.styleFrom(
                  primary: AppColor.bgColor),
              onPressed: () {
                // Navigator.of(context).pop();
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (dialogContext) {
                      return UpdateFinance(
                         financeModel: widget.financeModel, );
                    });
              },
              label: Text("",
                  style: TextStyle(color: AppColor.bgSideMenu)),
            ),
            TextButton.icon(
              icon: Icon(Icons.delete,color: AppColor.bgSideMenu,),
              style:
              TextButton.styleFrom(primary: AppColor.bgSideMenu),
              onPressed: () async {
                //  await deleteImage(widget.applianceModel.image!);
                await DatabaseService()
                    .deletefinance(widget.financeModel.id);

              },
              label: Text(
                "",
                style: TextStyle(color: AppColor.bgSideMenu, ),
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
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${widget.financeModel.name}',
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
                      "Date",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${widget.financeModel.date}',
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
                      "Payment",
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' ${widget.financeModel.payment} ${String.fromCharCodes(Runes('\u0024'))}',
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

            ],
          ),
        ),
      ),
    );
  }
}
