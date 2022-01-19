import 'package:beachu/constants.dart'
    show
        kBathMargin,
        kBathOpacTextStyle,
        kBathTextStyle,
        kBathTitleDecoration,
        kV30Padding;
import 'package:flutter/material.dart'
    show
        Alignment,
        BuildContext,
        Color,
        Column,
        Container,
        Expanded,
        Icon,
        IconData,
        SizedBox,
        StatelessWidget,
        Text,
        TextButton,
        VoidCallback,
        Widget;

class BathContainer extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const BathContainer({
    required this.title,
    required this.colour,
    required this.info,
    required this.icon,
    this.onPressed,
  });

  final Color colour;
  final String title, info;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed,
        child: Container(
          margin: kBathMargin,
          padding: kV30Padding,
          decoration: kBathTitleDecoration,
          alignment: Alignment.center,
          child: Column(
            children: [
              Icon(
                icon,
                color: colour,
                size: 30.0,
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: kBathOpacTextStyle,
              ),
              const SizedBox(height: 20),
              Text(
                info,
                style: kBathTextStyle.copyWith(fontSize: 21),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
