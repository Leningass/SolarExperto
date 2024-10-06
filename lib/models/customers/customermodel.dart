import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final String address;
  final Timestamp addedday;
  CustomerModel(
      {required this.id,
      required this.name,
      required this.phone,
       this.email,
      required this.address,
      required this.addedday
      });
}

class Consumption {
  const Consumption({
    required this.day,
    required this.usage,
  });

  final String day;
  final double usage;
}
