import 'package:beachu/constants.dart' show kLogInOutButtonStyle;
import 'package:beachu/views/login.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Expanded,
        Icon,
        Icons,
        Navigator,
        OutlinedButton,
        StatelessWidget,
        Widget;

// ignore: use_key_in_widget_constructors
class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => Navigator.pushNamed(context, LoginPage.id),
        child: const Icon(Icons.login_outlined),
        style: kLogInOutButtonStyle,
      ),
    );
  }
}
