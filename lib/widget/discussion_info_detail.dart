import 'package:flutter/material.dart';
import 'package:SolarExperto/constants/constants.dart';
import 'package:SolarExperto/constants/app_colors.dart';
import 'package:SolarExperto/models/discussion%20info/discussions_info_model.dart';

class DiscussionInfoDetail extends StatelessWidget {
  const DiscussionInfoDetail({Key? key, required this.info}) : super(key: key);

  final DiscussionInfoModel info;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: appPadding),
      padding: EdgeInsets.all(10 / 2),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.asset(
              info.imageSrc!,
              height: 38,
              width: 38,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    info.name!,
                    style: TextStyle(
                        color: AppColor.black, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    info.date!,
                    style: TextStyle(
                      color: AppColor.black.withOpacity(0.5),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // IconButton(
          //   icon: Icon(
          //     Icons.more_vert_rounded,
          //     color: AppColor.black.withOpacity(0.5),
          //     size: 18,
          //   ),
          //   onPressed: () {
          //     print('daa');
          //   },
          // )
          PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
              itemBuilder: (context) {
            return [
              PopupMenuItem<int>(
                value: 0,
                child: Text("Update"),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text("Delete"),
              ),
            ];
          }, onSelected: (value) {
            if (value == 0) {
              print("My account menu is selected.");
            } else if (value == 1) {
              print("Settings menu is selected.");
            }
          }),
        ],
      ),
    );
  }
}
