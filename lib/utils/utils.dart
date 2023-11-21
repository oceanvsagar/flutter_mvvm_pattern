import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'colors.dart';

class Utils {
  static double height = 720;
  static double width = 560;

  static init(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    height = mediaQueryData.size.height - mediaQueryData.padding.bottom;
    width = mediaQueryData.size.width;
  }

  static String success = "Success";

  static String getPlatformCode() {
    if (kIsWeb) {
      return "2";
    }
    return Platform.isAndroid ? "2" : "1";
  }

  static void print(String message) {
    debugPrint(message);
  }

  static void printCrashError(String message) {
    debugPrint(message);
  }
}
