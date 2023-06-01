import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:table_layout_demo/manager/controllers/controllers.dart';
import 'package:table_layout_demo/ui/sidebar_widget.dart';
import 'package:table_layout_demo/utils/utils.dart';
import 'ui/grid_canvas_widget.dart';

void main() {
  debugRepaintRainbowEnabled = false;
  Get.lazyPut(() => CanvasController());
  Get.lazyPut(() => GeneralTableController());
  runApp(const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      home: Material(child: Homepage())));
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  void restart() {
    setState(() {});
  }

  Future<Map?> _showSetBlockSizeDialog(
      BuildContext context, double width, double height, int? colCount) async {
    double? w = width;
    double? h = height;
    int? c = colCount;
    return await showDialog<Map>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Set Block Size (px)"),
            content: Material(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 150, child: Text("Width: ")),
                      Expanded(
                        child: TextField(
                          controller:
                              TextEditingController(text: width.toString()),
                          onChanged: (value) {
                            w = double.tryParse(value);
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 150, child: Text("Height: ")),
                      Expanded(
                        child: TextField(
                          controller:
                              TextEditingController(text: height.toString()),
                          onChanged: (value) {
                            h = double.tryParse(value);
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                          width: 150,
                          child: Text("Column count (0 to remove): ")),
                      Expanded(
                        child: TextField(
                          controller: TextEditingController(text: c.toString()),
                          onChanged: (value) {
                            c = int.tryParse(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: Get.back, child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    final Map map = {
                      "width": w,
                      "height": h,
                      "colCount": c,
                    };
                    Get.back(result: map);
                  },
                  child: const Text("Save")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // final BoxConstraints constraints = BoxConstraints(
    //   maxWidth: Get.width,
    //   maxHeight: Get.height,
    // );
    // logger('Screen size : => ${constraints.maxWidth} ${constraints.maxHeight}');
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                final Map? result = await _showSetBlockSizeDialog(
                    context,
                    GridSettingsConstants
                        .defaultGridCells.toOffsetFromCellIndex.dx,
                    GridSettingsConstants
                        .defaultGridCells.toOffsetFromCellIndex.dy,
                    GridSettingsConstants.columnCount);
                if (result != null) {
                  double? width = result["width"];
                  if (width != null) {
                    width = width / GridSettingsConstants.defaultGridInterval;
                  }
                  double? height = result["height"];
                  if (height != null) {
                    height = height / GridSettingsConstants.defaultGridInterval;
                  }
                  final colCount = result["colCount"];
                  if (colCount != null) {
                    GridSettingsConstants.columnCount = colCount;
                  }
                  if (width != null && height != null) {
                    GridSettingsConstants.defaultGridCells =
                        Offset(width, height);
                  }
                  restart();
                }
              },
              child: const Text("Set Screen size")),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // logger("Canvas Size : ${GlobalKeyConstants.canvasGridKey.getSize}");
          // logger(
          //     "Canvas Size : ${GridSettingsConstants.defaultGridCellSize.width * GridSettingsConstants.defaultGridCells.dx}");
          // logger(
          //     "Canvas Size : ${GridSettingsConstants.defaultGridCellSize.height * GridSettingsConstants.defaultGridCells.dy}");
          // logger(
          //     "Canvas left top corner : ${CanvasController.to.getLeftTopCorner}");
          // logger(
          //     "Canvas right top corner : ${CanvasController.to.getRightTopCorner}");
          // logger(
          //     "Canvas left bottom corner : ${CanvasController.to.geLeftBottomCorner}");
          // logger(
          //     "Canvas right bottom corner : ${CanvasController.to.getRightBottomCorner}");
          //
          // logger("--------------------------");
          // logger(
          //     "Selected table size : ${CanvasController.to.getSelectedTable?.controller.getSize}");
          // logger(
          //     "Selected table center position : ${CanvasController.to.getSelectedTable?.controller.getCenterOffset}");
          // logger(
          //     "Selected table left top corner : ${CanvasController.to.getSelectedTable?.controller.getLeftTopCorner}");
          // logger(
          //     "Selected table right top corner : ${CanvasController.to.getSelectedTable?.controller.getRightTopCorner}");
          // logger(
          //     "Selected table left bottom corner : ${CanvasController.to.getSelectedTable?.controller.getLeftBottomCorner}");
          // logger(
          //     "Table touching top : ${CanvasController.to.getSelectedTable?.controller.isTouchingCanvasTop}");
          // logger(
          //     "Table touching left : ${CanvasController.to.getSelectedTable?.controller.isTouchingCanvasLeft}");
          // logger(
          //     "Table touching right : ${CanvasController.to.getSelectedTable?.controller.isTouchingCanvasRight}");
          logger(
              "Table touching bottom : ${CanvasController.to.getSelectedTable?.controller.getOffset.toCellIndex}");
          // CanvasController.to.getSelectedTable?.controller.moveToBottomLeft();
        },
        label: const Text(
          'Test Button',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      backgroundColor: Colors.black26,
      body: Row(
        children: [
          Expanded(
            child: Align(
              child: SizedBox(
                width: (GridSettingsConstants.defaultGridCellSize.width *
                    GridSettingsConstants.defaultGridCells.dx),
                height: (GridSettingsConstants.defaultGridCellSize.height *
                    GridSettingsConstants.defaultGridCells.dy),
                child: GridCanvas(),
              ),
            ),
          ),
          const SidebarWidget(),
        ],
      ),
    );
  }
}
