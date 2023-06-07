import 'package:table_layout_demo/manager/dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'app.dart';

void main() {
  Manager.init();
  debugRepaintRainbowEnabled = false;

  runApp(const CGOApp());
}
