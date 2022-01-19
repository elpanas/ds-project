import 'package:flutter/material.dart'
    show
        AlertDialog,
        BuildContext,
        Navigator,
        StatelessWidget,
        Text,
        TextButton,
        VoidCallback,
        Widget;
import 'package:easy_localization/easy_localization.dart';

class DeleteAlert extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const DeleteAlert({required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('alert_title').tr(),
      content: const Text('alert_content').tr(),
      actions: [
        TextButton(
          child: const Text('alert_cancel').tr(),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('alert_confirm').tr(),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
