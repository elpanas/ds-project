import 'package:beachu/constants.dart' show kLogInOutButtonStyle;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Icon,
        Icons,
        OutlinedButton,
        StatelessWidget,
        VoidCallback,
        Widget;

class LogoutButton extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LogoutButton({required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: kLogInOutButtonStyle,
      onPressed: onPressed,
      child: const Icon(Icons.logout),
    );
  }
}
