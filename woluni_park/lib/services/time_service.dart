import 'package:flutter/material.dart';

class TimeService {
  static Color getColorBasedOnDelay(int delay) {
    if (delay >= 0 && delay <= 15) return Color(0xff38C77F);
    if (delay >= 16 && delay <= 30) return Color(0xffCB9705);
    if (delay > 30) return Color(0xffFF3A17);
    return Color(0xff38C77F);
  }

  static Color getColorBasedOnDelayAlpha(int delay) {
    if (delay >= 0 && delay <= 15) return Color(0x5538C77F);
    if (delay >= 16 && delay <= 30) return Color(0x55CB9705);
    if (delay > 30) return Color(0x55FF3A17);
    return Color(0xaa38C77F);
  }
}
