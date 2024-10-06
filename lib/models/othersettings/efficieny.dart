import 'package:cloud_firestore/cloud_firestore.dart';

class EfficiencyModel {
  String id;
  double efficiency;
  final Timestamp addedday;
  EfficiencyModel(
      {required this.id, required this.efficiency, required this.addedday});
}
