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
 final double component_width = 600.0;
 final double component_height = 500.0;
 

  CustomTestOptions get options => CustomTestOptions(
        component_width: 600.0,
        component_height: 500.0,
       
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
   _CustomTestWidget(this.options,{Key? key}) : super(key: key);

  final CustomTestOptions options;

  // 
  // final CustomButton child_0 = CustomButton(customOptions: ButtonOptions.fromMap({"text": 'Button', "backgroundColor": 4280391411, "width": 100.0, "height": 50.0, "fontSize": 16.0, "fontWeight": 3, "textColor": 4294967295, "borderRadius": 0.0, "isIconRight": 'true'}));
  // 
  // final CustomButton child_0 = CustomButton(customOptions: ButtonOptions.fromMap({"text": 'Button', "backgroundColor": 4278190080, "width": 100.0, "height": 50.0, "fontSize": 16.0, "fontWeight": 3, "textColor": 4294967295, "borderRadius": 0.0, "isIconRight": 'true'}));
  // 
  // final CustomButton child_0 = CustomButton(customOptions: ButtonOptions.fromMap({"text": 'Button', "backgroundColor": 4283215696, "width": 100.0, "height": 50.0, "fontSize": 16.0, "fontWeight": 3, "textColor": 4294967295, "borderRadius": 0.0, "isIconRight": 'true'}));
  // 
  // final CustomButton child_0 = CustomButton(customOptions: ButtonOptions.fromMap({"text": 'Button', "backgroundColor": 4294961979, "width": 100.0, "height": 50.0, "fontSize": 16.0, "fontWeight": 3, "textColor": 4294967295, "borderRadius": 0.0, "isIconRight": 'true'}));
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
        left: 35.0,
        top: 20.0,
        width: 80.0,
        height: 80.0,
        child:
        Center( child: CustomButton(customOptions: ButtonOptions.fromMap({"text": 'Button', "backgroundColor": 4280391411, "width": 100.0, "height": 50.0, "fontSize": 16.0, "fontWeight": 3, "textColor": 4294967295, "borderRadius": 0.0, "isIconRight": 'true'}))),//TODO: make this a proper child
      ),
  
      Positioned(
        left: 0.0,
        top: 420.0,
        width: 80.0,
        height: 80.0,
        child:
        Center( child: CustomButton(customOptions: ButtonOptions.fromMap({"text": 'Button', "backgroundColor": 4278190080, "width": 100.0, "height": 50.0, "fontSize": 16.0, "fontWeight": 3, "textColor": 4294967295, "borderRadius": 0.0, "isIconRight": 'true'}))),//TODO: make this a proper child
      ),
  
      Positioned(
        left: 520.0,
        top: 420.0,
        width: 80.0,
        height: 80.0,
        child:
        Center( child: CustomButton(customOptions: ButtonOptions.fromMap({"text": 'Button', "backgroundColor": 4283215696, "width": 100.0, "height": 50.0, "fontSize": 16.0, "fontWeight": 3, "textColor": 4294967295, "borderRadius": 0.0, "isIconRight": 'true'}))),//TODO: make this a proper child
      ),
  
      Positioned(
        left: 0.0,
        top: 0.0,
        width: 80.0,
        height: 80.0,
        child:
        Center( child: CustomButton(customOptions: ButtonOptions.fromMap({"text": 'Button', "backgroundColor": 4294961979, "width": 100.0, "height": 50.0, "fontSize": 16.0, "fontWeight": 3, "textColor": 4294967295, "borderRadius": 0.0, "isIconRight": 'true'}))),//TODO: make this a proper child
      ),
  
    ],
    ),
);
  }
}