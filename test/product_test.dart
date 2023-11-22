import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:technical_assessment/src/controllers/product_controller.dart';
import 'package:technical_assessment/src/models/index.dart';
import 'package:technical_assessment/src/views/screens/home.dart';

import 'mock_database.dart';

void main() {
  testWidgets('Add product and check if it appears in the list',
      (WidgetTester tester) async {
    final MockDatabase mockDatabase = MockDatabase();
    final ProductController controller =
        ProductController(database: mockDatabase);
    await tester.pumpWidget(const MyAppTest());

    // Ensure the list is initially empty
    expect(controller.products.length, 0);

    // Trigger the add product action
    controller.addProduct(Product(
        name: 'Test Product', quantity: 10, costPrice: 23.2, sellingPrice: 10));

    // Wait for the widget tree to be rebuilt
    await tester.pump();

    // Expect the list to contain one product
    expect(controller.products.length, 1);

    // Expect the product to be rendered in the UI
    expect(find.text('Test Product'), findsOneWidget);
  });

  testWidgets('Update product and check if it reflects in the list',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyAppTest());

    final MockDatabase mockDatabase = MockDatabase();
    final ProductController controller =
        ProductController(database: mockDatabase);

    // Add a product to the list
    controller.addProduct(Product(
        name: 'Test Product', quantity: 10, costPrice: 23.2, sellingPrice: 10));

    // Wait for the widget tree to be rebuilt
    await tester.pump();

    // Trigger the update product action
    controller.updateRecord(Product(
        name: 'Updated Product',
        quantity: 10,
        costPrice: 23.2,
        sellingPrice: 10));

    // Wait for the widget tree to be rebuilt
    await tester.pump();

    // Expect the updated product name to be reflected in the UI
    expect(find.text('Updated Product'), findsOneWidget);
  });
}

class MyAppTest extends StatelessWidget {
  const MyAppTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Management App test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}
