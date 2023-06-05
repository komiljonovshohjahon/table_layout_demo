import 'dart:convert';
import 'dart:io';

import 'package:creatego_packages/creatego_packages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_layout_demo/ui/table_widget.dart';
import 'package:table_layout_demo/utils/utils.dart';
import 'controllers.dart';
export '../../utils/logger.dart';

class CanvasController extends GetxController {
  static CanvasController get to => Get.find();
  final TextEditingController heightTEC = TextEditingController();
  final TextEditingController widthTEC = TextEditingController();

  bool get isTableTouchingCanvasLeft {
    return getSelectedTable?.controller.isTouchingCanvasLeft ?? false;
  }

  void moveTableToCanvasRightCorner() {}

  Offset get getLeftTopCorner {
    return GlobalKeyConstants.canvasGridKey.getPosition ?? Offset.zero;
  }

  Offset get getRightTopCorner {
    return Offset(
      getLeftTopCorner.dx +
          GridSettingsConstants.defaultGridCellSize.width *
              GridSettingsConstants.defaultGridCells.dx,
      getLeftTopCorner.dy,
    );
  }

  Offset get geLeftBottomCorner {
    return Offset(
      getLeftTopCorner.dx,
      getLeftTopCorner.dy +
          GridSettingsConstants.defaultGridCellSize.height *
              GridSettingsConstants.defaultGridCells.dy,
    );
  }

  Offset get getRightBottomCorner {
    return Offset(
      getLeftTopCorner.dx +
          GridSettingsConstants.defaultGridCellSize.width *
              GridSettingsConstants.defaultGridCells.dx,
      getLeftTopCorner.dy +
          GridSettingsConstants.defaultGridCellSize.height *
              GridSettingsConstants.defaultGridCells.dy,
    );
  }

  TableWidget? get getSelectedTable {
    TableWidget? t;
    for (final table in tables) {
      if (table.controller.getIsSelected) {
        t = table;
      }
    }
    return t;
  }

  final RxList<TableWidget> _tables = <TableWidget>[].obs;
  List<TableWidget> get tables => _tables;
  RxList<TableWidget> get tablesRx => _tables;

  bool isTableUsed(TableController ctr) {
    return tables.any((element) => element.controller.tableId == ctr.tableId);
  }

  void addTable(TableController ctr) {
    _tables.add(TableWidget(controller: ctr));
    selectTable(ctr, swap: false);
    update([GridConstants.gridSidebarBarTableListId]);
  }

  void removeTable() {
    _tables.removeWhere((element) =>
        element.controller.tableId == getSelectedTable?.controller.tableId);
    heightTEC.clear();
    widthTEC.clear();

    update([
      GridConstants.gridCanvasId,
      GridConstants.gridSidebarBarTableListId,
      GridConstants.gridSidebarTablePropsId,
    ]);
  }

  void clearSelectedTable() {
    getSelectedTable?.controller.callback?.call();
    if (tables.isNotEmpty) {
      for (final table in tables) {
        if (table.controller.getIsSelected) {
          table.controller.callback?.call();
          table.controller.setIsSelected = false;
        }
      }
      for (var element in tables) {
        element.controller.callback?.call();
      }
      heightTEC.clear();
      widthTEC.clear();
      update([
        GridConstants.gridSidebarTablePropsId,
        GridConstants.gridCanvasId,
      ]);
    }
  }

  void selectTable(TableController ctr, {bool swap = true}) {
    if (getSelectedTable != null) {
      getSelectedTable!.controller.callback?.call();
      getSelectedTable!.controller.setIsSelected = false;
    }
    ctr.setIsSelected = true;
    heightTEC.text = ctr.getSize.toCellIndex.height.toString();
    widthTEC.text = ctr.getSize.toCellIndex.width.toString();
    if (swap && tables.length >= 2) {
      final indexOf1 = tables.indexOf(tables
          .firstWhere((element) => element.controller.tableId == ctr.tableId));
      if (getSelectedTable != null) {
        List<TableWidget> l =
            swapList<TableWidget>(tables, indexOf1, tables.length - 1);
        _tables.assignAll(l);
      }
    }
    // ctr.callback?.call();
    logger("selectTable: ${ctr.tableId}");
    update([GridConstants.gridCanvasId, GridConstants.gridSidebarTablePropsId]);
  }

  @override
  void onReady() {
    super.onReady();
    heightTEC.addListener(() {
      if (heightTEC.text.endsWith(".0")) {
        heightTEC.text = heightTEC.text.substring(0, heightTEC.text.length - 2);
      }
    });
    widthTEC.addListener(() {
      if (widthTEC.text.endsWith(".0")) {
        widthTEC.text = widthTEC.text.substring(0, widthTEC.text.length - 2);
      }
    });

    _tables.listen((p0) {
      logger("tables OLD: $tables");
      logger("tables: $p0");
      //New added
    });
  }

  @override
  void onClose() {
    heightTEC.dispose();
    widthTEC.dispose();
    super.onClose();
  }

  Future<void> saveAsJson() async {
    //get the name of the widget
    String widgetName = "test";

    //get the type of the widget
    final String type = "test";

    //get the block size
    final Size canvasSize = Size(
        GridSettingsConstants.defaultGridCells.toOffsetFromCellIndex.dx,
        GridSettingsConstants.defaultGridCells.toOffsetFromCellIndex.dy);

    //get the children of the widget
    final List<TableController> childrenControllers =
        tables.map<TableController>((element) => element.controller).toList();

    // waiting for the user to enter the name of the widget
    await Get.dialog(AlertDialog(
      title: Text("Please enter the name of the widget"),
      content: TextFormField(
        initialValue: widgetName,
        decoration: InputDecoration(hintText: "Widget name"),
        onChanged: (value) {
          widgetName = value;
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Get.back(result: widgetName);
          },
          child: Text("Save"),
        ),
      ],
    ));
    if (widgetName.isEmpty) {
      Get.showSnackbar(GetSnackBar(
        title: "Error",
        message: "Please enter a name",
      ));
      return;
    }

    Future<bool> writeJson(File json) async {
      bool success = false;
      final File file = await json.writeAsString(
        jsonEncode({
          "component_name": widgetName,
          "component_type": type,
          "options": {
            "required_variables": [
              {
                "name": "component_width",
                "type": "double",
                "value": canvasSize.width
              },
              {
                "name": "component_height",
                "type": "double",
                "value": canvasSize.height
              }
            ]
          },
          "children": [
            for (final child in childrenControllers)
              {
                "offset": {"x": child.getOffset.dx, "y": child.getOffset.dy},
                "size": {"w": child.getSize.width, "h": child.getSize.height},
                "name": "child_${child.tableId}",
                "type": child.child.toString(),
                "option_type": "ButtonOptions",
                "options": child.child!.options.toMap()
              }
          ]
        }),
      );
      if (file.existsSync()) {
        success = true;
      }
      return success;
    }

    //create a JSON file and save locally with the above data
    final File json = File("gen/widget_configs/${widgetName}_config.json");
    writeJson(json).then((success) {
      Get.showSnackbar(const GetSnackBar(
        duration: Duration(seconds: 2),
        title: "Success",
        message: "Widget saved successfully",
      ));
    });
  }
}
