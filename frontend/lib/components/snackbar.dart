import 'package:beachu/constants.dart'
    show kSnackBarTextStyle, kSnackbarPadding;
import 'package:flutter/material.dart' show Color, SnackBar, Text;

SnackBar snackBarBuilder({required String title}) {
  return SnackBar(
    content: Text(
      title,
      style: kSnackBarTextStyle,
    ),
    backgroundColor: const Color(0xFFFF9800),
    padding: kSnackbarPadding,
    duration: const Duration(seconds: 2),
  );
}
