


import 'package:cloud_firestore/cloud_firestore.dart';

class AccessoriesModel{
String? id;
String? name;
String? type;
 String? primary;
String? secondary;
num quantity;
 num buyingprice;
 num sellingprice;
 String? image;

 String? description;
 String? Categoryname;
 Timestamp? addedday;

AccessoriesModel({
   required this.id,
    required this.name,
 required this.type,
      this.primary,
     this.secondary,
    required this.quantity,
    required this.buyingprice,
    required this.sellingprice,
     this.image,

    required this.description,
     this.Categoryname,
     this.addedday});


}

class tempAccessoryModel{
  String? id;
  String? itemid;
  String? name;
  String? type;

  num quantity;
  num buyingprice;
  num sellingprice;


  String? description;

  tempAccessoryModel({
    required this.id,
    required this.itemid,
    required this.name,
    required this.type,

    required this.quantity,
    required this.buyingprice,
    required this.sellingprice,

    required this.description,
   });
}