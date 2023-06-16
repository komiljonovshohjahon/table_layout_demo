import 'package:creatego_packages/creatego_packages.dart';
import 'package:get/get.dart';

class VarModel extends Equatable {
  VarModel({
    this.type = VariableType.string,
    this.name = "name",
    this.value,
  });

  VariableType type;
  String name;
  String? value;

  void setDefaultValue(String? value) {
    this.value = value;
  }

  void setName(String value) {
    if (value.isNotEmpty) {
      name = value.removeAllWhitespace;
    }
  }

  void setType(VariableType value) {
    type = value;
    this.value = null;
  }

  bool get isVerified {
    if (name.isEmpty) return false;
    if (value != null) {
      if (!type.checkValueIsCorrectType(value!)) return false;
    }
    return true;
  }

  @override
  List<Object?> get props => [type, name, value];

  Map<String, dynamic> toJson() {
    setMiddleware();
    final map = {
      "type": type.toDartType(value),
      "name": name,
      "value": type.convertValue(value) ?? "null",
    };
    return map;
  }

  factory VarModel.fromJson(Map<String, dynamic> json) {
    final type = VariableType.values.firstWhere(
      (element) => element.toString() == json["type"],
    );
    final name = json["name"];
    final value = json["value"];
    return VarModel(
      type: type,
      name: name,
      value: value,
    );
  }

  (VariableType type, String name, String? value) setMiddleware() {
    //TODO: set middleware
    return (type, name, value);
  }
}

/// If new added, steps to follow are:
/// 1. add to [VariableType]
/// 2. add to [toString]
/// 3. add to [checkValueIsCorrectType]
/// 4. add to [toDartType]
/// 5. add to [convertValue]
/// 6. add to [types]
enum VariableType {
  number,
  string,
  boolean,
  list;

  @override
  String toString() {
    switch (this) {
      case VariableType.number:
        return "Number";
      case VariableType.string:
        return "String";
      case VariableType.list:
        return "List";
      case VariableType.boolean:
        return "Boolean";
    }
  }

  ///mapper function for checking the value of the variable type
  ///returns true if the value is correct for the type
  ///returns false if the value is incorrect for the type
  bool checkValueIsCorrectType(String v) {
    if (this == VariableType.number) return num.tryParse(v) != null;
    if (this == VariableType.boolean) return v == "true" || v == "false";
    if (this == VariableType.string) return true;
    if (this == VariableType.list) {
      try {
        final l = v.split(",");
        for (var i in l) {
          if (i.isEmpty) return false;
        }
        return true;
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  //enum to dart type
  String toDartType(String? value) {
    if (this == VariableType.number) return "num${value == null ? "?" : ""}";
    if (this == VariableType.boolean) return "bool${value == null ? "?" : ""}";
    if (this == VariableType.string) return "String${value == null ? "?" : ""}";
    if (this == VariableType.list) {
      return "List<String>${value == null ? "?" : ""}";
    }
    return "String";
  }

  //enum value to string
  String? convertValue(String? value) {
    if (value == null) return null;
    if (this == VariableType.number) return num.tryParse(value)?.toString();
    if (this == VariableType.boolean) return value == "true" ? "true" : "false";
    if (this == VariableType.string) return value;
    if (this == VariableType.list) {
      return value.removeAllWhitespace
          .split(',')
          .map((e) => "'$e'")
          .toList()
          .toString();
    }
    return null;
  }
}

//list of variable types
List<VariableType> types = [
  VariableType.number,
  VariableType.string,
  VariableType.list,
  VariableType.boolean
];
