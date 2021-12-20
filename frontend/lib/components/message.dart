import 'package:beachu/constants.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const Message({required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: kMessageStyle,
      ),
    );
  }
}
