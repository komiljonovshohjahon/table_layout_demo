import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_layout_demo/manager/controllers/controllers.dart';
import 'package:table_layout_demo/manager/dependencies/dependencies.dart';
import 'package:table_layout_demo/ui/spaced_row.dart';
import 'package:table_layout_demo/utils/utils.dart';

class GridCanvas extends StatelessWidget {
  GridCanvas({super.key});

  int oldDy = 0;
  bool reversed = false;
  int reversedAt = 0;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: DecoratedBox(
        decoration:
            Manager.configDep.decorations.defaultGridBackgroundImage != null
                ? BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Manager
                          .configDep.decorations.defaultGridBackgroundImage!),
                      fit: BoxFit.cover,
                    ),
                  )
                : const BoxDecoration(),
        child: GridPaper(
          key: GridConstants.canvasGridKey,
          divisions: 1,
          color: Manager.configDep.decorations.defaultGridColor,
          interval: Manager.configDep.sizes.defaultGridCellSize.width,
          subdivisions: Manager.configDep.sizes.defaultGridSubdivision,
          child: GetBuilder<CanvasController>(
            id: GridConstants.gridCanvasId,
            builder: (ctr) => ColoredBox(
              color: Manager.configDep.decorations.defaultBackgroundColor,
              child: RepaintBoundary(
                child: Stack(
                  children: [
                    if (Manager.configDep.sizes.columnCount > 1)
                      IgnorePointer(
                        child: SpacedRow(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          horizontalSpace: Manager.configDep.sizes.columnGutter,
                          children: [
                            for (int i = 0;
                                i < Manager.configDep.sizes.columnCount;
                                i++)
                              Expanded(
                                child: Container(
                                  height: double.infinity,
                                  color:
                                      Manager.configDep.decorations.columnColor,
                                ),
                              ),
                          ],
                        ),
                      ),
                    if (ctr.tables.isEmpty)
                      Center(
                          child: Text(
                        'Add tables',
                        style: Theme.of(context).textTheme.headline1,
                      )),
                    //// Handles the outside click to deselect the selected table
                    GestureDetector(
                        onTap: ctr.clearSelectedTable,
                        child: Container(color: Colors.transparent)),
                    ...ctr.tables,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
