import 'package:flutter/material.dart';
import 'package:table_layout_demo/manager/dependencies/dependencies.dart';

extension SizeHelpers on Size {
  Size get toCellIndex => Size(
      width / Manager.configDep.sizes.defaultGridCellSize.width,
      height / Manager.configDep.sizes.defaultGridCellSize.height);

  Size get toSizeFromCellIndex => Size(
      width * Manager.configDep.sizes.defaultGridCellSize.width,
      height * Manager.configDep.sizes.defaultGridCellSize.height);
}

extension OffsetHelpers on Offset {
  Offset get toCellIndex {
    return Offset(dx / Manager.configDep.sizes.defaultGridCellSize.width,
        dy / Manager.configDep.sizes.defaultGridCellSize.height);
  }

  Offset get toOffsetFromCellIndex {
    final off = Offset(dx * Manager.configDep.sizes.defaultGridCellSize.width,
        dy * Manager.configDep.sizes.defaultGridCellSize.height);
    return off;
  }
}

extension GlobalKeyExtentions on GlobalKey {
  Offset? get getPosition => (currentContext?.findRenderObject() as RenderBox?)
      ?.localToGlobal(Offset.zero);
  Size? get getSize => (currentContext?.findRenderObject() as RenderBox?)?.size;
}
