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
              onPanUpdate: onPanUpdate,
              child: CustomPaint(
                  foregroundPainter:
                      _TablePainter(controller: widget.controller),
                  child: _getPressableTable())));
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
            child: Center(child: child ?? Text(tableName)),
          ),
        ),
      ),
    );
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
  _TablePainter({required this.controller});
  @override
  void paint(Canvas canvas, Size size) {
    //Box border style
    final borderPaint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    //draw border
    canvas.drawRect(Offset.zero & size, borderPaint);

    //text style
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      backgroundColor: Colors.blueAccent,
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
    return false;
  }
}
