extension DateTimeExtension on DateTime {
  int get weekOfMonth {
    var wom = 0;
    var date = this;

    while (date.month == month) {
      date = date.subtract(const Duration(days: 7));
      wom++;
    }

    return wom;
  }
}
