import 'package:cloud_firestore/cloud_firestore.dart';

class ChargeControllerModel {
  final String? userid;
  final String? id;
  final String? name;
  final String? type;
  final num? ratedVoltage;
  final num? quantity;
  final num? current;
  final num? buyingprice;
  final num? sellingprice;
  final String? image;
  final String? description;
  final String? Categoryname;
  final Timestamp? addedday;

  ChargeControllerModel(
      {this.userid,
      this.id,
      this.name,
      this.type,
      this.ratedVoltage,
      this.quantity,
      this.current,
      this.buyingprice,
      this.sellingprice,
      this.image,
      this.description,
      this.Categoryname,
      this.addedday});
}
