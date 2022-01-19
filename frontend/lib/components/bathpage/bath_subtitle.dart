import 'package:beachu/constants.dart' show kBathMargin, kBathTextStyle;
import 'package:flutter/material.dart'
    show Alignment, BuildContext, Container, StatelessWidget, Text, Widget;
import 'package:easy_localization/easy_localization.dart';

// ignore: use_key_in_widget_constructors
class BathSubTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: kBathMargin,
      child: Text(
        'bath_subtitle',
        style: kBathTextStyle.copyWith(fontSize: 20),
      ).tr(),
    );
  }
}
