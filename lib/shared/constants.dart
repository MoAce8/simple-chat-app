import 'package:flutter/material.dart';

double screenWidth(context) {
  return MediaQuery.of(context).size.width;
}

///////////////////////////////////////////////////////////

double screenHeight(context) {
  return MediaQuery.of(context).size.height;
}
double sizeFromHeight(BuildContext context, double fraction, {bool hasAppBar = false}) {
  final screenHeight = MediaQuery.of(context).size.height;
  final calculateHeight = (hasAppBar
      ? (screenHeight -
      AppBar().preferredSize.height -
      MediaQuery.of(context).padding.top)
      : screenHeight) /
      fraction;
  return calculateHeight;
}
double sizeFromWidth(BuildContext context, double fraction) {
  final calculateWidth = MediaQuery.of(context).size.width / fraction;
  return calculateWidth;
}

const kPrimaryColor = Color(0xff2B475E);
const kAppLogo = 'assets/images/scholar.png';
const kMessage = 'message';
const kCreatedAt = 'createdAt';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}