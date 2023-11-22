import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technical_assessment/src/controllers/product_controller.dart';
import 'package:technical_assessment/src/views/screens/edit.dart';
import 'package:technical_assessment/src/views/widgets/card.dart';
import 'package:technical_assessment/src/views/widgets/vertical_spacing.dart';

import '../../models/index.dart';

class ProductInfo extends StatelessWidget {
  final Product product;
  const ProductInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Extracting the arguments from the current route
    final ProductController productController = Get.put(ProductController());
    // Accessing the values
    // Uint8List x = arguments['image'];
    // double y = arguments['price'];
    // int z = arguments['qt'];
    // int w = arguments['id'];
    // double v = arguments['cost'];

    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              Get.to(EditProduct(
                product: product,
              ));
            },
            icon: const Icon(Icons.edit))
      ]),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          children: [
            FilledCard(
              product: product,
            ),
            const VerticalSpacing(),
            ElevatedButton(
                onPressed: () {
                  productController.deleteProduct(product);
                  Get.back();
                },
                child: const Text("Delete"))
          ]),
    );
  }
}
