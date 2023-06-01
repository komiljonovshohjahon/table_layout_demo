// ignore: depend_on_referenced_packages
import 'package:creatego_interface/creatego_interface.dart';
import 'package:flutter/material.dart';

class Custom{{widget.pascalCase()}}Options {
  Custom{{widget.pascalCase()}}Options({
    {{#options.required_vars}}required this.{{name}},
    {{/options.required_vars}}
  });

  {{#options.required_vars}}final {{{type}}} {{name}};
  {{/options.required_vars}}
}

class _State {
 {{#options.required_vars}}final {{{type}}} {{name}} = {{value}};
 {{/options.required_vars}}

  Custom{{widget.pascalCase()}}Options get options => Custom{{widget.pascalCase()}}Options(
       {{#options.required_vars}} {{name}}: {{value}},
       {{/options.required_vars}}
      );
}

class Custom{{widget.pascalCase()}}Component extends IWidget<Custom{{widget.pascalCase()}}Options> {
  final _state = _State();

  Custom{{widget.pascalCase()}}Component({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, {ValueChanged<IWidget>? onTapped}) {
    return ValueListenableBuilder<Custom{{widget.pascalCase()}}Options>(
      valueListenable: notifier,
      builder: (context, value, child) {
        return _Custom{{widget.pascalCase()}}Widget(value);
      },
    );
  }

  
  @override
  IWidget copy() {
    final Custom{{widget.pascalCase()}}Component newWidget = Custom{{widget.pascalCase()}}Component();
    return newWidget;
  }

 @override
  Custom{{widget.pascalCase()}}Options setOptions() {
    return _state.options;
  }

    @override
  WidgetType get widgetType => WidgetType.{{type}};
}


class _Custom{{widget.pascalCase()}}Widget extends StatelessWidget {
  const _Custom{{widget.pascalCase()}}Widget(this.options,{Key? key}) : super(key: key);

  final Custom{{widget.pascalCase()}}Options options;

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