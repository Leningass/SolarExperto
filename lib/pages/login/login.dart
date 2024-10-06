import 'dart:ui';

import 'package:SolarExperto/constants/app_colors.dart';
import 'package:SolarExperto/constants/constants.dart';
import 'package:SolarExperto/global_widgets/Loading/loading.dart';
import 'package:SolarExperto/services/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(

      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
      //  color: AppColor.bgColor,
        image: DecorationImage(
          image: AssetImage('assets/background.jpeg',),
          fit: BoxFit.cover
        ),

      ),
      child: authProvider.status == Status.Authenticating
          ? Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Loading()],
        ),
      )
          : Scaffold(
        key: _key,
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: authProvider.formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: 400,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColor.bgColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      // width: 360,
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset(
                                'assets/images/main-logo.png'),

                            Text(
                              'Sign In to continue',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              validator: (value) =>
                                  authProvider.validateEmail(
                                      value.toString()),
                              controller: authProvider.email,
                              decoration: InputDecoration(
                                hintText: 'Enter email address',
                                filled: true,
                                fillColor: Colors.blueGrey[50],
                                labelStyle:
                                TextStyle(fontSize: 12),
                                contentPadding:
                                EdgeInsets.only(left: 30),
                                enabledBorder:
                                OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.bgColor),
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                                focusedBorder:
                                OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.bgColor),
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              validator: (value) =>
                                  authProvider.validatePassword(
                                      value.toString()),
                              controller: authProvider.password,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                hintText: 'Password',

                                suffixIcon: IconButton(
                                  color: Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      _obscureText =
                                      !_obscureText;
                                    });
                                  },
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.blueGrey[50],
                                labelStyle:
                                TextStyle(fontSize: 12),
                                contentPadding:
                                EdgeInsets.only(left: 30),
                                enabledBorder:
                                OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.bgColor),
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                                focusedBorder:
                                OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.bgColor),
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.bgColor,
                                    spreadRadius: 10,
                                    blurRadius: 20,
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    child: Center(
                                        child:
                                        Text("Sign In"))),
                                onPressed: () async {
                                  if (authProvider
                                      .formkey.currentState!
                                      .validate()) {
                                    if (!await authProvider
                                        .signIn()) {
                                      ScaffoldMessenger.of(
                                          context)
                                          .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  "Invalid email or password!")));
                                      return;
                                    }
                                    authProvider
                                        .clearController();
                                    SharedPreferences prefs =
                                    await SharedPreferences
                                        .getInstance();

                                    firebaseFiretore
                                        .collection(
                                        adminsCollection)
                                        .doc(prefs
                                        .getString("id"))
                                        .get()
                                        .then(
                                            (DocumentSnapshot) async {
                                          await prefs.setString(
                                              "name",
                                              DocumentSnapshot[
                                              'name']);
                                          await prefs.setString(
                                              "pic",
                                              DocumentSnapshot[
                                              'image']);
                                        });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: AppColor.bgSideMenu,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        15),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 40)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
