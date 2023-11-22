// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technical_assessment/src/controllers/product_controller.dart';
import 'package:technical_assessment/src/services/database_service.dart';
import 'package:technical_assessment/src/views/screens/home.dart';
import 'package:technical_assessment/src/views/widgets/textField.dart';
import 'package:technical_assessment/src/views/widgets/vertical_spacing.dart';

import '../../models/index.dart';
import '../../services/image_service.dart';

File? _image;

class EditProduct extends StatefulWidget {
  final Product? product;
  const EditProduct({
    super.key,
    this.product,
  });

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  late TextEditingController _quantityController;
  late TextEditingController _costPriceController;
  late TextEditingController _sellingPriceController;
  final _productController =
      Get.put(ProductController(database: DatabaseHelper()));

  @override
  void initState() {
    _quantityController =
        TextEditingController(text: widget.product!.quantity.toString());
    _costPriceController =
        TextEditingController(text: widget.product!.costPrice.toString());
    _sellingPriceController =
        TextEditingController(text: widget.product!.sellingPrice.toString());
    super.initState();
  }

  setValues() {
    try {
      Product product = Product(
        id: widget.product!.id,
        name: 'New Product',
        quantity: int.parse(_quantityController.value.text),
        costPrice: double.parse(_costPriceController.value.text),
        sellingPrice: double.parse(_sellingPriceController.value.text),
        imageData: imageFileToUint8List(_image).isEmpty
            ? widget.product!.imageData
            : imageFileToUint8List(_image),
      );

      _productController.updateRecord(product);
      Get.offAll(const Home());
    } catch (e) {
      e.printError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Product"),
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
          ElevatedButton(onPressed: setValues, child: const Text("Update"))
        ],
      ),
    );
  }
}

Uint8List imageFileToUint8List(File? imageFile) {
  Uint8List? imageBytes = imageFile?.readAsBytesSync();
  return Uint8List.fromList(imageBytes ?? [3093095305903]);
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
