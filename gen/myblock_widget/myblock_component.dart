// ignore: depend_on_referenced_packages
import 'package:creatego_interface/creatego_interface.dart';
import 'package:flutter/material.dart';

class CustomMyBlockOptions {
  CustomMyBlockOptions({
    required this.component_width,
    required this.component_height,
    required this.isDisabed,
    required this.isTakeout,
    required this.name,
  });

  //required variables
  final double component_width;
  final double component_height;

  //custom variables
  final bool isDisabed;
  final bool isTakeout;
  final String? name;
}

class _State {
  //required variables
  final double component_width = 600.0;
  final double component_height = 500.0;

  //custom variables
  final bool isDisabed = false;
  final bool isTakeout = true;
  final String? name = null;

  CustomMyBlockOptions get options => CustomMyBlockOptions(
        component_width: component_width,
        component_height: component_height,
        isDisabed: isDisabed,
        isTakeout: isTakeout,
        name: name,
      );
}

class CustomMyBlockComponent extends IWidget<CustomMyBlockOptions> {
  final _state = _State();

  CustomMyBlockComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, {ValueChanged<IWidget>? onTapped}) {
    return ValueListenableBuilder<CustomMyBlockOptions>(
      valueListenable: notifier,
      builder: (context, value, child) {
        return _CustomMyBlockWidget(value);
      },
    );
  }

  @override
  IWidget copy() {
    final CustomMyBlockComponent newWidget = CustomMyBlockComponent();
    return newWidget;
  }

  @override
  CustomMyBlockOptions setOptions() {
    return _state.options;
  }

  @override
  WidgetType get widgetType => WidgetType.test;
}

class _CustomMyBlockWidget extends StatelessWidget {
  _CustomMyBlockWidget(this.options, {Key? key}) : super(key: key);

  final CustomMyBlockOptions options;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: options.component_width,
      height: options.component_height,
      child: Stack(
        children: [
          Positioned(
            left: 0.0,
            top: 0.0,
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
