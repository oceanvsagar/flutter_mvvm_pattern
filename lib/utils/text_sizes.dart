import 'dart:math';

import 'package:ekam_flutter_assignment/utils/utils.dart';

class TextSize {
  static double setSp(int size) {
    return (size / 720) * max(Utils.height, Utils.width);
  }

  static double listHeadingTextSize = setSp(15);
}

class Space {
  static double sp(int size) {
    return (size / 720) * max(Utils.height, Utils.width);
  }
}
