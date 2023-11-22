import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technical_assessment/src/controllers/product_controller.dart';
import 'package:technical_assessment/src/models/index.dart';
import 'package:technical_assessment/src/services/database_service.dart';
import 'package:technical_assessment/src/views/screens/add_product.dart';
import 'package:technical_assessment/src/views/screens/product_info.dart';

import '../widgets/card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final productController =
      Get.put(ProductController(database: DatabaseHelper()));

  bool delete = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Products"),
          actions: [
            IconButton(
              onPressed: () => Get.to(const AddProduct()),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: Obx(() {
          return ListView.builder(
            itemCount: productController.products.length,
            itemBuilder: (context, index) {
              // Build your list item here
              return InkWell(
                onTap: () {
                  Get.to(
                      ProductInfo(product: productController.products[index]));
                },
                child: FilledCard(
                  product: productController.products[index],
                ),
              );
            },
          );
        })
        // body: ,
        // body:
        );
  }
}
