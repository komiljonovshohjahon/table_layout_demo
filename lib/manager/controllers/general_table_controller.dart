import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_layout_demo/manager/dependencies/dependencies.dart';
import 'package:table_layout_demo/utils/utils.dart';
import 'controllers.dart';

class GeneralTableController extends GetxController {
  void onChangeTableSize({String? width, String? height}) {
    if (width != null || height != null) {
      final getSelectedTable = Manager.canvasController.getSelectedTable;
      final widthTEC = Manager.canvasController.widthTEC;
      final heightTEC = Manager.canvasController.heightTEC;
      if (width != null) {
        if ((width.isNotEmpty && width != "0") && (num.parse(width) > 0)) {
          widthTEC.text = width;
        } else if (getSelectedTable != null && width == "0") {
          widthTEC.text =
              getSelectedTable.controller.getSize.toCellIndex.width.toString();
        } else {
          if (getSelectedTable != null) {
            widthTEC.text = getSelectedTable
                .controller.getSize.toCellIndex.width
                .toString();
          }
        }
        if (double.parse(widthTEC.text) >
            Manager.configDep.sizes.defaultGridCells.dx) {
          ScaffoldMessenger.of(Get.key.currentContext!).showSnackBar(SnackBar(
              action: SnackBarAction(
                onPressed: () {
                  ScaffoldMessenger.of(Get.key.currentContext!)
                      .clearSnackBars();
                },
                label: "Close",
              ),
              content:
                  const Text("Width cannot be greater than the canvas width")));
          return;
        }
      }
      if (height != null) {
        if ((height.isNotEmpty && height != "0") && (num.parse(height) > 0)) {
          heightTEC.text = height;
        } else if ((getSelectedTable != null && height == "0")) {
          heightTEC.text =
              getSelectedTable.controller.getSize.toCellIndex.height.toString();
        } else {
          if (getSelectedTable != null) {
            heightTEC.text = getSelectedTable
                .controller.getSize.toCellIndex.height
                .toString();
          }
        }
        if (double.parse(heightTEC.text) >
            Manager.configDep.sizes.defaultGridCells.dy) {
          ScaffoldMessenger.of(Get.key.currentContext!).showSnackBar(SnackBar(
              action: SnackBarAction(
                onPressed: () {
                  ScaffoldMessenger.of(Get.key.currentContext!)
                      .clearSnackBars();
                },
                label: "Close",
              ),
              content: const Text(
                  "Height cannot be greater than the canvas height")));
          return;
        }
      }
      getSelectedTable?.controller.changeSize(
          isAsCellIndex: true,
          height: double.parse(heightTEC.text),
          width: double.parse(widthTEC.text));
    }
  }
}
