import 'package:SolarExperto/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class NoData extends StatelessWidget {
  const NoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Image(
      width: 450.0,
      height: 450.0,
      image: AssetImage('assets/error404.png'),
    );
  }
}

class yelloNoData extends StatelessWidget {
  const yelloNoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      width: 450.0,
      height: 450.0,
      image: AssetImage('assets/yellow404.png'),
    );
  }
}
