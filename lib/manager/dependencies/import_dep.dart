import 'dart:convert';

import 'package:creatego_packages/creatego_packages.dart';
import 'package:table_layout_demo/manager/controllers/controllers.dart';
import 'package:table_layout_demo/manager/dependencies/dependencies.dart';
import 'package:table_layout_demo/manager/models/json_model.dart';
import 'package:table_layout_demo/utils/utils.dart';

class ImporterDep extends IImporter {
  @override
  Future<void> import(String json) async {
    // 0. Parse json
    final jsonResult = jsonDecode(json);
    final JsonModel jsonModel = JsonModel.fromJson(jsonResult);

    // 1. Set size
    setScreenSize(
        jsonModel.options.componentWidth, jsonModel.options.componentHeight);

    // 1.1 Set id
    Manager.canvasController.id = jsonModel.id;

    // 2. Add children
    final children = jsonModel.children;
    for (var child in children) {
      final tableCtr = TableController.fromChild(child);
      Manager.canvasController.addTable(tableCtr);
    }
  }

  @override
  void setScreenSize(double width, double height) {
    Manager.configDep.sizes.defaultGridCells =
        Offset(width, height).toCellIndex;
    Manager.appDep.restart();
  }
}

abstract class IImporter {
  Future<void> import(String json);

  void setScreenSize(double width, double height);
}
