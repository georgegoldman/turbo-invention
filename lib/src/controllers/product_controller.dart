import 'package:get/get.dart';

import '../models/index.dart';

class ProductController extends GetxController {
  final dynamic database;
  ProductController({required this.database});
  var products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchData();
  }

  _fetchData() async {
    try {
      var productList = await database.getProducts();
      if (productList.isNotEmpty) {
        products.assignAll(productList);
        return;
      }
      return;
    } catch (e) {
      e.printError();
    }
  }

  void addProduct(Product product) async {
    await database.insertProduct(product);
    _fetchData();
    return;
  }

  void updateRecord(Product product) async {
    final index = products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      products[index] = product;
      await database.updateProduct(product);
      return;
    }
    return;
  }

  void deleteProduct(Product product) async {
    final index = products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      if (product.quantity > 1) {
        product.quantity--;
        updateRecord(product);
        return;
      }
      products.remove(product);
      await database.deleteProduct(product.id!);
      return;
    }
  }

  // Refresh data after editing
}
