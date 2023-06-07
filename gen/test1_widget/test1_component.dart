// ignore: depend_on_referenced_packages
import 'package:creatego_interface/creatego_interface.dart';
import 'package:flutter/material.dart';

class CustomTest1Options {
  CustomTest1Options({
    required this.component_width,
    required this.component_height,
    required this.name,
    required this.name1,
  });

  //required variables
  final double component_width;
  final double component_height;

  //custom variables
  final List<String> name;
  final num? name1;
}

class _State {
  //required variables
  final double component_width = 600.0;
  final double component_height = 500.0;

  //custom variables
  final List<String> name = ['abc', 'dfe'];
  final num? name1 = null;

  CustomTest1Options get options => CustomTest1Options(
        component_width: component_width,
        component_height: component_height,
        name: name,
        name1: name1,
      );
}

class CustomTest1Component extends IWidget<CustomTest1Options> {
  final _state = _State();

  CustomTest1Component({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, {ValueChanged<IWidget>? onTapped}) {
    return ValueListenableBuilder<CustomTest1Options>(
      valueListenable: notifier,
      builder: (context, value, child) {
        return _CustomTest1Widget(value);
      },
    );
  }

  @override
  IWidget copy() {
    final CustomTest1Component newWidget = CustomTest1Component();
    return newWidget;
  }

  @override
  CustomTest1Options setOptions() {
    return _state.options;
  }

  @override
  WidgetType get widgetType => WidgetType.test;
}

class _CustomTest1Widget extends StatelessWidget {
  _CustomTest1Widget(this.options, {Key? key}) : super(key: key);

  final CustomTest1Options options;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: options.component_width,
      height: options.component_height,
      child: Stack(
        children: [
          Positioned(
            left: 210.0,
            top: 215.0,
            width: 100.0,
            height: 100.0,
            child: Center(
                child: CustomButton(
                    customOptions: ButtonOptions.fromMap({
              "text": "Button",
              "backgroundColor": 4294198070,
              "fontSize": 16.0,
              "fontWeight": 3,
              "textColor": 4294967295,
              "borderRadius": 0.0,
              "isIconRight": 'true'
            }))),
          ),
        ],
      ),
    );
  }
}
