import 'package:beachu/constants.dart' show kGoogleButtonStyle;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Expanded,
        Icon,
        OutlinedButton,
        StatelessWidget,
        VoidCallback,
        Widget;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleButton extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const GoogleButton({required this.onPressed});

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        child: const Icon(FontAwesomeIcons.google),
        style: kGoogleButtonStyle,
        onPressed: onPressed,
      ),
    );
  }
}
