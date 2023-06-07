import 'package:creatego_interface/creatego_interface.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_layout_demo/manager/models/models.dart';

class ResourceVarSelector extends StatelessWidget {
  final ValueChanged<VarModel> onAdded;
  final VarModel? model;

  const ResourceVarSelector({
    Key? key,
    required this.onAdded,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (model != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Variable Type: ${model!.type}"),
              Text("Variable Name: ${model!.name}"),
              Text(model!.value == null ? "" : "Value: ${model!.value}"),
            ],
          ),
        TextButton(
            onPressed: () async {
              final m = model ?? VarModel();
              await showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(builder: (context, setState) {
                      return AlertDialog(
                        title: const Text("Add Variable"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ResourceDropdown<VariableType>(
                                onChanged: (value) {
                                  setState(() {
                                    m.setType(value);
                                  });
                                },
                                value: m.type,
                                items: types),
                            const SizedBox(height: 20),
                            ResourceInputField(
                              label: "Name",
                              onChanged: (value) {
                                setState(() {
                                  m.setName(value);
                                });
                              },
                              initialValue: m.name,
                            ),
                            const SizedBox(height: 20),
                            ResourceInputField(
                              label: "Value (Opt) ${getHint(m)}",
                              onChanged: (value) {
                                setState(() {
                                  m.setDefaultValue(value);
                                });
                              },
                              initialValue: m.value,
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel")),
                          TextButton.icon(
                            onPressed: () => onSave(m, context),
                            label: Text(
                                "${model == null ? "Add" : "Edit"} Variable"),
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      );
                    });
                  });
            },
            child: Text("${model == null ? "Add" : "Edit"} Variable")),
      ],
    );
  }

  void onSave(VarModel m, BuildContext context) {
    if (!m.isVerified) {
      Get.dialog(AlertDialog(
        title: const Text("Error"),
        content: const Text("Failed to match the variable type with value"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ok")),
        ],
      ));
      return;
    }
    onAdded(m);
    Navigator.pop(context);
  }

  String getHint(VarModel model) {
    String hint = "";
    if (model.type == VariableType.number) hint = "e.g. 1 or 2.5";
    if (model.type == VariableType.string) hint = "e.g. Hello World";
    if (model.type == VariableType.boolean) hint = "e.g. true or false";
    if (model.type == VariableType.list) {
      hint = "e.g. 1,2,3,4 (comma separated)";
    }
    return hint;
  }
}
