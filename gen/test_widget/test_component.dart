// ignore: depend_on_referenced_packages
import 'package:creatego_interface/creatego_interface.dart';
import 'package:flutter/material.dart';

class CustomTestOptions {
  CustomTestOptions({
    required this.component_width,
    required this.component_height,
    required this.full_name,
  });

  //required variables
  final double component_width;
  final double component_height;

  //custom variables
  final String full_name;
}

class _State {
  //required variables
  final double component_width = 600.0;
  final double component_height = 500.0;

  //custom variables
  final String full_name = 'test';

  CustomTestOptions get options => CustomTestOptions(
        component_width: component_width,
        component_height: component_height,
        full_name: full_name,
      );
}

class CustomTestComponent extends IWidget<CustomTestOptions> {
  final _state = _State();

  CustomTestComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, {ValueChanged<IWidget>? onTapped}) {
    return ValueListenableBuilder<CustomTestOptions>(
      valueListenable: notifier,
      builder: (context, value, child) {
        return _CustomTestWidget(value);
      },
    );
  }

  @override
  IWidget copy() {
    final CustomTestComponent newWidget = CustomTestComponent();
    return newWidget;
  }

  @override
  CustomTestOptions setOptions() {
    return _state.options;
  }

  @override
  WidgetType get widgetType => WidgetType.test;
}

class _CustomTestWidget extends StatelessWidget {
  _CustomTestWidget(this.options, {Key? key}) : super(key: key);

  final CustomTestOptions options;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: options.component_width,
      height: options.component_height,
      child: Stack(
        children: [
          Positioned(
            left: 200.0,
            top: 60.0,
            width: 200.0,
            height: 80.0,
            child: Center(
                child: CustomButton(
                    customOptions: ButtonOptions.fromMap({
              "text": 'Button',
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
