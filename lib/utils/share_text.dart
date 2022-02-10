import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

void copyOderShareText({BuildContext? context, String? url}) async {
  if (!kIsWeb) {
    if (Platform.isAndroid || Platform.isIOS) {
      Share.share(url!);
    } else {
      final data = ClipboardData(text: url);
      await Clipboard.setData(data);
      ScaffoldMessenger.of(context!).showSnackBar(
        const SnackBar(content: Text('Text Copied To ClipBoard')),
      );
    }
  } else {
    final data = ClipboardData(text: url);
    await Clipboard.setData(data);
    ScaffoldMessenger.of(context!).showSnackBar(
      const SnackBar(content: Text('Text Copied To ClipBoard')),
    );
  }
}
