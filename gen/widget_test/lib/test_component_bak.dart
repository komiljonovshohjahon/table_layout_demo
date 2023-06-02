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
  final double width = 600;
  final double height = 500;

  CustomTestOptions get options => CustomTestOptions(
        width: width,
        height: height,
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
  _CustomTestWidget(this.options, {Key? key}) : super(key: key);

  final CustomTestOptions options;

  //
  // final CustomButton button = CustomButton(customOptions: ButtonOptions.fromMap({text:  Button, backgroundColor:  4294198070, width: 100.0, height: 50.0, fontSize: 16.0, fontWeight: 3, textColor:  4294967295, borderRadius: BorderRadius.zero, isIconRight: true}));
  //

  final CustomButton button = CustomButton(
      customOptions: ButtonOptions(
          action: CustomSimpleAction(() {}),
          icon: CustomIcon(),
          text: "Button",
          backgroundColor: Colors.red,
          width: 80.0,
          height: 80.0,
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          textColor: Colors.blue,
          borderRadius: BorderRadius.zero,
          isIconRight: true));

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        width: options.width,
        height: options.height,
        child: Stack(
          children: [
            Positioned(
              left: 520,
              top: 420,
              child: SizedBox(width: 80, height: 80, child: button),
            ),
          ],
        ));
  }
}
