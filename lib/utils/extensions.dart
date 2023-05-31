import 'package:flutter/material.dart';
import 'utils.dart';

extension SizeHelpers on Size {
  Size get toCellIndex => Size(
      width / GridSettingsConstants.defaultGridCellSize.width,
      height / GridSettingsConstants.defaultGridCellSize.height);

  Size get toSizeFromCellIndex => Size(
      width * GridSettingsConstants.defaultGridCellSize.width,
      height * GridSettingsConstants.defaultGridCellSize.height);
}

extension OffsetHelpers on Offset {
  Offset get toCellIndex {
    return Offset(dx / GridSettingsConstants.defaultGridCellSize.width,
        dy / GridSettingsConstants.defaultGridCellSize.height);
  }

  Offset get toOffsetFromCellIndex {
    final off = Offset(dx * GridSettingsConstants.defaultGridCellSize.width,
        dy * GridSettingsConstants.defaultGridCellSize.height);
    return off;
  }
}

extension GlobalKeyExtentions on GlobalKey {
  Offset? get getPosition => (currentContext?.findRenderObject() as RenderBox?)
      ?.localToGlobal(Offset.zero);
  Size? get getSize => (currentContext?.findRenderObject() as RenderBox?)?.size;
}
