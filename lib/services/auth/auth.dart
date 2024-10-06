import 'dart:async';
import 'dart:io';

import 'package:SolarExperto/constants/constants.dart';
import 'package:SolarExperto/models/user/user.dart';
import 'package:SolarExperto/services/userservice/user.dart';
import 'package:SolarExperto/utilis/UplaodImages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  User? _user;
  Status _status = Status.Uninitialized;
  final UserServices _userServices = UserServices();
  UserModel? _userModel;

//  getter
  UserModel? get userModel => _userModel;
  Status get status => _status;
  User? get user => _user;

  // public variables
  final formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();

  AuthProvider.initialize() {
    _fireSetUp();
  }

  _fireSetUp() async {
    await initialization.then((value) {
      auth.authStateChanges().listen(_onStateChanged);
    });
  }

  Future<bool> signIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      _status = Status.Authenticating;
      notifyListeners();
      await auth
          .signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim())
          .then((value) async {
        await prefs.setString("id", value.user!.uid);
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp( BuildContext context) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim())
          .then((result) async {
        _userServices.createAdmin(
          id: result.user!.uid,
          name: name.text.trim(),
          email: email.text.trim(),

        );
      });
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code.toString());
      if (e.code.toString() == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Email Already In Use")));
      }
      if (e.code.toString() == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Password Must be Atleast 8 Characters")));
      }
      return false;
    }
  }

  Future signOut() async {
    auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController() {
    name.text = "";
    password.text = "";
    email.text = "";
  }

  Future<void> reloadUserModel() async {
    _userModel = await _userServices.getAdminById(user!.uid);
    notifyListeners();
  }

  updateUserData(Map<String, dynamic> data) async {
    _userServices.updateUserData(data);
  }

  _onStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;

      _userModel = await _userServices.getAdminById(user!.uid).then((value) {
        _status = Status.Authenticated;
        return value;
      });
    }
    notifyListeners();
  }
  String? validatePassword(String value){
    value=value.trim();
    if(password.text!=null){
      if(value.isEmpty){
        return 'Password can\'t be empty';
      }
      else if(password.text.length<8){
        return 'Password length should be 8';
      }
    }

  }
  String? validateEmail(String value) {
    value = value.trim();

    if (email.text != null) {
      if (value.isEmpty) {
        return 'Email can\'t be empty';
      } else if (!value.contains(RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
        return 'Enter a correct email address';
      }
    }

    return null;
  }
}
