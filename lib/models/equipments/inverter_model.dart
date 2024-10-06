import 'package:cloud_firestore/cloud_firestore.dart';

class InverterModel {
  final String? userid;
  final String? id;
  final String? name;
  final String? type;
  final num? ratedpower;
  final num? quantity;
  final num? nominalvoltage;
  final num? acvoltage;
  final num? efficiency;
  final num? buyingprice;
  final num? sellingprice;
  final String? image;
  final String? description;
  final String? Categoryname;
  final Timestamp? addedday;

  InverterModel(
      {this.userid,
      this.id,
      this.name,
      this.type,
      this.ratedpower,
      this.quantity,
      this.nominalvoltage,
      this.acvoltage,
      this.efficiency,
      this.buyingprice,
      this.sellingprice,
      this.image,
      this.description,
      this.Categoryname,
      this.addedday});
}
