import 'package:creatego_packages/creatego_packages.dart';
import 'package:table_layout_demo/utils/utils.dart';

class ConfigDep {
  // create a singleton
  static final ConfigDep _singleton = ConfigDep._internal();

  // create a factory constructor

  factory ConfigDep() {
    return _singleton;
  }

  ConfigDep._internal();

  //sizes
  final _GridSizes sizes = _GridSizes();

  //settings
  final _GridSettings settings = _GridSettings();

  //decorations
  final _GridDecorations decorations = _GridDecorations();
}

class _GridSizes {
  //Grid column and row configs
  int columnCount = 0;
  double columnGutter = 30;
  int rowCount = 0;
  double rowGutter = 30;

  ///Number of cells in the grid => (x,y)
  ///
  /// Default to: (x = 60, y = 50)
  Offset defaultGridCells =
      const Offset(60, 50); // Number of pixels in the grid x and y

  /// Number of pixels in each cell => (width, height)
  ///
  /// Default to: (width = 10, height = 10)
  Size defaultGridCellSize = const Size(10, 10);

  /// Makes 1 cell [_defaultGridCellSize.height] pixels
  int get defaultGridSubdivision =>
      defaultGridCellSize.width ~/ defaultGridCellSize.height;
  Size get defaultTableSize =>
      const Size(8, 8).toSizeFromCellIndex; // 8 is pixels of table
  double defaultSidebarWidth = 500;
}

class _GridSettings {
  ///When true, the selected table can go off through the canvas boundaries
  ///
  /// Default to: false
  bool canItemGoOffCanvasBoundaries = false;
}

class _GridDecorations {
  Color defaultGridColor = const Color(0xFFFF0000).withOpacity(.1);
  String? defaultGridBackgroundImage = null; //"assets/floor.jpg";
  Color defaultBackgroundColor = Colors.white;
  Color columnColor = const Color(0xFFFF0000).withOpacity(.1);
}
