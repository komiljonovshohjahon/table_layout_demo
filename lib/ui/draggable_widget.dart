import 'package:flutter/material.dart';
import 'package:table_layout_demo/ui/table_widget.dart';

import '../utils/logger.dart';

class DraggableWidget extends StatelessWidget {
  final TableWidget table;
  final bool isPositioned;
  const DraggableWidget(
      {Key? key, required this.table, this.isPositioned = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = table.controller.getIsSelected;
    if (isSelected) {
      return Positioned(
          top: table.controller.getOffset.dy,
          left: table.controller.getOffset.dx,
          child: GestureDetector(onPanUpdate: onPanUpdate, child: table));
    } else {
      return Positioned(
        top: table.controller.getOffset.dy,
        left: table.controller.getOffset.dx,
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
            child: table),
      );
    }
  }

  void onDragEnd(DraggableDetails o) {
    table.controller.changePosition(o.offset);
  }

  void onPanUpdate(DragUpdateDetails details) {
    table.controller.changePosition(Offset(
        details.globalPosition.dx - table.controller.getSize.width / 2,
        details.globalPosition.dy - table.controller.getSize.height / 2));
  }
}
