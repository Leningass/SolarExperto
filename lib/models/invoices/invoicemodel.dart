import 'package:cloud_firestore/cloud_firestore.dart';

class InvoiceModel {
  String id;
  num? rank;
  String? customername;
  String? customerphone;
  //panel

  String? panelname;
  num? panelquantity;
  num? panelprice;
  num? paneltotalprice;

  //battery

  String? batteryname;
  num? batteryquantity;
  num? batteryprice;
  num? batterytotalprice;

  //inverter

  String? invertername;
  num? inverterquantity;
  num? inverterprice;
  num? invertertotalprice;

  // controller

  String? controllername;
  num? controllerquantity;
  num? controllerprice;
  num? controllertotalprice;

  //accesories

  String? accessoriesname;
  num? accessoriesquantity;
  num? accessoriesprice;
  num? accessoriestotalprice;


  // service fee

  String? servicename;

  num? serviceprice;
  num? servicetotalprice;

  num? G1;
  num? CI3;
  num? GE6;
  num? GE7;
  num? G2;
  num? G3;
  num? G4;
  num? G5;
  num? G6;
  num? G7;
  num? G8;
  num? G9;
  num? G19;
  num? G20;
  num? G21;
  num? G22;
  num? G23;
  num? G24;
  num? G25;
  num? G26;

  InvoiceModel({
    required this.id,
     this.rank,
    this.customername,
    this.customerphone,
    required this.panelname,
    required this.panelquantity,
    required this.panelprice,
    required this.paneltotalprice,
    required this.batteryname,
    required this.batteryquantity,
    required  this.batteryprice,
    required this.batterytotalprice,
    required this.invertername,
    required  this.inverterquantity,
    required  this.inverterprice,
    required  this.invertertotalprice,
    required   this.controllername,
    required  this.controllerquantity,
    required  this.controllerprice,
    required  this.controllertotalprice,
    required   this.accessoriesname,
    required this.accessoriesquantity,
    required this.accessoriesprice,
    required this.accessoriestotalprice,
    required this.servicename,
    required this.serviceprice,
    required  this.servicetotalprice,
    required  this.G1,
    required  this.CI3,
    required  this.GE6,
    required  this.GE7,
    required  this.G2,
    required  this.G3,
    required  this.G4,
    required this.G5,
    required this.G6,
    required this.G7,
    required this.G8,
    required this.G9,
    required  this.G19,
    required  this.G20,
    required  this.G21,
    required  this.G22,
    required  this.G23,
    required  this.G24,
    required this.G25,
    required this.G26, });
}
