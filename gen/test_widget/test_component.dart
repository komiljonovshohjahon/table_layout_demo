// ignore: depend_on_referenced_packages
import 'package:creatego_interface/creatego_interface.dart';
import 'package:flutter/material.dart';

class CustomTestOptions {
  CustomTestOptions({
    required this.width,
    required this.height,
    
  });

  final double width;
  final double height;
  
}

class _State {
 final double width = 100;
 final double height = 100;
 

  CustomTestOptions get options => CustomTestOptions(
        width: 100,
        height: 100,
       
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
  WidgetType get widgetType => WidgetType.text;
}


class _CustomTestWidget extends StatelessWidget {
  const _CustomTestWidget(this.options,{Key? key}) : super(key: key);

  final CustomTestOptions options;

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: options.width,
      height: options.height,
      child: Container(
        color: Colors.red,
      ),
    );
  }
}