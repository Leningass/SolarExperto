import 'package:SolarExperto/provider/app_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../../../constants/constants.dart';
import '../../../../services/database/database_service.dart';

class Controller extends StatefulWidget {
  Controller({Key? key, required this.appProvider, this.Userid})
      : super(key: key);
  final AppProvider appProvider;
  final String? Userid;
  @override
  State<Controller> createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  @override
  void initState() {
    //Controller

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
