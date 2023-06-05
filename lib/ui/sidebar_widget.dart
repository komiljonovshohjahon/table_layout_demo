import 'package:creatego_packages/creatego_packages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_layout_demo/manager/controllers/controllers.dart';
import 'package:table_layout_demo/manager/models/models.dart';
import 'package:table_layout_demo/ui/table_widget.dart';
import 'package:table_layout_demo/utils/utils.dart';

class SidebarWidget extends StatelessWidget {
  const SidebarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CanvasController());
    return Container(
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: Colors.black)),
        color: Colors.white,
      ),
      width: GridSettingsConstants.defaultSidebarWidth,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Center(
                child: Text(
                  'Widgets',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 20),
              RepaintBoundary(
                child: GetBuilder<CanvasController>(
                  id: GridConstants.gridSidebarBarTableListId,
                  builder: (controller) => SizedBox(
                    height: MediaQuery.of(context).size.height / 2 - 100,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          for (int i = 0; i < coreWidgets.length; i++)
                            _buildTableButton(
                                tableId: i.toString(), child: coreWidgets[i]),
                          for (int i = 0; i < yoshopWidgets.length; i++)
                            _buildTableButton(
                                tableId: i.toString(), child: yoshopWidgets[i]),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(height: 2, color: Colors.blueGrey),
              Center(
                child: Text(
                  'Options',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 20),
              RepaintBoundary(
                child: GetBuilder<CanvasController>(
                    id: GridConstants.gridSidebarTablePropsId,
                    builder: (controller) => Opacity(
                        opacity: controller.getSelectedTable == null ? 0.5 : 1,
                        child: IgnorePointer(
                            ignoring: controller.getSelectedTable == null,
                            child:
                                _buildTableParamsWidget(context, controller)))),
              ),
            ],
          ),
          const Divider(),
          RepaintBoundary(
            child: GetBuilder<CanvasController>(
              id: GridConstants.gridSidebarTablePropsId,
              builder: (controller) => SpacedRow(
                children: [
                  // Expanded(
                  //   child: TextButton(
                  //       onPressed: controller.getSelectedTable != null
                  //           ? controller.removeTable
                  //           : null,
                  //       style: TextButton.styleFrom(
                  //           side: const BorderSide(
                  //         color: Colors.blueGrey,
                  //         width: 1,
                  //       )),
                  //       child: const Text("Delete")),
                  // ),
                  Expanded(
                    child: TextButton(
                        onPressed: controller.saveAsJson,
                        style: TextButton.styleFrom(
                            side: const BorderSide(
                          color: Colors.blueGrey,
                          width: 1,
                        )),
                        child: const Text("Save as JSON")),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableParamsWidget(
      BuildContext context, CanvasController controller) {
    List<Widget> params = [];
    Widget getTitle(String title) {
      return Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    Widget getShapeWidget(TableShape shape) {
      void onTap() {
        controller.getSelectedTable?.controller.changeShape(shape);
        // GeneralTableController.to.onChangeTableShape(shape);
      }

      bool isSelected =
          controller.getSelectedTable?.controller.getTableShape == shape;
      final decoration = BoxDecoration(
        color: isSelected ? Colors.lightBlueAccent : Colors.white,
        border: Border.all(color: Colors.black, width: isSelected ? 1 : 1),
      );
      switch (shape) {
        case TableShape.rectangle:
          return InkWell(
            onTap: onTap,
            child: Container(
              decoration: decoration,
              padding: const EdgeInsets.all(5),
              child: Container(
                width: 50,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                ),
              ),
            ),
          );
        case TableShape.circle:
          return InkWell(
            onTap: onTap,
            child: Container(
              decoration: decoration,
              padding: const EdgeInsets.all(5),
              child: Container(
                width: 50,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                ),
              ),
            ),
          );
      }
    }

    // params.add(Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     getTitle("Shape"),
    //     Row(
    //       children: [
    //         getShapeWidget(TableShape.rectangle),
    //         const SizedBox(width: 10),
    //         getShapeWidget(TableShape.circle),
    //       ],
    //     )
    //   ],
    // ));

    params.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getTitle("Width"),
        SizedBox(
          width: 150,
          height: 30,
          child: TextFormField(
            onFieldSubmitted: (value) =>
                GeneralTableController.to.onChangeTableSize(width: value),
            keyboardType: TextInputType.number,
            controller: controller.widthTEC,
            decoration: const InputDecoration(
              // suffixText: (controller.getSelectedTable?.controller.getSize
              //     .toString()),
              border: OutlineInputBorder(),
              hintText: 'Enter table width',
              hintStyle: TextStyle(fontSize: 12),
            ),
          ),
        ),
      ],
    ));

    params.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getTitle("Height"),
        SizedBox(
          width: 150,
          height: 30,
          child: TextFormField(
            onFieldSubmitted: (value) =>
                GeneralTableController.to.onChangeTableSize(height: value),
            keyboardType: TextInputType.number,
            controller: controller.heightTEC,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter table height',
              hintStyle: TextStyle(fontSize: 12),
            ),
          ),
        ),
      ],
    ));

    if (controller.getSelectedTable != null) {
      if (controller.getSelectedTable!.controller.child != null) {
        for (int i = 0;
            i < controller.getSelectedTable!.controller.child!.resources.length;
            i++) {
          final resource =
              controller.getSelectedTable!.controller.child!.resources[i];
          params.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getTitle("Option ${i + 1}"),
              Flexible(
                child: resource,
              ),
            ],
          ));
        }
      }
    }

    return RepaintBoundary(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2 - 100,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          children: [
            for (Widget param in params) ...[param, const SizedBox(height: 20)],
          ],
        ),
      ),
    );
  }

  Widget _buildTableButton({required String tableId, required IWidget child}) {
    final tableCtr = TableController(
        tableId: tableId,
        tableDecoration: TableDecoration(child: child.copy()));
    return Container(
      width: 80,
      height: 80,
      color: Colors.black38,
      child: TableWidget(
        isPositioned: false,
        isDisabled: false, // isDisabled,
        onTap: () {
          CanvasController.to.addTable(tableCtr);
        },
        controller: tableCtr,
      ),
    );
  }
}
