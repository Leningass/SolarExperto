import 'dart:math';

import 'package:SolarExperto/constants/constants.dart';
import 'package:SolarExperto/models/user/user.dart';

class UserServices {
  void createAdmin({
    String? id,
    String? name,
    String? email,

  }) {
    firebaseFiretore.collection(adminsCollection).doc(id).set({
      "name": name,
      "id": id,
      "email": email,

    });
  }

  void updateUserData(Map<String, dynamic> values) {
    firebaseFiretore
        .collection(adminsCollection)
        .doc(values['id'])
        .update(values);
  }

  Future<UserModel> getAdminById(String id) =>
      firebaseFiretore.collection(adminsCollection).doc(id).get().then((doc) {
        return UserModel.fromSnapshot(doc);

      });
}
