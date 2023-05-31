import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_layout_demo/manager/controllers/controllers.dart';
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
        decoration: GridDecorations.defaultGridBackgroundImage != null
            ? BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage(GridDecorations.defaultGridBackgroundImage!),
                  fit: BoxFit.cover,
                ),
              )
            : const BoxDecoration(),
        child: GridPaper(
          key: GlobalKeyConstants.canvasGridKey,
          divisions: 1,
          color: GridDecorations.defaultGridColor,
          interval: GridSettingsConstants.defaultGridInterval,
          subdivisions: GridSettingsConstants.defaultGridSubdivision,
          child: GetBuilder<CanvasController>(
            id: GridConstants.gridCanvasId,
            builder: (ctr) => ColoredBox(
              color: GridDecorations.defaultBackgroundColor,
              child: RepaintBoundary(
                child: Stack(
                  children: [
                    if (GridSettingsConstants.columnCount > 1)
                      IgnorePointer(
                        child: SpacedRow(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          horizontalSpace: GridSettingsConstants.columnGutter,
                          children: [
                            for (int i = 0;
                                i < GridSettingsConstants.columnCount;
                                i++)
                              Expanded(
                                child: Container(
                                  height: double.infinity,
                                  color: GridSettingsConstants.columnColor,
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
