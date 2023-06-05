import 'package:creatego_packages/creatego_packages.dart';
import 'package:table_layout_demo/manager/models/models.dart';
import 'package:table_layout_demo/utils/utils.dart';
import '../dependencies/dependencies.dart';

class TableController extends ValueNotifier<TableData> {
  /// To assign initial position of the widget, use [index] parameter
  ///
  /// and pass Offset(dx, dy) where dx = x-coordinate and dy = y-coordinate.
  ///
  /// This will divide the passed values to [Constants.defaultGridCellSize]
  ///
  /// Use offset parameter to assign initial position of the widget
  ///
  /// but using Offset(dx, dy) where dx and dy is Flutter offset.

  VoidCallback? callback;
  set setCallback(VoidCallback cb) {
    if (callback != null) {
      logger('Callback RESET for tableID ${value.tableId}');
    } else {
      logger('Callback SET for tableID ${value.tableId}');
    }
    callback = cb;
  }

  TableController(
      {Size? size,
      Offset? offset,
      // Offset? coordinates,
      String? tableName,
      TableShape? shape,
      bool? isSelected,
      this.callback,
      TableDecoration? tableDecoration,
      required String tableId})
      : super(
          TableData(
            tableName: tableName,
            size: size,
            offset: offset,
            key: UniqueKey(),
            isSelected: isSelected,
            tableDecoration: tableDecoration,
            tableId: tableId,
          ),
        );

  Size get getSize => value.size!;
  Offset get getOffset => value.offset!;
  bool get getIsSelected => value.getIsSelected;
  String get getTableName => value.tableName!;
  TableDecoration get getTableDecoration => value.tableDecoration!;
  TableShape get getTableShape => value.tableDecoration!.tableShape!;
  String get tableId => value.tableId;
  IWidget? get child => getTableDecoration.child;

  set setOffset(Offset offset) => value = value.copyWith(offset: offset);

  set setIsSelected(bool isSelected) =>
      value = value.copyWith(isSelected: isSelected);

  void changeSize({double? width, double? height, bool isAsCellIndex = false}) {
    if (isAsCellIndex) {
      value = value.copyWith(
        width: Manager.configDep.sizes.defaultGridCellSize.width * width!,
        height: Manager.configDep.sizes.defaultGridCellSize.height * height!,
      );
    } else {
      value = value.copyWith(width: width, height: height);
    }
    callback?.call();

    // Manager.canvasController.update([GridConstants.gridCanvasTableId]);
  }

  Offset get getCenterOffset {
    return Offset(
      Manager.canvasController.getLeftTopCorner.dx + getSize.width / 2,
      Manager.canvasController.getLeftTopCorner.dy + getSize.height / 2,
    );
  }

  Offset get getLeftTopCorner {
    return Offset(
      getOffset.dx + Manager.canvasController.getLeftTopCorner.dx,
      getOffset.dy + Manager.canvasController.getLeftTopCorner.dy,
    );
  }

  Offset get getRightTopCorner {
    return Offset(
      getOffset.dx +
          getSize.width +
          Manager.canvasController.getLeftTopCorner.dx,
      getOffset.dy + Manager.canvasController.getLeftTopCorner.dy,
    );
  }

  Offset get getLeftBottomCorner {
    return Offset(
      getOffset.dx + Manager.canvasController.getLeftTopCorner.dx,
      getOffset.dy +
          getSize.height +
          Manager.canvasController.getLeftTopCorner.dy,
    );
  }

  bool get isTouchingCanvasLeft {
    return getOffset.dx == 0.0;
  }

  bool get isTouchingCanvasTop {
    return getOffset.dy == 0.0;
  }

  bool get isTouchingCanvasRight {
    return getOffset.dx + getSize.width ==
        GridConstants.canvasGridKey.getSize!.width;
  }

  bool get isTouchingCanvasBottom {
    return getOffset.dy + getSize.height ==
        GridConstants.canvasGridKey.getSize!.height;
  }

  void moveToTopRight() {
    setOffset =
        Offset(GridConstants.canvasGridKey.getSize!.width - getSize.width, 0);
    callback?.call();

    Manager.canvasController.update([GridConstants.gridCanvasId]);
  }

  void moveToTopLeft() {
    setOffset = const Offset(0, 0);
    callback?.call();

    Manager.canvasController.update([GridConstants.gridCanvasId]);
  }

  void moveToBottomRight() {
    setOffset = Offset(
        GridConstants.canvasGridKey.getSize!.width - getSize.width,
        GridConstants.canvasGridKey.getSize!.height - getSize.height);
    callback?.call();

    Manager.canvasController.update([GridConstants.gridCanvasId]);
  }

  void moveToBottomLeft() {
    setOffset =
        Offset(0, GridConstants.canvasGridKey.getSize!.height - getSize.height);
    callback?.call();

    Manager.canvasController.update([GridConstants.gridCanvasId]);
  }

  void moveToCenter() {
    setOffset = Offset(
        GridConstants.canvasGridKey.getSize!.width / 2 - getSize.width / 2,
        GridConstants.canvasGridKey.getSize!.height / 2 - getSize.height / 2);
    callback?.call();

    Manager.canvasController.update([GridConstants.gridCanvasId]);
  }

  void changeShape(TableShape shape) {
    value = value.copyWith(
        tableDecoration: value.tableDecoration!.copyWith(tableShape: shape));
    callback?.call();
    Manager.canvasController.update([GridConstants.gridSidebarTablePropsId]);
  }

  void changePosition(Offset o) {
    Offset? canvasPosition = GridConstants.canvasGridKey.getPosition;

    if (canvasPosition != null) {
      Offset off = Offset(o.dx - canvasPosition.dx, o.dy - canvasPosition.dy);

      final yRemainder =
          (off.dy % Manager.configDep.sizes.defaultGridCellSize.height);
      final xRemainder =
          (off.dx % Manager.configDep.sizes.defaultGridCellSize.width);

      final halfCell = Manager.configDep.sizes.defaultGridCellSize.width / 2;
      if (xRemainder != 0) {
        double dx = off.dx;
        if (halfCell < xRemainder) {
          final temp =
              Manager.configDep.sizes.defaultGridCellSize.width - xRemainder;
          dx += temp;
        } else if (halfCell > xRemainder) {
          final temp = halfCell - xRemainder;
          dx += temp;
          // dx -= xRemainder;
        }
        off = Offset(dx, off.dy);
      }
      if (yRemainder != 0) {
        double dy = off.dy;
        if (halfCell < yRemainder) {
          final temp =
              Manager.configDep.sizes.defaultGridCellSize.width - yRemainder;
          dy += temp;
        } else if (halfCell > yRemainder) {
          final temp = halfCell - yRemainder;
          dy += temp;
          // dy -= yRemainder;
        }
        off = Offset(off.dx, dy);
      }

      //Check if the table goes off Canvas boundaries
      if (!Manager.configDep.settings.canItemGoOffCanvasBoundaries) {
        //Left
        if (off.dx < 0) off = Offset(0, off.dy);
        //Top
        if (off.dy < 0) off = Offset(off.dx, 0);
        //Right
        if (off.dx + getSize.width >
            GridConstants.canvasGridKey.getSize!.width) {
          off = Offset(
              GridConstants.canvasGridKey.getSize!.width - getSize.width,
              off.dy);
        }
        //Bottom
        if (off.dy + getSize.height >
            GridConstants.canvasGridKey.getSize!.height) {
          off = Offset(off.dx,
              GridConstants.canvasGridKey.getSize!.height - getSize.height);
        }
      }
      setOffset = off;
    }
  }

  //copyWith
  TableController copyWith({
    String? tableId,
    Function()? callback,
    Size? size,
    Offset? offset,
    TableShape? shape,
    bool? isSelected,
    TableDecoration? tableDecoration,
    String? tableName,
  }) {
    return TableController(
      tableId: tableId ?? this.tableId,
      callback: callback ?? this.callback,
      offset: offset,
      size: size,
      shape: shape,
      isSelected: isSelected,
      tableDecoration: tableDecoration?.copyWith(),
      tableName: tableName,
    );
  }
}
