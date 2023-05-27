// ignore_for_file: file_names
import 'package:flutter/material.dart';

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double screenAwareSize(double value, BuildContext context,
    {bool width = false}) {
  if (width) {
    return MediaQuery.of(context).size.width * (value / 414);
  } else {
    return MediaQuery.of(context).size.height * (value / 1181);
  }
}

addVerticalSp(double doublespace) {
  return SizedBox(
    height: doublespace,
  );
}

addHorizontalSp(double doubleSpace) {
  return SizedBox(
    width: doubleSpace,
  );
}
