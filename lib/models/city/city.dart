import 'package:cloud_firestore/cloud_firestore.dart';

class CityModel {
  String id;
  String name;
  double peaksunhours;
  int electricity_price;
  int inverterac_voltage;
  final Timestamp addedday;
  CityModel(
      {required this.id,
      required this.name,
      required this.peaksunhours,
      required this.electricity_price,
        required this.inverterac_voltage,
      required this.addedday});
}
