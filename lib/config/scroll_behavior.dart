
import 'dart:ui';

import 'package:flutter/material.dart';

/// Enables Swiping on the PageView widgets foor Web and Desktop
class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
