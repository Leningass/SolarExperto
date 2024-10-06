import 'package:cloud_firestore/cloud_firestore.dart';

class ApointmentsModel {
  final String id;
  final Timestamp date;
  final String from_time;
  final String to_time;
  final String customername;
  final String customerphone;
  final String customeraddress;
  final String customeremail;
  final String? detail;
  ApointmentsModel(
      {required this.id,
      required this.date,
      required this.from_time,
      required this.to_time,
      required this.customername,
      required this.customerphone,
      required this.customeraddress,
        required this.customeremail,
      this.detail});
}
