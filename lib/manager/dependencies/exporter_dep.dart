import 'dart:convert';
import 'dart:io';

import 'package:creatego_packages/creatego_packages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_client/github_client.dart';
import 'package:table_layout_demo/manager/controllers/controllers.dart';
import 'package:table_layout_demo/manager/models/models.dart';
import 'package:table_layout_demo/utils/utils.dart';
import 'dependencies.dart';

class ExporterDep extends IExporter {
  // create a singleton
  static final ExporterDep _singleton = ExporterDep._internal();

  // create a factory constructor

  factory ExporterDep() {
    return _singleton;
  }

  ExporterDep._internal();

  //get the block size
  Size get canvasSize => Size(
      Manager.configDep.sizes.defaultGridCells.toOffsetFromCellIndex.dx,
      Manager.configDep.sizes.defaultGridCells.toOffsetFromCellIndex.dy);

  @override
  void setJsonModel({
    String? id,
    required String componentName,
    required String componentType,
    required Options options,
    required List<Child> children,
  }) {
    jsonModel = JsonModel(
      id: id ?? "${componentName}_id_${DateTime.now().millisecondsSinceEpoch}",
      children: children,
      componentName: componentName,
      componentType: componentType,
      options: options,
    );
  }

  @override
  String getSavePath(String widgetName) {
    return "gen/configs/${widgetName}_config.json"; //TODO: Fix the path
  }

  @override
  Future<String?> showNamePopup([String? widgetName]) async {
    String? _name = widgetName;
    final String? name = await Get.dialog<String>(AlertDialog(
      title: const Text("Please enter the name of the widget"),
      content: TextFormField(
        initialValue: _name,
        onChanged: (value) {
          _name = value;
        },
        decoration: const InputDecoration(hintText: "Widget name"),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Get.back(result: _name);
          },
          child: const Text("Save"),
        ),
      ],
    ));
    if (name != null && name.isEmpty) {
      showSnackbar("Please enter a name", "Error");
    }
    return name;
  }

  @override
  void showSnackbar(String message, [String title = "Success"]) {
    Get.showSnackbar(GetSnackBar(
      duration: const Duration(seconds: 3),
      title: title,
      message: message,
    ));
  }

  @override
  Future<void> export(
      List<TableController> children, List<VarModel> customVariables,
      {String? id}) async {
    //find name
    final String? widgetName = await showNamePopup('test1');
    if (widgetName == null) return;
    const String widgetType = "test"; //TODO: get widget type
    final Options options = Options(
      componentWidth: canvasSize.width,
      componentHeight: canvasSize.height,
      customVariables: customVariables,
    );
    final List<Child> ch = [];
    for (var child in children) {
      ch.add(Child(
          offset: child.getOffset,
          size: child.getSize,
          name: child.getTableName,
          type: child.child.toString(),
          optionType: "ButtonOptions",
          options: child.child!.options.toMap()));
    }
    setJsonModel(
        id: id,
        componentName: widgetName,
        componentType: widgetType,
        options: options,
        children: ch);
    // final String path = getSavePath(widgetName);
    bool success = false;
    final res = await GithubClient.postContent(
        widgetName, jsonModel.toJson().toString());
    success = res != null;
    if (success) {
      showSnackbar("Export successful");
    } else {
      showSnackbar("Export failed", "Error");
    }
  }

  //TODO:
  @override
  Future<JsonModel> importFromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}

abstract class IExporter {
  late JsonModel jsonModel;

  ///set the json model
  void setJsonModel({
    String? id,
    required String componentName,
    required String componentType,
    required Options options,
    required List<Child> children,
  });

  ///get the file saving path
  String getSavePath(String widgetName);

  ///Show Popup
  Future<String?> showNamePopup([String? widgetName]);

  ///show snackbar
  void showSnackbar(String message, [String title = "Success"]);

  ///perform export
  Future<void> export(
      List<TableController> children, List<VarModel> customVariables,
      {String? id});

  ///import file
  Future<JsonModel> importFromJson(Map<String, dynamic> json);
}
