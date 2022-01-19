import 'package:beachu/constants.dart' show kFacebookButtonStyle;
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

class FacebookButton extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const FacebookButton({required this.onPressed});

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        child: const Icon(FontAwesomeIcons.facebook),
        style: kFacebookButtonStyle,
        onPressed: () {},
      ),
    );
  }
}
