import 'package:beachu/constants.dart';
import 'package:flutter/material.dart';

class BathTitle extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const BathTitle({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: kBathMargin,
      padding: kBathTitlePadding,
      decoration: kBathTitleDecoration,
      alignment: Alignment.center,
      child: Text(
        title,
        style: kBathTextStyle.copyWith(fontSize: 30),
      ),
    );
  }
}
