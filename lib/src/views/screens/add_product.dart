import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technical_assessment/src/controllers/product_controller.dart';
import 'package:technical_assessment/src/services/database_service.dart';
import 'package:technical_assessment/src/views/widgets/textField.dart';
import 'package:technical_assessment/src/views/widgets/vertical_spacing.dart';

import '../../models/index.dart';
import '../../services/image_service.dart';

File? _image;

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _costPriceController = TextEditingController();
  final TextEditingController _sellingPriceController = TextEditingController();
  final ProductController _productController =
      Get.put(ProductController(database: DatabaseHelper()));

  addNewProduct() {
    try {
      Product newProduct = Product(
        name: 'New Product',
        quantity: int.parse(_quantityController.text),
        costPrice: double.parse(_costPriceController.text),
        sellingPrice: double.parse(_sellingPriceController.text),
        imageData: imageFileToUint8List(_image!),
      );
      _productController.addProduct(newProduct);
      Get.back();
    } catch (e) {
      e.printError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        children: [
          TextForm(
            label: "Quantity",
            helpingText: "3",
            keyboardtype: TextInputType.number,
            controller: _quantityController,
          ),
          const VerticalSpacing(),
          TextForm(
            label: 'Cost Price',
            helpingText: '\$200',
            keyboardtype: TextInputType.number,
            controller: _costPriceController,
          ),
          const VerticalSpacing(),
          TextForm(
            label: "Selling Price",
            helpingText: "\$210",
            keyboardtype: TextInputType.phone,
            controller: _sellingPriceController,
          ),
          const VerticalSpacing(),
          const IP(),
          ElevatedButton(onPressed: addNewProduct, child: const Text("Add"))
        ],
      ),
    );
  }
}

Uint8List imageFileToUint8List(File imageFile) {
  List<int> imageBytes = imageFile.readAsBytesSync();
  return Uint8List.fromList(imageBytes);
}

class IP extends StatefulWidget {
  const IP({super.key});

  @override
  State<IP> createState() => _IPState();
}

class _IPState extends State<IP> {
  final ImageService _imageService = ImageService();

  Future<void> _pickedandSaveImage() async {
    final pickedImage = await _imageService.pickAndSaveImage();

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _image == null
            ? const Text("No Image seleted.")
            : Image.file(
                _image!,
                height: 150,
              ),
        const VerticalSpacing(),
        ElevatedButton(
            onPressed: _pickedandSaveImage, child: const Text('Pick Image'))
      ],
    );
  }
}
