import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryAppliancesModel {
  final String? id;
  final String? name;
  final Timestamp? addedday;
  CategoryAppliancesModel(
      { this.addedday,
       this.id,
       this.name});
}

class CategoryEquipmentModel {
  final String id;
  final String name;
  final Timestamp addedday;
  CategoryEquipmentModel(
      {required this.addedday,
      required this.id,
      required this.name});
}
