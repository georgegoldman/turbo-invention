import 'dart:typed_data';

class Product {
  final int? id;
  final String name;
  int quantity;
  final double costPrice;
  final double sellingPrice;
  final Uint8List? imageData;

  Product({
    this.id,
    required this.name,
    required this.quantity,
    required this.costPrice,
    required this.sellingPrice,
    this.imageData,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'costPrice': costPrice,
      'sellingPrice': sellingPrice,
      'imageData': imageData,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
      costPrice: map['costPrice'],
      sellingPrice: map['sellingPrice'],
      imageData: map['imageData'],
    );
  }
}
