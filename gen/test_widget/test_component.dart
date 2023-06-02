// ignore: depend_on_referenced_packages
import 'package:creatego_interface/creatego_interface.dart';
import 'package:flutter/material.dart';

class CustomTestOptions {
  CustomTestOptions({
    required this.component_width,
    required this.component_height,
  });

  final double component_width;
  final double component_height;
}

class _State {
  final double component_width = 100;
  final double component_height = 100;

  CustomTestOptions get options => CustomTestOptions(
        component_width: 100,
        component_height: 100,
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

  //
  // final CustomButton button = CustomButton(customOptions: ButtonOptions.fromMap({"text": 'text', "backgroundColor": '#FFffffff', "width": 100, "height": 50, "fontSize": 12, "fontWeight": FontWeight.normal, "textColor": '#FF000000', "borderRadius": BorderRadius.circular(0), "isIconRight": false}));
  //

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: options.component_width,
      height: options.component_height,
      child: Stack(
        children: [
          Positioned(
            left: 85,
            top: 100,
            child: SizedBox(
                width: 100,
                height: 100,
                child: CustomButton(
                    customOptions: ButtonOptions.fromMap({
                  "text": 'text',
                  "backgroundColor": '#FFffffff',
                  "width": 100,
                  "height": 50,
                  "fontSize": 12,
                  "fontWeight": FontWeight.normal,
                  "textColor": '#FF000000',
                  "borderRadius": BorderRadius.circular(0),
                  "isIconRight": false
                }))), //TODO: make this a proper child
          ),
        ],
      ),
    );
  }
}
