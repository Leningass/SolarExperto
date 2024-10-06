import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const PIC = "image";

  String? id;
  String? name;
  String? email;


//  getters
  String? get names => name;
  String? get emails => email;
  String? get ids => id;


  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot[NAME];
    email = snapshot[EMAIL];
    id = snapshot[ID];

  }

  UserModel({required this.id,required this.name,
    required this.email,
    });
}
