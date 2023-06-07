import 'package:creatego_packages/creatego_packages.dart';
import 'package:table_layout_demo/manager/models/variable_model.dart';

class JsonModel extends Equatable {
  final String componentName;
  final String componentType;
  final Options options;
  final List<Child> children;

  const JsonModel({
    required this.componentName,
    required this.componentType,
    required this.options,
    required this.children,
  });

  @override
  List<Object?> get props => [componentName, componentType, options, children];

  //toJson
  Map<String, dynamic> toJson() {
    return {
      'component_name': componentName,
      'component_type': componentType,
      'options': options.toJson(),
      'children': children.map((e) => e.toJson()).toList(),
    };
  }
}

class Options extends Equatable {
  final List<VarModel> customVariables;
  final double componentWidth;
  final double componentHeight;

  const Options({
    required this.customVariables,
    required this.componentWidth,
    required this.componentHeight,
  });

  @override
  List<Object?> get props => [customVariables, componentWidth, componentHeight];

  //toJson
  Map<String, dynamic> toJson() {
    return {
      'custom_variables': customVariables.map((e) => e.toJson()).toList(),
      'required_variables': [
        {
          'name': 'component_width',
          'type': 'double',
          'value': componentWidth,
        },
        {
          'name': 'component_height',
          'type': 'double',
          'value': componentHeight,
        },
      ],
    };
  }
}

class Child extends Equatable {
  final Offset offset;
  final Size size;
  final String name;
  final String type;
  final String optionType;
  final Map<String, dynamic> options;

  const Child({
    required this.offset,
    required this.size,
    required this.name,
    required this.type,
    required this.optionType,
    required this.options,
  });

  @override
  List<Object?> get props => [offset, size, name, type, optionType, options];

  //toJson
  Map<String, dynamic> toJson() {
    return {
      'offset': {
        'x': offset.dx,
        'y': offset.dy,
      },
      'size': {
        'w': size.width,
        'h': size.height,
      },
      'name': name,
      'type': type,
      'option_type': optionType,
      'options': options,
    };
  }
}
