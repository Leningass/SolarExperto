import 'package:SolarExperto/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';

class Header extends StatefulWidget {
  String text;
  bool backDisabled;
  bool forwardDisabled;
  Function onNavigate;
  Header({
    required this.text,
    required this.backDisabled,
    required this.forwardDisabled,
    required this.onNavigate,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25, left: 30, right: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(1, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: widget.backDisabled ? Colors.grey : AppColor.yellow,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: IconButton(
              onPressed: () {
                setState(() {
                  if (!widget.backDisabled) {
                    widget.onNavigate(-1);
                  }
                });
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            widget.text,
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
          ),
          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: widget.forwardDisabled ? Colors.grey : AppColor.yellow,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: IconButton(
              onPressed: () {
                setState(() {
                  if (!widget.forwardDisabled) {
                    widget.onNavigate(1);
                  }
                });
              },
              icon: Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
