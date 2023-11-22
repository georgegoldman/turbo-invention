import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:technical_assessment/src/models/index.dart';

class FilledCard extends StatelessWidget {
  final Product product;
  const FilledCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.surfaceVariant,
          child: Column(children: [
            Image.memory(product.imageData!),
            ListTile(
              title: Text("Price: \$${product.sellingPrice}"),
              subtitle: Text("quantity ${product.quantity}"),
              trailing: Text("id ${product.id}"),
            )
          ]),
        ),
      ),
    );
  }
}
