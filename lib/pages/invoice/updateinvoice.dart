// import 'package:SolarExperto/models/invoices/invoicemodel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
//
// import '../../constants/app_colors.dart';
// import '../../constants/app_responsive.dart';
// import '../../global_widgets/Loading/saveloading.dart';
// import '../../services/database/database_service.dart';
//
// class UpdateInvoice extends StatefulWidget {
//    UpdateInvoice({Key? key, required this.invoiceModel}) : super(key: key);
// final InvoiceModel invoiceModel;
//   @override
//   State<UpdateInvoice> createState() => _UpdateInvoiceState();
// }
//
// class _UpdateInvoiceState extends State<UpdateInvoice> {
//   TextEditingController name = TextEditingController();
//   TextEditingController date = TextEditingController();
//   TextEditingController payment = TextEditingController();
//   final form = GlobalKey<FormState>();
//   bool isadded = false;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     name.text=widget.invoiceModel.name;
//     payment.text=widget.invoiceModel.payment;
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     return Center(
//         child: AlertDialog(
//           title: const Center(
//             child: Text("Update Sale"),
//           ),
//           content: Container(
//             decoration: BoxDecoration(
//                 color: AppColor.white, borderRadius: BorderRadius.circular(30)),
//             width: (!AppResponsive.isMobile(context))
//                 ? 400
//                 : MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             child: Stack(children: [
//               Form(
//                 key: form,
//                 child: ListView(
//                   children: [
//                     TextFormField(
//                       validator: (value) =>
//                       value!.isEmpty ? 'Please enter a name ' : null,
//                       decoration: InputDecoration(
//                         labelText: 'Name',
//                         hintText: "Name",
//                         fillColor: AppColor.bgColor,
//                         filled: true,
//                         border: const OutlineInputBorder(
//                           borderSide:
//                           BorderSide(color: Color(0xff131e29), width: 0.8),
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         ),
//                       ),
//                       controller: name,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//
//
//
//                     TextFormField(
//                       keyboardType: TextInputType.number,
//                       inputFormatters: <TextInputFormatter>[
//                         FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//                         FilteringTextInputFormatter.digitsOnly
//                       ],
//                       validator: (value) =>
//                       value!.isEmpty ? 'Please enter payment ' : null,
//                       decoration: InputDecoration(
//                         labelText: "Payment",
//                         hintText: "Payment",
//                         suffixText: String.fromCharCodes(Runes('\u0024')),
//                         fillColor: AppColor.bgColor,
//                         filled: true,
//                         border: const OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.amber, width: 0.8),
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         ),
//                       ),
//                       controller: payment,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//
//
//                     SizedBox(
//                       height: 16,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ElevatedButton.icon(
//                           icon:
//                           Icon(Icons.close, size: 16, color: AppColor.bgColor),
//                           style: ElevatedButton.styleFrom(primary: Colors.red),
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           label: Text("Cancel",
//                               style: TextStyle(color: AppColor.bgColor)),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         ElevatedButton.icon(
//                           icon: Icon(Icons.add, size: 16, color: AppColor.bgColor),
//                           style: ElevatedButton.styleFrom(
//                               primary: AppColor.bgSideMenu),
//                           onPressed: () async {
//                             if (form.currentState!.validate()) {
//                               setState(() {
//                                 isadded = true;
//                               });
//
//
//                               var date = DateFormat.yMMMEd()
//                                   .format(DateTime.now());
//
//                               // await DatabaseService().updateinvoices(
//                               //     widget.invoiceModel.id,
//                               //     name.text.toString(),
//                               //     '${date}',
//                               //     '${payment.text.toString()}'
//                               // );
//
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(content: Text("Updated!")));
//                               Navigator.of(context).pop();
//                             }
//                           },
//                           label: Text(
//                             "Update",
//                             style:
//                             TextStyle(color: AppColor.bgColor, fontSize: 16.0),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 5.0,
//                     ),
//                     (isadded == true) ? const SaveLoading() : Container(),
//                   ],
//                 ),
//               ),
//             ]),
//           ),
//         ));
// }}
