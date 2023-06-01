import 'package:creatego_packages/creatego_packages.dart';
import 'package:table_layout_demo/utils/utils.dart';

class GlobalKeyConstants {
  static GlobalKey canvasGridKey = GlobalKey(debugLabel: 'CANVAS_GRID_KEY');
}

class GridSettingsConstants {
  static int columnCount = 0;
  static double columnGutter = 30;
  static Color columnColor = const Color(0xFFFF0000).withOpacity(.1);

  ///When true, the selected table can go off through the canvas boundaries
  ///
  /// Default to: false
  static bool canItemGoOffCanvasBoundaries = false;

  ///Number of cells in the grid => (x,y)
  ///
  /// Default to: (x = 60, y = 50)
  static Offset defaultGridCells =
      const Offset(60, 50); // Number of pixels in the grid x and y

  /// Number of pixels in each cell => (width, height)
  ///
  /// Default to: (width = 10, height = 10)
  static Size defaultGridCellSize = const Size(10, 10);

  /// Makes 1 cell [_defaultGridCellSize.height] pixels
  static int get defaultGridSubdivision =>
      defaultGridCellSize.width ~/ defaultGridCellSize.height;
  static Size get defaultTableSize =>
      const Size(8, 8).toSizeFromCellIndex; // 8 is pixels of table
  static double defaultSidebarWidth = 500;
}

class GridConstants {
  static const String gridCanvasId = "grid_canvas";
  static const String gridSidebarTablePropsId = "sidebar_table_props";
  static const String gridSidebarBarTableListId = "sidebar_table_list";
}

class GridDecorations {
  static Color defaultGridColor = const Color(0xFFFF0000).withOpacity(.1);
  static String? defaultGridBackgroundImage = null; //"assets/floor.jpg";
  static Color defaultBackgroundColor = Colors.white;
}
