import 'package:creatego_packages/creatego_packages.dart';
import 'package:table_layout_demo/manager/models/variable_model.dart';

class JsonModel extends Equatable {
  final String id;
  final String componentName;
  final String componentType;
  final Options options;
  final List<Child> children;

  const JsonModel({
    required this.id,
    required this.componentName,
    required this.componentType,
    required this.options,
    required this.children,
  });

  @override
  List<Object?> get props =>
      [componentName, componentType, options, children, id];

  //toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'component_name': componentName,
      'component_type': componentType,
      'options': options.toJson(),
      'children': children.map((e) => e.toJson()).toList(),
    };
  }

  factory JsonModel.fromJson(Map<String, dynamic> json) {
    return JsonModel(
      id: json['id'],
      componentName: json['component_name'],
      componentType: json['component_type'],
      options: Options.fromJson(json['options']),
      children: List<Child>.from(
        json['children'].map(
          (e) => Child.fromJson(e),
        ),
      ),
    );
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

  factory Options.fromJson(Map<String, dynamic> json) {
    return Options(
      customVariables: List<VarModel>.from(
        json['custom_variables'].map(
          (e) => VarModel.fromJson(e),
        ),
      ),
      componentWidth: json['required_variables'][0]['value'],
      componentHeight: json['required_variables'][1]['value'],
    );
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

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      offset: Offset(json['offset']['x'], json['offset']['y']),
      size: Size(json['size']['w'], json['size']['h']),
      name: json['name'],
      type: json['type'],
      optionType: json['option_type'],
      options: json['options'],
    );
  }
}
