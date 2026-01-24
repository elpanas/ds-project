import 'package:beachu/constants.dart' show kBathOpacTextStyle;
import 'package:beachu/functions.dart' show validatorCallback;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Flexible,
        InputDecoration,
        StatelessWidget,
        TextEditingController,
        TextFormField,
        TextInputType,
        Widget;

class BathField extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const BathField({
    required this.controller,
    this.inputType,
    required this.labelText,
  });

  final TextEditingController controller;
  final TextInputType? inputType;
  final String labelText;


  @override
  Widget build(BuildContext context) {
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
