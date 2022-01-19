import 'package:flutter/material.dart'
    show
        BuildContext,
        CircleBorder,
        Color,
        Colors,
        Icon,
        IconButton,
        IconData,
        Ink,
        Key,
        ShapeDecoration,
        StatelessWidget,
        VoidCallback,
        Widget;

class UmbrellasIconButton extends StatelessWidget {
  const UmbrellasIconButton({
    required Key key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: const ShapeDecoration(
        color: Color(0xFFFF9800),
        shape: CircleBorder(),
      ),
      child: IconButton(
        icon: Icon(icon),
        color: Colors.black,
        onPressed: onPressed,
      ),
    );
  }
}
