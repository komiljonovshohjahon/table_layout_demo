import 'package:creatego_packages/creatego_packages.dart';
import 'package:flutter/material.dart';
import 'package:table_layout_demo/manager/controllers/controllers.dart';
import 'package:table_layout_demo/utils/utils.dart';
import 'package:focusable_control_builder/focusable_control_builder.dart';

class TableWidget extends StatefulWidget {
  final TableController controller;
  final VoidCallback? onTap;
  bool? isDisabled;
  final bool isPositioned;
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
    logger("Table ${widget.controller.tableId} is selected: $isSelected");
    if (isSelected) {
      return Positioned(
          top: widget.controller.getOffset.dy,
          left: widget.controller.getOffset.dx,
          width: widget.controller.getSize.width,
          height: widget.controller.getSize.height,
          child: GestureDetector(
              onPanUpdate: onPanUpdate, child: _getPressableTable(isSelected)));
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

  Widget _getPressableTable([bool isSelected = false]) {
    IWidget? child = widget.controller.child;
    return FocusableControlBuilder(
        onPressed: widget.isDisabled!
            ? null
            : (widget.onTap ??
                () {
                  CanvasController.to.selectTable(widget.controller);
                  setState(() {});
                }),
        builder: (context, control) {
          return CustomPaint(
              foregroundPainter: _TablePainter(
                controller: widget.controller,
                isHovered: control.isHovered,
                isSelected: isSelected,
              ),
              child:
                  Center(child: child ?? const Text("CANNOT FIND THE CHILD")));
        });
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

class _TablePainter extends CustomPainter {
  final TableController controller;
  final bool isHovered;
  final bool isSelected;
  _TablePainter(
      {required this.controller,
      this.isHovered = false,
      this.isSelected = false});
  @override
  void paint(Canvas canvas, Size size) {
    if (!isSelected && !isHovered) {
      return;
    }
    Color mainColor = Colors.blueAccent;
    if (isHovered && !isSelected) {
      mainColor = Colors.greenAccent;
    }
    //Box border style
    final borderPaint = Paint()
      ..color = mainColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    //draw border
    canvas.drawRect(Offset.zero & size, borderPaint);

    //text style
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      backgroundColor: mainColor,
      height: 1.3,
      fontStyle: FontStyle.italic,
    );

    //text span
    final textSpan = TextSpan(
      text: controller.child?.widgetType.toString() ?? "NO CHILD",
      style: textStyle,
    );

    //text painter
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      maxLines: 3,
      ellipsis: '...',
    );

    //layout the text painter
    textPainter.layout(
      minWidth: size.width,
      maxWidth: size.width,
    );

    //find the top left of the canvas
    final topLeft = Offset(
      0,
      -textPainter.height,
    );
    final textOffset = Offset(
      topLeft.dx,
      topLeft.dy,
    );

    //paint the text
    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
