import 'package:beachu/constants.dart';
import 'package:beachu/views/login.dart';
import 'package:flutter/material.dart';

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
