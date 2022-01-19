import 'package:beachu/constants.dart' show kBathCardMargin;
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

class FavCard extends StatelessWidget {
  const FavCard({
    required UniqueKey key,
    required this.title,
    required this.city,
    required this.onTap,
    required this.onLongPress,
  }) : super(key: key);
  final String title, city;
  final VoidCallback onTap, onLongPress;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: kBathCardMargin,
      elevation: 4,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 18.0),
        ),
        subtitle: Row(
          children: [
            const Icon(Icons.location_city),
            const SizedBox(width: 3),
            Text(city),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}
