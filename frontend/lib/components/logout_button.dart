import 'package:beachu/constants.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LogoutButton({required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: const Icon(Icons.logout),
      style: kLogInOutButtonStyle,
      onPressed: onPressed,
    );
  }
}
