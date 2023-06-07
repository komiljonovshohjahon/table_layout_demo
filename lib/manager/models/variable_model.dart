import 'package:creatego_packages/creatego_packages.dart';

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
      name = value;
    }
  }

  void setType(VariableType value) {
    type = value;
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

  Map<String, dynamic> toMap() {
    return {
      mapKey("type"): type,
      mapKey("name"): mapKey(name),
    };
  }

  factory VarModel.fromMap(Map<String, dynamic> map) {
    return VarModel(
      type: map['type'],
      name: map['name'],
    );
  }
}

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
  String toDartType() {
    if (this == VariableType.number) return "num";
    if (this == VariableType.boolean) return "bool";
    if (this == VariableType.string) return "String";
    if (this == VariableType.list) return "List<String>";
    return "String";
  }
}

//list of variable types
List<VariableType> types = [
  VariableType.number,
  VariableType.string,
  VariableType.list,
  VariableType.boolean
];
