import 'package:beachu/constants.dart';
import 'package:beachu/functions.dart';
import 'package:flutter/material.dart';

class BathField extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const BathField({
    required this.controller,
    this.inputType,
    required this.labelText,
    this.initialValue,
  });

  final TextEditingController controller;
  final TextInputType? inputType;
  final String labelText;
  final String? initialValue;

  void checkAndSetInitialValue() {
    if (initialValue != null) controller.text = initialValue!;
  }

  @override
  Widget build(BuildContext context) {
    checkAndSetInitialValue();
    return Flexible(
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: kBathOpacTextStyle,
        ),
        validator: validatorCallback,
      ),
    );
  }
}
