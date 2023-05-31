import 'package:creatego_packages/creatego_packages.dart';
import 'package:flutter/material.dart';
import 'package:table_layout_demo/manager/controllers/controllers.dart';
import 'package:table_layout_demo/utils/utils.dart';

class TableWidget extends StatefulWidget {
  final TableController controller;
  final VoidCallback? onTap;
  bool? isDisabled;
  bool isPositioned = true;
  TableWidget(
      {Key? key,
      required this.controller,
      this.onTap,
      this.isDisabled = false,
      this.isPositioned = true})
      : super(key: key) {
    isDisabled ?? false;
  }

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  ValueNotifier<TableController>? ctr;
  @override
  void initState() {
    super.initState();
    ctr = ValueNotifier(widget.controller);
    widget.controller.setCallback = () {
      logger("Call back called");
      setState(() {});
    };
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TableWidget(TABLE_ID: ${widget.controller.tableId})';
  }

  void onPanUpdate(DragUpdateDetails details) {
    widget.controller.changePosition(Offset(
        details.globalPosition.dx - widget.controller.getSize.width / 2,
        details.globalPosition.dy - widget.controller.getSize.height / 2));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isPositioned) {
      return _getPositionedWidget();
    }
    return _getPressableTable();
  }

  Widget _getPositionedWidget() {
    bool isSelected = widget.controller.getIsSelected;
    if (isSelected) {
      return Positioned(
          top: widget.controller.getOffset.dy,
          left: widget.controller.getOffset.dx,
          width: widget.controller.getSize.width,
          height: widget.controller.getSize.height,
          child: GestureDetector(
              onPanUpdate: onPanUpdate, child: _getPressableTable()));
    }
    return Positioned(
      top: widget.controller.getOffset.dy,
      left: widget.controller.getOffset.dx,
      width: widget.controller.getSize.width,
      height: widget.controller.getSize.height,
      child: GestureDetector(
          onPanStart: (details) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                action: SnackBarAction(
                  onPressed: () {
                    ScaffoldMessenger.of(context).clearSnackBars();
                  },
                  label: "Close",
                ),
                content: const Text(
                    "You can only drag selected tables. Please select the table first.")));
          },
          child: _getPressableTable()),
    );
  }

  Widget _getPressableTable() {
    String tableName = widget.controller.getTableName;
    IWidget? child = widget.controller.child;
    return GestureDetector(
      onTap: widget.isDisabled!
          ? null
          : (widget.onTap ??
              () {
                CanvasController.to.selectTable(widget.controller);
                setState(() {});
              }),
      child: Opacity(
        opacity: widget.isDisabled! ? 0.5 : 1,
        child: ClipRRect(
          borderRadius: _getRadius(),
          child: SizedBox(
            width: widget.controller.getSize.width,
            height: widget.controller.getSize.height,
            child: DecoratedBox(
                decoration: BoxDecoration(
                  border: _getBorder(),
                  shape: BoxShape.rectangle,
                  // color: _getColor(),
                ),
                child: Center(child: child?.build(context) ?? Text(tableName))),
          ),
        ),
      ),
    );
  }

  Color _getColor() {
    if (widget.controller.getIsSelected) {
      return widget.controller.getTableDecoration.getActiveBgColor;
    } else {
      return widget.controller.getTableDecoration.getInactiveBgColor;
    }
  }

  Border _getBorder() {
    if (widget.controller.getIsSelected) {
      return Border.all(
          color: Colors.blueAccent,
          width: 2,
          strokeAlign: BorderSide.strokeAlignInside);
    } else {
      return Border.all(
          color: Colors.transparent,
          width: 2,
          strokeAlign: BorderSide.strokeAlignInside);
    }
  }

  BorderRadiusGeometry _getRadius() {
    switch (widget.controller.getTableShape) {
      case TableShape.circle:
        return BorderRadius.circular(widget.controller.getSize.width / 2);
      case TableShape.rectangle:
      default:
        return BorderRadius.zero;
    }
  }
}
