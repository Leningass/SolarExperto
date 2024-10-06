import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  bool active;
  String text;
  Function()? onClick;
  TabItem({

    required this.active,
    required this.text,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: active
            ? Border(
                bottom: BorderSide(
                  color: Colors.blue,
                  width: 3.0,
                ),
              )
            : Border.symmetric(),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: active ? Colors.blue : Colors.black,
        ),
      ),
    ),
    );
  }
}
