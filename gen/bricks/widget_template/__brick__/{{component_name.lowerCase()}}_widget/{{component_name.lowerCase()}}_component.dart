// ignore: depend_on_referenced_packages
import 'package:creatego_interface/creatego_interface.dart';
import 'package:flutter/material.dart';

class Custom{{component_name.pascalCase()}}Options {
  Custom{{component_name.pascalCase()}}Options({
    {{#options.required_variables}}required this.{{name}},
    {{/options.required_variables}}

    {{#options.custom_variables}}required this.{{name}} ,
    {{/options.custom_variables}}
  });

  //required variables
  {{#options.required_variables}}final {{{type}}} {{name}};
  {{/options.required_variables}}

  //custom variables
  {{#options.custom_variables}}final {{type}} {{name}};
  {{/options.custom_variables}}
}

class _State {
  //required variables
 {{#options.required_variables}}final {{{type}}} {{name}} = {{value}};
 {{/options.required_variables}}

  //custom variables
 {{#options.custom_variables}}final {{type}} {{name}} = {{{value}}};
 {{/options.custom_variables}}

  Custom{{component_name.pascalCase()}}Options get options => Custom{{component_name.pascalCase()}}Options(
       {{#options.required_variables}} {{name}}: {{name}},
       {{/options.required_variables}}
      {{#options.custom_variables}} {{name}}: {{name}},
      {{/options.custom_variables}}
      );
}

class Custom{{component_name.pascalCase()}}Component extends IWidget<Custom{{component_name.pascalCase()}}Options> {
  final _state = _State();

  Custom{{component_name.pascalCase()}}Component({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, {ValueChanged<IWidget>? onTapped}) {
    return ValueListenableBuilder<Custom{{component_name.pascalCase()}}Options>(
      valueListenable: notifier,
      builder: (context, value, child) {
        return _Custom{{component_name.pascalCase()}}Widget(value);
      },
    );
  }

  
  @override
  IWidget copy() {
    final Custom{{component_name.pascalCase()}}Component newWidget = Custom{{component_name.pascalCase()}}Component();
    return newWidget;
  }

 @override
  Custom{{component_name.pascalCase()}}Options setOptions() {
    return _state.options;
  }

    @override
  WidgetType get widgetType => WidgetType.{{component_type}};
}


class _Custom{{component_name.pascalCase()}}Widget extends StatelessWidget {
   _Custom{{component_name.pascalCase()}}Widget(this.options,{Key? key}) : super(key: key);

  final Custom{{component_name.pascalCase()}}Options options;


  @override
  Widget build(BuildContext context) {
  return Container(
    color: Colors.white,
    width: options.component_width,
    height: options.component_height,
    child: Stack(
    children: [
  {{#children}}
      Positioned(
        left: {{offset.x}},
        top: {{offset.y}},
        width: {{size.w}},
        height: {{size.h}},
        child:
        Center( child: {{type}}(customOptions: {{option_type}}.fromMap({{{options}}}))),
      ),
  {{/children}}
    ],
    ),
);
  }
}