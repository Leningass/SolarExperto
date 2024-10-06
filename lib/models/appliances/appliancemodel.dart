import 'package:cloud_firestore/cloud_firestore.dart';

class ApplianceModel {
  final String id;
  final String name;
  String categoryid;
  dynamic type;
  dynamic ratedwattage;
  dynamic timeofusage;
  int quatity;
  dynamic image;
  Timestamp? addedday;
  ApplianceModel(
      {required this.id,
      required this.name,
      required this.type,
      required this.categoryid,
      required this.ratedwattage,
      required this.timeofusage,
      required this.quatity,
      required this.image,
      this.addedday});
}
