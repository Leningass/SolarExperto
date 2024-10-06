import 'package:SolarExperto/constants/app_colors.dart';
import 'package:SolarExperto/constants/app_responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SaveLoading extends StatelessWidget {
  const SaveLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            child: SpinKitWave(
      color: AppColor.bgSideMenu,
      size: (!AppResponsive.isMobile(context)) ? 40 : 30,
    )));
  }
}
