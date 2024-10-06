import 'package:cloud_firestore/cloud_firestore.dart';

class FinanceModel {
  String? id;
  String? name;
  String? date;
  String? payment;

  FinanceModel(
      { this.id,
       this.name,
       this.date,
       this.payment});
}
