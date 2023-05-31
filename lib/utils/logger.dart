import 'package:flutter/foundation.dart';

void logger(dynamic text, [String hint = ""]) {
  if (kDebugMode) {
    print(hint);
    print(text);
    print(hint);
  }
}
