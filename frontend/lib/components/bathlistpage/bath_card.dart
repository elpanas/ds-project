import 'package:beachu/constants.dart'
    show kBathCardLeadingIcon, kBathCardMargin;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Card,
        Icon,
        Icons,
        ListTile,
        Row,
        SizedBox,
        StatelessWidget,
        Text,
        TextStyle,
        UniqueKey,
        VoidCallback,
        Widget;

class BathCard extends StatelessWidget {
  const BathCard({
    required UniqueKey key,
    required this.title,
    required this.availableUmbrella,
    required this.onTap,
    required this.onLongPress,
  }) : super(key: key);
  final String title;
  final int availableUmbrella;
  final VoidCallback onTap, onLongPress;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: kBathCardMargin,
      elevation: 4,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 21.0),
        ),
        subtitle: Row(
          children: [
            kBathCardLeadingIcon,
            const SizedBox(width: 3),
            Text(
              availableUmbrella.toString(),
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}
