import 'dart:async';
import 'dart:math';

import 'package:SolarExperto/constants/constants.dart';
import 'package:SolarExperto/models/Service%20Fee/servicefeemodel.dart';
import 'package:SolarExperto/models/appliances/appliancemodel.dart';
import 'package:SolarExperto/models/equipments/batteriesmodel.dart';
import 'package:SolarExperto/models/equipments/controllermodel.dart';
import 'package:SolarExperto/models/equipments/inverter_model.dart';
import 'package:SolarExperto/models/equipments/pvmodulemodel.dart';
import 'package:SolarExperto/models/global/global.dart';
import 'package:SolarExperto/models/othersettings/batteryiconratio.dart';
import 'package:SolarExperto/models/city/city.dart';
import 'package:SolarExperto/models/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/accessories/accessoriesmodel.dart';
import '../../models/appointments/appointmentmodel.dart';
import '../../models/categories/categorymodel.dart';
import '../../models/customers/customermodel.dart';
import '../../models/finance/financemodel.dart';
import '../../models/invoices/invoicemodel.dart';
import '../../models/othersettings/efficieny.dart';
import '../../models/othersettings/paneliconratio.dart';

class DatabaseService {
  final dynamic doctoken;

  DatabaseService({
    this.doctoken,
  });

//deleteappliancecategory..
  Future deleteappliancecategory(String? categoryid) async {
    await appliancescategoryreference.doc(categoryid).delete();
  }
  Future deleteservicefee(String? serviceid) async {
    await servicerefference.doc(serviceid).delete();
  }
  Future deletetempservicefee(String? serviceid) async {
    await tempservicerefference.doc(serviceid).delete();
  }
  Future deleteglobal(String? id) async {
    await globalreference.doc(id).delete();
  }

  Future deletetempglobal(String? id) async {
    await tempglobalrefference.doc(id).delete();
  }
  Future deleteadmin(String? id) async {
    await adminrefference.doc(id).delete();

    await FirebaseAuth.instance.currentUser!.delete();
  }
  Future deleteinvoice(String? invoiceid) async {
    await invoicereference.doc(invoiceid).delete();
  }

  Future deletefinance(String? financeid) async {
    await financereference.doc(financeid).delete();
  }

//deleteequipmentcategory..
  Future deleteequipmentcategory(String? categoryid) async {
    await equipmentscategoryreference.doc(categoryid).delete();
  }

  Future deleteappliances(String? applianceid) async {
    await appliancesreferences.doc(applianceid).delete();
  }

  Future deleteapointment(String? apointmentid) async {
    await appointmentrefference.doc(apointmentid).delete();
  }

  Future deletepanel(String? panelid) async {
    await equipmentreferences.doc(panelid).delete();
  }

  Future deletecustomer(String? customerid) async {
    await customerreferences.doc(customerid).delete();
  }

  Future deletebattery(String? batteryid) async {
    await equipmentreferences.doc(batteryid).delete();
  }

  Future deletecontroller(String? controllerid) async {
    await equipmentreferences.doc(controllerid).delete();
  }

  Future deleteinverter(String? inverterid) async {
    await equipmentreferences.doc(inverterid).delete();
  }
  Future deleteaccessories(String? accessoriesid) async {
    await equipmentreferences.doc(accessoriesid).delete();
  }
  Future deletecities(String? id) async {
    await cityreference.doc(id).delete();
  }

  Future deleteefficiencies(String? id) async {
    await efficiencyreference.doc(id).delete();
  }

  Future deleteratiobatteries(String? id) async {
    await batteryiconrationreference.doc(id).delete();
  }

  Future deleteratiopanels(String? id) async {
    await paneliconrationreference.doc(id).delete();
  }

  Future deletetemp(String? id) async {
    await tempappliancesrefference.doc(id).delete();
  }

  Future deletetemcal(String? id) async {
    await tempcalulationrefference.doc(id).delete();
  }
  Future deletetempaccess(String? id) async {
    await tempaccessrefference.doc(id).delete();
  }
  // add global parameters
  Future updateglobals(
      String? id,
      double? contSafetyFactor,
      double? inverterEfficiency,
      double? batteryDod,
      double? roundTripEfficiency,
      double? deRatingFactor,
      double? lifeTime,
      int? batteryAutonomy) async {
    return await globalreference.doc(id.toString()).set({
      'id': id,
      'contSafetyFactor': contSafetyFactor,
      'inverterEfficiency': inverterEfficiency,
      'batteryDod': batteryDod,
      'roundTripEfficiency': roundTripEfficiency,
      'deRatingFactor': deRatingFactor,
      'lifeTime': lifeTime,
      'batteryAutonomy': batteryAutonomy,
    });
  }
  Future updateservicefee(
      String? id,
      String? name,
      String? description,
      double? installationfee,
      double? maintenancefee,
      double? transportfee,
      double? additionalfee
      ) async {
    return await servicerefference.doc(id.toString()).set({
      'id': id,
      'name': name,
      'description': description,
      'installationfee': installationfee,
      'maintenancefee': maintenancefee,
      'transportfee': transportfee,
      'additionalfee': additionalfee,

    });
  }
  Future updatetempservicefee(
      String? id,
      String? name,
      String? description,
      int? installationfee,
      int? maintenancefee,
      int? transportfee,
      int? additionalfee
      ) async {
    return await tempservicerefference.doc(id.toString()).set({
      'id': id,
      'name': name,
      'description': description,
      'installationfee': installationfee,
      'maintenancefee': maintenancefee,
      'transportfee': transportfee,
      'additionalfee': additionalfee,

    });
  }
  Future updatetempglobals(
      String? id,
      double? contSafetyFactor,
      double? inverterEfficiency,
      double? batteryDod,
      double? roundTripEfficiency,
      double? deRatingFactor,
      double? lifeTime,
      int? batteryAutonomy,
      num? inverterac_voltage,

      num? peaksunhour,
      num? electricityprice,
      String? cityname) async {
    return await tempglobalrefference.doc(id.toString()).set({
      'id': id,
      'contSafetyFactor': contSafetyFactor,
      'inverterEfficiency': inverterEfficiency,
      'batteryDod': batteryDod,
      'roundTripEfficiency': roundTripEfficiency,
      'deRatingFactor': deRatingFactor,
      'lifeTime': lifeTime,
      'batteryAutonomy': batteryAutonomy,
      'inverterac_voltage': inverterac_voltage,

      'peaksunhour': peaksunhour,
      'electricityprice': electricityprice,
      'cityname': cityname
    });
  }

  //add appliancescategories..
  Future updateappliancescategory(
      String? categoryname, String? categoryid, Timestamp addedday) async {
    return await appliancescategoryreference
        .doc(categoryid.toString())
        .set({'id': categoryid, 'name': categoryname, 'addedday': addedday});
  }

  //add equipmentcategories..
  Future updateequipmentscategory(
      String? categoryname, String? categoryid, Timestamp addedday) async {
    return await equipmentscategoryreference.doc(categoryid.toString()).set({
      'categoryid': categoryid,
      'categoryname': categoryname,
      'addedday': addedday
    });
  }

//add customers..
  Future updatecustomers(
      String customerid,
      String customername,
      String customerphone,
      String customeremail,
      String customeraddress,
      Timestamp addedday) async {
    return await customerreferences.doc(customerid.toString()).set({
      'customerid': customerid,
      'customername': customername,
      'customerphon': customerphone,
      'customeremail': customeremail,
      'customeraddress': customeraddress,
      'addedday': addedday,
    });
  }

//add TempAppliances
  Future updatetempappliances(
      String categoryid,
      String id,
      String name,
      String type,
      int quatity,
      int ratedwattage,
      int timeofusage,
      // int simultaneity,
      String icon,
      // String description,
      bool isadded) async {
    return await tempappliancesrefference.doc(id.toString()).set({
      'categoryid': categoryid,
      'id': id,
      'name': name,
      'type': type,
      'quatity': quatity,
      'ratedwattage': ratedwattage,
      'timeofusage': timeofusage,
      // 'simultaneity': simultaneity,
      'icon': icon,
      // 'description': description,
      'isadded': isadded,
    });
  }

//add Appliances
  Future updateappliances(
      String id,
      String name,
      int quatity,
      dynamic type,
      String categoryid,
      dynamic ratedwattage,
      dynamic timeofusage,
      String image,
      Timestamp addedday) async {
    return await appliancesreferences.doc(id.toString()).set({
      'id': id,
      'name': name,
      'quatity': quatity,
      'type': type,
      'categoryid': categoryid,
      'ratedwattage': ratedwattage,
      'timeofusage': timeofusage,
      'image': image,
      'addedday': addedday
    });
  }

  Future updateinvoices(
  String? id,

String? date,
String? customername,
String? customerphone,
  String? panelname,
  num? panelquantity,
      num? panelprice,
      num? paneltotalprice,
  //battery
  String? batteryname,
      num? batteryquantity,
      num? batteryprice,
      num? batterytotalprice,
  //inverter
  String? invertername,
      num? inverterquantity,
      num? inverterprice,
      num? invertertotalprice,
  // controller
  String? controllername,
      num? controllerquantity,
      num? controllerprice,
      num? controllertotalprice,
  //accesories
  String? accessoriesname,
      num? accessoriesquantity,
      num? accessoriesprice,
      num? accessoriestotalprice,
  // service fee

  String? servicename,

      num? serviceprice,
      num? servicetotalprice,
num CI3,
num GE6,
num GE7,
  num? G1,
  num? G2,
  num? G3,
  num? G4,
  num? G5,
  num? G6,
  num? G7,
  num? G8,
  num? G9,
  num? G19,
  num? G20,
  num? G21,
  num? G22,
  num? G23,
  num? G24,
  num? G25,
  num? G26,
      ) async {
    return await invoicereference
        .doc(date).set({
  'id': id,
  'customername': customername,
  'customerphone': customerphone,
  'panelname': panelname,
  'panelquantity': panelquantity,
  'panelprice': panelprice,
  'paneltotalprice': paneltotalprice,
  'batteryname': batteryname,
  'batteryquantity': batteryquantity,
  'batteryprice': batteryprice,
  'batterytotalprice': batterytotalprice,
  'invertername': invertername,
  'inverterquantity': inverterquantity,
  'inverterprice': inverterprice,
  'invertertotalprice': invertertotalprice,
  'controllername': controllername,
  'controllerquantity': controllerquantity,
  'controllerprice': controllerprice,
  'controllertotalprice': controllertotalprice,
  'accessoriesname': accessoriesname,
  'accessoriesquantity': accessoriesquantity,
  'accessoriesprice': accessoriesprice,
  'accessoriestotalprice': accessoriestotalprice,
  'servicename': servicename,
  'serviceprice': serviceprice,

  'servicetotalprice': servicetotalprice,
      'CI3':CI3,
      'GE6':GE6,
      'GE7':GE7,
  'G1': G1,
  'G2': G2,
  'G3': G3,
  'G4': G4,
  'G5': G5,
  'G6': G6,
  'G7': G7,
  'G8': G8,
  'G9': G9,
  'G19': G19,
  'G20': G20,
  'G21': G21,
  'G22': G22,
  'G23': G23,
  'G24': G24,
  'G25': G25,
  'G26': G26,





        });
  }

  List<InvoiceModel>? _invoicelist(QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return InvoiceModel(
            id:doc.get("id")??'',
            customername:doc.get("customername")??'',
            customerphone:doc.get("customerphone")??'',

            panelname:doc.get("panelname")??'',
            panelquantity:doc.get("panelquantity")??0,
            panelprice:doc.get("panelprice")??0,
            paneltotalprice:doc.get("paneltotalprice")??0,

            batteryname:doc.get("batteryname")??'',
            batteryquantity:doc.get("batteryquantity")??0,
            batteryprice:doc.get("batteryprice")??0,
            batterytotalprice:doc.get("batterytotalprice")??0,

            invertername:doc.get("invertername")??'',
            inverterquantity:doc.get("inverterquantity")??0,
            inverterprice:doc.get("inverterprice")??0,
            invertertotalprice:doc.get("invertertotalprice")??'',

            controllername:doc.get("controllername")??'',
            controllerquantity:doc.get("controllerquantity")??0,
            controllerprice:doc.get("controllerprice")??0,
            controllertotalprice:doc.get("controllertotalprice")??0,

            accessoriesname:doc.get("accessoriesname")??'',
            accessoriesquantity:doc.get("accessoriesquantity")??0,
            accessoriesprice:doc.get("accessoriesprice")??0,
            accessoriestotalprice:doc.get("accessoriestotalprice")??0,

            servicename:doc.get("servicename")??'',
            serviceprice:doc.get("serviceprice")??'',
            servicetotalprice:doc.get("servicetotalprice")??0,
            G1:doc.get("G1")??0,
            CI3:doc.get("CI3")??0,
            GE6:doc.get("GE6")??0,
            GE7:doc.get("GE7")??0,
            G2:doc.get("G2")??0,
            G3:doc.get("G3")??0,
            G4:doc.get("G4")??0,
            G5:doc.get("G5")??0,
            G6:doc.get("G6")??0,
            G7:doc.get("G7")??0,
            G8:doc.get("G8")??0,
            G9:doc.get("G9")??0,
            G19:doc.get("G19")??0,
            G20:doc.get("G20")??0,
            G21:doc.get("G21")??0,
            G22:doc.get("G22")??0,
            G23:doc.get("G23")??0,
            G24:doc.get("G24")??0,
            G25:doc.get("G25")??0,
            G26:doc.get("G26")??0
        );
      }).toList();

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  List<Global>? _globallist(QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return Global(
          id: doc.get('id') ?? '',
          contSafetyFactor: doc.get('contSafetyFactor') ?? 1.25,
          inverterEfficiency: doc.get('inverterEfficiency') ?? 0.85,
          batteryDod: doc.get('batteryDod') ?? 0.8,
          roundTripEfficiency: doc.get('roundTripEfficiency') ?? 0.8,
          deRatingFactor: doc.get('deRatingFactor') ?? 0.9,
          lifeTime: doc.get('lifeTime') ?? 1,
          batteryAutonomy: doc.get('batteryAutonomy') ?? 4,
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  List<ServiceFeeModel>? _servicelist(QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return ServiceFeeModel(
          id: doc.get('id') ?? '',
          name: doc.get('name') ?? '',
          description: doc.get('description') ?? '',
          installationfee: doc.get('installationfee') ?? 0.0,
          maintenancefee: doc.get('maintenancefee') ?? 0.0,
          transportfee: doc.get('transportfee') ?? 0.0,
          additionalfee: doc.get('additionalfee') ?? 0,

        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  Stream<List<InvoiceModel>?>? get invoices {
    try {
      return invoicereference
.orderBy('customername')
          .snapshots()
          .map(_invoicelist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<List<Global>?>? get globals {
    try {
      return globalreference.snapshots().map(_globallist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  Stream<List<ServiceFeeModel>?>? get service {
    try {
      return servicerefference.snapshots().map(_servicelist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  Future updatefinances(
      String? id, String? names, String? dates, dynamic? payments) async {
    return await financereference
        .doc(id.toString())
        .set({'id': id, 'name': names, 'date': dates, 'payment': payments});
  }

  List<FinanceModel>? _financelist(QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return FinanceModel(
          id: doc.get('id') ?? '',
          name: doc.get('name'),
          date: doc.get('date') ?? '',
          payment: doc.get('payment') ?? '',
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<List<FinanceModel>?>? get finances {
    try {
      return financereference
          .orderBy(
            "name",
          )
          .snapshots()
          .map(_financelist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  List<UserModel>? _adminlist(QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return UserModel(
            id: doc.get('id')??'',
            name: doc.get('name')??'',
            email: doc.get('email')??'',
            );
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<List<UserModel>?>? get admins {
    try {
      return adminrefference
          .orderBy(
        "name",
      )
          .snapshots()
          .map(_adminlist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future updateadmin(
      String id,
      String name,
      )async{
    return await adminrefference.doc(id.toString()).update({
      'id': id,
      'name': name,
    }
    );
  }

  Future updateaccessories(
      String? id,
      String? name,
      String? type,
     String? primary,
      String? secondary,
      num? quantity,
      num? buyingprice,
      num? sellingprice,
      String? image,
      String? description,
      String? Categoryname,
      Timestamp? addedday) async {
    return await equipmentreferences.doc(id).set({
      'id': id,
      'name': name,
      'type': type,
      'primary': primary,
      'secondary': secondary,
      'quantity': quantity,
      'buyingprice': buyingprice,
      'sellingprice': sellingprice,
      'image': image,
      'description': description,
      'Categoryname': Categoryname,
      'addedday': addedday
    });
  }

  List<AccessoriesModel>? _acessorylist(QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return AccessoriesModel(
            id: doc.get('id') ?? '',
            name: doc.get('name') ?? '',
            type: doc.get('type') ?? '',
          primary: doc.get('primary') ?? '',
            secondary: doc.get('secondary') ?? '',
            quantity: doc.get('quantity') ?? '',
            buyingprice: doc.get('buyingprice') ?? '',
            sellingprice: doc.get('sellingprice') ?? '',
            image: doc.get('image') ?? '',
            description: doc.get('description') ?? '',
            Categoryname: doc.get('Categoryname') ?? '',
            addedday: doc.get('addedday'));
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  List<tempAccessoryModel>? _tempacessorylist(QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return tempAccessoryModel(
            id: doc.get('id') ?? '',
            itemid: doc.get('itemid') ?? '',
            name: doc.get('name') ?? '',
            type: doc.get('type') ?? '',
          //  primary: doc.get('primary') ?? '',
          //  secondary: doc.get('secondary') ?? '',
            quantity: doc.get('quantity') ?? '',
            buyingprice: doc.get('buyingprice') ?? '',
            sellingprice: doc.get('sellingprice') ?? '',
           // image: doc.get('image') ?? '',
            description: doc.get('image') ?? '',
           // Categoryname: doc.get('Categoryname') ?? '',
           // addedday: doc.get('addedday')
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<List<AccessoriesModel>?>? get accessories {
    try {
      return equipmentreferences
          .where('Categoryname', isEqualTo: 'Accessories')
          .orderBy('name')
          .snapshots()
          .map(_acessorylist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  Stream<List<tempAccessoryModel>?>? get tempaccessories {
    try {
      return tempaccessrefference

          .orderBy('name')
          .snapshots()
          .map(_tempacessorylist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//updatepanel...
  Future updatepanel(
      String? id,
      String? name,
      String? type,
      num? power,
      num? quantity,
      num? systemvoltage,
      num? short_circuit_current,
      num? current,
      num? open_circuit_voltage,
      num? buyingprice,
      num? sellingprice,
      String? image,
      String? description,
      String Categoryname,
      Timestamp? addedday) async {
    return await equipmentreferences.doc(id).set({
      'id': id,
      'name': name,
      'type': type,
      'power': power,
      'quantity': quantity,
      'systemvoltage': systemvoltage,
      'short_circuit_current': short_circuit_current,
      'current': current,
      'open_circuit_voltage': open_circuit_voltage,
      'buyingprice': buyingprice,
      'sellingprice': sellingprice,
      'image': image,
      'description': description,
      'Categoryname': Categoryname,
      'addedday': addedday
    });
  }

//updatebattery...
  Future updatebattery(
    String? id,
    String? name,
    String? type,
    num? voltage,
    num? capacity,
    num? deep_of_discharge,
    num? quantity,
    num? buyingprice,
    num? sellingprice,
    String? image,
    String? description,
    String? Categoryname,
    Timestamp? addedday,
  ) async {
    return await equipmentreferences.doc(id).set({
      'id': id,
      'name': name,
      'type': type,
      'voltage': voltage,
      'capacity': capacity,
      'deep_of_discharge': deep_of_discharge,
      'quantity': quantity,
      'buyingprice': buyingprice,
      'sellingprice': sellingprice,
      'image': image,
      'description': description,
      'Categoryname': Categoryname,
      'addedday': addedday,
    });
  }

//updatetempbattery...
  Future updatetempbattery(
    String? userid,
    String? itemid,
    String? id,
    String? name,
    String? type,
    num? quantity,
    num? voltage,
    num? capacity,
    num? deep_of_discharge,
    num? sellingprice,
    num? buyingprice,
    String? image,
    num? series,
    num? parrellel,
    num? stockquantiy,
    num? totalsellingprice,
  ) async {
    return await tempbatteryreference
        .doc(userid)
        .collection('Battery_$userid')
        .doc(itemid)
        .set({
      'userid': userid,
      'itemid': itemid,
      'id': id,
      'name': name,
      'type': type,
      'quantity': quantity,
      'voltage': voltage,
      'capacity': capacity,
      'deep_of_discharge': deep_of_discharge,
      'sellingprice': sellingprice,
      'buyingprice': buyingprice,
      'image': image,
      'series': series,
      'parrellel': parrellel,
      'stockquantiy': stockquantiy,
      'totalsellingprice': totalsellingprice
    });
  }

//updatetempbattery...
  Future updatetempcalculationbattery(
    String? itemid,
    String? id,
    String? name,
    String? type,
    num? quantity,
    num? voltage,
    num? capacity,
    num? deep_of_discharge,
    num? sellingprice,
    num? buyingprice,
    String? image,
    num? series,
    num? parrellel,
    num? stockquantiy,
    num? totalsellingprice,
  ) async {
    return await tempcalulationrefference.doc(itemid).set({
      'itemid': itemid,
      'id': id,
      'name': name,
      'type': type,
      'quantity': quantity,
      'voltage': voltage,
      'capacity': capacity,
      'deep_of_discharge': deep_of_discharge,
      'sellingprice': sellingprice,
      'buyingprice': buyingprice,
      'image': image,
      'series': series,
      'parrellel': parrellel,
      'stockquantiy': stockquantiy,
      'totalsellingprice': totalsellingprice
    });
  }

  //updatecontroller...
  Future updatecontroller(
    String? id,
    String? name,
    String? type,
    num? quantity,
    num? ratedVoltage,
    num? current,
    num? buyingprice,
    num? sellingprice,
    String? image,
    String? description,
    String? Categoryname,
    Timestamp? addedday,
  ) async {
    return await equipmentreferences.doc(id).set({
      'id': id,
      'name': name,
      'type': type,
      'quantity': quantity,
      'ratedVoltage': ratedVoltage,
      'current': current,
      'buyingprice': buyingprice,
      'sellingprice': sellingprice,
      'image': image,
      'description': description,
      'Categoryname': Categoryname,
      'addedday': addedday,
    });
  }

//updatetempcontroller...
  Future updatetempcontroller(
    String? userid,
    String? itemid,
    String? id,
    String? name,
    String? type,
    num? quantity,
    num? voltage,
    num? current,
    num? sellingprice,
    num? buyingprice,
    String? image,
  ) async {
    return await tempcontrollerrefference
        .doc(userid)
        .collection('Controller_$userid')
        .doc(itemid)
        .set({
      'userid': userid,
      'itemid': itemid,
      'id': id,
      'name': name,
      'type': type,
      'quantity': quantity,
      'voltage': voltage,
      'current': current,
      'sellingprice': sellingprice,
      'buyingprice': buyingprice,
      'image': image,
    });
  }

  Future updatetempcalculationcontroller(
    String? itemid,
    String? id,
    String? name,
    String? type,
    num? quantity,
    num? voltage,
    num? current,
    num? sellingprice,
    num? buyingprice,
    String? image,
  ) async {
    return await tempcalulationrefference.doc(itemid).set({
      'itemid': itemid,
      'id': id,
      'name': name,
      'type': type,
      'quantity': quantity,
      'voltage': voltage,
      'current': current,
      'sellingprice': sellingprice,
      'buyingprice': buyingprice,
      'image': image,
    });
  }

//updatetemppanel...
  Future updatetemppanel(
    String userid,
    String itemid,
    String id,
    String name,
    String type,
    num quantity,
    num power,
    num systemvoltage,
    num short_circuit_current,
    num open_circuit_voltage,
    num sellingprice,
    num buyingprice,
    String image,
    num series,
    num parrellel,
    num current,
    num? stockquantiy,
    num? totalsellingprice,
  ) async {
    return await temppanelreference
        .doc(userid)
        .collection('Panel_$userid')
        .doc(itemid)
        .set({
      'userid': userid,
      'itemid': itemid,
      'id': id,
      'name': name,
      'type': type,
      'quantity': quantity,
      'power': power,
      'systemvoltage': systemvoltage,
      'short_circuit_current': short_circuit_current,
      'open_circuit_voltage': open_circuit_voltage,
      'sellingprice': sellingprice,
      'buyingprice': buyingprice,
      'image': image,
      'series': series,
      'parrellel': parrellel,
      'current': current,
      'stockquantiy': stockquantiy,
      'totalsellingprice': totalsellingprice
    });
  }
  Future updatecalculationtemppanel(
      String itemid,
      String id,
      String name,
      String type,
      num quantity,
      num power,
      num systemvoltage,
      num short_circuit_current,
      num open_circuit_voltage,
      num sellingprice,
      num buyingprice,
      String image,
      num series,
      num parrellel,
      num? stockquantiy,
      num? totalsellingprice,
      ) async {
    return await tempcalulationrefference.doc(itemid).set({
      'itemid': itemid,
      'id': id,
      'name': name,
      'type': type,
      'quantity': quantity,
      'power': power,
      'systemvoltage': systemvoltage,
      'short_circuit_current': short_circuit_current,
      'open_circuit_voltage': open_circuit_voltage,
      'sellingprice': sellingprice,
      'buyingprice': buyingprice,
      'image': image,
      'series': series,
      'parrellel': parrellel,
      'stockquantiy': stockquantiy,
      'totalsellingprice': totalsellingprice
    });
  }
  Future updatecalculationtempaccessories(
    String itemid,
    String id,
    String name,
    String type,
    num quantity,
    num sellingprice,
    num buyingprice,
    String image,
      // num stockquantity,

  ) async {
    return await tempcalulationrefference.doc(itemid).set({
      'itemid': itemid,
      'id': id,
      'name': name,
      'type': type,
      'quantity': quantity,

      'sellingprice': sellingprice,
      'buyingprice': buyingprice,
      'image': image,
    //  'stockquantity': stockquantity,

    });
  }
  Future updatetempaccessories(
      String itemid,
      String id,
      String name,
      String type,
      num quantity,
      num sellingprice,
      num buyingprice,
      String image,
      // num stockquantity,

      ) async {
    return await tempaccessrefference.doc(itemid).set({
      'itemid': itemid,
      'id': id,
      'name': name,
      'type': type,
      'quantity': quantity,

      'sellingprice': sellingprice,
      'buyingprice': buyingprice,
      'image': image,
      //  'stockquantity': stockquantity,

    });
  }

  //updateinverter...
  Future updateinverter(
    String? id,
    String? name,
    String? type,
    num? ratedpower,
    num? quantity,
    num? nominalvoltage,
    num? acvoltage,
    num? efficiency,
    num? buyingprice,
    num? sellingprice,
    String? image,
    String? description,
    String? Categoryname,
    Timestamp? addedday,
  ) async {
    return await equipmentreferences.doc(id).set({
      'id': id,
      'name': name,
      'type': type,
      'ratedpower': ratedpower,
      'quantity': quantity,
      'nominalvoltage': nominalvoltage,
      'acvoltage': acvoltage,
      'efficiency': efficiency,
      'buyingprice': buyingprice,
      'sellingprice': sellingprice,
      'image': image,
      'description': description,
      'Categoryname': Categoryname,
      'addedday': addedday,
    });
  }

//updatetempinverter...
  Future updatetempinverter(
    String userid,
    String itemid,
    String id,
    String name,
    String type,
    num? quantity,
    num? ratedpower,
    num? nominalvoltage,
    // dynamic rpeek_power,
    num? acvoltage,
    num? sellingprice,
    num? buyingprice,
    num? efficiency,
    String image,
  ) async {
    return await tempinverterrefference
        .doc(userid)
        .collection('Inverter_$userid')
        .doc(itemid)
        .set({
      'userid': userid,
      'itemid': itemid,
      'id': id,
      'name': name,
      'type': type,
      'quantity': quantity,
      'ratedpower': ratedpower,
      'nominalvoltage': nominalvoltage,
      'acvoltage': acvoltage,
      'sellingprice': sellingprice,
      'buyingprice': buyingprice,
      'efficiency': efficiency,
      'image': image,
    });
  }

  Future updatetempcalculationinverter(
    String itemid,
    String id,
    String name,
    String type,
    dynamic quantity,
    dynamic ratedpower,
    dynamic nominalvoltage,
    // dynamic inverterpeek_power,
    dynamic acvoltage,
    dynamic sellingprice,
    dynamic buyingprice,
    dynamic efficiency,
    String image,
  ) async {
    return await tempcalulationrefference.doc(itemid).set({
      'itemid': itemid,
      'id': id,
      'name': name,
      'type': type,
      'quantity': quantity,
      'ratedpower': ratedpower,
      'nominalvoltage': nominalvoltage,
      'acvoltage': acvoltage,
      'sellingprice': sellingprice,
      'buyingprice': buyingprice,
      'efficiency': efficiency,
      'image': image,
    });
  }

  //updatecity...
  Future updatecity(String id, String name, double peaksunhours,
      int inverterac_voltage, int electricity_price, Timestamp addedday) async {
    return await cityreference.doc(id).set({
      'id': id,
      'name': name,
      'peaksunhours': peaksunhours,
      'inverterac_voltage': inverterac_voltage,
      'electricity_price': electricity_price,
      'addedday': addedday
    });
  }

  //updateefficieny
  Future updateefficiency(
      String id, double efficiency, Timestamp addedday) async {
    return await efficiencyreference
        .doc(id)
        .set({'id': id, 'efficiency': efficiency, 'addedday': addedday});
  }

  //updatebatteryratio..
  Future updatebatteryratio(
    String id,
    int total,
    int numberseries,
    int numberparallel,
    String icon,
  ) async {
    return await batteryiconrationreference.doc(id).set({
      'id': id,
      'total': total,
      'numberseries': numberseries,
      'numberparallel': numberparallel,
      'icon': icon
    });
  }

  //updatepanelratio..
  Future updatepanelratio(
    String id,
    int total,
    int numberseries,
    int numberparallel,
    String icon,
  ) async {
    return await paneliconrationreference.doc(id).set({
      'id': id,
      'total': total,
      'numberseries': numberseries,
      'numberparallel': numberparallel,
      'icon': icon,
    });
  }

//updateappointments...
  Future updateappointments(
    String id,
    DateTime date,
    String from_time,
    String to_time,
    String customername,
    String customerphone,
    String customeremail,
    String customeraddress,
    String? detail,
  ) async {
    return await appointmentrefference.doc(id).set({
      'id': id,
      'date': date,
      'from_time': from_time,
      'to_time': to_time,
      'customername': customername,
      'customerphone': customerphone,
      'customeraddress': customeraddress,
      'customeremail': customeremail,
      'detail': detail,
    });
  }

  Stream<List<ApointmentsModel>?>? get appointments {
    try {
      return appointmentrefference
          .orderBy(
            'from_time',
          )
          .snapshots()
          .map(_appointpmentlist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<List<ApointmentsModel>?>? get appointmentsbyname {
    try {
      return appointmentrefference
          .orderBy('customername')
          .startAt([doctoken])
          .endAt([doctoken! + '\uf8ff'])
          .snapshots()
          .map(_appointpmentlist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<List<CustomerModel>?>? get customerbyname {
    try {
      return customerreferences
          .orderBy('customername')
          .startAt([doctoken])
          .endAt([doctoken! + '\uf8ff'])
          .snapshots()
          .map(_customerList);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<List<InvoiceModel>?>? get invoicebyname {
    try {
      return invoicereference
          .orderBy('name')
          .startAt([doctoken])
          .endAt([doctoken! + '\uf8ff'])
          .snapshots()
          .map(_invoicelist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<List<FinanceModel>?>? get financebyname {
    try {
      return financereference
          .orderBy('name')
          .startAt([doctoken])
          .endAt([doctoken! + '\uf8ff'])
          .snapshots()
          .map(_financelist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<List<CategoryAppliancesModel>?>? get categoriesbyname {
    try {
      return appliancescategoryreference
          .orderBy('name')
          .startAt([doctoken])
          .endAt([doctoken! + '\uf8ff'])
          .snapshots()
          .map(_categoryappliancelist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<List<ApplianceModel>?>? get appliancebyname {
    try {
      return appliancesreferences
          .orderBy('name')
          .startAt([doctoken])
          .endAt([doctoken! + '\uf8ff'])
          .snapshots()
          .map(_applianceslist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Stream<List<BatteriesModel>?>? get battriesbyname {
  //   try {
  //     return equipmentreferences
  //         .orderBy('name')
  //         // .startAt([doctoken])
  //         // .endAt([doctoken! + '\uf8ff'])
  //         .snapshots()
  //         .map(_batterieslist);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  Stream<List<PvModuleModel>?>? get pvmodulebyname {
    try {
      return equipmentreferences
          .orderBy('name')
          .startAt([doctoken])
          .endAt([doctoken! + '\uf8ff'])
          .snapshots()
          .map(_panellist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<List<InverterModel>?>? get inverterbyname {
    try {
      return equipmentreferences
          .orderBy('name')
          .startAt([doctoken])
          .endAt([doctoken! + '\uf8ff'])
          .snapshots()
          .map(_inverterlist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<List<AccessoriesModel>?>? get accessoriesbyname {
    try {
      return equipmentreferences
          .orderBy('name')
          .startAt([doctoken])
          .endAt([doctoken! + '\uf8ff'])
          .snapshots()
          .map(_acessorylist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<List<ChargeControllerModel>?>? get controllerbyname {
    try {
      return equipmentreferences
          .orderBy('name')
          .startAt([doctoken])
          .endAt([doctoken! + '\uf8ff'])
          .snapshots()
          .map(_controllerlist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  List<ApointmentsModel>? _appointpmentlist(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return ApointmentsModel(
            id: doc.get('id'),
            date: doc.get('date'),
            from_time: doc.get('from_time'),
            to_time: doc.get('to_time'),
            customername: doc.get('customername'),
            customerphone: doc.get('customerphone'),
            customeraddress: doc.get('customeraddress'),
            customeremail: doc.get('customeremail'),
            detail: doc.get('detail'));
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //appliancescategorylistfromsnapshot
  List<CategoryAppliancesModel>? _categoryappliancelist(
      QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return CategoryAppliancesModel(
            id: doc.get('id') ?? '',
            name: doc.get('name') ?? '',
            addedday: doc.get('addedday') ?? '');
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//stream for category..
  Stream<List<CategoryAppliancesModel>?>? get aplliancecategory {
    try {
      return appliancescategoryreference
          .orderBy('name')
          .snapshots()
          .map(_categoryappliancelist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //euipmentcategorylistfromsnapshot
  List<CategoryEquipmentModel>? _categoryeuipmentlist(QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return CategoryEquipmentModel(
            id: doc.get('id') ?? '',
            name: doc.get('name') ?? '',
            addedday: doc.get('addedday') ?? '');
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//stream for euipmentcategory..
  Stream<List<CategoryEquipmentModel>?>? get equipmentcategory {
    try {
      return equipmentscategoryreference
          .orderBy(
            'name',
          )
          .snapshots()
          .map(_categoryeuipmentlist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//applianceslistfromsnapshot

  List<ApplianceModel>? _applianceslist(QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return ApplianceModel(
            id: doc.get('id'),
            name: doc.get('name'),
            categoryid: doc.get('categoryid'),
            type: doc.get('type'),
            ratedwattage: doc.get('ratedwattage'),
            timeofusage: doc.get('timeofusage'),
            quatity: doc.get('quatity'),
            image: doc.get('image'),
            addedday: doc.get('addedday'));
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//stream for appliances..

  Stream<List<ApplianceModel>?>? get appliances {
    try {
      return appliancesreferences
          .where('categoryid', isEqualTo: doctoken)
          .snapshots()
          .map(_applianceslist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  List<CustomerModel>? _customerList(QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return CustomerModel(
            id: doc.get("customerid"),
            name: doc.get("customername"),
            phone: doc.get("customerphon"),
            email: doc.get("customeremail"),
            address: doc.get("customeraddress"),
            addedday: doc.get("addedday"));
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  List<CityModel>? _citylist(QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return CityModel(
            id: doc.get('id') ?? '',
            name: doc.get('name') ?? '',
            peaksunhours: doc.get('peaksunhours') ?? 0.0,
            electricity_price: doc.get('electricity_price') ?? 0,
            inverterac_voltage: doc.get('inverterac_voltage'),
            addedday: doc.get('addedday') ?? '');
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//stream for service..
  Stream<List<ServiceFeeModel>?>? get tempservicefee {
    try {
      return servicerefference
          .orderBy(
        'name',
      )
          .snapshots()
          .map(_tempservicefeelist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //listcities..
  List<ServiceFeeModel>? _servicefeelist(QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return ServiceFeeModel(
            id: doc.get('id') ?? '',
            name: doc.get('name') ?? '',
            description: doc.get('description') ?? '',
            installationfee: doc.get('installationfee') ?? 0,
            maintenancefee: doc.get('maintenancefee') ?? 0,
            transportfee: doc.get('transportfee')??0,
            additionalfee: doc.get('additionalfee') ?? 0);
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
//stream for service..
  Stream<List<ServiceFeeModel>?>? get servicefee {
    try {
      return servicerefference
          .orderBy(
        'name',
      )
          .snapshots()
          .map(_servicefeelist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //listcities..
  List<ServiceFeeModel>? _tempservicefeelist(QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return ServiceFeeModel(
            id: doc.get('id') ?? '',
            name: doc.get('name') ?? '',
            description: doc.get('description') ?? '',
            installationfee: doc.get('installationfee') ?? 0,
            maintenancefee: doc.get('maintenancefee') ?? 0,
            transportfee: doc.get('transportfee')??0,
            additionalfee: doc.get('additionalfee') ?? 0);
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//stream for cities..
  Stream<List<CityModel>?>? get cities {
    try {
      return cityreference
          .orderBy(
            'name',
          )
          .snapshots()
          .map(_citylist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<List<CustomerModel>?>? get customers {
    try {
      return customerreferences
          .orderBy(
            "customername",
          )
          .snapshots()
          .map((_customerList));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //listefficiency..
  List<EfficiencyModel>? _efficienylist(QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return EfficiencyModel(
            id: doc.get('id') ?? '',
            efficiency: doc.get('efficiency') ?? 0.0,
            addedday: doc.get('addedday') ?? '');
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//stream for efficiency..
  Stream<List<EfficiencyModel>?>? get efficiencies {
    try {
      return efficiencyreference
          .orderBy(
            'efficiency',
          )
          .snapshots()
          .map(_efficienylist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //listbatteryicon..
  List<BatteryIconratioModel>? _batteryratiolist(QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return BatteryIconratioModel(
          id: doc.get('id') ?? '',
          total: doc.get('total') ?? 0,
          numberseries: doc.get('numberseries') ?? 0,
          numberparallel: doc.get('numberparallel') ?? 0,
          icon: doc.get('icon') ?? '',
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//stream for batteryratioicon..
  Stream<List<BatteryIconratioModel>?>? get batteriesratioicon {
    try {
      return batteryiconrationreference
          .orderBy(
            'total',
          )
          .snapshots()
          .map(_batteryratiolist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//stream for batteriesicon..
//   Stream<List<BatteryIconratioModel>?>? get batteriesicon {
//     try {
//       print('Series : $series');
//       return batteryiconrationreference
//           .where('numberseries', isEqualTo: series)
//           .where('numberparallel', isEqualTo: parallel)
//           .snapshots()
//           .map(_batteryratiolist);
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }

  //listpanelicon..
  List<PanelIconratioModel>? _panelratiolist(QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return PanelIconratioModel(
          id: doc.get('id') ?? '',
          total: doc.get('total') ?? 0,
          numberseries: doc.get('numberseries') ?? 0,
          numberparallel: doc.get('numberparallel') ?? 0,
          icon: doc.get('icon') ?? '',
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//stream for panelratioicon..
  Stream<List<PanelIconratioModel>?>? get panelsratioicon {
    try {
      return paneliconrationreference
          .orderBy(
            'total',
          )
          .snapshots()
          .map(_panelratiolist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// //stream for panelriesicon..
//   Stream<List<PanelIconratioModel>?>? get panelriesicon {
//     try {
//       print('Series : $series');
//       return paneliconrationreference
//           .where('numberseries', isEqualTo: series)
//           .where('numberparallel', isEqualTo: parallel)
//           .snapshots()
//           .map(_panelratiolist);
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }

  //panellistfromsnapshot
  List<PvModuleModel>? _panellist(QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return PvModuleModel(
          //panels...
          id: doc.get('id') ?? '',
          name: doc.get('name') ?? '',
          type: doc.get('type') ?? '',
          power: doc.get('power') ?? 0,
          quantity: doc.get('quantity') ?? 0,
          voltage: doc.get('systemvoltage') ?? 0.0,
          short_circuit_current: doc.get('short_circuit_current') ?? 0.0,
          current: doc.get('current') ?? 0.0,
          open_circuit_voltage: doc.get('open_circuit_voltage') ?? 0.0,
          buyingprice: doc.get('buyingprice') ?? 0.0,
          sellingprice: doc.get('sellingprice') ?? 0.0,
          image: doc.get('image') ?? '',
          description: doc.get('description') ?? '',
          Categoryname: doc.get('Categoryname') ?? '',
          addedday: doc.get('addedday') ?? '',
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  List<PvModuleModel>? _temppanellist(QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return PvModuleModel(
          //panels...
          userid: doc.get('userid') ?? '',
          itemid: doc.get('itemid') ?? '',
          id: doc.get('id') ?? '',
          name: doc.get('name') ?? '',
          type: doc.get('type') ?? '',
          power: doc.get('power') ?? 0,
          quantity: doc.get('quantity') ?? 0,
          parallel: doc.get('parrellel') ?? 0,
          series: doc.get('series') ?? 0,
          stockquantiy: doc.get('stockquantiy') ?? 0,
          totalsellingprice: doc.get('totalsellingprice') ?? 0,
          voltage: doc.get('systemvoltage') ?? 0.0,
          short_circuit_current: doc.get('short_circuit_current') ?? 0.0,
          current: doc.get('current') ?? 0.0,
          open_circuit_voltage: doc.get('open_circuit_voltage') ?? 0.0,
          buyingprice: doc.get('buyingprice') ?? 0.0,
          sellingprice: doc.get('sellingprice') ?? 0.0,
          image: doc.get('image') ?? '',
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//stream for panels..
  Stream<List<PvModuleModel>?>? get panels {
    try {
      return equipmentreferences
          .where('Categoryname', isEqualTo: 'Panels')
          .orderBy('name')
          .snapshots()
          .map(_panellist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  List<InverterModel>? _tempinverterlist(QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return InverterModel(
          userid: doc.get('userid') ?? '',
          id: doc.get('id'),
          name: doc.get('name'),
          type: doc.get('type'),
          acvoltage: doc.get('acvoltage'),
          image: doc.get('image'),
          quantity: doc.get('quantity'),
          buyingprice: doc.get('buyingprice'),
          sellingprice: doc.get('sellingprice'),
          ratedpower: doc.get('ratedpower'),
          nominalvoltage: doc.get('nominalvoltage'),
          efficiency: doc.get('efficiency'),
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<List<PvModuleModel>?>? get temppanels {
    try {
      return temppanelreference
          .doc(doctoken)
          .collection('Panel_$doctoken')
          .orderBy('totalsellingprice', descending: false)
          //  .where('userid', isEqualTo: doctoken)
          .snapshots()
          .map(_temppanellist)
          .distinct();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<List<InverterModel>?>? get tempinverters {
    try {
      return tempinverterrefference
          .doc(doctoken)
          .collection('Inverter_$doctoken')
          .orderBy('sellingprice', descending: false)
          //.where('userid', isEqualTo: doctoken)
          .snapshots()
          .map(_tempinverterlist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // //panellistfromsnapshot
  List<BatteriesModel>? _batterieslist(QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return BatteriesModel(
          id: doc.get('id') ?? '',
          name: doc.get('name') ?? '',
          type: doc.get('type') ?? '',
          voltage: doc.get('voltage') ?? 0,
          capacity: doc.get('capacity') ?? 0,
          deep_of_discharge: doc.get('deep_of_discharge') ?? 0,
          quantity: doc.get('quantity') ?? 0,
          buyingprice: doc.get('buyingprice') ?? 0,
          sellingprice: doc.get('sellingprice') ?? 0,
          image: doc.get('image') ?? '',
          description: doc.get('description') ?? '',
          Categoryname: doc.get('Categoryname') ?? '',
          addedday: doc.get('addedday') ?? '',
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  List<BatteriesModel>? _tempbatterieslist(QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return BatteriesModel(
          userid: doc.get('userid') ?? '',
          itemid: doc.get('itemid') ?? '',
          id: doc.get('id') ?? '',
          name: doc.get('name') ?? '',
          type: doc.get('type') ?? '',
          voltage: doc.get('voltage') ?? 0,
          capacity: doc.get('capacity') ?? 0,
          deep_of_discharge: doc.get('deep_of_discharge') ?? 0,
          stockquantiy: doc.get('stockquantiy') ?? 0,
          sellingprice: doc.get('sellingprice') ?? 0,
          totalsellingprice: doc.get('totalsellingprice') ?? 0,
          buyingprice: doc.get('buyingprice') ?? 0,
          quantity: doc.get('quantity') ?? 0,
          parallel: doc.get('parrellel') ?? 0,
          series: doc.get('series') ?? 0,
          image: doc.get('image') ?? '',
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }



//stream for pathis.batteryquantity, this.batteryparallel, this.batteryseries,nels..
  Stream<List<BatteriesModel>?>? get batteries {
    try {
      return equipmentreferences
          .where('Categoryname', isEqualTo: 'Battery')
          .orderBy('name')
          .snapshots()
          .map(_batterieslist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<List<BatteriesModel>?>? get tempbatteries {
    try {
      return tempbatteryreference
          .doc(doctoken)
          .collection('Battery_$doctoken')
          .orderBy('totalsellingprice', descending: false)
          //.where('userid', isEqualTo: doctoken)
          .snapshots()
          .map(_tempbatterieslist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //controllerlistfromsnapshot
  List<ChargeControllerModel>? _controllerlist(QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return ChargeControllerModel(
          id: doc.get('id') ?? '',
          name: doc.get('name') ?? '',
          type: doc.get('type') ?? '',
          ratedVoltage: doc.get('ratedVoltage') ?? 0,
          current: doc.get('current') ?? 0,
          buyingprice: doc.get('buyingprice') ?? 0,
          sellingprice: doc.get('sellingprice') ?? 0,
          image: doc.get('image') ?? '',
          description: doc.get('description') ?? '',
          Categoryname: doc.get('Categoryname') ?? '',
          addedday: doc.get('addedday') ?? '',
          quantity: doc.get('quantity') ?? 0,
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  List<ChargeControllerModel>? _controllertemplist(QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return ChargeControllerModel(
          userid: doc.get('userid') ?? '',
          id: doc.get('id') ?? '',
          name: doc.get('name') ?? '',
          type: doc.get('type') ?? '',
          ratedVoltage: doc.get('voltage') ?? 0,
          current: doc.get('current') ?? 0,
          buyingprice: doc.get('buyingprice') ?? 0,
          sellingprice: doc.get('sellingprice') ?? 0,
          image: doc.get('image') ?? '',
          quantity: doc.get('quantity') ?? 0,
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//stream for controllers..
  Stream<List<ChargeControllerModel>?>? get controllers {
    try {
      return equipmentreferences
          .where('Categoryname', isEqualTo: 'Controler')
          .orderBy('name')
          .snapshots()
          .map(_controllerlist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//stream for controllers..
  Stream<List<ChargeControllerModel>?>? get tempcontrollers {
    try {
      return tempcontrollerrefference
          .doc(doctoken)
          .collection('Controller_$doctoken')
          .orderBy('sellingprice', descending: false)
          //.where('userid', isEqualTo: doctoken)
          .snapshots()
          .map(_controllertemplist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //controllerlistfromsnapshot
  List<InverterModel>? _inverterlist(QuerySnapshot? snapshot) {
    try {
      return snapshot!.docs.map((doc) {
        return InverterModel(
          id: doc.get('id') ?? '',
          name: doc.get('name') ?? '',
          type: doc.get('type') ?? '',
          ratedpower: doc.get('ratedpower') ?? 0,
          nominalvoltage: doc.get('nominalvoltage') ?? 0,
          acvoltage: doc.get('acvoltage') ?? 0,
          efficiency: doc.get('efficiency') ?? 0,
          buyingprice: doc.get('buyingprice') ?? 0,
          sellingprice: doc.get('sellingprice') ?? 0,
          Categoryname: doc.get('Categoryname'),
          description: doc.get('description') ?? '',
          image: doc.get('image') ?? '',
          addedday: doc.get('addedday') ?? '',
          quantity: doc.get('quantity') ?? 0,
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//stream for controllers..
  Stream<List<InverterModel>?>? get inverters {
    try {
      return equipmentreferences
          .where('Categoryname', isEqualTo: 'Inverter')
          .orderBy('name')
          .snapshots()
          .map(_inverterlist);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
