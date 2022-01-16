import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageRouter {
  BuildContext? ctx;
  PageRouter(this.ctx);

  ///Android
  void pushPage(Widget page) {
    if (Platform.isAndroid) {
      Navigator.push(ctx!, MaterialPageRoute(builder: (ctx) => page));
    } else {
      Navigator.push(ctx!, CupertinoPageRoute(builder: (ctx) => page));
    }
  }

  void pushPageAndRemove(Widget page) {
    if (Platform.isAndroid) {
      Navigator.pushAndRemoveUntil(
          ctx!, MaterialPageRoute(builder: (ctx) => page), (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          ctx!, CupertinoPageRoute(builder: (ctx) => page), (route) => false);
    }
  }
}
