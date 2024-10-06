import 'package:flutter/material.dart';

class TabOption extends StatelessWidget {
  String type;
  int activeIndex;
  Function onSelect;
  TabOption({
    required this.type,
    required this.activeIndex,
    required this.onSelect,
  });

  int _currentIndex() {
    if (type == 'pumping') {
      return activeIndex - 2;
    }
    return activeIndex;
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = _currentIndex();
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (type == 'pumping') {
              onSelect(0 + 2);
            } else {
              onSelect(0);
            }
          },
          child: Container(
            margin: EdgeInsets.only(top: 50, left: 40, right: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              border: currentIndex == 0
                  ? Border.all(color: Colors.blue, width: 2)
                  : Border.symmetric(),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(1, 2), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Image(
                  image: AssetImage(type == 'home'
                      ? 'assets/home.png'
                      : 'assets/direct_pump.png'),
                  width: 300,
                  height: 170,
                  fit: BoxFit.fitWidth,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 15),
                  child: Text(
                    type == 'home' ? 'Automomous' : 'Direct Supply',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: currentIndex == 0 ? Colors.blue : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (type == 'pumping') {
              onSelect(1 + 2);
            } else {
              onSelect(1);
            }
          },
          child: Container(
            margin: EdgeInsets.only(top: 50, left: 40, right: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              border: currentIndex == 1
                  ? Border.all(color: Colors.blue, width: 2)
                  : Border.symmetric(),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(1, 2), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Image(
                  image: AssetImage(type == 'home'
                      ? 'assets/home_wire.png'
                      : 'assets/storage_pump.png'),
                  width: 300,
                  height: 170,
                  fit: BoxFit.fitWidth,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 15),
                  child: Text(
                    type == 'home' ? 'Network cut off' : 'Tank Supply',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: currentIndex == 1 ? Colors.blue : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
