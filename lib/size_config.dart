import 'package:flutter/widgets.dart';

class SizeConfig {
  late final MediaQueryData mediaQueryData;
  double screenWidth = 0;
  double screenHeight = 0;
  static double defaultSize = 0;
  static Orientation? orientation;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    orientation = mediaQueryData.orientation;
    // On iPhone 11 the defaultSize = 10 almost
    // So if the screen size increase or decrease then our defaultSize also vary
    defaultSize = orientation == Orientation.landscape
        ? screenHeight * 0.024
        : screenWidth * 0.024;
  }
}
