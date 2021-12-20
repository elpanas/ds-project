import 'package:flutter/material.dart';

class ActionIconButton extends StatelessWidget {
  const ActionIconButton({
    required UniqueKey key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Icon(
          icon,
          color: const Color(0xFFFF9800),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
