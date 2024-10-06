import 'package:cloud_firestore/cloud_firestore.dart';

class BatteriesModel {
  final String? userid;
  final String? id;
  final String? itemid;
  final String? name;
  final String? type;
  final num? voltage;
  final num? capacity;
  final num? deep_of_discharge;
  final num? quantity;
  final num? stockquantiy;
  final num? buyingprice;
  final num? sellingprice;
  final num? totalsellingprice;
  final num? parallel;
  final num? series;
  final String? image;
  final String? description;
  final String? Categoryname;
  final Timestamp? addedday;

  BatteriesModel(
      {this.userid,
      this.id,
      this.itemid,
      this.name,
      this.type,
      this.voltage,
      this.capacity,
      this.deep_of_discharge,
      this.quantity,
      this.stockquantiy,
      this.buyingprice,
      this.sellingprice,
      this.totalsellingprice,
      this.parallel,
      this.series,
      this.image,
      this.description,
      this.Categoryname,
      this.addedday});
}
