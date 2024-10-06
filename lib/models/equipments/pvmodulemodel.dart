import 'package:cloud_firestore/cloud_firestore.dart';

class PvModuleModel {
  final String? userid;
  final String? id;
  final String? itemid;
  final String? name;
  final String? type;
  final num? power;
  final num? quantity;
  final num? stockquantiy;
  final num? parallel;
  final num? series;
  final num? voltage;
  final num? short_circuit_current;
  final num? current;
  final num? open_circuit_voltage;
  final num? buyingprice;
  final num? sellingprice;
  final num? totalsellingprice;
  final String? image;
  final String? description;
  final String? Categoryname;
  final Timestamp? addedday;

  PvModuleModel(
      {this.userid,
      this.id,
      this.itemid,
      this.name,
      this.type,
      this.power,
      this.quantity,
      this.stockquantiy,
      this.parallel,
      this.series,
      this.voltage,
      this.short_circuit_current,
      this.current,
      this.open_circuit_voltage,
      this.buyingprice,
      this.sellingprice,
      this.totalsellingprice,
      this.image,
      this.description,
      this.Categoryname,
      this.addedday});
}
