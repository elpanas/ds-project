import 'package:beachu/constants.dart' show kSimpleButtonStyle;
import 'package:flutter/material.dart'
    show
        BuildContext,
        ElevatedButton,
        StatelessWidget,
        Text,
        VoidCallback,
        Widget;

class SimpleButton extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const SimpleButton({
    required this.title,
    required this.onPressed,
  });
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
      style: kSimpleButtonStyle,
    );
  }
}
