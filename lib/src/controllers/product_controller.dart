import 'package:get/get.dart';

import '../models/index.dart';
import '../services/database_service.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchData();
  }

  _fetchData() async {
    try {
      var productList = await DatabaseHelper().getProducts();
      if (productList.isNotEmpty) {
        products.assignAll(productList);
      }
    } catch (e) {
      print("Eror in ");
    }
  }

  void addProduct(Product product) async {
    await DatabaseHelper().insertProduct(product);
    _fetchData();
  }

  void updateRecord(Product product) async {
    final index = products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      products[index] = product;
      await DatabaseHelper().updateProduct(product);
    }
  }

  void deleteProduct(Product product) async {
    final index = products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      products.remove(product);
      await DatabaseHelper().deleteProduct(product.id!);
    }
  }

  // Refresh data after editing
}
