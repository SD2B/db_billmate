import 'package:db_billmate/models/item_model.dart';
import 'package:flutter/material.dart';

class QuantitySuffix extends StatelessWidget {
  const QuantitySuffix({
    super.key,
    required this.billItem,
  });

  final ItemModel billItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (billItem.id != null) Text(billItem.unit ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w900)),
            if (billItem.id == null) Text(billItem.unit ?? "Unit🔽", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w900)),
          ],
        ));
  }
}
