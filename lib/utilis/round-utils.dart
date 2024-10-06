int roundvalue(double value) {
  int afterPoint = ((value.abs() * 100).round() % 100).toInt();
  print('After Point: ${afterPoint}');
  if (afterPoint >= 01) {
    return value.ceil();
  } else {
    return value.round();
  }
}
