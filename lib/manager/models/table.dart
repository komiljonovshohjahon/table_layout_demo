import 'package:creatego_packages/creatego_packages.dart';
import 'package:flutter/material.dart';
import 'package:table_layout_demo/manager/dependencies/dependencies.dart';
import 'package:table_layout_demo/utils/utils.dart';

class TableDecoration {
  Color? activeBgColor;
  Color? inactiveBgColor;
  TableShape? tableShape;
  TextStyle? textStyle;
  IWidget? child;

  Color get getActiveBgColor => activeBgColor!;
  Color get getInactiveBgColor => inactiveBgColor!;
  TableShape get getTableShape => tableShape!;
  TextStyle? get getTextStyle => textStyle;

  void defaultAll() {
    activeBgColor ??= Colors.black38;
    inactiveBgColor ??= Colors.transparent;
    tableShape ??= TableShape.rectangle;
  }

  TableDecoration({
    this.activeBgColor,
    this.inactiveBgColor,
    this.tableShape,
    this.textStyle,
    this.child,
  }) {
    defaultAll();
  }

  TableDecoration copyWith({
    Color? activeBgColor,
    Color? inactiveBgColor,
    TableShape? tableShape,
    TextStyle? textStyle,
    IWidget? child,
  }) {
    return TableDecoration(
      activeBgColor: activeBgColor ?? this.activeBgColor,
      inactiveBgColor: inactiveBgColor ?? this.inactiveBgColor,
      tableShape: tableShape ?? this.tableShape,
      textStyle: textStyle ?? this.textStyle,
      child: child ?? this.child,
    );
  }

  @override
  String toString() {
    return 'TableDecoration(activeBgColor: $activeBgColor, inactiveBgColor: $inactiveBgColor, tableShape: $tableShape, textStyle: $textStyle)';
  }
}

class TableData {
  Size? size;
  Offset? offset;
  String? tableName;
  final UniqueKey key;
  bool? isSelected;
  TableDecoration? tableDecoration;
  String tableId;

  Offset get getOffset => offset!;
  Size get getSize => size!;
  String get getTableName => tableName!;
  bool get getIsSelected => isSelected!;
  TableDecoration get getTableDecoration => tableDecoration!;

  TableData copyWith({
    double? width,
    double? height,
    Offset? offset,
    UniqueKey? key,
    String? tableName,
    bool? isSelected,
    TableDecoration? tableDecoration,
  }) {
    return TableData(
      size: Size(width ?? size!.width, height ?? size!.height),
      offset: offset ?? this.offset,
      key: key ?? this.key,
      tableName: tableName ?? this.tableName,
      isSelected: isSelected ?? this.isSelected,
      tableDecoration: tableDecoration ?? this.tableDecoration,
      tableId: tableId,
    );
  }

  TableData({
    this.size,
    this.offset,
    required this.key,
    required this.tableName,
    required this.isSelected,
    this.tableDecoration,
    required this.tableId,
  }) {
    size ??= Manager.configDep.sizes.defaultTableSize;
    offset ??= const Offset(0, 0);
    tableName ??= 'Table ${key.toString()}';
    isSelected ??= false;
    tableDecoration ??= TableDecoration();
  }

  @override
  String toString() {
    return 'TableData(tableId: $tableId, size: $size, offset: $offset, key: $key, tableName: $tableName, isSelected: $isSelected, tableDecoration: ${tableDecoration.toString()})';
  }
}
