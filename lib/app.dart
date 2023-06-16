import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_layout_demo/manager/models/json_model.dart';
import 'package:table_layout_demo/utils/utils.dart';
import 'manager/dependencies/dependencies.dart';
import 'ui/grid_canvas_widget.dart';
import 'ui/sidebar_widget.dart';

class CGOApp extends StatelessWidget {
  const CGOApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        showPerformanceOverlay: false,
        home: Material(child: _Homepage()));
  }
}

class _Homepage extends StatefulWidget {
  const _Homepage({Key? key}) : super(key: key);

  @override
  State<_Homepage> createState() => __HomepageState();
}

class __HomepageState extends State<_Homepage> {
  void restart() {
    setState(() {});
    logger("APP RESTART", "APP");
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
  void initState() {
    super.initState();
    Manager.appDep.restart = restart;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //// Handles the outside click to deselect the selected table
      onTap: Manager.canvasController.clearSelectedTable,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  final Map? result = await _showSetBlockSizeDialog(
                      context,
                      Manager.configDep.sizes.defaultGridCells
                          .toOffsetFromCellIndex.dx,
                      Manager.configDep.sizes.defaultGridCells
                          .toOffsetFromCellIndex.dy,
                      Manager.configDep.sizes.columnCount);
                  if (result != null) {
                    double? width = result["width"];
                    if (width != null) {
                      width = width /
                          Manager.configDep.sizes.defaultGridCellSize.width;
                    }
                    double? height = result["height"];
                    if (height != null) {
                      height = height /
                          Manager.configDep.sizes.defaultGridCellSize.width;
                    }
                    final colCount = result["colCount"];
                    if (colCount != null) {
                      Manager.configDep.sizes.columnCount = colCount;
                    }
                    if (width != null && height != null) {
                      Manager.configDep.sizes.defaultGridCells =
                          Offset(width, height);
                    }
                    restart();
                  }
                },
                child: const Text("Set Screen size")),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            String data = await DefaultAssetBundle.of(context)
                .loadString("assets/widgets/test1_config.json");
            final jsonResult = jsonDecode(data); //latest Dart
            final JsonModel jsonModel = JsonModel.fromJson(jsonResult);
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
                  width: (Manager.configDep.sizes.defaultGridCellSize.width *
                      Manager.configDep.sizes.defaultGridCells.dx),
                  height: (Manager.configDep.sizes.defaultGridCellSize.height *
                      Manager.configDep.sizes.defaultGridCells.dy),
                  child: GridCanvas(),
                ),
              ),
            ),
            const SidebarWidget(),
          ],
        ),
      ),
    );
  }
}
